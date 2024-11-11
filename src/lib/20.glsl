#version 100
precision highp float;

uniform sampler2D  tex0;
varying vec2           vTexCoord;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


// chromatic aberration
//---------------------------------



const vec2 r_displacement = vec2( 3.0, 0.0);
const vec2 g_displacement = vec2( 0.0, 0.0);
const vec2 b_displacement = vec2(-3.0, 0.0);


void main()
{
    vec2 screen_pixel_size = 1.0 / canvasSize;

	float r = texture2D(tex0, vTexCoord + vec2(screen_pixel_size * r_displacement), 0.0).r;
	float g = texture2D(tex0, vTexCoord + vec2(screen_pixel_size * g_displacement), 0.0).g;
	float b = texture2D(tex0, vTexCoord + vec2(screen_pixel_size * b_displacement), 0.0).b;
	
	gl_FragColor = vec4(r, g, b, 1.0);
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/just-chromatic-aberration/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@















