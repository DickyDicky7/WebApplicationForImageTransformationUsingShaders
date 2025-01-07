#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/distort/stretch.glsl"

uniform vec2 direction    ; // 0.0, 0.0
uniform int  samples; // 0.0

void main()
{
    fragColor = stretch(tex0, vTexCoord, direction, samples);
}

// https://lygia.xyz/distort/stretch