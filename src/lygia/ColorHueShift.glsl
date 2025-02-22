#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// ------------------------------------------
#define TAU 6.2831853071795864769252867665590
// ------------------------------------------

#include "lygia/color/hueShift.glsl"

//const float angle; // 0.0
uniform float angle; // 0.0

void main()
{
    fragColor = hueShift(texture(tex0, vTexCoord), angle);
}

// https://lygia.xyz/color/hueShift
// https://lygia.xyz/color/hueShift
// https://lygia.xyz/color/hueShift
