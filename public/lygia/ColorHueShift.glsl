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

    // ------------------------------------------
//  // ------------------------------------------
#define TAU 6.2831853071795864769252867665590
// #define TAU 6.2831853071795864769252867665590
    // ------------------------------------------
//  // ------------------------------------------

#include "lygia/color/hueShift.glsl"
// #include "lygia/color/hueShift.glsl"

    //const float angle; // 0.0
//  //const float angle; // 0.0
    uniform float angle; // 0.0
//  uniform float angle; // 0.0

    void main()
    {
    fragColor = hueShift(texture(tex0, vTexCoord), angle);
//  fragColor = hueShift(texture(tex0, vTexCoord), angle);
    }

    // https://lygia.xyz/color/hueShift
//  // https://lygia.xyz/color/hueShift
    // https://lygia.xyz/color/hueShift
//  // https://lygia.xyz/color/hueShift
    // https://lygia.xyz/color/hueShift
//  // https://lygia.xyz/color/hueShift
