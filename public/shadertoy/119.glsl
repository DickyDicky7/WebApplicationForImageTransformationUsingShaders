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

    // https://www.shadertoy.com/view/MfVfWV
//  // https://www.shadertoy.com/view/MfVfWV


    float easeInOutQuad(float t) { return t < 0.5 ? 2.0 * t * t : -1.0 + (4.0 - 2.0 * t) * t; }
//  float easeInOutQuad(float t) { return t < 0.5 ? 2.0 * t * t : -1.0 + (4.0 - 2.0 * t) * t; }

    // Cubic Easing
//  // Cubic Easing
    float easeInCubic(float t) { return t * t * t; }
//  float easeInCubic(float t) { return t * t * t; }

    float easeOutCubic(float t) { float f = t - 1.0; return f * f * f + 1.0; }
//  float easeOutCubic(float t) { float f = t - 1.0; return f * f * f + 1.0; }

    float easeInOutCubic(float t) { return t < 0.5 ? 4.0 * t * t * t : (t - 1.0) * (2.0 * t - 2.0) * (2.0 * t - 2.0) + 1.0; }
//  float easeInOutCubic(float t) { return t < 0.5 ? 4.0 * t * t * t : (t - 1.0) * (2.0 * t - 2.0) * (2.0 * t - 2.0) + 1.0; }

    // Quartic Easing
//  // Quartic Easing
    float easeInQuart(float t) { return t * t * t * t; }
//  float easeInQuart(float t) { return t * t * t * t; }

    float easeOutQuart(float t) { float f = t - 1.0; return 1.0 - f * f * f * f; }
//  float easeOutQuart(float t) { float f = t - 1.0; return 1.0 - f * f * f * f; }

    float easeInOutQuart(float t) { return t < 0.5 ? 8.0 * t * t * t * t : 1.0 - 8.0 * (t - 1.0) * (t - 1.0) * (t - 1.0) * (t - 1.0); }
//  float easeInOutQuart(float t) { return t < 0.5 ? 8.0 * t * t * t * t : 1.0 - 8.0 * (t - 1.0) * (t - 1.0) * (t - 1.0) * (t - 1.0); }

    // Sine Easing
//  // Sine Easing
    float easeInSine(float t) { return 1.0 - cos((t * 3.141592653589793) / 2.0); }
//  float easeInSine(float t) { return 1.0 - cos((t * 3.141592653589793) / 2.0); }

    float easeOutSine(float t) { return sin((t * 3.141592653589793) / 2.0); }
//  float easeOutSine(float t) { return sin((t * 3.141592653589793) / 2.0); }

    float easeInOutSine(float t) { return -0.5 * (cos(3.141592653589793 * t) - 1.0); }
//  float easeInOutSine(float t) { return -0.5 * (cos(3.141592653589793 * t) - 1.0); }

    // Exponential Easing
//  // Exponential Easing
    float easeInExpo(float t) { return t == 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0)); }
//  float easeInExpo(float t) { return t == 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0)); }

    float easeOutExpo(float t) { return t == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t); }
//  float easeOutExpo(float t) { return t == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t); }

    float easeInOutExpo(float t) { if (t == 0.0) return 0.0; if (t == 1.0) return 1.0; return t < 0.5 ? 0.5 * pow(2.0, 20.0 * t - 10.0) : 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0); }
//  float easeInOutExpo(float t) { if (t == 0.0) return 0.0; if (t == 1.0) return 1.0; return t < 0.5 ? 0.5 * pow(2.0, 20.0 * t - 10.0) : 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0); }

    // Back Easing
//  // Back Easing
    float easeInBack(float t) { const float c1 = 1.70158; return (c1 + 1.0) * t * t * t - c1 * t * t; }
//  float easeInBack(float t) { const float c1 = 1.70158; return (c1 + 1.0) * t * t * t - c1 * t * t; }

    float easeOutBack(float t) { const float c1 = 1.70158; float f = t - 1.0; return 1.0 + (c1 + 1.0) * f * f * f + c1 * f * f; }
//  float easeOutBack(float t) { const float c1 = 1.70158; float f = t - 1.0; return 1.0 + (c1 + 1.0) * f * f * f + c1 * f * f; }

    float easeInOutBack(float t) { const float c1 = 1.70158; const float c2 = c1 * 1.525; return t < 0.5 ? (pow(2.0 * t, 2.0) * ((c2 + 1.0) * 2.0 * t - c2)) / 2.0 : (pow(2.0 * t - 2.0, 2.0) * ((c2 + 1.0) * (t * 2.0 - 2.0) + c2) + 2.0) / 2.0; }
