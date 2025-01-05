#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// // 振動の強さ
// const float shake_powers     = 00.03;
// // 振動ブロックサイズ
// const float shake_block_size = 30.50;
// // 色の分離率
// const float             fade = 00.01;
// // R方向
// const vec2 direction_r = vec2(  1.0,  0.0 );
// // G方向
// const vec2 direction_g = vec2(  0.4,  1.0 );
// // B方向
// const vec2 direction_b = vec2( -0.7, -0.3 );

// 振動の強さ
uniform float shake_powers     ; // 00.03
// 振動ブロックサイズ
uniform float shake_block_size ; // 30.50
// 色の分離率
uniform float             fade ; // 00.01
// R方向
uniform vec2 direction_r ; //   1.0,  0.0 
// G方向
uniform vec2 direction_g ; //   0.4,  1.0 
// B方向
uniform vec2 direction_b ; //  -0.7, -0.3 

// float trunc(float x) {
//     if (x < 0.0) {
//         return ceil (x);
//     }       else {
//         return floor(x);
//     }
// }

float random( float seed )
{
    return fract( 543.2543 * sin( dot( vec2( seed, seed ), vec2( 3525.46, -54.3415 ) ) ) );
}

void main( )
{
    vec2 fixed_uv    =   vTexCoord;
         fixed_uv.x += (
        random(
            ( trunc    ( vTexCoord.y * shake_block_size ) / shake_block_size )
        +	time
        ) - 0.5f
    ) * shake_powers * ( fade * 12.0 );

    fragColor = vec4(
        textureLod( tex0, fixed_uv + normalize( direction_r ) * fade, 0.0 ).r
    ,	textureLod( tex0, fixed_uv + normalize( direction_g ) * fade, 0.0 ).g
    ,	textureLod( tex0, fixed_uv + normalize( direction_b ) * fade, 0.0 ).b
    ,	  0.0
    ) * ( 1.0   - fade );
    fragColor.a = 1.0f  ;
}


// https://godotshaders.com/shader/glitch-transition/

/*
    グリッチ トランジション シェーダー by あるる（きのもと 結衣） @arlez80
    グリッチ トランジション シェーダー by あるる（きのもと 結衣） @arlez80
    Glitch Transition Shader by Yui Kinomoto @arlez80
    Glitch Transition Shader by Yui Kinomoto @arlez80

    MIT License
    MIT License
*/











