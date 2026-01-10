#version 300 es
// #version 300 es
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

    // const float  seed = 81.00;
//  // const float  seed = 81.00;
    // const float power = 00.03;
//  // const float power = 00.03;
    // const float speed = 00.00;
//  // const float speed = 00.00;

    uniform float  seed ; // 81.00
//  uniform float  seed ; // 81.00
    uniform float power ; // 00.03
//  uniform float power ; // 00.03
    uniform float speed ; // 00.00
//  uniform float speed ; // 00.00

    vec2 random( vec2 pos )
//  vec2 random( vec2 pos )
    {
//  {
    return fract(
//  return fract(
    sin(
//  sin(
    //  	sin(
//  //  	sin(
    vec2(
//  vec2(
    //  		vec2(
//  //  		vec2(
    dot(pos, vec2(  012.9898 ,  78.233 ))
//  dot(pos, vec2(  012.9898 ,  78.233 ))
    //  			dot(pos, vec2(  012.9898 ,  78.233 ))
//  //  			dot(pos, vec2(  012.9898 ,  78.233 ))
    ,	dot(pos, vec2( -148.9980 , -65.233 ))
//  ,	dot(pos, vec2( -148.9980 , -65.233 ))
    //  		,	dot(pos, vec2( -148.9980 , -65.233 ))
//  //  		,	dot(pos, vec2( -148.9980 , -65.233 ))
    )
//  )
    //  		)
//  //  		)
    ) * 43758.5453
//  ) * 43758.5453
    //  	) * 43758.5453
//  //  	) * 43758.5453
    );
//  );
    }
//  }

    void main( )
    {
    vec2 uv = vTexCoord + ( random( vTexCoord + vec2( seed - time * speed, time * speed ) ) - vec2( 0.5, 0.5 ) ) * power;
//  vec2 uv = vTexCoord + ( random( vTexCoord + vec2( seed - time * speed, time * speed ) ) - vec2( 0.5, 0.5 ) ) * power;
    fragColor =
//  fragColor =
    //            fragColor =
//  //            fragColor =
    textureLod(tex0, uv, 0.0);
//  textureLod(tex0, uv, 0.0);
    }



    // https://godotshaders.com/shader/screen-noise-effect-shader/
//  // https://godotshaders.com/shader/screen-noise-effect-shader/

    /*
//  /*
    砂嵐エフェクト by あるる（きのもと 結衣）
//  砂嵐エフェクト by あるる（きのもと 結衣）
    砂嵐エフェクト by あるる（きのもと 結衣）
//  砂嵐エフェクト by あるる（きのもと 結衣）
    Screen Noise Effect Shader by Yui Kinomoto @arlez80
//  Screen Noise Effect Shader by Yui Kinomoto @arlez80
    Screen Noise Effect Shader by Yui Kinomoto @arlez80
//  Screen Noise Effect Shader by Yui Kinomoto @arlez80

    MIT License
//  MIT License
    MIT License
//  MIT License
    */
//  */


