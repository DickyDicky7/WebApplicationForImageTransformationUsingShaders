    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4          fragColor;
//  out             vec4          fragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    // const float       shake          = 000.015;
//  // const float       shake          = 000.015;
    // const float       noiseQuality   = 250.000;
//  // const float       noiseQuality   = 250.000;
    // const float       noiseIntensity = 000.001;
//  // const float       noiseIntensity = 000.001;
    // const float      offsetIntensity = 000.050;
//  // const float      offsetIntensity = 000.050;
    // const float colorOffsetIntensity = 000.500;
//  // const float colorOffsetIntensity = 000.500;

    uniform float       shake          ; // 000.015
//  uniform float       shake          ; // 000.015
    uniform float       noiseQuality   ; // 250.000
//  uniform float       noiseQuality   ; // 250.000
    uniform float       noiseIntensity ; // 000.001
//  uniform float       noiseIntensity ; // 000.001
    uniform float      offsetIntensity ; // 000.050
//  uniform float      offsetIntensity ; // 000.050
    uniform float colorOffsetIntensity ; // 000.500
//  uniform float colorOffsetIntensity ; // 000.500

    float rand(vec2 co)
//  float rand(vec2 co)
    {
//  {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
//  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
    }
//  }

    float verticalBar(float pos, float uvY, float offset)
//  float verticalBar(float pos, float uvY, float offset)
    {
//  {
    float edge0 = (pos - shake);
//  float edge0 = (pos - shake);
    float edge1 = (pos + shake);
//  float edge1 = (pos + shake);

    float  x  = smoothstep(edge0, pos, uvY) * offset;
//  float  x  = smoothstep(edge0, pos, uvY) * offset;
    x -= smoothstep(pos, edge1, uvY) * offset;
//  x -= smoothstep(pos, edge1, uvY) * offset;
    return x;
//  return x;
    }
//  }


    void main() {
    vec2 iResolution = canvasSize         ;
//  vec2 iResolution = canvasSize         ;
    vec2          uv =           vTexCoord;
//  vec2          uv =           vTexCoord;

    for (float i = 0.0; i < 0.71; i += 0.1313)
//  for (float i = 0.0; i < 0.71; i += 0.1313)
    {
//  {
    float d =           mod(time * i    , 1.7 );
//  float d =           mod(time * i    , 1.7 );
    float o = sin(1.0 - tan(time * 0.24 * i  ));
//  float o = sin(1.0 - tan(time * 0.24 * i  ));
    o    *=         offsetIntensity;
//  o    *=         offsetIntensity;
    uv.x += verticalBar(d, uv.y, o);
//  uv.x += verticalBar(d, uv.y, o);
    }
//  }
    float uvY     =            uv.y    ;
//  float uvY     =            uv.y    ;
    uvY    *=                          noiseQuality ;
//  uvY    *=                          noiseQuality ;
    uvY     = float(int(uvY)) * (1.0 / noiseQuality);
//  uvY     = float(int(uvY)) * (1.0 / noiseQuality);
    float   noise =                                        rand(vec2(time * 0.00001, uvY));
//  float   noise =                                        rand(vec2(time * 0.00001, uvY));
    uv.x += noise * noiseIntensity;
//  uv.x += noise * noiseIntensity;
    
    vec2 offsetR = vec2(0.0060 *  sin(time)        , 0.0) * colorOffsetIntensity;
//  vec2 offsetR = vec2(0.0060 *  sin(time)        , 0.0) * colorOffsetIntensity;
    vec2 offsetG = vec2(0.0073 * (cos(time * 0.97)), 0.0) * colorOffsetIntensity;
//  vec2 offsetG = vec2(0.0073 * (cos(time * 0.97)), 0.0) * colorOffsetIntensity;
    
    float r = texture(tex0, uv + offsetR).r;
//  float r = texture(tex0, uv + offsetR).r;
    float g = texture(tex0, uv + offsetG).g;
//  float g = texture(tex0, uv + offsetG).g;
    float b = texture(tex0, uv          ).b;
//  float b = texture(tex0, uv          ).b;

    vec4        tex = vec4(r, g, b, 1.0);
//  vec4        tex = vec4(r, g, b, 1.0);
    fragColor = tex                     ;
//  fragColor = tex                     ;
    }

    // https://godotshaders.com/shader/vhs-shader-distortion/
//  // https://godotshaders.com/shader/vhs-shader-distortion/
