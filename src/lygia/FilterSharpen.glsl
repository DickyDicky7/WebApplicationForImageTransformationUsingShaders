#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/sharpen.glsl"

uniform vec2  direction; // 0.0, 0.0
uniform float strengths; // 0.0

void main()
{
    fragColor = vec4(sharpen(tex0, vTexCoord, direction, strengths), texture(tex0, vTexCoord).a);
}

// https://lygia.xyz/filter/sharpen