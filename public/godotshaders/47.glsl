    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4          fragColor;
//  out             vec4          fragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    // // 発射中央部
//  // // 発射中央部
    // const vec2      blur_center = vec2( 0.5, 0.5 );
//  // const vec2      blur_center = vec2( 0.5, 0.5 );
    // // ブラー強度
//  // // ブラー強度
    // const float     blur_powers = 0.01;
//  // const float     blur_powers = 0.01;
    // // サンプリング回数
//  // // サンプリング回数
    // const   int sampling_counts =    6;
//  // const   int sampling_counts =    6;

    // 発射中央部
//  // 発射中央部
    uniform vec2      blur_center ; // 0.50, 0.50
//  uniform vec2      blur_center ; // 0.50, 0.50
    // ブラー強度
//  // ブラー強度
    uniform float     blur_powers ; // 0.01
//  uniform float     blur_powers ; // 0.01
    // サンプリング回数
//  // サンプリング回数
    uniform   int sampling_counts ; //    6
//  uniform   int sampling_counts ; //    6

    void main( )
    {
    vec2 direction = vTexCoord - blur_center;
//  vec2 direction = vTexCoord - blur_center;
    vec3  c =        vec3( 0.0 , 0.0 , 0.0 );
//  vec3  c =        vec3( 0.0 , 0.0 , 0.0 );
    float f = 1.0 / float( sampling_counts );
//  float f = 1.0 / float( sampling_counts );
    for( int i = 0; i    < sampling_counts  ; i++ ) {
//  for( int i = 0; i    < sampling_counts  ; i++ ) {
    c += texture( tex0, vTexCoord - blur_powers * direction * float(i) ).rgb * f;
//  c += texture( tex0, vTexCoord - blur_powers * direction * float(i) ).rgb * f;
    }
//  }
    fragColor.rgb = c;
//  fragColor.rgb = c;
    }








    // https://godotshaders.com/shader/radical-blur-shader/
//  // https://godotshaders.com/shader/radical-blur-shader/

    /*
//  /*
    放射状ブラーエフェクト by あるる（きのもと　結衣） @arlez80
//  放射状ブラーエフェクト by あるる（きのもと　結衣） @arlez80
    放射状ブラーエフェクト by あるる（きのもと　結衣） @arlez80
//  放射状ブラーエフェクト by あるる（きのもと　結衣） @arlez80
    Radial Blur Effect by Yui Kinomoto
//  Radial Blur Effect by Yui Kinomoto
    Radial Blur Effect by Yui Kinomoto
//  Radial Blur Effect by Yui Kinomoto

    MIT License
//  MIT License
    MIT License
//  MIT License
    */
//  */


