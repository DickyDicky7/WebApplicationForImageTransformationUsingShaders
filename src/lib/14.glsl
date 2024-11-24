#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


/*
	Glitch Effect@ Shader by Yui Kinomoto @arlez80
    @@@@@@ @@@@@@@
	MIT@@@ License
*/



const float shake_power = 0.03;
const float shake_rate  = 0.20;
const float shake_speed = 5.00;
const float shake_block_size = 30.50;
const float shake_color_rate = 00.01;


float random( float seed )
{
	return fract( 543.2543 * sin( dot( vec2( seed, seed ), vec2( 3525.46, -54.3415 ) ) ) );
}

// float trunc(float x) {
//     if (x < 0.0) {
//         return ceil (x);
//     }       else {
//         return floor(x);
//     }
// }

void main( )
{
	float enable_shift = float(
		random( trunc( time * shake_speed ) )
	<	shake_rate
	);

	vec2
    fixed_uv    =      vTexCoord;
	fixed_uv.x +=    (
		random(
			  ( trunc( vTexCoord.y * shake_block_size ) / shake_block_size )
		+	time
		) - 0.50
	) * shake_power * enable_shift;

	vec4 pixel_color = textureLod( tex0, fixed_uv, 0.0 );
	pixel_color.r = mix(
		pixel_color.r
	,	textureLod( tex0, fixed_uv + vec2(  shake_color_rate, 0.0 ), 0.0 ).r
	,	enable_shift
	);
	pixel_color.b = mix(
		pixel_color.b
	,	textureLod( tex0, fixed_uv + vec2( -shake_color_rate, 0.0 ), 0.0 ).b
	,	enable_shift
	);
	fragColor = pixel_color;
}


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/glitch-effect-shader-for-godot-engine-4/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@







