#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// const float  seed = 81.00;
// const float power = 00.03;
// const float speed = 00.00;

uniform float  seed ; // 81.00
uniform float power ; // 00.03
uniform float speed ; // 00.00

vec2 random( vec2 pos )
{ 
	return fract(
		sin(
			vec2(
				dot(pos, vec2(  012.9898 ,  78.233 ))
			,	dot(pos, vec2( -148.9980 , -65.233 ))
			)
		) * 43758.5453
	);
}

void main( )
{
	vec2 uv = vTexCoord + ( random( vTexCoord + vec2( seed - time * speed, time * speed ) ) - vec2( 0.5, 0.5 ) ) * power;
	          fragColor =
	textureLod(tex0, uv, 0.0);
}



// https://godotshaders.com/shader/screen-noise-effect-shader/

/*
	砂嵐エフェクト by あるる（きのもと 結衣）
	砂嵐エフェクト by あるる（きのもと 結衣）
	Screen Noise Effect Shader by Yui Kinomoto @arlez80
	Screen Noise Effect Shader by Yui Kinomoto @arlez80

	MIT License
	MIT License
*/


