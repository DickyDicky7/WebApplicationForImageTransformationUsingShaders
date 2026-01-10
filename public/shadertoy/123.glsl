    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    uniform         sampler2D    uploadTex0; // null
//  uniform         sampler2D    uploadTex0; // null
    uniform         sampler2D        noise0; // null
//  uniform         sampler2D        noise0; // null
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

    // https://www.shadertoy.com/view/wd3fR8
//  // https://www.shadertoy.com/view/wd3fR8

    #define pi 3.14159265359
//  #define pi 3.14159265359

    float get_ratio(float ratio, float start, float finish, float power) { return pow((step(start, ratio) * step(-finish, -ratio) * (ratio - start) / (finish - start)), power); }
//  float get_ratio(float ratio, float start, float finish, float power) { return pow((step(start, ratio) * step(-finish, -ratio) * (ratio - start) / (finish - start)), power); }


    const float speed = 00.6;
//  const float speed = 00.6;
    const float blur  = 10.0;
//  const float blur  = 10.0;
    const float zoom  = 00.3;
//  const float zoom  = 00.3;

    const vec3       strip_col   = vec3(0.05); // vec3(30./255., 50./255., 50./255.);
//  const vec3       strip_col   = vec3(0.05); // vec3(30./255., 50./255., 50./255.);
    const vec3  background_col   = vec3(0.80);
//  const vec3  background_col   = vec3(0.80);
    const float      strip_count =      5.00 ;
//  const float      strip_count =      5.00 ;


    ////////////////////
//  ////////////////////
    ///   Stage 1.   ///
//  ///   Stage 1.   ///
    ////////////////////
//  ////////////////////
    const float  start_1 = 0.0;
//  const float  start_1 = 0.0;
    const float finish_1 = 0.3;
//  const float finish_1 = 0.3;
    const float  power_1 = 0.5;
//  const float  power_1 = 0.5;


    ////////////////////
//  ////////////////////
    ///   Stage 2.   ///
//  ///   Stage 2.   ///
    ////////////////////
//  ////////////////////
    const float  start_2 = 0.3;
//  const float  start_2 = 0.3;
    const float finish_2 = 0.7;
//  const float finish_2 = 0.7;
    const float  power_2 = 1.0;
//  const float  power_2 = 1.0;


    ////////////////////
//  ////////////////////
    ///   Stage 3.   ///
//  ///   Stage 3.   ///
    ////////////////////
//  ////////////////////
    const float  start_3 = 0.7;
//  const float  start_3 = 0.7;
    const float finish_3 = 1.0;
//  const float finish_3 = 1.0;
    const float  power_3 = 2.0;
