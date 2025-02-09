#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/dither/shift.glsl"



void main()
{
    fragColor = ditherShift(texture(tex0, vTexCoord));
}




// https://lygia.xyz/color/dither/shift
// https://lygia.xyz/color/dither/shift
// https://lygia.xyz/color/dither/shift
