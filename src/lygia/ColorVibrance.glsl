#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/vibrance.glsl"


//const float amountVibrance; // 0.0
uniform float amountVibrance; // 0.0


void main()
{
 
    fragColor = vibrance(texture(tex0, vTexCoord), amountVibrance);

}

// https://lygia.xyz/color/vibrance
// https://lygia.xyz/color/vibrance
// https://lygia.xyz/color/vibrance
