#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/brightnessContrast.glsl"

uniform float brightness; // 0.0
uniform float contrast__; // 0.0

void main()
{
    fragColor = brightnessContrast(texture(tex0, vTexCoord), brightness, contrast__);
}

// https://lygia.xyz/color/brightnessContrast
// https://lygia.xyz/color/brightnessContrast
// https://lygia.xyz/color/brightnessContrast
