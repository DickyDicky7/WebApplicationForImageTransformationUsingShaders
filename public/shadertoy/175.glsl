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

    // https://www.shadertoy.com/view/4cdfWl
//  // https://www.shadertoy.com/view/4cdfWl


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

    //const bool onEaseOutExpo   ; // false
//  //const bool onEaseOutExpo   ; // false
    uniform bool onEaseInOutQuad ; // false
//  uniform bool onEaseInOutQuad ; // false
    uniform bool onEaseInCubic   ; // false
//  uniform bool onEaseInCubic   ; // false
    uniform bool onEaseOutCubic  ; // false
//  uniform bool onEaseOutCubic  ; // false
    uniform bool onEaseInOutCubic; // false
//  uniform bool onEaseInOutCubic; // false
    uniform bool onEaseInQuart   ; // false
//  uniform bool onEaseInQuart   ; // false
    uniform bool onEaseOutQuart  ; // false
//  uniform bool onEaseOutQuart  ; // false
    uniform bool onEaseInOutQuart; // false
//  uniform bool onEaseInOutQuart; // false
    uniform bool onEaseInSine    ; // false
//  uniform bool onEaseInSine    ; // false
    uniform bool onEaseOutSine   ; // false
//  uniform bool onEaseOutSine   ; // false
    uniform bool onEaseInOutSine ; // false
//  uniform bool onEaseInOutSine ; // false
    uniform bool onEaseInExpo    ; // false
//  uniform bool onEaseInExpo    ; // false
    uniform bool onEaseOutExpo   ; // false
//  uniform bool onEaseOutExpo   ; // false
    uniform bool onEaseInOutExpo ; // false
//  uniform bool onEaseInOutExpo ; // false
    uniform bool onEaseInBack    ; // false
//  uniform bool onEaseInBack    ; // false
    uniform bool onEaseOutBack   ; // false
//  uniform bool onEaseOutBack   ; // false
    uniform bool onEaseInOutBack ; // false
