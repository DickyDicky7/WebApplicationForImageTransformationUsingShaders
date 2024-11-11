#version 100
precision highp float;

uniform sampler2D  tex0;
varying vec2           vTexCoord;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// Big thanks to both jecovier and axilirate, who's shaders I built upon
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


const vec2 r_displacement = vec2( 3.0, 0.0);
const vec2 g_displacement = vec2( 0.0, 0.0);
const vec2 b_displacement = vec2(-3.0, 0.0);

const float height = 0.7;
const float widtht = 0.5;
const float fade   = 0.7;

void main() {
    float shrink_widtht = 2.0 / widtht;
    float shrink_height = 2.0 / height;
    float dist = distance(vec2(vTexCoord.x * shrink_widtht, vTexCoord.y * shrink_height), vec2(0.5 * shrink_widtht, 0.5 * shrink_height));

    vec2 screen_pixel_size = 1.0 / canvasSize;

    float r = texture2D(tex0, vTexCoord + vec2(screen_pixel_size * r_displacement), 0.0).r;
    float g = texture2D(tex0, vTexCoord + vec2(screen_pixel_size * g_displacement), 0.0).g;
    float b = texture2D(tex0, vTexCoord + vec2(screen_pixel_size * b_displacement), 0.0).b;

    gl_FragColor = vec4(r, g, b, dist - fade);
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/chromatic-aberration-vignette/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@









