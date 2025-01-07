#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/pincushion.glsl"

uniform vec2  pixels; // 0.0, 0.0
uniform float amount; // 0.0

void main()
{
    fragColor = vec4(pincushion(tex0, vTexCoord, pixels, amount), texture(tex0, vTexCoord).a);
}

// https://lygia.xyz/distort/pincushion