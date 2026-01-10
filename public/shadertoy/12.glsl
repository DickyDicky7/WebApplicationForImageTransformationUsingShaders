#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform sampler2D  tex0;
//  uniform sampler2D  tex0;
    in      vec2           vTexCoord;
//  in      vec2           vTexCoord;
    out     vec4       glslFragColor;
//  out     vec4       glslFragColor;
    uniform float      time;
//  uniform float      time;
    uniform vec2 canvasSize;
//  uniform vec2 canvasSize;
    uniform vec2           texelSize;
//  uniform vec2           texelSize;

    // vec3     darkest  = vec3(0.0588235, 0.219608, 0.0588235);
//  // vec3     darkest  = vec3(0.0588235, 0.219608, 0.0588235);
    // float lumDarkest  = 0.13921568627450980;
//  // float lumDarkest  = 0.13921568627450980;
    // vec3     darker   = vec3(0.1882350, 0.384314, 0.1882350);
//  // vec3     darker   = vec3(0.1882350, 0.384314, 0.1882350);
    // float lumDarker   = 0.28627450980392155;
//  // float lumDarker   = 0.28627450980392155;
    // vec3     lighter  = vec3(0.5450980, 0.674510, 0.0588235);
//  // vec3     lighter  = vec3(0.5450980, 0.674510, 0.0588235);
    // float lumLighter  = 0.36666666666666670;
//  // float lumLighter  = 0.36666666666666670;
    // vec3     lightest = vec3(0.6078430, 0.737255, 0.0588235);
//  // vec3     lightest = vec3(0.6078430, 0.737255, 0.0588235);
    // float lumLightest = 0.39803921568627454;
//  // float lumLightest = 0.39803921568627454;

    uniform vec3     darkest  ; // 0.0588235, 0.219608, 0.0588235
//  uniform vec3     darkest  ; // 0.0588235, 0.219608, 0.0588235
    uniform float lumDarkest  ; // 0.13921568627450980
//  uniform float lumDarkest  ; // 0.13921568627450980
    uniform vec3     darker   ; // 0.1882350, 0.384314, 0.1882350
//  uniform vec3     darker   ; // 0.1882350, 0.384314, 0.1882350
    uniform float lumDarker   ; // 0.28627450980392155
//  uniform float lumDarker   ; // 0.28627450980392155
    uniform vec3     lighter  ; // 0.5450980, 0.674510, 0.0588235
//  uniform vec3     lighter  ; // 0.5450980, 0.674510, 0.0588235
    uniform float lumLighter  ; // 0.36666666666666670
//  uniform float lumLighter  ; // 0.36666666666666670
    uniform vec3     lightest ; // 0.6078430, 0.737255, 0.0588235
//  uniform vec3     lightest ; // 0.6078430, 0.737255, 0.0588235
    uniform float lumLightest ; // 0.39803921568627454
//  uniform float lumLightest ; // 0.39803921568627454

    float CalculateHue(vec4 color, float minCol, float maxCol)
//  float CalculateHue(vec4 color, float minCol, float maxCol)
    {
//  {
    float hue = 00.0;
//  float hue = 00.0;
    hue = hue * 60.0;
//  hue = hue * 60.0;
    
    if (hue < 0.0)
//  if (hue < 0.0)
    {
//  {
    hue += 360.0;
//  hue += 360.0;
    }
//  }
    
    if (abs(maxCol - color.r) < 0.000001)
//  if (abs(maxCol - color.r) < 0.000001)
    {
//  {
    hue =       (color.g - color.b) / (maxCol - minCol);
//  hue =       (color.g - color.b) / (maxCol - minCol);
    }
//  }
    else
//  else
    if (abs(maxCol - color.g) < 0.000001)
//  if (abs(maxCol - color.g) < 0.000001)
    {
//  {
    hue = 2.0 + (color.b - color.r) / (maxCol - minCol);
//  hue = 2.0 + (color.b - color.r) / (maxCol - minCol);
    }
//  }
    else
//  else
    {
//  {
    hue = 4.0 + (color.r - color.g) / (maxCol - minCol);
//  hue = 4.0 + (color.r - color.g) / (maxCol - minCol);
    }
//  }
    
    return hue;
//  return hue;
    }
//  }

    void main()
    {
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    uv *= 100.00;
//  uv *= 100.00;
    uv = vec2(floor(uv.x), floor(uv.y));
//  uv = vec2(floor(uv.x), floor(uv.y));
    uv *= 000.01;
//  uv *= 000.01;
    
    vec4 fragColor = texture(tex0, uv);
//  vec4 fragColor = texture(tex0, uv);
    float maxCol = max(max(fragColor.r, fragColor.g), fragColor.b);
//  float maxCol = max(max(fragColor.r, fragColor.g), fragColor.b);
    float minCol = min(min(fragColor.r, fragColor.g), fragColor.b);
//  float minCol = min(min(fragColor.r, fragColor.g), fragColor.b);
    float lum = (minCol + maxCol) / 2.0 ;
//  float lum = (minCol + maxCol) / 2.0 ;
    
    float  darkestDist = abs(lumDarkest  - lum);
//  float  darkestDist = abs(lumDarkest  - lum);
    float   darkerDist = abs(lumDarker   - lum);
//  float   darkerDist = abs(lumDarker   - lum);
    float  lighterDist = abs(lumLighter  - lum);
//  float  lighterDist = abs(lumLighter  - lum);
    float lightestDist = abs(lumLightest - lum);
//  float lightestDist = abs(lumLightest - lum);
    
    float minDist = min(min(min(darkestDist, darkerDist), lighterDist), lightestDist);
//  float minDist = min(min(min(darkestDist, darkerDist), lighterDist), lightestDist);
    
    if (abs(minDist - darkestDist) < 0.000001)
//  if (abs(minDist - darkestDist) < 0.000001)
    {
//  {
    fragColor = vec4(darkest , 1.0);
//  fragColor = vec4(darkest , 1.0);
    }
//  }
    else
//  else
    if (abs(minDist -  darkerDist) < 0.000001)
//  if (abs(minDist -  darkerDist) < 0.000001)
    {
//  {
    fragColor = vec4(darker  , 1.0);
//  fragColor = vec4(darker  , 1.0);
    }
//  }
    else
//  else
    if (abs(minDist - lighterDist) < 0.000001)
//  if (abs(minDist - lighterDist) < 0.000001)
    {
//  {
    fragColor = vec4(lighter , 1.0);
//  fragColor = vec4(lighter , 1.0);
    }
//  }
    else
//  else
    {
//  {
    fragColor = vec4(lightest, 1.0);
//  fragColor = vec4(lightest, 1.0);
    }
//  }
    
    glslFragColor = fragColor;
//  glslFragColor = fragColor;
    }

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/ltV3Wc
//  // https://www.shadertoy.com/view/ltV3Wc
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
