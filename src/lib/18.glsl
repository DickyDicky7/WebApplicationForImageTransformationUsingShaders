#version 100
precision highp float;

uniform sampler2D  tex0;
varying vec2           vTexCoord;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


const float alpha       =  0.5;
const float scale       =  1.5;
const float border_mask =  2.0;
const float strength    = 25.0;

void main() {
	float                   scale_reverse =      2.0 - scale              ;
	vec2 uvss = vTexCoord * scale_reverse + vec2(1.0 - scale_reverse) / 2.;
	vec2 mask =                                                           pow(2.0 * abs(vTexCoord - 0.5), vec2(border_mask));
	
    vec2 screen_pixel_size = 1.0 / canvasSize;

	float r = texture2D(tex0, (uvss + vec2(screen_pixel_size  * strength) * mask), 0.0).r;
	float g = texture2D(tex0, (uvss + vec2(screen_pixel_size)             * mask), 0.0).g;
	float b = texture2D(tex0, (uvss + vec2(screen_pixel_size  * strength) * mask), 0.0).b;
	
	gl_FragColor = vec4(r, g, b, alpha);
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/aberration-phasmophobia-effect/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

















