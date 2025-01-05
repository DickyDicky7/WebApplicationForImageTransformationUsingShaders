#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// // 発射中央部
// const vec2      blur_center = vec2( 0.5, 0.5 );
// // ブラー強度
// const float     blur_powers = 0.01;
// // サンプリング回数
// const   int sampling_counts =    6;

// 発射中央部
uniform vec2      blur_center ; // 0.50, 0.50
// ブラー強度
uniform float     blur_powers ; // 0.01
// サンプリング回数
uniform   int sampling_counts ; //    6

void main( )
{
    vec2 direction = vTexCoord - blur_center;
    vec3  c =        vec3( 0.0 , 0.0 , 0.0 );
    float f = 1.0 / float( sampling_counts );
    for( int i = 0; i    < sampling_counts  ; i++ ) {
        c += texture( tex0, vTexCoord - blur_powers * direction * float(i) ).rgb * f;
    }
    fragColor.rgb = c;
}








// https://godotshaders.com/shader/radical-blur-shader/

/*
    放射状ブラーエフェクト by あるる（きのもと　結衣） @arlez80
    放射状ブラーエフェクト by あるる（きのもと　結衣） @arlez80
    Radial Blur Effect by Yui Kinomoto
    Radial Blur Effect by Yui Kinomoto

    MIT License
    MIT License
*/


