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

    // https://www.shadertoy.com/view/mddyD4
//  // https://www.shadertoy.com/view/mddyD4

    uniform bool onType001; // true
//  uniform bool onType001; // true
    uniform bool onType002; // false
//  uniform bool onType002; // false
    uniform bool onType003; // false
//  uniform bool onType003; // false
    uniform bool onType004; // false
//  uniform bool onType004; // false
    uniform bool onType005; // false
//  uniform bool onType005; // false
    uniform bool onType006; // false
//  uniform bool onType006; // false

    float randomNoise(float x, float y) { return fract(sin(dot(vec2(x, y), vec2(12.9f, 78.2f))) * 43758.0f); }
//  float randomNoise(float x, float y) { return fract(sin(dot(vec2(x, y), vec2(12.9f, 78.2f))) * 43758.0f); }

    vec4 methed1(in vec2 uv) {
//  vec4 methed1(in vec2 uv) {
    // 简单版，运动恒定的左右RGB色彩分离
//  // 简单版，运动恒定的左右RGB色彩分离
    // 简单版，运动恒定的左右RGB色彩分离
//  // 简单版，运动恒定的左右RGB色彩分离
    float               _Intensity =                   0.05f;
//  float               _Intensity =                   0.05f;
    float splitAmount = _Intensity * randomNoise(time, 2.00f);
//  float splitAmount = _Intensity * randomNoise(time, 2.00f);
    vec4       ColorR = texture(tex0, vec2(uv.x + splitAmount, uv.y));
//  vec4       ColorR = texture(tex0, vec2(uv.x + splitAmount, uv.y));
    vec4       ColorG = texture(tex0                         , uv   );
//  vec4       ColorG = texture(tex0                         , uv   );
    vec4       ColorB = texture(tex0, vec2(uv.x - splitAmount, uv.y));
//  vec4       ColorB = texture(tex0, vec2(uv.x - splitAmount, uv.y));
    return vec4(ColorR.r
//  return vec4(ColorR.r
    ,      ColorG.g
//  ,      ColorG.g
    ,      ColorB.b
//  ,      ColorB.b
    ,      ColorR.a);
//  ,      ColorR.a);
    }
//  }

    vec4 methed2(in vec2 uv) {
//  vec4 methed2(in vec2 uv) {
    // 利用sin和pow控制抖动间隔、幅度，以及抖动的曲线
//  // 利用sin和pow控制抖动间隔、幅度，以及抖动的曲线
    // 利用sin和pow控制抖动间隔、幅度，以及抖动的曲线
//  // 利用sin和pow控制抖动间隔、幅度，以及抖动的曲线
    float _Amplitude = 2.0f;
//  float _Amplitude = 2.0f;
    float _Amount    = 0.2f;
//  float _Amount    = 0.2f;
    float
//  float
    splitAmount  = (1.0f + sin(time * 06.0f) * 0.5f);
//  splitAmount  = (1.0f + sin(time * 06.0f) * 0.5f);
    splitAmount *=  1.0f + sin(time * 16.0f) * 0.5f ;
//  splitAmount *=  1.0f + sin(time * 16.0f) * 0.5f ;
    splitAmount *=  1.0f + sin(time * 19.0f) * 0.5f ;
//  splitAmount *=  1.0f + sin(time * 19.0f) * 0.5f ;
    splitAmount *=  1.0f + sin(time * 27.0f) * 0.5f ;
//  splitAmount *=  1.0f + sin(time * 27.0f) * 0.5f ;
    splitAmount  =  pow(splitAmount, _Amplitude);
//  splitAmount  =  pow(splitAmount, _Amplitude);
    splitAmount *= (0.05f * _Amount);
//  splitAmount *= (0.05f * _Amount);
    vec3 finalColor;
//  vec3 finalColor;
    finalColor.r = texture(tex0, vec2(uv.x + splitAmount, uv.y)).r;
//  finalColor.r = texture(tex0, vec2(uv.x + splitAmount, uv.y)).r;
    finalColor.g = texture(tex0                         , uv   ).g;
//  finalColor.g = texture(tex0                         , uv   ).g;
    finalColor.b = texture(tex0, vec2(uv.x - splitAmount, uv.y)).b;
//  finalColor.b = texture(tex0, vec2(uv.x - splitAmount, uv.y)).b;
    finalColor  *= (1.0f - splitAmount * 0.5f);
//  finalColor  *= (1.0f - splitAmount * 0.5f);
    return vec4(
//  return vec4(
    finalColor ,    1.0f                     );
//  finalColor ,    1.0f                     );
    }
