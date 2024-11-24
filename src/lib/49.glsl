#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float  radius_c =  000.200;
const float  radius_m = -000.300;
const float  radius_y =  000.000;
const float  radius_k =  000.785;

const float frequency =  400.000;

mat2 rotate( float r )
{
	float c = cos( r );
	float s = sin( r );
	return mat2(
		vec2(  c, s )
	,	vec2( -s, c )
	);
}

float f( float value, vec2 uv, float radius )
{
	return smoothstep( -1.0, 1.0, sqrt( value ) - length( 2.0 * fract( rotate( radius ) * ( frequency * uv ) ) - 1.0 ) );
}

void main( )
{
	vec3 color = texture( tex0, vTexCoord ).rgb;
	vec4 cmyk = vec4( vec3( 1.0 ) - color, 1.0 - max( max( color.r, color.g ), color.b ) );
	cmyk.xyz -= cmyk.w;

	float k = f( cmyk.w, vTexCoord, radius_k );
	float c = f( cmyk.x, vTexCoord, radius_c );
	float m = f( cmyk.y, vTexCoord, radius_m );
	float y = f( cmyk.z, vTexCoord, radius_y );

	vec3 new_color = mix(  vec3( 1.0 ) - 0.9 * vec3( c, m, y ), vec3( 0.0 ), 0.85 * k );

	fragColor = vec4( new_color, 1.0 );
}



// https://godotshaders.com/shader/halftone-cmyk-shader/

/*
	印刷物風ハーフトーンシェーダー by あるる（きのもと 結衣） @arlez80
	印刷物風ハーフトーンシェーダー by あるる（きのもと 結衣） @arlez80
	Halftone Shader by Yui Kinomoto
	Halftone Shader by Yui Kinomoto

	MIT License
	MIT License
*/







