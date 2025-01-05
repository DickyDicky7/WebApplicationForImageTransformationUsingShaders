#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


// float round(float x) {
//     return floor(x + 0.5);
// }

// vec2 round(vec2 v) {
//     return vec2(round(v.x), round(v.y));
// }

// vec3 round(vec3 v) {
//     return vec3(round(v.x), round(v.y), round(v.z));
// }

// vec4 round(vec4 v) {
//     return vec4(round(v.x), round(v.y), round(v.z), round(v.w));
// }

//const float resolution =    32.0; // 4 - 16 - 32 - 64 - 128
uniform float resolution ; // 32.0
void main() {
    fragColor = texture(tex0, round(vTexCoord * (resolution + 1.0) - (vTexCoord - 0.5)) / (resolution + 1.0));
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/pixelize/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@















