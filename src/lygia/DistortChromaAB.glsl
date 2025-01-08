#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/chromaAB.glsl"

uniform vec2  sdf; // 0.0, 0.0
uniform float pct; // 0.0

void main()
{
    fragColor = vec4(chromaAB(tex0, vTexCoord, sdf, pct), texture(tex0, vTexCoord).a);
}

// https://lygia.xyz/distort/chromaAB
// https://lygia.xyz/distort/chromaAB
// https://lygia.xyz/distort/chromaAB
