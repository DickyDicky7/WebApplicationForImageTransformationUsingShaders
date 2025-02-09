#version 300 es
precision  lowp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;





// const lowp float alpha = 0.5;
// const lowp float scale = 1.0;

// const lowp float  rred_shift = 10.0;
// const lowp float  blue_shift = 20.0;
// const lowp float green_shift = 30.0;

// const lowp float red_mult = 1.0;

uniform float alpha       ; //  0.5
uniform float scale       ; //  1.0
uniform float  rred_shift ; // 10.0
uniform float  blue_shift ; // 20.0
uniform float green_shift ; // 30.0
uniform float red_mult    ; //  1.0

void main() {
	vec2  uvs = vTexCoord * scale;
	vec4  final_texture    =       texture(tex0, uvs);
	vec2 screen_pixel_size = 1.0 / canvasSize          ;
	float r = texture(tex0, uvs + vec2(screen_pixel_size *  rred_shift), 0.0).r * red_mult;
	float g = texture(tex0, uvs + vec2(screen_pixel_size * green_shift), 0.0).g           ;
	float b = texture(tex0, uvs + vec2(screen_pixel_size *  blue_shift), 0.0).b           ;
	
	fragColor = vec4(r, g, b, alpha);
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/double-vision-w-chromatic-aberration/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@













