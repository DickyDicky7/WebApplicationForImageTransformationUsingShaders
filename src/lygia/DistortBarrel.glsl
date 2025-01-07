#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/barrel.glsl"

uniform float distances; // 0.0

void main()
{
    fragColor = vec4(barrel(tex0, vTexCoord, distances), texture(tex0, vTexCoord).a);
}

// https://lygia.xyz/distort/barrel