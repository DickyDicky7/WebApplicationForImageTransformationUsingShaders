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

#include "lygia/filter/jointBilateral.glsl"
// #include "lygia/filter/jointBilateral.glsl"

    uniform vec2 offset    ; // 0.0, 0.0
//  uniform vec2 offset    ; // 0.0, 0.0
    uniform int  kernelSize; // 0.0
//  uniform int  kernelSize; // 0.0

    void main()
    {
    fragColor = jointBilateral(tex0, vTexCoord, offset, kernelSize);
//  fragColor = jointBilateral(tex0, vTexCoord, offset, kernelSize);
    }

    // https://lygia.xyz/filter/jointBilateral
//  // https://lygia.xyz/filter/jointBilateral
    // https://lygia.xyz/filter/jointBilateral
//  // https://lygia.xyz/filter/jointBilateral
    // https://lygia.xyz/filter/jointBilateral
//  // https://lygia.xyz/filter/jointBilateral
