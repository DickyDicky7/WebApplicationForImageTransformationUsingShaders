#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/tonemap/reinhardJodie.glsl"



void main()
{
    fragColor = tonemapReinhardJodie(texture(tex0, vTexCoord));
}

// https://lygia.xyz/color/tonemap/reinhardJodie
// https://lygia.xyz/color/tonemap/reinhardJodie
// https://lygia.xyz/color/tonemap/reinhardJodie
