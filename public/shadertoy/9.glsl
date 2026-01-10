    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
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

    // Constants
//  // Constants
    // const float SPEED = 0.290;
//  // const float SPEED = 0.290;
    // const float TURBULENCE = 0.16;
//  // const float TURBULENCE = 0.16;
    // const float  ADVECTION = 0.30;
//  // const float  ADVECTION = 0.30;
    // const float DEPTH = 0.023;
//  // const float DEPTH = 0.023;
    // const vec3  LIGHT = normalize(vec3(-0.5, 1.0, 0.25)); // Match the ref texture
//  // const vec3  LIGHT = normalize(vec3(-0.5, 1.0, 0.25)); // Match the ref texture
    // const vec3  COLOR_SUN = vec3(1.1, 1.00, 1.0) * 9.0;
//  // const vec3  COLOR_SUN = vec3(1.1, 1.00, 1.0) * 9.0;
    // const vec3  COLOR_SKY = vec3(0.1, 0.14, 0.2) * 0.9;
//  // const vec3  COLOR_SKY = vec3(0.1, 0.14, 0.2) * 0.9;

    uniform float SPEED           ; // 0.290
//  uniform float SPEED           ; // 0.290
    uniform float TURBULENCE      ; // 0.160
//  uniform float TURBULENCE      ; // 0.160
    uniform float  ADVECTION      ; // 0.300
//  uniform float  ADVECTION      ; // 0.300
    uniform float DEPTH           ; // 0.023
//  uniform float DEPTH           ; // 0.023
    uniform vec3  INPUT_LIGHT     ; // -0.50, 1.00, 0.25
//  uniform vec3  INPUT_LIGHT     ; // -0.50, 1.00, 0.25
    uniform vec3  INPUT_COLOR_SUN ; //  1.10, 1.00, 1.00
//  uniform vec3  INPUT_COLOR_SUN ; //  1.10, 1.00, 1.00
    uniform vec2  INPUT_COLOR_SKY ; //  0.10, 0.14, 0.20
//  uniform vec2  INPUT_COLOR_SKY ; //  0.10, 0.14, 0.20
    vec3  LIGHT = normalize(INPUT_LIGHT);
//  vec3  LIGHT = normalize(INPUT_LIGHT);
    vec3  COLOR_SUN = INPUT_COLOR_SUN * 9.0;
//  vec3  COLOR_SUN = INPUT_COLOR_SUN * 9.0;
    vec3  COLOR_SKY = INPUT_COLOR_SKY * 0.9;
//  vec3  COLOR_SKY = INPUT_COLOR_SKY * 0.9;

    //  #define DEBUG_NORMAL
//  //  #define DEBUG_NORMAL
    //  #define DEBUG_LIGHT@
//  //  #define DEBUG_LIGHT@

    #define PHI 1.61803399
//  #define PHI 1.61803399
    #define TAU 6.28318531
//  #define TAU 6.28318531
    #define ASPECT (canvasSize.x / canvasSize.y)
//  #define ASPECT (canvasSize.x / canvasSize.y)

    // Helper functions
//  // Helper functions
    float   lum(vec3  rgb) { return dot(rgb, vec3(0.299, 0.587, 0.114)); }
//  float   lum(vec3  rgb) { return dot(rgb, vec3(0.299, 0.587, 0.114)); }
    float nmapu(float   x) { return x * 0.5 + 0.5; }
//  float nmapu(float   x) { return x * 0.5 + 0.5; }
    vec2  nmapu(vec2    x) { return x * 0.5 + 0.5; }
//  vec2  nmapu(vec2    x) { return x * 0.5 + 0.5; }
    float nmaps(float   x) { return x * 2.0 - 1.0; }
//  float nmaps(float   x) { return x * 2.0 - 1.0; }
    vec2  nmaps(vec2    x) { return x * 2.0 - 1.0; }
//  vec2  nmaps(vec2    x) { return x * 2.0 - 1.0; }
    float   tri(float   x) { return abs(nmaps(fract(x))); }
//  float   tri(float   x) { return abs(nmaps(fract(x))); }
    vec2    tri(vec2    x) { return abs(nmaps(fract(x))); }
//  vec2    tri(vec2    x) { return abs(nmaps(fract(x))); }
    vec2  gnse2(vec2    p) { return fract(tan(p * vec2(PHI, PHI * PHI) * 512.0) * 512.0 * PHI); }
