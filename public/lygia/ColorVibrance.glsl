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

#include "lygia/color/vibrance.glsl"
// #include "lygia/color/vibrance.glsl"


    //const float amountVibrance; // 0.0
//  //const float amountVibrance; // 0.0
    uniform float amountVibrance; // 0.0
//  uniform float amountVibrance; // 0.0


    void main()
    {
 
    fragColor = vibrance(texture(tex0, vTexCoord), amountVibrance);
//  fragColor = vibrance(texture(tex0, vTexCoord), amountVibrance);

    }

    // https://lygia.xyz/color/vibrance
//  // https://lygia.xyz/color/vibrance
    // https://lygia.xyz/color/vibrance
//  // https://lygia.xyz/color/vibrance
    // https://lygia.xyz/color/vibrance
//  // https://lygia.xyz/color/vibrance
