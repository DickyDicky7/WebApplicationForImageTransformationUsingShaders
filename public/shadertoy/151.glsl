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

    // https://www.shadertoy.com/view/ddVyzG
//  // https://www.shadertoy.com/view/ddVyzG

    #define pi 3.14159265359
//  #define pi 3.14159265359


    uniform float speed   ; // 0.3
//  uniform float speed   ; // 0.3
    uniform float density ; // 4.0
//  uniform float density ; // 4.0


    void main()
    {
    vec2 uv = vTexCoord; vec3 original_col = texture(tex0, uv).rgb; vec3 col = vec3(length(original_col) / sqrt(3.0)); col *= density; col += speed * time; col = mod(col, 1.0); col = 0.5 * sin(col * 2.0 * pi) + 0.5; fragColor = vec4(col, 1.0);
//  vec2 uv = vTexCoord; vec3 original_col = texture(tex0, uv).rgb; vec3 col = vec3(length(original_col) / sqrt(3.0)); col *= density; col += speed * time; col = mod(col, 1.0); col = 0.5 * sin(col * 2.0 * pi) + 0.5; fragColor = vec4(col, 1.0);
    }




