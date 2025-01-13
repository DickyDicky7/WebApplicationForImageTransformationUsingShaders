#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/noiseBlur.glsl"

uniform vec2  pixels; // 0.0, 0.0
uniform float radius; // 0.0

void main()
{
    fragColor = noiseBlur(tex0, vTexCoord, pixels, radius);
}

// https://lygia.xyz/filter/noiseBlur
// https://lygia.xyz/filter/noiseBlur
// https://lygia.xyz/filter/noiseBlur
