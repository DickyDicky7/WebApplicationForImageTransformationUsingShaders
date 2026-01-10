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

    #include "lygia/color/tonemap/reinhard.glsl"
//  #include "lygia/color/tonemap/reinhard.glsl"



    void main()
    {
    fragColor = tonemapReinhard(texture(tex0, vTexCoord));
//  fragColor = tonemapReinhard(texture(tex0, vTexCoord));
    }

    // https://lygia.xyz/color/tonemap/reinhard
//  // https://lygia.xyz/color/tonemap/reinhard
    // https://lygia.xyz/color/tonemap/reinhard
//  // https://lygia.xyz/color/tonemap/reinhard
    // https://lygia.xyz/color/tonemap/reinhard
//  // https://lygia.xyz/color/tonemap/reinhard
