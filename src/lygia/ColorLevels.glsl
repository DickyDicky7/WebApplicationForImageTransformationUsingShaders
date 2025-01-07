#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/levels"


uniform vec3 minInput; // 0.0, 0.0, 0.0
uniform vec3 gamma; // 0.0, 0.0, 0.0
uniform vec3 maxInput; // 0.0, 0.0, 0.0
uniform vec3 minOutput; // 0.0, 0.0, 0.0
uniform vec3 maxOutput; // 0.0, 0.0, 0.0
void main()
{
    fragColor = levels(texture(tex0, vTexCoord), minInput, gamma, maxInput, minOutput, maxOutput);
}

// https://lygia.xyz/color/levels