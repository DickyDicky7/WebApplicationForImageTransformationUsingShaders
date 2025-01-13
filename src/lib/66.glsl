#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// // ブラウン管のガラスの曲がり具合（フラットなやつは0.0でいいかな）
// // ブラウン管のガラスの曲がり具合（フラットなやつは0.0でいいかな）
// const float crt_curve            = 0.020;
// // 走査線の濃さ
// // 走査線の濃さ
// const float crt_scan_line_color  = 0.347;
// // 光量
// // 光量
// const float aperture_grille_rate = 0.400;
// // RFスイッチ的ブラー
// // RFスイッチ的ブラー
// const float rf_switch_esque_blur = 1.000;
// // 白色ノイズ
// // 白色ノイズ
// const float     white_noise_rate = 0.000;

// ブラウン管のガラスの曲がり具合（フラットなやつは0.0でいいかな）
// ブラウン管のガラスの曲がり具合（フラットなやつは0.0でいいかな）
uniform float crt_curve            ; //   0.020
// 走査線の濃さ
// 走査線の濃さ
uniform float crt_scan_line_color  ; //   0.347
// 光量
// 光量
uniform float aperture_grille_rate ; //   0.400
// RFスイッチ的ブラー
// RFスイッチ的ブラー
uniform float rf_switch_esque_blur ; //   1.000
// 白色ノイズ
// 白色ノイズ
uniform float     white_noise_rate ; //   0.000

const   float PI = 3.14;

float random( vec2 pos )
{ 
    return fract(sin(dot(pos, vec2(12.9898,78.233))) * 43758.5453);
}

void main( )
{
    // ガラスの曲がり具合
    // ガラスの曲がり具合
    vec2 crt_curve_shift = ( vec2( 1.0, 1.0 ) - sin( vTexCoord.yx * PI ) ) * crt_curve;
    vec2 crt_curve_scale =   vec2( 1.0, 1.0 ) +           crt_curve_shift  * 2.0      ;
    vec2 texture_fixed_uv = vTexCoord * crt_curve_scale - crt_curve_shift;
    vec2         fixed_uv = vTexCoord * crt_curve_scale - crt_curve_shift;
    // 範囲外を消す
    // 範囲外を消す
    float enable_color = float( 0.0 <= texture_fixed_uv.x && texture_fixed_uv.x <= 1.0 &&
                                0.0 <= texture_fixed_uv.y && texture_fixed_uv.y <= 1.0 );

    // ガラスの曲がり具合から元色を取得 + RFスイッチ的ブラー
    // ガラスの曲がり具合から元色を取得 + RFスイッチ的ブラー
    fragColor.rgb = (
        (
            texture (    tex0, fixed_uv ). rgb
        *	( 1.0 - rf_switch_esque_blur * 0.50 )
        )
    +	(
            (
                texture( tex0, fixed_uv + vec2( -(1.0 / canvasSize).x * 3.1, 0.0 ) ).rgb
            +	texture( tex0, fixed_uv + vec2(  (1.0 / canvasSize).x * 3.1, 0.0 ) ).rgb
            )
            *	(   rf_switch_esque_blur * 0.25 )	// （RFノイズ）0.5 * （テクスチャから読んだ2箇所を半分にしたい）0.5
        )
    ) * enable_color   ;
    fragColor.a   = 1.0;

    // ------------------------------------------------
    // ------------------------------------------------
    // 以下はアパーチャグリル上の1ピクセルごとの処理
    // 以下はアパーチャグリル上の1ピクセルごとの処理
    vec2 aperture_grille_pixel = vec2( floor( ( fixed_uv.x / (1.0 / canvasSize).x ) / 3.0 ) * 3.0, fixed_uv.y );

    // 白色ノイズ
    // 白色ノイズ
    float white_noise = random( aperture_grille_pixel + vec2( sin( time * 0.543254000 ) ,
                                                              cos( time * 0.254323563 ) ) );
    fragColor.rgb = mix(
    fragColor.rgb
    ,	vec3( white_noise,
              white_noise,
              white_noise )
    ,   white_noise_rate * enable_color
    );

    // アパーチャグリル再現
    // アパーチャグリル再現
    float aperture_grille_point = mod( ( ( vTexCoord.x * crt_curve_scale.x ) - crt_curve_shift.x ) / (1.0 / canvasSize).x, 3.0 );
    float aperture_grille_r_rate = clamp( 1.0 -            aperture_grille_point  , 0.0, 1.0 ) + clamp( aperture_grille_point - 2.0, 0.0, 1.0 );
    float aperture_grille_g_rate = clamp( 1.0 - abs( 1.0 - aperture_grille_point ), 0.0, 1.0 );
    float aperture_grille_b_rate = 1.0 - aperture_grille_r_rate
                                       - aperture_grille_g_rate;
    fragColor = clamp(
        fragColor * vec4(
            normalize( vec3(
                clamp( aperture_grille_r_rate, aperture_grille_rate, 1.0 )
            ,	clamp( aperture_grille_g_rate, aperture_grille_rate, 1.0 )
            ,	clamp( aperture_grille_b_rate, aperture_grille_rate, 1.0 )
            ) )
        ,	1.0
        )
    ,	vec4( 0.0, 0.0, 0.0, 0.0 )
    ,	vec4( 1.0, 1.0, 1.0, 1.0 )
    );

    // 走査線
    // 走査線
    fragColor = mix(
    fragColor
    ,	vec4( 0.0, 0.0, 0.0, 1.0 )
    ,  float( 0 == int(mod(( fixed_uv.y / (1.0 / canvasSize).y ) , 2.0)) ) * crt_scan_line_color
    );
}

/*
    CRT shader for Godot Engine by Yui Kinomoto @arlez80
*/

//---------------------------------------------------------------
// https://godotshaders.com/shader/crt-shader-for-godot-engine-4/
//---------------------------------------------------------------