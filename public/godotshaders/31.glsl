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

    // const float range = 0.05;
//  // const float range = 0.05;
    // const float  noiseQuality = 250.0;
//  // const float  noiseQuality = 250.0;
    // const float  noiseIntensity = 0.0088;
//  // const float  noiseIntensity = 0.0088;
    // const float offsetIntensity = 0.0300;
//  // const float offsetIntensity = 0.0300;
    // const float colorOffsetIntensity  = 1.3;
//  // const float colorOffsetIntensity  = 1.3;

    uniform float       range          ; // 000.0500
//  uniform float       range          ; // 000.0500
    uniform float       noiseQuality   ; // 250.0000
//  uniform float       noiseQuality   ; // 250.0000
    uniform float       noiseIntensity ; // 000.0088
//  uniform float       noiseIntensity ; // 000.0088
    uniform float      offsetIntensity ; // 000.0300
//  uniform float      offsetIntensity ; // 000.0300
    uniform float colorOffsetIntensity ; // 001.3000
//  uniform float colorOffsetIntensity ; // 001.3000

    float rand(vec2 co)
//  float rand(vec2 co)
    {
//  {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
//  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
    }
//  }

    float verticalBar(float pos, float UVY, float offset)
//  float verticalBar(float pos, float UVY, float offset)
    {
//  {
    float edge0 = (pos - range);
//  float edge0 = (pos - range);
    float edge1 = (pos + range);
//  float edge1 = (pos + range);

    float  x  = smoothstep(edge0,  pos , UVY) * offset;
//  float  x  = smoothstep(edge0,  pos , UVY) * offset;
    x -= smoothstep( pos , edge1, UVY) * offset;
//  x -= smoothstep( pos , edge1, UVY) * offset;
    return x;
//  return x;
    }
//  }
    //const float saturation =    0.2;
//  //const float saturation =    0.2;
    uniform float saturation ; // 0.2
//  uniform float saturation ; // 0.2
    void main()
    {
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    for (float i =  0.0000;
//  for (float i =  0.0000;
    i <  0.7100;
//  i <  0.7100;
    i += 0.1313)
//  i += 0.1313)
    {
//  {
    float d =  mod(time * i, 1.7);
//  float d =  mod(time * i, 1.7);
    float o =  sin(1.00 - tan(time * 0.24 * i));
//  float o =  sin(1.00 - tan(time * 0.24 * i));
    o *=                offsetIntensity  ;
//  o *=                offsetIntensity  ;
    uv.x += verticalBar(d, vTexCoord.y, o);
//  uv.x += verticalBar(d, vTexCoord.y, o);
    }
//  }
    
    float UVY = uv.y;
//  float UVY = uv.y;
    UVY *= noiseQuality;
//  UVY *= noiseQuality;
    UVY  = float(int(UVY)) * (1.00 / noiseQuality );
//  UVY  = float(int(UVY)) * (1.00 / noiseQuality );
    float   noise = rand(vec2(time * 0.00001, UVY));
//  float   noise = rand(vec2(time * 0.00001, UVY));
    uv.x += noise * noiseIntensity;
//  uv.x += noise * noiseIntensity;

    vec2 offsetR = vec2(0.0090 *  sin(time)        , 0.0) * colorOffsetIntensity;
//  vec2 offsetR = vec2(0.0090 *  sin(time)        , 0.0) * colorOffsetIntensity;
    vec2 offsetG = vec2(0.0073 * (cos(time * 0.97)), 0.0) * colorOffsetIntensity;
//  vec2 offsetG = vec2(0.0073 * (cos(time * 0.97)), 0.0) * colorOffsetIntensity;
    
    float r = texture(tex0, uv + offsetR).r;
//  float r = texture(tex0, uv + offsetR).r;
    float g = texture(tex0, uv + offsetG).g;
//  float g = texture(tex0, uv + offsetG).g;
    float b = texture(tex0, uv          ).b;
//  float b = texture(tex0, uv          ).b;
    vec4  tex = vec4(r, g, b, 1.0);
//  vec4  tex = vec4(r, g, b, 1.0);
    fragColor = tex;
//  fragColor = tex;
    }

    // https://godotshaders.com/shader/vhs-glitch/
//  // https://godotshaders.com/shader/vhs-glitch/
