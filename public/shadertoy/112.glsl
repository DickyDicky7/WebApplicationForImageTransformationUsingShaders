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

    // https://www.shadertoy.com/view/43GcDD
//  // https://www.shadertoy.com/view/43GcDD

    #define SPEED_MULT 0.8f
//  #define SPEED_MULT 0.8f

    void main()
    {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2   uv   = vTexCoord;
//  vec2   uv   = vTexCoord;
    vec2 center = vec2(0.5);
//  vec2 center = vec2(0.5);

    vec2 diff = uv  - center;
//  vec2 diff = uv  - center;
    float rad = length(diff);
//  float rad = length(diff);
    
    float          sinRes = sin(time * SPEED_MULT);
//  float          sinRes = sin(time * SPEED_MULT);
    uv = center - (sinRes + rad)     *       diff ;
//  uv = center - (sinRes + rad)     *       diff ;
    
    vec3 col = texture(
//  vec3 col = texture(
    tex0     , uv).xyz;
//  tex0     , uv).xyz;

    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    fragColor = vec4(col
//  fragColor = vec4(col
    ,      1.0
//  ,      1.0
    ) ;
//  ) ;
    }
