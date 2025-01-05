#version 300 es
precision highp  float;
uniform sampler2D tex0;
in      vec2 vTexCoord;
out     vec4 fragColor;
void main() {
    fragColor = texture(tex0, vTexCoord);
}

// https://www.shadertoy.com/view/3sySRK

