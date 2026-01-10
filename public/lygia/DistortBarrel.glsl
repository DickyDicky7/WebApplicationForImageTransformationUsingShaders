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

#include "lygia/distort/barrel.glsl"
// #include "lygia/distort/barrel.glsl"

    uniform vec2 sdf; // 0.0, 0.0
//  uniform vec2 sdf; // 0.0, 0.0
    //const vec2 pct; // 0.0, 0.0
//  //const vec2 pct; // 0.0, 0.0

    void main()
    {
    fragColor = vec4(barrel(tex0, vTexCoord, sdf), texture(tex0, vTexCoord).a);
//  fragColor = vec4(barrel(tex0, vTexCoord, sdf), texture(tex0, vTexCoord).a);
    }

    // https://lygia.xyz/distort/barrel
//  // https://lygia.xyz/distort/barrel
    // https://lygia.xyz/distort/barrel
//  // https://lygia.xyz/distort/barrel
    // https://lygia.xyz/distort/barrel
//  // https://lygia.xyz/distort/barrel