//  const float  power_3 = 2.0;



    void main()
    {
    float remapTime = mod(speed * time, 2.f) - 1.f; remapTime *= step(0.f, remapTime); bool change_scene = int((speed * time + start_2) / 2.f) % 2 == 0; float ratio = remapTime; vec2 uv = vTexCoord;
//  float remapTime = mod(speed * time, 2.f) - 1.f; remapTime *= step(0.f, remapTime); bool change_scene = int((speed * time + start_2) / 2.f) % 2 == 0; float ratio = remapTime; vec2 uv = vTexCoord;

    float stage_1 = get_ratio(ratio, start_1, finish_1, power_1);
//  float stage_1 = get_ratio(ratio, start_1, finish_1, power_1);
    float stage_2 = get_ratio(ratio, start_2, finish_2, power_2);
//  float stage_2 = get_ratio(ratio, start_2, finish_2, power_2);
    float stage_3 = get_ratio(ratio, start_3, finish_3, power_3);
//  float stage_3 = get_ratio(ratio, start_3, finish_3, power_3);
    
    
    ////////////////////
//  ////////////////////
    ///   Stage 1.   ///
//  ///   Stage 1.   ///
    ////////////////////
//  ////////////////////
    uv -= 0.5;
//  uv -= 0.5;
    uv *= 1. + zoom * stage_1;
//  uv *= 1. + zoom * stage_1;
    uv += 0.5;
//  uv += 0.5;
    
    
    ////////////////////
//  ////////////////////
    ///   Stage 2.   ///
//  ///   Stage 2.   ///
    ////////////////////
//  ////////////////////
    uv   -= 0.5;
//  uv   -= 0.5;
    uv   *= 1. + zoom * float(stage_2 > 0.);
//  uv   *= 1. + zoom * float(stage_2 > 0.);
    uv   += 0.5;
//  uv   += 0.5;
    uv.y -=                   stage_2      ;
//  uv.y -=                   stage_2      ;
    
    
    ////////////////////
//  ////////////////////
    ///   Stage 3.   ///
//  ///   Stage 3.   ///
    ////////////////////
//  ////////////////////
    uv -= 0.5;
//  uv -= 0.5;
    uv *= (stage_3 == 0.) ? 1. : 1. + zoom * (1. - stage_3);
//  uv *= (stage_3 == 0.) ? 1. : 1. + zoom * (1. - stage_3);
    uv += 0.5;
//  uv += 0.5;
    
    
    /////////////////////
//  /////////////////////
    ///   Mirroring   ///
//  ///   Mirroring   ///
    /////////////////////
//  /////////////////////
    if (uv.y <  0.) { if (stage_3 == 0.) { change_scene = !change_scene; }
//  if (uv.y <  0.) { if (stage_3 == 0.) { change_scene = !change_scene; }
    uv.y += 1.;
//  uv.y += 1.;
    if (uv.y <  0.) { if (stage_2 <= 0.) { change_scene = !change_scene; }
//  if (uv.y <  0.) { if (stage_2 <= 0.) { change_scene = !change_scene; }
    uv.y += 1.;
//  uv.y += 1.;
    }
//  }
    } else if (uv.y >  1.) { if (stage_3 >  0.) { change_scene = !change_scene; }
//  } else if (uv.y >  1.) { if (stage_3 >  0.) { change_scene = !change_scene; }
    uv.y -= 1.;
//  uv.y -= 1.;
    }
//  }
        
    
    
    /////////////////////////////
//  /////////////////////////////
    ///   Picking the color   ///
//  ///   Picking the color   ///
    /////////////////////////////
//  /////////////////////////////
    vec3 col = (change_scene) ? texture(      tex0, uv).rgb
//  vec3 col = (change_scene) ? texture(      tex0, uv).rgb
    : texture(uploadTex0, uv).rgb;
//  : texture(uploadTex0, uv).rgb;
    
    
    
    //////////////////////
//  //////////////////////
    ///   Background   ///
//  ///   Background   ///
    //////////////////////
//  //////////////////////
    vec2 real_uv = vTexCoord;
//  vec2 real_uv = vTexCoord;
    if (uv.x < 0.f
//  if (uv.x < 0.f
    ||  uv.x > 1.f) { col  = 1.5f * texture(noise0, real_uv).rgb; if (sin(strip_count * 2.f * pi * uv.y) >= 0.f) { col = strip_col; }
//  ||  uv.x > 1.f) { col  = 1.5f * texture(noise0, real_uv).rgb; if (sin(strip_count * 2.f * pi * uv.y) >= 0.f) { col = strip_col; }
    }
//  }
    if (uv.x < 0.f
//  if (uv.x < 0.f
    &&  uv.x >     - 0.4f * zoom / (2.f * (1.f + zoom))) {
//  &&  uv.x >     - 0.4f * zoom / (2.f * (1.f + zoom))) {
    col = strip_col;
//  col = strip_col;
    }
//  }
    if (uv.x > 1.f
//  if (uv.x > 1.f
    &&  uv.x < 1.f + 0.4f * zoom / (2.f * (1.f + zoom))) {
//  &&  uv.x < 1.f + 0.4f * zoom / (2.f * (1.f + zoom))) {
    col = strip_col;
//  col = strip_col;
    }
//  }
    if (uv.x <     - 0.9f * zoom / (2.f * (1.f + zoom))) {
//  if (uv.x <     - 0.9f * zoom / (2.f * (1.f + zoom))) {
    col = strip_col;
//  col = strip_col;
    }
//  }
    if (uv.x > 1.f + 0.9f * zoom / (2.f * (1.f + zoom))) {
//  if (uv.x > 1.f + 0.9f * zoom / (2.f * (1.f + zoom))) {
    col = strip_col;
//  col = strip_col;
    }
//  }
    
    
    
    //////////////////////////
//  //////////////////////////
    ///    Sliding blur    ///
//  ///    Sliding blur    ///
    //////////////////////////
//  //////////////////////////
    /*
//  /*
    float numSteps = float(int(blur * sin(pi * pow(ratio, power)))); float sigma = 0.01; for (float i = 1.; i < numSteps; i++) { uv.y -= sigma; col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.) col /= numSteps;
//  float numSteps = float(int(blur * sin(pi * pow(ratio, power)))); float sigma = 0.01; for (float i = 1.; i < numSteps; i++) { uv.y -= sigma; col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.) col /= numSteps;
    */
//  */
    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }











