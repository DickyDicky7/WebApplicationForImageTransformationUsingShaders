#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#include "lygia/color/blend/glow.glsl"

uniform  vec3   blend; // 0.0, 0.0, 0.0
uniform float opacity; // 0.0

void main()
{
    vec4 currColor     =   texture(tex0         ,
                                   vTexCoord                    );
         currColor.rgb = blendGlow(currColor.rgb, blend, opacity);
         fragColor     =           currColor                     ;
}

// https://lygia.xyz/color/blend/glow
// https://lygia.xyz/color/blend/glow
// https://lygia.xyz/color/blend/glow
