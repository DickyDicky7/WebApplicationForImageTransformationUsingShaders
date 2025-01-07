#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/edge.glsl"

uniform vec2 pixels_scale; // 0.0, 0.0


void main()
{
    fragColor = edge(tex0, vTexCoord, pixels_scale) * texture(tex0, vTexCoord);
}

// https://lygia.xyz/filter/edge