//  }

    vec4 methed3(vec2 uv) {
//  vec4 methed3(vec2 uv) {
    // 利用sin函数，实现平缓左右摇摆RGB分离
//  // 利用sin函数，实现平缓左右摇摆RGB分离
    // 利用sin函数，实现平缓左右摇摆RGB分离
//  // 利用sin函数，实现平缓左右摇摆RGB分离
    float                   strength = 0.5f + 0.5f * cos(time * 15.2f);
//  float                   strength = 0.5f + 0.5f * cos(time * 15.2f);
    float _Amount = 0.08f * strength                                  ;
//  float _Amount = 0.08f * strength                                  ;
    vec3
//  vec3
    splitAmountX    = vec3(uv.x
//  splitAmountX    = vec3(uv.x
    ,      uv.x
//  ,      uv.x
    ,      uv.x);
//  ,      uv.x);
    splitAmountX.r += sin (time * 0.2f) * _Amount;
//  splitAmountX.r += sin (time * 0.2f) * _Amount;
    splitAmountX.g += sin (time * 0.1f) * _Amount;
//  splitAmountX.g += sin (time * 0.1f) * _Amount;
    vec4
//  vec4
    splitColor   = vec4(0.0f);
//  splitColor   = vec4(0.0f);
    splitColor.r = texture(tex0, vec2(splitAmountX.r, uv.y)).r;
//  splitColor.r = texture(tex0, vec2(splitAmountX.r, uv.y)).r;
    splitColor.g = texture(tex0, vec2(splitAmountX.g, uv.y)).g;
//  splitColor.g = texture(tex0, vec2(splitAmountX.g, uv.y)).g;
    splitColor.b = texture(tex0, vec2(splitAmountX.b, uv.y)).b;
//  splitColor.b = texture(tex0, vec2(splitAmountX.b, uv.y)).b;
    splitColor.a = 1.0f ;
//  splitColor.a = 1.0f ;
    vec3 color   = splitColor.rgb;
//  vec3 color   = splitColor.rgb;
    return         vec4(color
//  return         vec4(color
    , 1.0f);
//  , 1.0f);
    }
//  }

    vec4 methed4(vec2 uv) {
//  vec4 methed4(vec2 uv) {
    // 利用sin函数，实现平缓上下摇摆RGB分离
//  // 利用sin函数，实现平缓上下摇摆RGB分离
    // 利用sin函数，实现平缓上下摇摆RGB分离
//  // 利用sin函数，实现平缓上下摇摆RGB分离
    float                   strength = 0.5f + 0.5f * cos(time * 15.2f);
//  float                   strength = 0.5f + 0.5f * cos(time * 15.2f);
    float _Amount = 0.08f * strength                                  ;
//  float _Amount = 0.08f * strength                                  ;
    vec3
//  vec3
    splitAmountY    = vec3(uv.y       )          ;
//  splitAmountY    = vec3(uv.y       )          ;
    splitAmountY.r += sin (time * 0.2f) * _Amount;
//  splitAmountY.r += sin (time * 0.2f) * _Amount;
    splitAmountY.g += sin (time * 0.1f) * _Amount;
//  splitAmountY.g += sin (time * 0.1f) * _Amount;
    vec4
//  vec4
    splitColor   = vec4(0.0f);
//  splitColor   = vec4(0.0f);
    splitColor.r = texture(tex0, vec2(uv.x, splitAmountY.r)).r;
//  splitColor.r = texture(tex0, vec2(uv.x, splitAmountY.r)).r;
    splitColor.g = texture(tex0, vec2(uv.x, splitAmountY.g)).g;
//  splitColor.g = texture(tex0, vec2(uv.x, splitAmountY.g)).g;
    splitColor.b = texture(tex0, vec2(uv.x, splitAmountY.b)).b;
//  splitColor.b = texture(tex0, vec2(uv.x, splitAmountY.b)).b;
    splitColor.a = 1.0f;
//  splitColor.a = 1.0f;
    return
//  return
    splitColor         ;
//  splitColor         ;
    }
