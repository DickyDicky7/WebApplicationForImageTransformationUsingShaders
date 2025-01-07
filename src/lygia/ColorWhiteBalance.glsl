#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/whiteBalance.glsl"




uniform float amountWhiteBalanceTemperature;
uniform float amountWhiteBalanceTint       ;



void main()
{
    fragColor = whiteBalance(texture(tex0,vTexCoord), amountWhiteBalanceTemperature, amountWhiteBalanceTint);

}

// https://lygia.xyz/color/whiteBalance