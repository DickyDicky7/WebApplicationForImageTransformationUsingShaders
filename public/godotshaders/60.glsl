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

    //const vec2 size = vec2( 64.0 , 48.0 ); //original size
//  //const vec2 size = vec2( 64.0 , 48.0 ); //original size
    //const vec2 size = vec2( 32.0 , 24.0 );
//  //const vec2 size = vec2( 32.0 , 24.0 );
    //const vec2 size = vec2( 16.0 , 12.0 );
//  //const vec2 size = vec2( 16.0 , 12.0 );
    //const vec2 size = vec2( 08.0 , 06.0 );
//  //const vec2 size = vec2( 08.0 , 06.0 );
    //const vec2 size = vec2( 04.0 , 03.0 );
//  //const vec2 size = vec2( 04.0 , 03.0 );
    uniform vec2 size ; //    08.0 , 06.0
//  uniform vec2 size ; //    08.0 , 06.0

    void main( )
    {
    vec2 norm_size = size * (1.0 / canvasSize);
//  vec2 norm_size = size * (1.0 / canvasSize);
    bool halff     = mod( vTexCoord.y / 2.0, norm_size.y ) / norm_size.y < 0.5;
//  bool halff     = mod( vTexCoord.y / 2.0, norm_size.y ) / norm_size.y < 0.5;
    vec2        uv = vTexCoord + vec2( norm_size.x * 0.5 * float( halff ), 0.0 );
//  vec2        uv = vTexCoord + vec2( norm_size.x * 0.5 * float( halff ), 0.0 );
    vec2 center_uv = floor( uv / norm_size ) * norm_size;
//  vec2 center_uv = floor( uv / norm_size ) * norm_size;
    vec2   norm_uv = mod  ( uv , norm_size ) / norm_size;
//  vec2   norm_uv = mod  ( uv , norm_size ) / norm_size;
    center_uv += mix(
//  center_uv += mix(
    vec2( 0.0, 0.0 )
//  vec2( 0.0, 0.0 )
    ,	mix(
//  ,	mix(
    mix(
//  mix(
    vec2 (  norm_size.x, -norm_size.y )
//  vec2 (  norm_size.x, -norm_size.y )
    ,	vec2 (  0.0        , -norm_size.y )
//  ,	vec2 (  0.0        , -norm_size.y )
    ,	float(  norm_uv  .x < 0.5 )
//  ,	float(  norm_uv  .x < 0.5 )
    )
//  )
    ,	mix(
//  ,	mix(
    vec2 (  0.0        , -norm_size.y )
//  vec2 (  0.0        , -norm_size.y )
    ,	vec2 ( -norm_size.x, -norm_size.y )
//  ,	vec2 ( -norm_size.x, -norm_size.y )
    ,	float(  norm_uv  .x < 0.5 )
//  ,	float(  norm_uv  .x < 0.5 )
    )
//  )
    ,	float( halff )
//  ,	float( halff )
    )
//  )
    ,	float( norm_uv.y < 0.3333333 ) * float( norm_uv.y / 0.3333333 < ( abs( norm_uv.x - 0.5 ) * 2.0 ) )
//  ,	float( norm_uv.y < 0.3333333 ) * float( norm_uv.y / 0.3333333 < ( abs( norm_uv.x - 0.5 ) * 2.0 ) )
    );
//  );

    fragColor = textureLod( tex0, center_uv, 0.0 );
//  fragColor = textureLod( tex0, center_uv, 0.0 );
    }




    // https://godotshaders.com/shader/hex-pixelization-shader/
//  // https://godotshaders.com/shader/hex-pixelization-shader/
