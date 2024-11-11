#version 100
precision highp float;

uniform sampler2D  tex0;
varying vec2           vTexCoord;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


uniform sampler2D gradient;
const float        depth   = 0.03;
const   int line_thickness = 7   ;

void main() {
    vec3 color = texture2D(tex0, vTexCoord).rgb;
    float grayscale_value  = dot(color, vec3(0.299, 0.587, 0.114));
    if(int(gl_FragCoord.x  +
           gl_FragCoord.y) % (2 * line_thickness)
                                < line_thickness) {
          grayscale_value -= depth;
    }

    vec3 sampled_color = texture2D(gradient, vec2(grayscale_value, 0.0)).rgb;

    gl_FragColor.rgb = sampled_color;
    gl_FragColor.a   = 1.0          ;
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/line-pattern-cell-shading/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

















