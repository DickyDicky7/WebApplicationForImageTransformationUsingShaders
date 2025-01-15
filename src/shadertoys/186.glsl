#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/Xcdfzf

float random(float     seed) {
      return fract(sin(seed) * 43758.54530);
}

float randomInRange(float seed, float a, float b) {
    return a + (b - a) * random(seed);
}

vec2 getRandomPoint(float seed, float timeOffset) {
    return  vec2(randomInRange(seed + timeOffset      , -0.2, 0.2)
         ,       randomInRange(seed + timeOffset + 1.0, -0.2, 0.2));
}

vec2 getRandomPoint2(    float seed    ) {
    return  vec2(randomInRange(seed      , -0.2, 0.2)
         ,       randomInRange(seed + 1.0, -0.2, 0.2));
}

float triangularWave(float x) {
    return 1.0 - abs(2.0 * x - 1.0);
}

vec3 pointsT1[60] = vec3[](
    vec3(-1.2,  0.7, 1.0),
    vec3(-0.7, -0.4, 1.0),
    vec3( 0.3,  0.7, 1.0),
    vec3( 1.5, -1.0, 1.0),
    vec3( 1.2, -0.5, 1.0),
    vec3(-2.0, -0.2, 1.0),
    vec3( 0.1,  0.9, 1.0),
    vec3( 1.3,  0.5, 1.0),
    vec3(-0.8, -0.6, 1.0),
    vec3( 0.6, -0.1, 1.0),
    vec3(-1.4, -0.9, 1.0),
    vec3(-1.5,  0.7, 1.0),
    vec3( 0.2, -0.8, 1.0),
    vec3( 1.0, -0.9, 1.0),
    vec3(-0.2,  0.1, 1.0),
    vec3(-1.1,  0.2, 1.0),
    vec3( 1.2,  0.7, 1.0),
    vec3( 0.6,  0.0, 1.0),
    vec3(-1.7,  0.4, 1.0),
    vec3( 0.1, -0.7, 1.0),
    vec3(-0.6,  0.1, 1.0),
    vec3( 0.8, -0.8, 1.0),
    vec3( 1.4,  0.2, 1.0),
    vec3(-0.6,  0.6, 1.0),
    vec3( 1.0,  0.1, 1.0),
    vec3(-1.9,  0.3, 1.0),
    vec3( 0.5, -0.8, 1.0),
    vec3(-0.2,  0.7, 1.0),
    vec3( 1.7, -0.5, 1.0),
    vec3( 1.4,  0.6, 1.0),
    vec3(-1.5, -0.3, 1.0),
    vec3( 0.2, -0.9, 1.0),
    vec3(-0.6,  0.5, 1.0),
    vec3( 1.9, -0.4, 1.0),
    vec3( 0.8,  0.9, 1.0),
    vec3(-0.7, -0.1, 1.0),
    vec3( 1.2,  0.3, 1.0),
    vec3(-1.8, -0.7, 1.0),
    vec3( 1.0, -0.2, 1.0),
    vec3(-0.9,  0.2, 1.0),
    vec3( 1.5, -0.6, 1.0),
    vec3( 0.7,  0.4, 1.0),
    vec3(-1.6,  0.0, 1.0),
    vec3( 1.1, -0.8, 1.0),
    vec3(-0.3,  0.8, 1.0),
    vec3( 0.6,  0.1, 1.0),
    vec3(-1.2, -0.5, 1.0),
    vec3( 0.4,  0.3, 1.0),
    vec3( 1.8, -0.6, 1.0),
    vec3(-1.0,  0.2, 1.0),
    vec3( 1.6, -0.4, 1.0),
    vec3( 0.3,  0.7, 1.0),
    vec3(-0.5, -0.9, 1.0),
    vec3( 1.3,  0.5, 1.0),
    vec3(-1.7, -0.2, 1.0),
    vec3( 0.9,  0.6, 1.0),
    vec3(-0.4, -0.8, 1.0),
    vec3( 1.4,  0.9, 1.0),
    vec3(-1.3,  0.0, 1.0),
    vec3( 0.1, -0.7, 1.0)
);

void main()
{
    vec2 uv = gl_FragCoord.xy / canvasSize.y;
    int         pointCount
      =  60 ;
    
    float scale       =        2.0;
    float speed       = time * 0.6;
    float         ray = 0.5;
    float   fractions = 9.0;
    vec4  waterCollor = vec4(0.00, 0.10, 0.200, 1);
    vec4  dropsCollor = vec4(0.03, 0.03, 0.045, 1);
    float   intensity = 1.0;
    float  sizeByTime = 1.2;
    float   startSize = 0.1;

    float                                                minResolution
             =                    min ( canvasSize.x
             ,                          canvasSize.y )                ;
    vec2 pos = (gl_FragCoord.xy * 2.0 - canvasSize.xy) / minResolution;
    
    vec4 dropsColor       = vec4(0.0);
    vec2 refractionOffset = vec2(0.0);
    
    for (int i = 0; i < pointCount; i++)
    {   
        float distortion = abs(fract(pointsT1[i].x 
                         +           pointsT1[i].y));
        
        ray = clamp(distortion, 0.1, 0.6);
//      ray = clamp(distortion, 0.1, 0.6);
        
        float timeOffset = speed / pointsT1[i].x * 0.5;
        float z          =         pointsT1[i].z -
          cos(timeOffset)                        * 0.5;

        float coordToPoint = length(pos - pointsT1[i].xy) / scale;
//      float coordToPoint = length(pos - pointsT1[i].xy) / scale;
        
        float        ray_speed_distort  = ray          * (speed     + distortion)       ;
        float d    = ray_speed_distort  - coordToPoint                                  ;
        float blur = sizeByTime         * coordToPoint + (startSize * distortion) * 2.0 ;
        
        float fracted  = smoothstep(-blur, 0.0, fract(d * fractions + distortion) - ray);
              fracted *=                   1.0
            - fracted;

        float alpha = smoothstep(ray, 0.0, coordToPoint) * 10.0;
//      float alpha = smoothstep(ray, 0.0, coordToPoint) * 10.0;
        dropsColor += dropsCollor * alpha * fracted * triangularWave(fract(z));   
//      dropsColor += dropsCollor * alpha * fracted * triangularWave(fract(z));   
        
        vec2 direction = normalize(pos - pointsT1[i].xy);
//      vec2 direction = normalize(pos - pointsT1[i].xy);
        refractionOffset += direction * fracted * 0.2 * dropsColor.b;
//      refractionOffset += direction * fracted * 0.2 * dropsColor.b;
    }
    
    vec2                        refractedUV = uv +
                                refractionOffset ;
    vec4 _floor = texture(tex0, refractedUV).rgba;
      fragColor = (_floor     + waterCollor
  +  dropsColor
  + (dropsColor *  _floor))
                * intensity;
}





