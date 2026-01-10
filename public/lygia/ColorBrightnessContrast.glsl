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

#include "lygia/color/brightnessContrast.glsl"
// #include "lygia/color/brightnessContrast.glsl"

    uniform float brightness; // 0.0
//  uniform float brightness; // 0.0
    uniform float contrastVL; // 0.0
//  uniform float contrastVL; // 0.0

    void main()
    {
    fragColor = brightnessContrast(texture(tex0, vTexCoord), brightness, contrastVL);
//  fragColor = brightnessContrast(texture(tex0, vTexCoord), brightness, contrastVL);
    }

    // https://lygia.xyz/color/brightnessContrast
//  // https://lygia.xyz/color/brightnessContrast
    // https://lygia.xyz/color/brightnessContrast
//  // https://lygia.xyz/color/brightnessContrast
    // https://lygia.xyz/color/brightnessContrast
//  // https://lygia.xyz/color/brightnessContrast
