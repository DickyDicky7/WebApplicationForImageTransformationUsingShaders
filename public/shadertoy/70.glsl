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

    // float round(float x) {
//  // float round(float x) {
    //     return floor(x + 0.5);
//  //     return floor(x + 0.5);
    // }
//  // }

    // vec2 round(vec2 v) {
//  // vec2 round(vec2 v) {
    //     return vec2(round(v.x), round(v.y));
//  //     return vec2(round(v.x), round(v.y));
    // }
//  // }

    // vec3 round(vec3 v) {
//  // vec3 round(vec3 v) {
    //     return vec3(round(v.x), round(v.y), round(v.z));
//  //     return vec3(round(v.x), round(v.y), round(v.z));
    // }
//  // }

    // vec4 round(vec4 v) {
//  // vec4 round(vec4 v) {
    //     return vec4(round(v.x), round(v.y), round(v.z), round(v.w));
//  //     return vec4(round(v.x), round(v.y), round(v.z), round(v.w));
    // }
//  // }



    vec2 rand(vec2 c) {
//  vec2 rand(vec2 c) {
    mat2 m =            mat2(   12.98980
//  mat2 m =            mat2(   12.98980
    ,                    00.16180
//  ,                    00.16180
    ,                    78.23300
//  ,                    78.23300
    ,                    00.31415);
//  ,                    00.31415);
    return fract(sin(m * c) * vec2(43758.5453
//  return fract(sin(m * c) * vec2(43758.5453
    ,      14142.1000));
//  ,      14142.1000));
    }
//  }

    vec2 noise(vec2 p) {
//  vec2 noise(vec2 p) {
    vec2 co = floor(p);
//  vec2 co = floor(p);
    vec2 mu = fract(p);
//  vec2 mu = fract(p);
    mu = 3. * mu * mu - 2. * mu * mu * mu;
//  mu = 3. * mu * mu - 2. * mu * mu * mu;
    vec2 a = rand((co + vec2(0., 0.)));
//  vec2 a = rand((co + vec2(0., 0.)));
    vec2 b = rand((co + vec2(1., 0.)));
//  vec2 b = rand((co + vec2(1., 0.)));
    vec2 c = rand((co + vec2(0., 1.)));
//  vec2 c = rand((co + vec2(0., 1.)));
    vec2 d = rand((co + vec2(1., 1.)));
//  vec2 d = rand((co + vec2(1., 1.)));
    return mix(mix(a, b, mu.x), mix(c, d, mu.x), mu.y);
//  return mix(mix(a, b, mu.x), mix(c, d, mu.x), mu.y);
    }
//  }

    void main( )
    {
    vec2 u =  vTexCoord,
//  vec2 u =  vTexCoord,
    v = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy * .1) / canvasSize.xy,
//  v = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy * .1) / canvasSize.xy,
    n = noise(v * 200.);
//  n = noise(v * 200.);
    // Displacement
//  // Displacement
    // Displacement
//  // Displacement
    
    fragColor = textureLod(tex0, u, 2.5);
//  fragColor = textureLod(tex0, u, 2.5);
    
    // Loop through the different inverse sizes of drops
//  // Loop through the different inverse sizes of drops
    // Loop through the different inverse sizes of drops
//  // Loop through the different inverse sizes of drops
    for (float r = 4.0; r > 0.0; r--) {
//  for (float r = 4.0; r > 0.0; r--) {
    vec2 x = canvasSize.xy * r * .015,
//  vec2 x = canvasSize.xy * r * .015,
    // Number of potential drops (in a grid)
//  // Number of potential drops (in a grid)
    // Number of potential drops (in a grid)
//  // Number of potential drops (in a grid)
    p = 6.28 * u * x + (n - .5) * 2.,
//  p = 6.28 * u * x + (n - .5) * 2.,
    s =             sin(p     )     ;
//  s =             sin(p     )     ;
        
    // Current drop properties. Coordinates are rounded to ensure a
//  // Current drop properties. Coordinates are rounded to ensure a
    // Current drop properties. Coordinates are rounded to ensure a
//  // Current drop properties. Coordinates are rounded to ensure a
    // consistent value among the fragment of a given drop.
//  // consistent value among the fragment of a given drop.
    // consistent value among the fragment of a given drop.
//  // consistent value among the fragment of a given drop.
    //vec4 d = texture(iChannel1, round(u * x - 0.25) / x);
//  //vec4 d = texture(iChannel1, round(u * x - 0.25) / x);
    //vec4 d = texture(iChannel1, round(u * x - 0.25) / x);
//  //vec4 d = texture(iChannel1, round(u * x - 0.25) / x);
    vec2 v =      round(u * x - 000.25) / x;
//  vec2 v =      round(u * x - 000.25) / x;
    vec4 d = vec4(noise(v *     200.00)
//  vec4 d = vec4(noise(v *     200.00)
    ,      noise(v             )   );
//  ,      noise(v             )   );
        
    // Drop shape and fading
//  // Drop shape and fading
    // Drop shape and fading
//  // Drop shape and fading
    float t = (s.x + s.y) * max(0., 1. - fract(time * (d.b + .1) + d.g) * 2.);;
//  float t = (s.x + s.y) * max(0., 1. - fract(time * (d.b + .1) + d.g) * 2.);;
        
    // d.r -> only x% of drops are kept on, with x depending on the size of drops
//  // d.r -> only x% of drops are kept on, with x depending on the size of drops
    // d.r -> only x% of drops are kept on, with x depending on the size of drops
//  // d.r -> only x% of drops are kept on, with x depending on the size of drops
    if (d.r < (5.0 - r  ) * .08
//  if (d.r < (5.0 - r  ) * .08
    &&    t >  0.5      ) {
//  &&    t >  0.5      ) {
    // Drop normal
//  // Drop normal
    // Drop normal
//  // Drop normal
    vec3 v = normalize(-vec3(cos(p), mix(.2, 2., t - .5)));
//  vec3 v = normalize(-vec3(cos(p), mix(.2, 2., t - .5)));
    // fragColor = vec4(v * 0.5 + 0.5, 1.0);  // show normals
//  // fragColor = vec4(v * 0.5 + 0.5, 1.0);  // show normals
    // fragColor = vec4(v * 0.5 + 0.5, 1.0);  // show normals
//  // fragColor = vec4(v * 0.5 + 0.5, 1.0);  // show normals
            
    // Poor man's refraction (no visual need to do more)
//  // Poor man's refraction (no visual need to do more)
    // Poor man's refraction (no visual need to do more)
//  // Poor man's refraction (no visual need to do more)
    fragColor = texture(tex0, u - v.xy * .3);
//  fragColor = texture(tex0, u - v.xy * .3);
    }
//  }
    }
//  }
    
    // Debug noise function
//  // Debug noise function
    // Debug noise function
//  // Debug noise function
    //f = vec4(n, 0.0, 1.0);
//  //f = vec4(n, 0.0, 1.0);
    //f = vec4(n, 0.0, 1.0);
//  //f = vec4(n, 0.0, 1.0);
    }


    // https://www.shadertoy.com/view/MlfBWr
//  // https://www.shadertoy.com/view/MlfBWr
    // https://www.shadertoy.com/view/MlfBWr
//  // https://www.shadertoy.com/view/MlfBWr

    // Author: Élie Michel
//  // Author: Élie Michel
    // Author: Élie Michel
//  // Author: Élie Michel
    // License: CC BY 3.0
//  // License: CC BY 3.0
    // License: CC BY 3.0
//  // License: CC BY 3.0
    // July 2017
//  // July 2017
    // July 2017
//  // July 2017
