#version 100
precision highp float;

uniform sampler2D  tex0;
varying vec2           vTexCoord;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


const float threshold = 0.5;
const float delta     = 0.2;

void main() {
    vec4 screen_color = texture2D(tex0, vTexCoord); // Get the color from the screen texture

    float avg = (screen_color.r + screen_color.g + screen_color.b) / 3.0;

    if(avg < threshold) {
        gl_FragColor.rgb = vec3(screen_color.r - delta, screen_color.r - delta, screen_color.r - delta);
    } else {
        gl_FragColor.rgb = vec3(screen_color.r + delta, screen_color.r + delta, screen_color.r + delta);
    }
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/grey-threshold/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

