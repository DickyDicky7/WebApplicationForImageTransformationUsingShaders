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

#include "lygia/filter/fibonacciBokeh.glsl"
// #include "lygia/filter/fibonacciBokeh.glsl"

    uniform vec2  pixels; // 0.0, 0.0
//  uniform vec2  pixels; // 0.0, 0.0
    uniform float amount; // 0.0
//  uniform float amount; // 0.0

    void main()
    {
    fragColor = fibonacciBokeh(tex0, vTexCoord, pixels, amount);
//  fragColor = fibonacciBokeh(tex0, vTexCoord, pixels, amount);
    }

    // https://lygia.xyz/filter/fibonacciBokeh
//  // https://lygia.xyz/filter/fibonacciBokeh
    // https://lygia.xyz/filter/fibonacciBokeh
//  // https://lygia.xyz/filter/fibonacciBokeh
    // https://lygia.xyz/filter/fibonacciBokeh
//  // https://lygia.xyz/filter/fibonacciBokeh
