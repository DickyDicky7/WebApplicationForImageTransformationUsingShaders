#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/contrast"


uniform float contrastAmount; // 0.0

void main()
{
    fragColor = contrast(texture(tex0, vTexCoord), contrastAmount);
}

// https://lygia.xyz/color/contrast