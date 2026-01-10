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

    // https://www.shadertoy.com/view/7dKGRK
//  // https://www.shadertoy.com/view/7dKGRK

    void main()
    {
    float ratio = (sin(50.0 * time) * 0.5 + 0.5);
//  float ratio = (sin(50.0 * time) * 0.5 + 0.5);
    vec2     uv = vTexCoord;
//  vec2     uv = vTexCoord;
    vec3  col   =                vec3(
//  vec3  col   =                vec3(
    1.2 * texture(tex0, uv                          ).r,
//  1.2 * texture(tex0, uv                          ).r,
    1.2 * texture(tex0, uv + vec2(0.01 * ratio, 0.0)).r,
//  1.2 * texture(tex0, uv + vec2(0.01 * ratio, 0.0)).r,
    1.2 * texture(tex0, uv + vec2(0.02 * ratio, 0.0)).r
//  1.2 * texture(tex0, uv + vec2(0.02 * ratio, 0.0)).r
    );
//  );
    col *= 0.4 + 0.6 * ratio;
//  col *= 0.4 + 0.6 * ratio;
    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }














