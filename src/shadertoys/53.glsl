#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// float round(float value) {
//   return floor(value + 0.5);
// }

// vec2 round(vec2 v) {
//   return vec2(floor(v.x + 0.5), floor(v.y + 0.5));
// }

// vec3 round(vec3 v) {
//   return vec3(floor(v.x + 0.5), floor(v.y + 0.5), floor(v.z + 0.5));
// }

// vec4 round(vec4 v) {
//   return vec4(floor(v.x + 0.5), floor(v.y + 0.5), floor(v.z + 0.5), floor(v.w + 0.5));
// }


vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg , K.wz ), vec4(c.gb , K.xy ), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r  ), vec4(c.r  , p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// All components are in the range [0…1], including hue.
// All components are in the range [0…1], including hue.
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p =     abs(       fract(c.xxx + K.xyz) * 6.0 -        K.www);
    return c.z * mix(K.xxx ,clamp(p     - K.xxx  , 0.0 , 1.0) , c.y  );
}

void main(void)
{
    vec2 uv     = gl_FragCoord.xy / canvasSize.xy ;
    vec4 texCol = texture(tex0    ,            uv);
    vec3    hsv = rgb2hsv(
         texCol . rgb    );

    float posterizeAmount = 0.7; 
    float posterizeSteps  = 5.0; 

    float posterizeStepsHue        = 8192.0; 
    float posterizeStepsSaturation = 8192.0; 
    
    vec3 posterizeStepsVec;
    vec3 blended          ;

    if (uv.x < (sin(time * 1.5) * 0.3) + 0.5)
    {
             posterizeStepsVec =   vec3 (
             posterizeStepsHue          ,
             posterizeStepsSaturation   ,
             posterizeSteps             );
        vec3 posterizedHsv     =   round(hsv
           * posterizeStepsVec)
           / posterizeStepsVec;
        vec3 posterizedRgb     = hsv2rgb(
             posterizedHsv              );
        blended = mix(texCol.rgb, posterizedRgb, posterizeAmount);
    }
    else
    {
             posterizeStepsVec = vec3(posterizeSteps
                               ,      posterizeSteps
                               ,      posterizeSteps);
        vec3 posterized        =               round(texCol.rgb
           * posterizeStepsVec)
           / posterizeStepsVec;
        blended =   mix     (                        texCol.rgb
           , posterized
           , posterizeAmount);
    }

    fragColor = vec4(blended, texCol.a);
}


// https://www.shadertoy.com/view/lffXDs
