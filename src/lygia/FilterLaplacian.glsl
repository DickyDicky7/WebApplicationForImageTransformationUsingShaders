#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/laplacian.glsl"

uniform vec2  pixels_scaling; // 0.0, 0.0
uniform float pixels_padding; // 0.0

void main()
{
    fragColor = laplacian(tex0, vTexCoord, pixels_scaling, pixels_padding);
}

// https://lygia.xyz/filter/laplacian
// https://lygia.xyz/filter/laplacian
// https://lygia.xyz/filter/laplacian
