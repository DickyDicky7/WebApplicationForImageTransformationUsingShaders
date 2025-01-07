#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/kuwahara.glsl"

uniform vec2  pixels; // 0.0, 0.0
uniform float radius; // 0.0

void main()
{
    fragColor = kuwahara(tex0, vTexCoord, pixels, radius);
}

// https://lygia.xyz/filter/kuwahara