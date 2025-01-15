#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/radialBlur.glsl"

uniform vec2  direction; // 0.0, 0.0
uniform float strengths; // 0.0

void main()
{
    fragColor = radialBlur(tex0, vTexCoord, direction, strengths);
}

// https://lygia.xyz/filter/radialBlur
// https://lygia.xyz/filter/radialBlur
// https://lygia.xyz/filter/radialBlur
