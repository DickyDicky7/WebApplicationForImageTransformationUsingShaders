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

#include "lygia/color/blend/colorBurn.glsl"
// #include "lygia/color/blend/colorBurn.glsl"

    uniform  vec3   blend; // 0.0, 0.0, 0.0
//  uniform  vec3   blend; // 0.0, 0.0, 0.0
    uniform float opacity; // 0.0
//  uniform float opacity; // 0.0

    void main()
    {
    vec4 currColor     =        texture(tex0         ,
//  vec4 currColor     =        texture(tex0         ,
    vTexCoord                    );
//  vTexCoord                    );
    currColor.rgb = blendColorBurn(currColor.rgb, blend, opacity);
//  currColor.rgb = blendColorBurn(currColor.rgb, blend, opacity);
    fragColor     =                currColor                     ;
//  fragColor     =                currColor                     ;
    }

    // https://lygia.xyz/color/blend/colorBurn
//  // https://lygia.xyz/color/blend/colorBurn
    // https://lygia.xyz/color/blend/colorBurn
//  // https://lygia.xyz/color/blend/colorBurn
    // https://lygia.xyz/color/blend/colorBurn
//  // https://lygia.xyz/color/blend/colorBurn
