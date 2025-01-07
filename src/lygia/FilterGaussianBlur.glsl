#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/gaussianBlur.glsl"

uniform vec2 pixel_direction    ; // 0.0, 0.0
uniform int  kernelSize; // 0.0

void main()
{
    fragColor = gaussianBlur(tex0, vTexCoord, pixel_direction, kernelSize);
}

// https://lygia.xyz/filter/gaussianBlur