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

    //const vec3 W = vec3(0.2125, 0.7154, 0.0721);
//  //const vec3 W = vec3(0.2125, 0.7154, 0.0721);
    uniform vec3 W ; //   0.2125, 0.7154, 0.0721
//  uniform vec3 W ; //   0.2125, 0.7154, 0.0721

    //#define TEST
//  //#define TEST
    //#define TEST
//  //#define TEST
#define SMOOTH
// #define SMOOTH

    float checkerDisplay( vec2 uv, float intens, float offset)
//  float checkerDisplay( vec2 uv, float intens, float offset)
    {
//  {
    float       val = clamp  ( sin(uv.x         )
//  float       val = clamp  ( sin(uv.x         )
    *          sin(uv.y + offset), 0., 1.);
//  *          sin(uv.y + offset), 0., 1.);
    return pow( val , intens );
//  return pow( val , intens );
    }
//  }

    float processLum( vec2 uv, float lum )
//  float processLum( vec2 uv, float lum )
    {
//  {
    float            scale = 350.0;
//  float            scale = 350.0;
    vec2  uv2 = uv * scale        ;
//  vec2  uv2 = uv * scale        ;
    
    float lum_orig = lum;
//  float lum_orig = lum;
    float offset   = 0.0;
//  float offset   = 0.0;
    if (  lum      < 0.5 )
//  if (  lum      < 0.5 )
    {
//  {
    lum    = 1.0 - lum;
//  lum    = 1.0 - lum;
    offset = 3.1415900;
//  offset = 3.1415900;
    }
//  }

    // rotation :
//  // rotation :
    // rotation :
//  // rotation :
    float angle = 1.0;  // why not ?
//  float angle = 1.0;  // why not ?
    // why not ?
//  // why not ?
    float     c = cos( angle )
//  float     c = cos( angle )
    ,         s = sin( angle );
//  ,         s = sin( angle );
    uv2 = vec2( uv2.x * c
//  uv2 = vec2( uv2.x * c
    +       uv2.y * s
//  +       uv2.y * s
    ,      -uv2.x * s
//  ,      -uv2.x * s
    +       uv2.y * c    );
//  +       uv2.y * c    );
    
    float   lum_scale =     smoothstep( 01.00, 00.82, lum      );
//  float   lum_scale =     smoothstep( 01.00, 00.82, lum      );
    float       power =            mix( 10.00, 03.10, lum_scale);
//  float       power =            mix( 10.00, 03.10, lum_scale);
    power = mix(power, 0.8, smoothstep( 00.82, 00.66, lum     ));
//  power = mix(power, 0.8, smoothstep( 00.82, 00.66, lum     ));
    power = mix(power, 0.0, smoothstep( 00.66, 00.50, lum     ));
//  power = mix(power, 0.0, smoothstep( 00.66, 00.50, lum     ));
    
#ifdef SMOOTH
// #ifdef SMOOTH
    vec2  delta = vec2(0.0, 0.2);
//  vec2  delta = vec2(0.0, 0.2);
    float color = checkerDisplay(uv2           , power, offset)
//  float color = checkerDisplay(uv2           , power, offset)
    + checkerDisplay(uv2 + delta.xy, power, offset)
//  + checkerDisplay(uv2 + delta.xy, power, offset)
    + checkerDisplay(uv2 + delta.yx, power, offset);
//  + checkerDisplay(uv2 + delta.yx, power, offset);
    color =                                color  /  3.0  * lum_scale;
//  color =                                color  /  3.0  * lum_scale;
#else
// #else
    float color = checkerDisplay(uv2           , power, offset) * lum_scale;
//  float color = checkerDisplay(uv2           , power, offset) * lum_scale;
#endif
// #endif

    if ( lum_orig < 0.5 )
//  if ( lum_orig < 0.5 )
    color = 1.0 - color;
//  color = 1.0 - color;
    
    color = 1.0 - color;
//  color = 1.0 - color;
    
    return  color              ;
//  return  color              ;
    }
//  }

    void main(void)
    {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv  = vTexCoord;
//  vec2 uv  = vTexCoord;

#ifdef TEST
// #ifdef TEST
    vec3 col =    vec3( uv.x     )    ;
//  vec3 col =    vec3( uv.x     )    ;
#else
// #else
    vec3 col = texture( tex0, uv ).xyz;
//  vec3 col = texture( tex0, uv ).xyz;
#endif
// #endif
    float                          luminance = dot(col, W);
//  float                          luminance = dot(col, W);
    float color = processLum( uv , luminance )            ;
//  float color = processLum( uv , luminance )            ;

    // add a blueish style for ink like :
//  // add a blueish style for ink like :
    // add a blueish style for ink like :
//  // add a blueish style for ink like :
    vec3 outputColor =   mix( vec3(0.0, 0.2, 0.3)
//  vec3 outputColor =   mix( vec3(0.0, 0.2, 0.3)
    ,        vec3(1.0, 1.0, 1.0)
//  ,        vec3(1.0, 1.0, 1.0)
    , color);
//  , color);

#ifdef TEST
// #ifdef TEST
    if (uv.y > 0.7)
//  if (uv.y > 0.7)
    outputColor = col ;
//  outputColor = col ;
#endif
// #endif
    fragColor = vec4(outputColor , 1.0);
//  fragColor = vec4(outputColor , 1.0);
    }


    // https://www.shadertoy.com/view/ttKBDG
//  // https://www.shadertoy.com/view/ttKBDG
