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

    #include "lygia/distort/grain.glsl"
//  #include "lygia/distort/grain.glsl"

    uniform float t         ; // 0.0
//  uniform float t         ; // 0.0
    uniform float multiplier; // 0.0
//  uniform float multiplier; // 0.0

    void main()
    {
    fragColor = vec4(grain(tex0, vTexCoord, canvasSize, t, multiplier), texture(tex0, vTexCoord).a);
//  fragColor = vec4(grain(tex0, vTexCoord, canvasSize, t, multiplier), texture(tex0, vTexCoord).a);
    }

    // https://lygia.xyz/distort/grain
//  // https://lygia.xyz/distort/grain
    // https://lygia.xyz/distort/grain
//  // https://lygia.xyz/distort/grain
    // https://lygia.xyz/distort/grain
//  // https://lygia.xyz/distort/grain
