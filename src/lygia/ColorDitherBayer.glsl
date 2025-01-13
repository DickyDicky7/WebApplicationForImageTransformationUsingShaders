#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/dither/bayer.glsl"



void main()
{
    fragColor = ditherBayer(texture(tex0, vTexCoord));
}



// https://lygia.xyz/color/dither/bayer
// https://lygia.xyz/color/dither/bayer
// https://lygia.xyz/color/dither/bayer
