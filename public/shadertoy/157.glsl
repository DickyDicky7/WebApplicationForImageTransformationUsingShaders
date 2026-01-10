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

    // https://www.shadertoy.com/view/3dGyR3
//  // https://www.shadertoy.com/view/3dGyR3

    uniform float perspective ; // 00.3
//  uniform float perspective ; // 00.3
    uniform int   samples     ; // 25
//  uniform int   samples     ; // 25
    uniform float minBlur     ; // 00.0
//  uniform float minBlur     ; // 00.0
    uniform float maxBlur     ; // 00.3
//  uniform float maxBlur     ; // 00.3
    uniform float speed       ; // 03.0
//  uniform float speed       ; // 03.0
    uniform float speed_1     ; // 02.0
//  uniform float speed_1     ; // 02.0
    uniform float speed_2     ; // 20.0
//  uniform float speed_2     ; // 20.0

    void main()
    {


    ////////////////////////////
//  ////////////////////////////

    float alpha = smoothstep(0.0
//  float alpha = smoothstep(0.0
    ,            1.0
//  ,            1.0
    , pow(sin(speed_1 * time) / 2.0, 2.0) * 4.0
//  , pow(sin(speed_1 * time) / 2.0, 2.0) * 4.0
    )
//  )
    * (   sin(speed_2 * time) + 1.0     ) / 2.0;
//  * (   sin(speed_2 * time) + 1.0     ) / 2.0;
    
    ////////////////////////////
//  ////////////////////////////
    
    float timeQ = mix(minBlur, maxBlur, alpha);
//  float timeQ = mix(minBlur, maxBlur, alpha);
    
    
    vec2 p      = vTexCoord;
//  vec2 p      = vTexCoord;
    vec4 result = vec4( 0 );
//  vec4 result = vec4( 0 );
    
    for (int i = 0; i <= samples; i++)
//  for (int i = 0; i <= samples; i++)
    {
//  {
    float q = float(i) / float(samples); result += texture(tex0, p + (vec2(0.5) - p) * q * timeQ) / float(samples);
//  float q = float(i) / float(samples); result += texture(tex0, p + (vec2(0.5) - p) * q * timeQ) / float(samples);
    }
//  }
    result += alpha / 2.0;
//  result += alpha / 2.0;
    
    
    fragColor = result;
//  fragColor = result;
    }