//  vec2  gnse2(vec2    p) { return fract(tan(p * vec2(PHI, PHI * PHI) * 512.0) * 512.0 * PHI); }

    float wave(float x) {
//  float wave(float x) {
    float x0  =  x;
//  float x0  =  x;
    x  = nmapu(sin( x  * 45.0 - time * 024.0));
//  x  = nmapu(sin( x  * 45.0 - time * 024.0));
    x  =       pow( x  , 24.0                ); // sharpen
//  x  =       pow( x  , 24.0                ); // sharpen
    x /=            x0 * 32.0        + 0.125  ; // falloff
//  x /=            x0 * 32.0        + 0.125  ; // falloff
    x *=       exp(-x0 * 02.0                ); // damping
//  x *=       exp(-x0 * 02.0                ); // damping
    return       x;
//  return       x;
    }
//  }

    float depthf(vec2 p) {
//  float depthf(vec2 p) {
    float bottom   = lum(texture(tex0  , p             ).rgb)             ; // luminance@ approximates depth
//  float bottom   = lum(texture(tex0  , p             ).rgb)             ; // luminance@ approximates depth
    vec2    flow   =             vec2 ( 0.0, time * SPEED   )             ;
//  vec2    flow   =             vec2 ( 0.0, time * SPEED   )             ;
    p +=    flow                                                          ;
//  p +=    flow                                                          ;
    p +=  bottom   *    ADVECTION                                         ; // divergence @@@@@@@@@@@@ @@@@@
//  p +=  bottom   *    ADVECTION                                         ; // divergence @@@@@@@@@@@@ @@@@@
    float  surface = lum(texture(noise0, p * TURBULENCE).rgb) * TURBULENCE;
//  float  surface = lum(texture(noise0, p * TURBULENCE).rgb) * TURBULENCE;
    return surface * DEPTH;
//  return surface * DEPTH;
    }
//  }

    void main() {
    vec2 uv  = vTexCoord;
//  vec2 uv  = vTexCoord;
    vec2 uv0 = uv                             ;
//  vec2 uv0 = uv                             ;

    float  d  = 00.0100000;
//  float  d  = 00.0100000;
    float  d0 = depthf(uv);
//  float  d0 = depthf(uv);
    vec2 grad = (vec2(
//  vec2 grad = (vec2(
    depthf(uv + vec2( d , 0.0)),
//  depthf(uv + vec2( d , 0.0)),
    depthf(uv + vec2(0.0,  d ))
//  depthf(uv + vec2(0.0,  d ))
    )  -  d0) / d;
//  )  -  d0) / d;
    vec3 N = normalize(vec3(grad.x, grad.y, 1.0));
//  vec3 N = normalize(vec3(grad.x, grad.y, 1.0));

    // Environment
//  // Environment
    float L   = max(0.0, reflect(LIGHT,  N).z);
//  float L   = max(0.0, reflect(LIGHT,  N).z);
    float sun = min(1.0, pow(L * 1.50 , 3.25));
//  float sun = min(1.0, pow(L * 1.50 , 3.25));
    float sky = min(1.0, pow(L + 0.39 , 1.10));
//  float sky = min(1.0, pow(L + 0.39 , 1.10));
    vec3  specular = COLOR_SUN * sun
//  vec3  specular = COLOR_SUN * sun
    + COLOR_SKY * sky          ;
//  + COLOR_SKY * sky          ;

    uv += refract(vec3(0.0, 0.0, 1.0), N, 1.4).xy * DEPTH;
//  uv += refract(vec3(0.0, 0.0, 1.0), N, 1.4).xy * DEPTH;

    vec3 col  = pow(texture(tex0, uv).rgb, vec3(1.0 / 2.2));
//  vec3 col  = pow(texture(tex0, uv).rgb, vec3(1.0 / 2.2));
    col -=                                             col      * COLOR_SKY; // ambience inversion
//  col -=                                             col      * COLOR_SKY; // ambience inversion
    col +=                                             specular * 4.45     ; // -------- ---------
//  col +=                                             specular * 4.45     ; // -------- ---------
    col  =                                                                  pow(col  - 0.27, vec3(2.35));
//  col  =                                                                  pow(col  - 0.27, vec3(2.35));

    #ifdef DEBUG_LIGHT
//  #ifdef DEBUG_LIGHT
    col =             specular;
//  col =             specular;
    #endif
//  #endif
    #ifdef DEBUG_NORMAL
//  #ifdef DEBUG_NORMAL
    col = N * 0.5 + 0.5       ;
//  col = N * 0.5 + 0.5       ;
    #endif
//  #endif

    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }


    // https://www.shadertoy.com/view/Mt3Bz7
//  // https://www.shadertoy.com/view/Mt3Bz7





