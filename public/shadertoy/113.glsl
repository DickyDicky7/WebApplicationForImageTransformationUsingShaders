#version 300 es
// #version 300 es
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

    // https://www.shadertoy.com/view/X3GczK
//  // https://www.shadertoy.com/view/X3GczK


    void main()
    {
    float t      = time * .5;
//  float t      = time * .5;
    float radius = 100.     ;
//  float radius = 100.     ;
    
    vec2   uv =        vTexCoord;
//  vec2   uv =        vTexCoord;
    vec4 tex1 = texture(tex0,uv);
//  vec4 tex1 = texture(tex0,uv);
    
    float cord = smoothstep(0.0
//  float cord = smoothstep(0.0
    ,            0.1
//  ,            0.1
    , sin(uv.x * 1. + cos(uv.y + t) * radius * (uv.x     ))
//  , sin(uv.x * 1. + cos(uv.y + t) * radius * (uv.x     ))
    + sin(uv.x + t) * radius * (uv.x - .5));
//  + sin(uv.x + t) * radius * (uv.x - .5));
    
    vec3 col = tex1.rgb * clamp(
//  vec3 col = tex1.rgb * clamp(
    cord,
//  cord,
    0.00,
//  0.00,
    1.00            );
//  1.00            );
    
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











