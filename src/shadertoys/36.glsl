#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

vec3 W = vec3(0.2125, 0.7154, 0.0721);

//#define TEST
//#define TEST
#define SMOOTH

float checkerDisplay( vec2 uv, float intens, float offset)
{
    float       val = clamp  ( sin(uv.x         )
                    *          sin(uv.y + offset), 0., 1.); 
    return pow( val , intens );
}

float processLum( vec2 uv, float lum )
{
    float            scale = 350.0;
    vec2  uv2 = uv * scale        ;
    
    float lum_orig = lum;
    float offset   = 0.0;
    if (  lum      < 0.5 ) 
    {
          lum    = 1.0 - lum;
          offset = 3.1415900;
    }

    // rotation :
    // rotation :
    float angle = 1.0;  // why not ?
    // why not ?
    float     c = cos( angle )
    ,         s = sin( angle );
    uv2 = vec2( uv2.x * c 
        +       uv2.y * s
        ,      -uv2.x * s 
        +       uv2.y * c    );
    
    float   lum_scale =     smoothstep( 01.00, 00.82, lum      );
    float       power =            mix( 10.00, 03.10, lum_scale);
    power = mix(power, 0.8, smoothstep( 00.82, 00.66, lum     ));
    power = mix(power, 0.0, smoothstep( 00.66, 00.50, lum     ));
    
#ifdef SMOOTH
    vec2  delta = vec2(0.0, 0.2);
    float color = checkerDisplay(uv2           , power, offset) 
                + checkerDisplay(uv2 + delta.xy, power, offset)
                + checkerDisplay(uv2 + delta.yx, power, offset);
          color =                                color  /  3.0  * lum_scale;
#else
    float color = checkerDisplay(uv2           , power, offset) * lum_scale;
#endif

    if ( lum_orig < 0.5 )
            color = 1.0 - color;
    
            color = 1.0 - color;
    
    return  color              ;
}

void main(void)
{
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv  = gl_FragCoord.xy 
             /   canvasSize.xy;

#ifdef TEST
    vec3 col =    vec3( uv.x     )    ;
#else
    vec3 col = texture( tex0, uv ).xyz;
#endif
    float                          luminance = dot(col, W);
    float color = processLum( uv , luminance )            ;

    // add a blueish style for ink like :
    // add a blueish style for ink like :
    vec3 outputColor =   mix( vec3(0.0, 0.2, 0.3)
                     ,        vec3(1.0, 1.0, 1.0)
                     , color);

#ifdef TEST
    if (uv.y > 0.7)
                     outputColor = col ;        
#endif
    fragColor = vec4(outputColor , 1.0);
}


// https://www.shadertoy.com/view/ttKBDG
