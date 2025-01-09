#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/dither/triangleNoise.glsl"



void main()
{
    fragColor = ditherTriangleNoise(texture(tex0, vTexCoord));
}



// https://lygia.xyz/color/dither/triangleNoise
// https://lygia.xyz/color/dither/triangleNoise
// https://lygia.xyz/color/dither/triangleNoise
