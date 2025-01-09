#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/tonemap/reinhard.glsl"



void main()
{
    fragColor = tonemapReinhard(texture(tex0, vTexCoord));
}

// https://lygia.xyz/color/tonemap/reinhard
// https://lygia.xyz/color/tonemap/reinhard
// https://lygia.xyz/color/tonemap/reinhard
