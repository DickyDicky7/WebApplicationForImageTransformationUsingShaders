    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    uniform         sampler2D        bayer0; // null
//  uniform         sampler2D        bayer0; // null
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

    // const float angle      = 20.0;
//  // const float angle      = 20.0;
    // const float scale      = 01.5;
//  // const float scale      = 01.5;
    // const float     amount = 04.0;
//  // const float     amount = 04.0;
    // const float saturation = 01.2;
//  // const float saturation = 01.2;
    // const bool   greyscale = true;
//  // const bool   greyscale = true;
    // const bool   colorOn   = true;
//  // const bool   colorOn   = true;

    uniform float angle      ; // 20.0
//  uniform float angle      ; // 20.0
    uniform float scale      ; // 01.5
//  uniform float scale      ; // 01.5
    uniform float     amount ; // 04.0
//  uniform float     amount ; // 04.0
    uniform float saturation ; // 01.2
//  uniform float saturation ; // 01.2
    uniform bool   greyscale ; // true
//  uniform bool   greyscale ; // true
    uniform bool   colorOn   ; // true
//  uniform bool   colorOn   ; // true

    #define   LINE
//  #define   LINE
    #define DOT
//  #define DOT
    #define DITHER
//  #define DITHER

    float greyScale(in    vec3 col) {
//  float greyScale(in    vec3 col) {
    return  dot(col , vec3(0.2126
//  return  dot(col , vec3(0.2126
    ,      0.7152
//  ,      0.7152
    ,      0.0722
//  ,      0.0722
    )
//  )
    )    ;
//  )    ;
    }
//  }

    mat2 rotate2d(float angle) {
//  mat2 rotate2d(float angle) {
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
//  return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
    }
//  }

    void main(void) {
    vec2  uv = vTexCoord     ;
//  vec2  uv = vTexCoord     ;
    vec3 col = texture(tex0, uv).rgb;
//  vec3 col = texture(tex0, uv).rgb;
    if (greyscale) col = vec3(greyScale(col));
//  if (greyscale) col = vec3(greyScale(col));
    
    uv      *=   canvasSize. xy;
//  uv      *=   canvasSize. xy;
    vec2 p   =   rotate2d(angle)
//  vec2 p   =   rotate2d(angle)
    *                uv
//  *                uv
    *             scale;
//  *             scale;
    
    float pattern;
//  float pattern;
    #ifdef   LINE
//  #ifdef   LINE
    pattern = sin(p.x)   *              amount       ;
//  pattern = sin(p.x)   *              amount       ;
    col     = col * 10.0 * saturation - 5.0 + pattern;
//  col     = col * 10.0 * saturation - 5.0 + pattern;
    #endif
//  #endif

    #ifdef DOT
//  #ifdef DOT
    pattern = sin(p.x)   * sin(p.y)   * amount       ;
//  pattern = sin(p.x)   * sin(p.y)   * amount       ;
    col     = col * 10.0 * saturation - 5.0 + pattern;
//  col     = col * 10.0 * saturation - 5.0 + pattern;
    #endif
//  #endif
    
    #ifdef DITHER
//  #ifdef DITHER
    pattern = texture(bayer0, vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / 4.0 * scale).r * amount / 5.0;
//  pattern = texture(bayer0, vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / 4.0 * scale).r * amount / 5.0;
    col     =                                                                 step(pattern, col * saturation / 1.2);
//  col     =                                                                 step(pattern, col * saturation / 1.2);
    #endif
//  #endif

    fragColor  =    vec4(col ,  1.0     );
//  fragColor  =    vec4(col ,  1.0     );
    if (colorOn) {
//  if (colorOn) {
    fragColor *= texture(tex0, vTexCoord);
//  fragColor *= texture(tex0, vTexCoord);
    }
//  }
    }



    // https://www.shadertoy.com/view/tdBSRc
//  // https://www.shadertoy.com/view/tdBSRc
