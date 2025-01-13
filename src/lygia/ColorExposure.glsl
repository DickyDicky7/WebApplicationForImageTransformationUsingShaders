#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/exposure.glsl"

//const float exposureValues; // 0.0
uniform float exposureAmount; // 0.0

void main()
{
    fragColor = exposure(texture(tex0, vTexCoord), exposureAmount);
}

// https://lygia.xyz/color/exposure
// https://lygia.xyz/color/exposure
// https://lygia.xyz/color/exposure
