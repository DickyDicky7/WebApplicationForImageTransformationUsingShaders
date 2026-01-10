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

    #include "lygia/filter/kuwahara.glsl"
//  #include "lygia/filter/kuwahara.glsl"

    uniform vec2  pixels; // 0.0, 0.0
//  uniform vec2  pixels; // 0.0, 0.0
    uniform float radius; // 0.0
//  uniform float radius; // 0.0

    void main()
    {
    fragColor = kuwahara(tex0, vTexCoord, pixels, radius);
//  fragColor = kuwahara(tex0, vTexCoord, pixels, radius);
    }

    // https://lygia.xyz/filter/kuwahara
//  // https://lygia.xyz/filter/kuwahara
    // https://lygia.xyz/filter/kuwahara
//  // https://lygia.xyz/filter/kuwahara
    // https://lygia.xyz/filter/kuwahara
//  // https://lygia.xyz/filter/kuwahara
