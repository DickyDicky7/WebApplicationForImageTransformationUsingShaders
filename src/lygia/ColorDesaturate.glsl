#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/desaturate.glsl"

//const float desaturateValues; // 0.0
uniform float desaturateAmount; // 0.0

void main()
{
    fragColor = desaturate(texture(tex0, vTexCoord), desaturateAmount);
}

// https://lygia.xyz/color/desaturate
// https://lygia.xyz/color/desaturate
// https://lygia.xyz/color/desaturate
