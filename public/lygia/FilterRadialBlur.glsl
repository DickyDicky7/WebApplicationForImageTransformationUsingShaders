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

    #include "lygia/filter/radialBlur.glsl"
//  #include "lygia/filter/radialBlur.glsl"

    uniform vec2  direction; // 0.0, 0.0
//  uniform vec2  direction; // 0.0, 0.0
    uniform float strengths; // 0.0
//  uniform float strengths; // 0.0

    void main()
    {
    fragColor = radialBlur(tex0, vTexCoord, direction, strengths);
//  fragColor = radialBlur(tex0, vTexCoord, direction, strengths);
    }

    // https://lygia.xyz/filter/radialBlur
//  // https://lygia.xyz/filter/radialBlur
    // https://lygia.xyz/filter/radialBlur
//  // https://lygia.xyz/filter/radialBlur
    // https://lygia.xyz/filter/radialBlur
//  // https://lygia.xyz/filter/radialBlur