//  float easeInOutBack(float t) { const float c1 = 1.70158; const float c2 = c1 * 1.525; return t < 0.5 ? (pow(2.0 * t, 2.0) * ((c2 + 1.0) * 2.0 * t - c2)) / 2.0 : (pow(2.0 * t - 2.0, 2.0) * ((c2 + 1.0) * (t * 2.0 - 2.0) + c2) + 2.0) / 2.0; }


    uniform float       WIDTH ; // 1.50
//  uniform float       WIDTH ; // 1.50
    uniform float SPREAD      ; // 0.33
//  uniform float SPREAD      ; // 0.33

    void main()
    {
    float                           T_MAX = 3.0;
//  float                           T_MAX = 3.0;
    float     remapTime = mod(time, T_MAX)     ;
//  float     remapTime = mod(time, T_MAX)     ;
    float t = remapTime /           T_MAX      ;
//  float t = remapTime /           T_MAX      ;
    //    t = 0.5    ;
//  //    t = 0.5    ;
    //    t = 1.0 - t;
//  //    t = 1.0 - t;
    float progress =  t ;
//  float progress =  t ;
    //    progress = 1.0;
//  //    progress = 1.0;
    
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv   = vTexCoord;
//  vec2 uv   = vTexCoord;
    vec4 mask = vec4(0.0);
//  vec4 mask = vec4(0.0);

    
    float
//  float
    ts = SPREAD * 0.0f; mask.r = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y; mask.r = abs(mask.r); mask.r /= WIDTH; mask.r = clamp(1.0f - mask.r, 0.0f, 1.0f); mask.r = easeInOutSine(mask.r);
//  ts = SPREAD * 0.0f; mask.r = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y; mask.r = abs(mask.r); mask.r /= WIDTH; mask.r = clamp(1.0f - mask.r, 0.0f, 1.0f); mask.r = easeInOutSine(mask.r);
    ts = SPREAD * 1.0f; mask.g = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y; mask.g = abs(mask.g); mask.g /= WIDTH; mask.g = clamp(1.0f - mask.g, 0.0f, 1.0f); mask.g = easeInOutSine(mask.g);
//  ts = SPREAD * 1.0f; mask.g = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y; mask.g = abs(mask.g); mask.g /= WIDTH; mask.g = clamp(1.0f - mask.g, 0.0f, 1.0f); mask.g = easeInOutSine(mask.g);
    ts = SPREAD * 2.0f; mask.b = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y; mask.b = abs(mask.b); mask.b /= WIDTH; mask.b = clamp(1.0f - mask.b, 0.0f, 1.0f); mask.b = easeInOutSine(mask.b);
//  ts = SPREAD * 2.0f; mask.b = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y; mask.b = abs(mask.b); mask.b /= WIDTH; mask.b = clamp(1.0f - mask.b, 0.0f, 1.0f); mask.b = easeInOutSine(mask.b);
    ts = SPREAD * 3.0f; mask.a = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y;                       mask.a /= WIDTH; mask.a = (mask.a >= 1.0f) ? 1.0f : mask.a;
//  ts = SPREAD * 3.0f; mask.a = mix(0.0f - (1.0f - ts), 1.0f + WIDTH + (ts), progress) - uv.y;                       mask.a /= WIDTH; mask.a = (mask.a >= 1.0f) ? 1.0f : mask.a;

    mask = clamp(mask, vec4(0.0f), vec4(1.0f));
//  mask = clamp(mask, vec4(0.0f), vec4(1.0f));

    //  fragColor = vec4(abs( (mask.r - uv.y) ));
//  //  fragColor = vec4(abs( (mask.r - uv.y) ));
    //  fragColor = vec4(abs( (mask.r - uv.y) ));
//  //  fragColor = vec4(abs( (mask.r - uv.y) ));
    
    fragColor = vec4(mask.r, mask.g, mask.b, 0.0f);
//  fragColor = vec4(mask.r, mask.g, mask.b, 0.0f);
    //fragColor = vec4(mask.a);
//  //fragColor = vec4(mask.a);
    //fragColor = vec4(mask.r , mask.g, mask.b, 0.0) + vec4(mask.a * 0.33);
//  //fragColor = vec4(mask.r , mask.g, mask.b, 0.0) + vec4(mask.a * 0.33);
    //fragColor = vec4(mask.r);
//  //fragColor = vec4(mask.r);
    
    vec4 oColor    = vec4(1.0f);
//  vec4 oColor    = vec4(1.0f);
    oColor.r  = texture(tex0, uv + vec2(0.0f, mask.r * -0.25f)).r * mix(1.0f, 5.0f, mask.r);
//  oColor.r  = texture(tex0, uv + vec2(0.0f, mask.r * -0.25f)).r * mix(1.0f, 5.0f, mask.r);
    oColor.g  = texture(tex0, uv + vec2(0.0f, mask.g * -0.25f)).g * mix(1.0f, 5.0f, mask.g);
//  oColor.g  = texture(tex0, uv + vec2(0.0f, mask.g * -0.25f)).g * mix(1.0f, 5.0f, mask.g);
    oColor.b  = texture(tex0, uv + vec2(0.0f, mask.b * -0.25f)).b * mix(1.0f, 5.0f, mask.b);
//  oColor.b  = texture(tex0, uv + vec2(0.0f, mask.b * -0.25f)).b * mix(1.0f, 5.0f, mask.b);
    oColor   *=                                                                     mask.a ;
//  oColor   *=                                                                     mask.a ;

    fragColor = oColor;
//  fragColor = oColor;
    

    /*
//  /*
    vec4 color = vec4(0.0, 1.0, 1.0, 1.0); color *= 1.0;
//  vec4 color = vec4(0.0, 1.0, 1.0, 1.0); color *= 1.0;

    float T_MAX = 1.50; float time = mod(iTime, T_MAX); float t = time/ T_MAX;
//  float T_MAX = 1.50; float time = mod(iTime, T_MAX); float t = time/ T_MAX;
    //t = 0.50    ;
//  //t = 0.50    ;
    t = 1.00 - t;
//  t = 1.00 - t;
    
    //t = 1.00    ;
//  //t = 1.00    ;
    //t = 0.01    ;
//  //t = 0.01    ;
    //t = 0.25    ;
//  //t = 0.25    ;
    
    float progress = t;
//  float progress = t;
    //progress = easeOutExpo(progress);
//  //progress = easeOutExpo(progress);
    //progress = easeOutExpo(progress);
//  //progress = easeOutExpo(progress);
    
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord / iResolution.xy;
//  vec2 uv = fragCoord / iResolution.xy;
    

    float stretch =     0.0                ;
//  float stretch =     0.0                ;
    float      ts = mix(0.0, 1.5, progress);
//  float      ts = mix(0.0, 1.5, progress);
    stretch = abs(ts - uv.y)          ; // / 0.25 ;
//  stretch = abs(ts - uv.y)          ; // / 0.25 ;
    stretch = 1.0 - stretch;
//  stretch = 1.0 - stretch;
    stretch = clamp(stretch, 0.0, 1.0);
//  stretch = clamp(stretch, 0.0, 1.0);
    
    
    float thickness = mix(100.0, 2.0, 0.99); stretch = pow(stretch, thickness);
//  float thickness = mix(100.0, 2.0, 0.99); stretch = pow(stretch, thickness);
    
    float xmask = 1.0; if (ts - uv.y < 0.0) { xmask = 0.0; stretch = 0.0; } fragColor = vec4(stretch); vec4 oColor = vec4(0.0);
//  float xmask = 1.0; if (ts - uv.y < 0.0) { xmask = 0.0; stretch = 0.0; } fragColor = vec4(stretch); vec4 oColor = vec4(0.0);

    
    float y = uv.y;
//  float y = uv.y;
    uv.y = y + (stretch * 0.25 * -1.0);
//  uv.y = y + (stretch * 0.25 * -1.0);
    oColor.r = texture(tex0, uv).r;
//  oColor.r = texture(tex0, uv).r;
    uv.y = y + (stretch * 0.20 * -1.0);
//  uv.y = y + (stretch * 0.20 * -1.0);
    oColor.g = texture(tex0, uv).g;
//  oColor.g = texture(tex0, uv).g;
    uv.y = y + (stretch * 0.15 * -1.0);
//  uv.y = y + (stretch * 0.15 * -1.0);
    oColor.b = texture(tex0, uv).b;
//  oColor.b = texture(tex0, uv).b;
    oColor.a = 1.0;
//  oColor.a = 1.0;
    
    
    oColor *= xmask * (1.0 - stretch);
//  oColor *= xmask * (1.0 - stretch);
    
    //oColor = mix(oColor * color, oColor, 1.0 - stretch);
//  //oColor = mix(oColor * color, oColor, 1.0 - stretch);
    //oColor = mix(oColor * color, oColor, 1.0 - stretch);
//  //oColor = mix(oColor * color, oColor, 1.0 - stretch);
    */
//  */

    /*
//  /*
    oColor.r *= pow((1.0 - stretch), 20.0) ;
//  oColor.r *= pow((1.0 - stretch), 20.0) ;
    oColor.g *= pow((1.0 - stretch), 01.0) ;
//  oColor.g *= pow((1.0 - stretch), 01.0) ;
    oColor.b *= pow((1.0 - stretch), 20.0) ;
//  oColor.b *= pow((1.0 - stretch), 20.0) ;
    */
//  */
    //fragColor = oColor;
//  //fragColor = oColor;
    
    }