//  uniform bool onEaseInOutBack ; // false

    void main()
    {

    vec4 color  = vec4(0.0, 1.0, 1.0, 1.0);
//  vec4 color  = vec4(0.0, 1.0, 1.0, 1.0);
    color *= 1.0;
//  color *= 1.0;

    float T_MAX =     1.50;
//  float T_MAX =     1.50;
    float timee = mod(time
//  float timee = mod(time
    , T_MAX)  ;
//  , T_MAX)  ;
    float t     =
//  float t     =
    timee / T_MAX   ;
//  timee / T_MAX   ;
    //t = 0.5    ;
//  //t = 0.5    ;
    //t = 1.0 - t;
//  //t = 1.0 - t;
    
    //t = 1.00;
//  //t = 1.00;
    //t = 0.01;
//  //t = 0.01;
    //t = 0.25;
//  //t = 0.25;
    
    float progress = t;
//  float progress = t;
    if (onEaseOutExpo   )
//  if (onEaseOutExpo   )
    {
//  {
    progress = easeOutExpo   (progress);
//  progress = easeOutExpo   (progress);
    }
//  }
    else
//  else
    if (onEaseInOutQuad )
//  if (onEaseInOutQuad )
    {
//  {
    progress = easeInOutQuad (progress);
//  progress = easeInOutQuad (progress);
    }
//  }
    else
//  else
    if (onEaseInCubic   )
//  if (onEaseInCubic   )
    {
//  {
    progress = easeInCubic   (progress);
//  progress = easeInCubic   (progress);
    }
//  }
    else
//  else
    if (onEaseOutCubic  )
//  if (onEaseOutCubic  )
    {
//  {
    progress = easeOutCubic  (progress);
//  progress = easeOutCubic  (progress);
    }
//  }
    else
//  else
    if (onEaseInOutCubic)
//  if (onEaseInOutCubic)
    {
//  {
    progress = easeInOutCubic(progress);
//  progress = easeInOutCubic(progress);
    }
//  }
    else
//  else
    if (onEaseInQuart   )
//  if (onEaseInQuart   )
    {
//  {
    progress = easeInQuart   (progress);
//  progress = easeInQuart   (progress);
    }
//  }
    else
//  else
    if (onEaseOutQuart  )
//  if (onEaseOutQuart  )
    {
//  {
    progress = easeOutQuart  (progress);
//  progress = easeOutQuart  (progress);
    }
//  }
    else
//  else
    if (onEaseInOutQuart)
//  if (onEaseInOutQuart)
    {
//  {
    progress = easeInOutQuart(progress);
//  progress = easeInOutQuart(progress);
    }
//  }
    else
//  else
    if (onEaseInSine    )
//  if (onEaseInSine    )
    {
//  {
    progress = easeInSine    (progress);
//  progress = easeInSine    (progress);
    }
//  }
    else
//  else
    if (onEaseOutSine   )
//  if (onEaseOutSine   )
    {
//  {
    progress = easeOutSine   (progress);
//  progress = easeOutSine   (progress);
    }
//  }
    else
//  else
    if (onEaseInOutSine )
//  if (onEaseInOutSine )
    {
//  {
    progress = easeInOutSine (progress);
//  progress = easeInOutSine (progress);
    }
//  }
    else
//  else
    if (onEaseInExpo    )
//  if (onEaseInExpo    )
    {
//  {
    progress = easeInExpo    (progress);
//  progress = easeInExpo    (progress);
    }
//  }
    else
//  else
    if (onEaseOutExpo   )
//  if (onEaseOutExpo   )
    {
//  {
    progress = easeOutExpo   (progress);
//  progress = easeOutExpo   (progress);
    }
//  }
    else
//  else
    if (onEaseInOutExpo )
//  if (onEaseInOutExpo )
    {
//  {
    progress = easeInOutExpo (progress);
//  progress = easeInOutExpo (progress);
    }
//  }
    else
//  else
    if (onEaseInBack    )
//  if (onEaseInBack    )
    {
//  {
    progress = easeInBack    (progress);
//  progress = easeInBack    (progress);
    }
//  }
    else
//  else
    if (onEaseOutBack   )
//  if (onEaseOutBack   )
    {
//  {
    progress = easeOutBack   (progress);
//  progress = easeOutBack   (progress);
    }
//  }
    else
//  else
    if (onEaseInOutBack )
//  if (onEaseInOutBack )
    {
//  {
    progress = easeInOutBack (progress);
//  progress = easeInOutBack (progress);
    }
//  }
    else
//  else
    {
//  {

    }
//  }
    
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    

    float stretch  =     0.0                ;
//  float stretch  =     0.0                ;
    float ts       = mix(0.0, 1.5, progress);
//  float ts       = mix(0.0, 1.5, progress);
    stretch =                               abs(ts - uv.y); // / 0.25 ;
//  stretch =                               abs(ts - uv.y); // / 0.25 ;
    stretch =  1.0 - stretch           ;
//  stretch =  1.0 - stretch           ;
    stretch =  clamp(stretch, 0.0, 1.0);
//  stretch =  clamp(stretch, 0.0, 1.0);
    
    
    float thickness = mix(100.0,2.0,0.99);
//  float thickness = mix(100.0,2.0,0.99);
    stretch         = pow(
//  stretch         = pow(
    stretch         ,
//  stretch         ,
    thickness);
//  thickness);
    
    float xmask = 1.0;
//  float xmask = 1.0;
    if (ts - uv.y < 0.0)
//  if (ts - uv.y < 0.0)
    {
//  {
    xmask   = 0.0;
//  xmask   = 0.0;
    stretch = 0.0;
//  stretch = 0.0;
    }
//  }
    
    fragColor = vec4(stretch);
//  fragColor = vec4(stretch);
    
    vec4 oColor = vec4(0.0);
//  vec4 oColor = vec4(0.0);
    oColor = vec4(0.0);
//  oColor = vec4(0.0);
    
    
    //  uv.y  += stretch *  0.15 * -1.0;
//  //  uv.y  += stretch *  0.15 * -1.0;
    //  oColor = texture(tex0    ,  uv);
//  //  oColor = texture(tex0    ,  uv);
    
    float  y = uv.y;
//  float  y = uv.y;
    uv.y = y + (stretch * 0.25 * -1.0);
//  uv.y = y + (stretch * 0.25 * -1.0);
    oColor.r = texture(tex0, uv).r * mix(1.0, 5.0, stretch);
//  oColor.r = texture(tex0, uv).r * mix(1.0, 5.0, stretch);
    uv.y = y + (stretch * 0.20 * -1.0);
//  uv.y = y + (stretch * 0.20 * -1.0);
    oColor.g = texture(tex0, uv).g * mix(1.0, 5.0, stretch);
//  oColor.g = texture(tex0, uv).g * mix(1.0, 5.0, stretch);
    uv.y = y + (stretch * 0.15 * -1.0);
//  uv.y = y + (stretch * 0.15 * -1.0);
    oColor.b = texture(tex0, uv).b * mix(1.0, 5.0, stretch);
//  oColor.b = texture(tex0, uv).b * mix(1.0, 5.0, stretch);
    oColor.a = 01.0;
//  oColor.a = 01.0;
    
    
    //  float xcolor  = pow((    1.0 - stretch), 1.0);
//  //  float xcolor  = pow((    1.0 - stretch), 1.0);
    //        oColor *= xmask * (1.0 - stretch)      ;
//  //        oColor *= xmask * (1.0 - stretch)      ;
    oColor *= xmask * (1.0 - stretch)      ;
//  oColor *= xmask * (1.0 - stretch)      ;
    //        oColor *= xmask                        ;
//  //        oColor *= xmask                        ;
    
    //  oColor = mix(oColor * color, oColor, 1.0 - stretch);
//  //  oColor = mix(oColor * color, oColor, 1.0 - stretch);
    
    /*
//  /*
    oColor.r *= pow((1.0 - stretch), 20.0);
//  oColor.r *= pow((1.0 - stretch), 20.0);
    oColor.g *= pow((1.0 - stretch), 01.0);
//  oColor.g *= pow((1.0 - stretch), 01.0);
    oColor.b *= pow((1.0 - stretch), 20.0);
//  oColor.b *= pow((1.0 - stretch), 20.0);
    */
//  */
    fragColor = oColor;
//  fragColor = oColor;
    }