//  }

    vec4 methed5(vec2 uv) {
//  vec4 methed5(vec2 uv) {
    // 利用sin函数，实现平缓左下右上摇摆RGB分离
//  // 利用sin函数，实现平缓左下右上摇摆RGB分离
    // 利用sin函数，实现平缓左下右上摇摆RGB分离
//  // 利用sin函数，实现平缓左下右上摇摆RGB分离
    float                        strength = 0.5f + 0.5f * sin(time * 15.2f);
//  float                        strength = 0.5f + 0.5f * sin(time * 15.2f);
    float     _Amount  = 0.08f * strength                                  ;
//  float     _Amount  = 0.08f * strength                                  ;
    float splitAmountR = sin(time * 0.2f) * _Amount;
//  float splitAmountR = sin(time * 0.2f) * _Amount;
    float splitAmountG = sin(time * 0.2f) * _Amount;
//  float splitAmountG = sin(time * 0.2f) * _Amount;
    vec4
//  vec4
    splitColor   = vec4(0.0f);
//  splitColor   = vec4(0.0f);
    splitColor.r = (texture(tex0, vec2(uv.x + splitAmountR, uv.y + splitAmountR)).rgb).x;
//  splitColor.r = (texture(tex0, vec2(uv.x + splitAmountR, uv.y + splitAmountR)).rgb).x;
    splitColor.g = (texture(tex0, vec2(uv.x               , uv.y               )).rgb).y;
//  splitColor.g = (texture(tex0, vec2(uv.x               , uv.y               )).rgb).y;
    splitColor.b = (texture(tex0, vec2(uv.x + splitAmountG, uv.y + splitAmountG)).rgb).z;
//  splitColor.b = (texture(tex0, vec2(uv.x + splitAmountG, uv.y + splitAmountG)).rgb).z;
    splitColor.a = 1.0f;
//  splitColor.a = 1.0f;
    return
//  return
    splitColor         ;
//  splitColor         ;
    }
//  }

    vec4 methed6(vec2 uv) {
//  vec4 methed6(vec2 uv) {
    //使用随机噪声，实现左下右上RGB色彩分离
//  //使用随机噪声，实现左下右上RGB色彩分离
    //使用随机噪声，实现左下右上RGB色彩分离
//  //使用随机噪声，实现左下右上RGB色彩分离
    float               _Indensity =                   0.05f ;
//  float               _Indensity =                   0.05f ;
    float splitAmount = _Indensity * randomNoise(time, 2.00f);
//  float splitAmount = _Indensity * randomNoise(time, 2.00f);
    vec4 ColorR = texture(tex0                         , uv                 );
//  vec4 ColorR = texture(tex0                         , uv                 );
    vec4 ColorG = texture(tex0, vec2(uv.x + splitAmount, uv.y + splitAmount));
//  vec4 ColorG = texture(tex0, vec2(uv.x + splitAmount, uv.y + splitAmount));
    vec4 ColorB = texture(tex0, vec2(uv.x - splitAmount, uv.y - splitAmount));
//  vec4 ColorB = texture(tex0, vec2(uv.x - splitAmount, uv.y - splitAmount));
    return vec4(ColorR.r
//  return vec4(ColorR.r
    ,      ColorG.g
//  ,      ColorG.g
    ,      ColorB.b
//  ,      ColorB.b
    , 1.0f);
//  , 1.0f);
    }
//  }

    vec4 Pow4(vec4 v, float p) { return vec4(pow(v.x, p)
//  vec4 Pow4(vec4 v, float p) { return vec4(pow(v.x, p)
    ,      pow(v.y, p)
//  ,      pow(v.y, p)
    ,      pow(v.z, p)
//  ,      pow(v.z, p)
    ,          v.w
//  ,          v.w
    );
//  );
    }
//  }

    void main() {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    if (onType001)
//  if (onType001)
    {
//  {
    fragColor = methed1(vTexCoord);
//  fragColor = methed1(vTexCoord);
    }
//  }
    else
//  else
    if (onType002)
//  if (onType002)
    {
//  {
    fragColor = methed2(vTexCoord);
//  fragColor = methed2(vTexCoord);
    }
//  }
    else
//  else
    if (onType003)
//  if (onType003)
    {
//  {
    fragColor = methed3(vTexCoord);
//  fragColor = methed3(vTexCoord);
    }
//  }
    else
//  else
    if (onType004)
//  if (onType004)
    {
//  {
    fragColor = methed4(vTexCoord);
//  fragColor = methed4(vTexCoord);
    }
//  }
    else
//  else
    if (onType005)
//  if (onType005)
    {
//  {
    fragColor = methed5(vTexCoord);
//  fragColor = methed5(vTexCoord);
    }
//  }
    else
//  else
    if (onType006)
//  if (onType006)
    {
//  {
    fragColor = methed6(vTexCoord);
//  fragColor = methed6(vTexCoord);
    }
//  }
    else
//  else
    {
//  {
    fragColor = texture(tex0, vTexCoord);
//  fragColor = texture(tex0, vTexCoord);
    }
//  }
    }





