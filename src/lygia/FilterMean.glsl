#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/mean.glsl"

uniform vec2 offset    ; // 0.0, 0.0
//const int  kernelSize; // 0.0

void main()
{
    fragColor = mean(tex0, vTexCoord, offset);
}

// https://lygia.xyz/filter/mean
// https://lygia.xyz/filter/mean
// https://lygia.xyz/filter/mean
