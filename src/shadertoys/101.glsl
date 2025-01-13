#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/43KyRW

void main() { vec2 U = sin(1.571 * gl_FragCoord); U /= fwidth(U); float v = textureLod(tex0, vTexCoord, 2.).r; fragColor = vec4( v > .6 ? max(U.x, U.y) : v <.33 ? U.x : U.y ) / 10.;
            }




            