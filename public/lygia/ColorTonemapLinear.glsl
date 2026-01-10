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

    #include "lygia/color/tonemap/linear.glsl"
//  #include "lygia/color/tonemap/linear.glsl"



    void main()
    {
    fragColor = tonemapLinear(texture(tex0, vTexCoord));
//  fragColor = tonemapLinear(texture(tex0, vTexCoord));
    }

    // https://lygia.xyz/color/tonemap/linear
//  // https://lygia.xyz/color/tonemap/linear
    // https://lygia.xyz/color/tonemap/linear
//  // https://lygia.xyz/color/tonemap/linear
    // https://lygia.xyz/color/tonemap/linear
//  // https://lygia.xyz/color/tonemap/linear
