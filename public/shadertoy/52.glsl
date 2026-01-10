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

    void main(void)
    {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    
    // placement of the blur center
//  // placement of the blur center
    // placement of the blur center
//  // placement of the blur center
    float  timee = time                         *       0.5;
//  float  timee = time                         *       0.5;
    vec2  center = vec2(sin(timee), cos(timee)) * 0.5 + 0.5;
//  vec2  center = vec2(sin(timee), cos(timee)) * 0.5 + 0.5;

    vec2 direction = uv - center;
//  vec2 direction = uv - center;
    vec3 c = vec3(0.0, 0.0, 0.0);
//  vec3 c = vec3(0.0, 0.0, 0.0);
    
    const float   blurPower = 0.01;
//  const float   blurPower = 0.01;
    const float sampleCount = 6.00;
//  const float sampleCount = 6.00;
    // GLSL 100 does not support uint, so use float
//  // GLSL 100 does not support uint, so use float
    // GLSL 100 does not support uint, so use float
//  // GLSL 100 does not support uint, so use float

    float f = 1.0    / sampleCount;
//  float f = 1.0    / sampleCount;
    for (float i = 0.0; i < sampleCount; i++) {
//  for (float i = 0.0; i < sampleCount; i++) {
    c += texture(tex0, uv - blurPower * direction * i).rgb * f;
//  c += texture(tex0, uv - blurPower * direction * i).rgb * f;
    }
//  }

    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    fragColor = vec4(c, 1.0);
//  fragColor = vec4(c, 1.0);
    }



    // https://www.shadertoy.com/view/NdtfDj
//  // https://www.shadertoy.com/view/NdtfDj

