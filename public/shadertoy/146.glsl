#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    uniform         sampler2D        noise0; // null
//  uniform         sampler2D        noise0; // null
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

    // https://www.shadertoy.com/view/ws3yD7
//  // https://www.shadertoy.com/view/ws3yD7

    void main()
    {
    vec2 uv  =        vTexCoord    ;
//  vec2 uv  =        vTexCoord    ;
    vec3 col = texture(tex0,uv).rgb;
//  vec3 col = texture(tex0,uv).rgb;
    
    /////////////////
//  /////////////////
    // Color shift //
//  // Color shift //
    /////////////////
//  /////////////////
    float shift = 0.01;
//  float shift = 0.01;
    col = vec3(
//  col = vec3(
    length(texture(tex0, uv                   ).rgb) / sqrt(3.0),
//  length(texture(tex0, uv                   ).rgb) / sqrt(3.0),
    length(texture(tex0, uv                   ).rgb) / sqrt(3.0),
//  length(texture(tex0, uv                   ).rgb) / sqrt(3.0),
    length(texture(tex0, uv + vec2(shift, 0.0)).rgb) / sqrt(3.0)
//  length(texture(tex0, uv + vec2(shift, 0.0)).rgb) / sqrt(3.0)
    );
//  );
    
    /////////////////
//  /////////////////
    //    Grain    //
//  //    Grain    //
    /////////////////
//  /////////////////
    float  grain_power =                                                0.1      ;
//  float  grain_power =                                                0.1      ;
    vec3   noise       = texture(noise0, mod(uv + vec2(0, 10.0 * time), 1.0)).rgb;
//  vec3   noise       = texture(noise0, mod(uv + vec2(0, 10.0 * time), 1.0)).rgb;
    col += grain_power
//  col += grain_power
    *  noise.r     ;
//  *  noise.r     ;
    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }





