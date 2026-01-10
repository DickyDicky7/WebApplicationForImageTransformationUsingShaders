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

    // https://www.shadertoy.com/view/fdsXzM
//  // https://www.shadertoy.com/view/fdsXzM

    #define pi 3.141592653589793
//  #define pi 3.141592653589793


    float hash(in vec2 uv) {
//  float hash(in vec2 uv) {
    float seed =  dot( uv, vec2(071.330, 852.381)); return fract(38351.43000 * sin(14.13 * seed));
//  float seed =  dot( uv, vec2(071.330, 852.381)); return fract(38351.43000 * sin(14.13 * seed));
    }
//  }


    const float shake_speed = 3.0;
//  const float shake_speed = 3.0;
    const float shake_power = 1.0;
//  const float shake_power = 1.0;
    const float motion_blur_power = 00.05;
//  const float motion_blur_power = 00.05;
    const float motion_blur_iters = 15.00;
//  const float motion_blur_iters = 15.00;


    void main()
    {
    float timee = mod(time        , 1.0);
//  float timee = mod(time        , 1.0);
    float ratio = pow(1.00 - timee, 3.0);
//  float ratio = pow(1.00 - timee, 3.0);
    
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    
    ///////////////
//  ///////////////
    //   Shake   //
//  //   Shake   //
    ///////////////
//  ///////////////
    vec2 hash =    ratio * vec2(
//  vec2 hash =    ratio * vec2(
    (sin(shake_speed * timee + 1.) * cos(2. * shake_speed * timee + 1.)  + sin(10. * shake_speed * timee + 1.)) * 0.25 * shake_power,
//  (sin(shake_speed * timee + 1.) * cos(2. * shake_speed * timee + 1.)  + sin(10. * shake_speed * timee + 1.)) * 0.25 * shake_power,
    (sin(shake_speed * timee + 1.) + cos(2. * shake_speed * timee + 1.)) * sin(10. * shake_speed * timee + 1.)  * 0.25 * shake_power) - 0.5;
//  (sin(shake_speed * timee + 1.) + cos(2. * shake_speed * timee + 1.)) * sin(10. * shake_speed * timee + 1.)  * 0.25 * shake_power) - 0.5;
    
    uv += hash;
//  uv += hash;
    uv += 0.50;
//  uv += 0.50;
    
    uv = abs (     uv     );
//  uv = abs (     uv     );
    uv = step(1. , uv) * 2.
//  uv = step(1. , uv) * 2.
    + sign(1. - uv) * uv;
//  + sign(1. - uv) * uv;
    
    
    /////////////////////
//  /////////////////////
    //   Motion blur   //
//  //   Motion blur   //
    /////////////////////
//  /////////////////////
    
    float y  =   sin(1. * ratio * 2. * pi);
//  float y  =   sin(1. * ratio * 2. * pi);
    float y1 =  y *       step(0.0, y) ;
//  float y1 =  y *       step(0.0, y) ;
    float y2 = -y * (1. - step(0.0, y));
//  float y2 = -y * (1. - step(0.0, y));
    
    
    vec3 col = vec3(0.);
//  vec3 col = vec3(0.);
    vec2 hold_uv       ;
//  vec2 hold_uv       ;
    for (float i = -motion_blur_iters / 2.;
//  for (float i = -motion_blur_iters / 2.;
    i <  motion_blur_iters / 2.;
//  i <  motion_blur_iters / 2.;
    ++i) {
//  ++i) {
    hold_uv =      uv + y1 * vec2(+1 , +1) * ratio * motion_blur_power * i;
//  hold_uv =      uv + y1 * vec2(+1 , +1) * ratio * motion_blur_power * i;
    hold_uv = hold_uv + y2 * vec2(+1 , -1) * ratio * motion_blur_power * i;
//  hold_uv = hold_uv + y2 * vec2(+1 , -1) * ratio * motion_blur_power * i;
    col += texture(tex0, hold_uv).rgb;
//  col += texture(tex0, hold_uv).rgb;
    }
//  }
    col /=                                                motion_blur_iters    ;
//  col /=                                                motion_blur_iters    ;
    col *= 1.
//  col *= 1.
    +  2.
//  +  2.
    *  pow(ratio
//  *  pow(ratio
    ,  2. );
//  ,  2. );

    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }












