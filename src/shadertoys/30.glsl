#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const vec2   redOffset = vec2(-0.1, 0.0);
const vec2 greenOffset = vec2( 0.1, 0.0);
const vec2  blueOffset = vec2( 0.1, 0.0);



void main() {
    vec2      fragCoord = gl_FragCoord.xy;
    vec2 uv = fragCoord /   canvasSize.xy;

    vec4 color;
    color.r = texture(tex0, uv +   redOffset).r;
    color.g = texture(tex0, uv + greenOffset).g;
    color.b = texture(tex0, uv +  blueOffset).b;
    color.a = texture(tex0, uv).a;

    fragColor = color;
}


// https://www.shadertoy.com/view/4tdyzH
