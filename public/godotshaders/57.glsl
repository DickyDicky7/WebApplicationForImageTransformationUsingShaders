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

    // const vec3  MONOCHROME_SCALE = vec3( 0.298912, 0.586611, 0.114478 );
//  // const vec3  MONOCHROME_SCALE = vec3( 0.298912, 0.586611, 0.114478 );

    // const  sampler2D  ascii_tex                     ;
//  // const  sampler2D  ascii_tex                     ;
    //       const vec2  ascii_size = vec2( 8.0, 16.0 );
//  //       const vec2  ascii_size = vec2( 8.0, 16.0 );
    // //    const vec2  ascii_size = vec2( 4.0, 08.0 );
//  // //    const vec2  ascii_size = vec2( 4.0, 08.0 );
    // const int available_columns = 10;
//  // const int available_columns = 10;
    // const int       max_columns = 16;
//  // const int       max_columns = 16;
    // const bool          colored = true;
//  // const bool          colored = true;

    uniform     vec3  MONOCHROME_SCALE ; // 0.298912, 0.586611, 0.114478
//  uniform     vec3  MONOCHROME_SCALE ; // 0.298912, 0.586611, 0.114478
    uniform sampler2D       ascii_tex  ; // null
//  uniform sampler2D       ascii_tex  ; // null
    uniform vec2        ascii_size ; // 8.0, 16.0
//  uniform vec2        ascii_size ; // 8.0, 16.0
    //    const vec2        ascii_size ; // 4.0, 08.0
//  //    const vec2        ascii_size ; // 4.0, 08.0
    uniform int available_columns ; // 10
//  uniform int available_columns ; // 10
    uniform int       max_columns ; // 16
//  uniform int       max_columns ; // 16
    uniform bool          colored ; // true
//  uniform bool          colored ; // true

    void main( )
    {
    vec2 screen_uv = floor( vTexCoord / (1.0 / canvasSize) / ascii_size ) * (1.0 / canvasSize) * ascii_size;
//  vec2 screen_uv = floor( vTexCoord / (1.0 / canvasSize) / ascii_size ) * (1.0 / canvasSize) * ascii_size;
    vec2  diff =                                             ascii_size   * (1.0 / canvasSize);
//  vec2  diff =                                             ascii_size   * (1.0 / canvasSize);
    vec4 color = (
//  vec4 color = (
    textureLod( tex0, screen_uv                         , 0.0 )
//  textureLod( tex0, screen_uv                         , 0.0 )
    +	textureLod( tex0, screen_uv + vec2( 0000.0, diff.y ), 0.0 )
//  +	textureLod( tex0, screen_uv + vec2( 0000.0, diff.y ), 0.0 )
    +	textureLod( tex0, screen_uv + vec2( diff.x, 0000.0 ), 0.0 )
//  +	textureLod( tex0, screen_uv + vec2( diff.x, 0000.0 ), 0.0 )
    +	textureLod( tex0, screen_uv +       diff            , 0.0 )
//  +	textureLod( tex0, screen_uv +       diff            , 0.0 )
    ) / 4.0;
//  ) / 4.0;

    vec2 ascii_uv   = fract( vTexCoord / (1.0 / canvasSize) / ascii_size );
//  vec2 ascii_uv   = fract( vTexCoord / (1.0 / canvasSize) / ascii_size );
    ascii_uv.x =                                 ( 1.0 - ascii_uv.x ) / float( max_columns );
//  ascii_uv.x =                                 ( 1.0 - ascii_uv.x ) / float( max_columns );
    float col = floor(  dot( color.rgb ,  MONOCHROME_SCALE) * float( available_columns ) ) / float( available_columns );
//  float col = floor(  dot( color.rgb ,  MONOCHROME_SCALE) * float( available_columns ) ) / float( available_columns );

    fragColor = texture( ascii_tex, ascii_uv + vec2( col * (  float( available_columns )   / float(       max_columns ) ), 0.0 ) );
//  fragColor = texture( ascii_tex, ascii_uv + vec2( col * (  float( available_columns )   / float(       max_columns ) ), 0.0 ) );
    
    if (colored)
//  if (colored)
    {
//  {
    fragColor *= texture(tex0, vTexCoord);
//  fragColor *= texture(tex0, vTexCoord);
    }
//  }
    }



    // https://godotshaders.com/shader/ascii-effect-shader/
//  // https://godotshaders.com/shader/ascii-effect-shader/
