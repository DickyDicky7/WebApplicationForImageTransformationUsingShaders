#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/filter/smartDeNoise.glsl"

uniform vec2     pixels; // 0.0, 0.0
uniform float     sigma; // 0.0
uniform float    kSigma; // 0.0
uniform float threshold; // 0.0

void main()
{
    fragColor = smartDeNoise(tex0, vTexCoord, pixels, sigma, kSigma, threshold);
}

// https://lygia.xyz/filter/smartDeNoise
// https://lygia.xyz/filter/smartDeNoise
// https://lygia.xyz/filter/smartDeNoise
