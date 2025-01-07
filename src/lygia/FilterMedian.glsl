#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/median.glsl"

uniform vec2 pixel_offset; // 0.0, 0.0


void main()
{
    fragColor = median(tex0, vTexCoord, pixel_offset);
}

// https://lygia.xyz/filter/median