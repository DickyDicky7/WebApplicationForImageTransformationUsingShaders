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
    uniform         float        frameCount; // 0.0
//  uniform         float        frameCount; // 0.0

    // Enabling glitch effects
//  // Enabling glitch effects
    // Enabling glitch effects
//  // Enabling glitch effects
    #define ANALOG
//  #define ANALOG
    #define DIGITAL
//  #define DIGITAL
    #define     CRT
//  #define     CRT

    // Duration of glitch loop and activation percentage
//  // Duration of glitch loop and activation percentage
    // Duration of glitch loop and activation percentage
//  // Duration of glitch loop and activation percentage
    #define DURATION 5.0
//  #define DURATION 5.0
    #define AMT      0.5 
//  #define AMT      0.5 

    // Smoothstep function
//  // Smoothstep function
    // Smoothstep function
//  // Smoothstep function
    #define SS(a, b, x) (smoothstep(a, b, x) * smoothstep(b, a, x))
//  #define SS(a, b, x) (smoothstep(a, b, x) * smoothstep(b, a, x))

    // Hash by David_Hoskins - adapted for GLSL ES
//  // Hash by David_Hoskins - adapted for GLSL ES
    // Hash by David_Hoskins - adapted for GLSL ES
//  // Hash by David_Hoskins - adapted for GLSL ES
    vec3 hash33(vec3  p) {
//  vec3 hash33(vec3  p) {
    p  =   fract( p              * 00.1031 );
//  p  =   fract( p              * 00.1031 );
    p +=   dot  ( p     , p.yzx  + 19.1900 );
//  p +=   dot  ( p     , p.yzx  + 19.1900 );
    return fract((p.xxy + p.yzz) *  p.zyx  );
//  return fract((p.xxy + p.yzz) *  p.zyx  );
    }
//  }

    // Gradient noise function by iq
//  // Gradient noise function by iq
    // Gradient noise function by iq
//  // Gradient noise function by iq
    float gnoise(vec3 x) {
//  float gnoise(vec3 x) {
    vec3 p = floor(x);
//  vec3 p = floor(x);
    vec3 w = fract(x);
//  vec3 w = fract(x);

    vec3 u = w * w * w * (w * (w * 6.0 - 15.0) + 10.0);
//  vec3 u = w * w * w * (w * (w * 6.0 - 15.0) + 10.0);

    vec3 ga = hash33(p + vec3(0.0, 0.0, 0.0));
//  vec3 ga = hash33(p + vec3(0.0, 0.0, 0.0));
    vec3 gb = hash33(p + vec3(1.0, 0.0, 0.0));
//  vec3 gb = hash33(p + vec3(1.0, 0.0, 0.0));
    vec3 gc = hash33(p + vec3(0.0, 1.0, 0.0));
//  vec3 gc = hash33(p + vec3(0.0, 1.0, 0.0));
    vec3 gd = hash33(p + vec3(1.0, 1.0, 0.0));
//  vec3 gd = hash33(p + vec3(1.0, 1.0, 0.0));
    vec3 ge = hash33(p + vec3(0.0, 0.0, 1.0));
//  vec3 ge = hash33(p + vec3(0.0, 0.0, 1.0));
    vec3 gf = hash33(p + vec3(1.0, 0.0, 1.0));
//  vec3 gf = hash33(p + vec3(1.0, 0.0, 1.0));
    vec3 gg = hash33(p + vec3(0.0, 1.0, 1.0));
//  vec3 gg = hash33(p + vec3(0.0, 1.0, 1.0));
    vec3 gh = hash33(p + vec3(1.0, 1.0, 1.0));
//  vec3 gh = hash33(p + vec3(1.0, 1.0, 1.0));

    float va = dot(ga, w - vec3(0.0, 0.0, 0.0));
//  float va = dot(ga, w - vec3(0.0, 0.0, 0.0));
    float vb = dot(gb, w - vec3(1.0, 0.0, 0.0));
//  float vb = dot(gb, w - vec3(1.0, 0.0, 0.0));
    float vc = dot(gc, w - vec3(0.0, 1.0, 0.0));
//  float vc = dot(gc, w - vec3(0.0, 1.0, 0.0));
    float vd = dot(gd, w - vec3(1.0, 1.0, 0.0));
//  float vd = dot(gd, w - vec3(1.0, 1.0, 0.0));
    float ve = dot(ge, w - vec3(0.0, 0.0, 1.0));
//  float ve = dot(ge, w - vec3(0.0, 0.0, 1.0));
    float vf = dot(gf, w - vec3(1.0, 0.0, 1.0));
//  float vf = dot(gf, w - vec3(1.0, 0.0, 1.0));
    float vg = dot(gg, w - vec3(0.0, 1.0, 1.0));
//  float vg = dot(gg, w - vec3(0.0, 1.0, 1.0));
    float vh = dot(gh, w - vec3(1.0, 1.0, 1.0));
//  float vh = dot(gh, w - vec3(1.0, 1.0, 1.0));

    float gNoise = va + u.x * (vb - va) +
//  float gNoise = va + u.x * (vb - va) +
    u.y * (vc - va) +
//  u.y * (vc - va) +
    u.z * (ve - va) +
//  u.z * (ve - va) +
    u.x * u.y * (va - vb - vc + vd) +
//  u.x * u.y * (va - vb - vc + vd) +
    u.y * u.z * (va - vc - ve + vg) +
//  u.y * u.z * (va - vc - ve + vg) +
    u.z * u.x * (va - vb - ve + vf) +
//  u.z * u.x * (va - vb - ve + vf) +
    u.x * u.y * u.z * (-va + vb + vc - vd + ve - vf - vg + vh);
//  u.x * u.y * u.z * (-va + vb + vc - vd + ve - vf - vg + vh);

    return 2.0 * gNoise;
//  return 2.0 * gNoise;
    }
//  }

    // Gradient noise in range [0, 1]
//  // Gradient noise in range [0, 1]
    // Gradient noise in range [0, 1]
//  // Gradient noise in range [0, 1]
    float gnoise01(vec3 x) {
//  float gnoise01(vec3 x) {
    return 0.5 + 0.5 * gnoise(x);
//  return 0.5 + 0.5 * gnoise(x);
    }
//  }

    // CRT warping
//  // CRT warping
    // CRT warping
//  // CRT warping
    vec2 crt(vec2 uv) {
//  vec2 crt(vec2 uv) {
    float tht =   atan(uv.y, uv.x);
//  float tht =   atan(uv.y, uv.x);
    float   r = length(uv        );
//  float   r = length(uv        );
    r    /=    (1.0 - 0.1 * r * r);
//  r    /=    (1.0 - 0.1 * r * r);
    uv.x  = r  * cos(tht);
//  uv.x  = r  * cos(tht);
    uv.y  = r  * sin(tht);
//  uv.y  = r  * sin(tht);
    return 0.5 *      (uv  +  1.0);
//  return 0.5 *      (uv  +  1.0);
    }
//  }

    // Inputs
//  // Inputs
    // Inputs
//  // Inputs


    void main() {
    vec2  uv = vTexCoord;
//  vec2  uv = vTexCoord;
    float t  =    time                        ;
//  float t  =    time                        ;
    
    // Glitch trigger timing
//  // Glitch trigger timing
    // Glitch trigger timing
//  // Glitch trigger timing
    float glitchAmount = SS(DURATION * 0.001, DURATION * AMT, mod(t, DURATION));
//  float glitchAmount = SS(DURATION * 0.001, DURATION * AMT, mod(t, DURATION));
    float displayNoise =      0.0                     ;
//  float displayNoise =      0.0                     ;
    vec3           col = vec3(0.0                    );
//  vec3           col = vec3(0.0                    );
    vec2           eps = vec2(5.0 / canvasSize.x, 0.0);
//  vec2           eps = vec2(5.0 / canvasSize.x, 0.0);
    vec2           st  = vec2(0.0                    );
//  vec2           st  = vec2(0.0                    );

    #ifdef CRT
//  #ifdef CRT
    uv            = crt(uv * 2.0 - 1.0);
//  uv            = crt(uv * 2.0 - 1.0);
    displayNoise +=                1.0 ;
//  displayNoise +=                1.0 ;
    #endif
//  #endif

    // Analog distortion
//  // Analog distortion
    // Analog distortion
//  // Analog distortion
    float y = uv.y * canvasSize.y;
//  float y = uv.y * canvasSize.y;
    float distortion  = gnoise(vec3(0.0, y * 0.01, t * 500.0)) * (glitchAmount * 4.0 + 0.100);
//  float distortion  = gnoise(vec3(0.0, y * 0.01, t * 500.0)) * (glitchAmount * 4.0 + 0.100);
    distortion *= gnoise(vec3(0.0, y * 0.02, t * 250.0)) * (glitchAmount * 2.0 + 0.025);
//  distortion *= gnoise(vec3(0.0, y * 0.02, t * 250.0)) * (glitchAmount * 2.0 + 0.025);

    #ifdef ANALOG
//  #ifdef ANALOG
    displayNoise += 1.0;
//  displayNoise += 1.0;
    distortion += smoothstep(0.999, 1.0, sin((uv.y + t * 1.6) * 2.0)) * 0.02;
//  distortion += smoothstep(0.999, 1.0, sin((uv.y + t * 1.6) * 2.0)) * 0.02;
    distortion -= smoothstep(0.999, 1.0, sin((uv.y + t      ) * 2.0)) * 0.02;
//  distortion -= smoothstep(0.999, 1.0, sin((uv.y + t      ) * 2.0)) * 0.02;
    st = uv + vec2(distortion, 0.0);
//  st = uv + vec2(distortion, 0.0);
    col.r += texture(tex0, st + eps + distortion).r;
//  col.r += texture(tex0, st + eps + distortion).r;
    col.g += texture(tex0, st                   ).g;
//  col.g += texture(tex0, st                   ).g;
    col.b += texture(tex0, st - eps - distortion).b;
//  col.b += texture(tex0, st - eps - distortion).b;
    #else
//  #else
    col   += texture(tex0, uv).xyz;
//  col   += texture(tex0, uv).xyz;
    #endif
//  #endif

    #ifdef DIGITAL
//  #ifdef DIGITAL
    // Digital blocky distortion
//  // Digital blocky distortion
    // Digital blocky distortion
//  // Digital blocky distortion
    float bt = floor(t * 30.0) * 300.0;
//  float bt = floor(t * 30.0) * 300.0;
    float blockGlitch  = 00.2  + 000.9 * glitchAmount;
//  float blockGlitch  = 00.2  + 000.9 * glitchAmount;
    float blockNoiseX  = step(gnoise01(vec3(0.0, uv.x * 3.0, bt      )), blockGlitch);
//  float blockNoiseX  = step(gnoise01(vec3(0.0, uv.x * 3.0, bt      )), blockGlitch);
    float blockNoiseX2 = step(gnoise01(vec3(0.0, uv.x * 1.5, bt * 1.2)), blockGlitch);
//  float blockNoiseX2 = step(gnoise01(vec3(0.0, uv.x * 1.5, bt * 1.2)), blockGlitch);
    float blockNoiseY  = step(gnoise01(vec3(0.0, uv.y * 4.0, bt      )), blockGlitch);
//  float blockNoiseY  = step(gnoise01(vec3(0.0, uv.y * 4.0, bt      )), blockGlitch);
    float blockNoiseY2 = step(gnoise01(vec3(0.0, uv.y * 6.0, bt * 1.2)), blockGlitch);
//  float blockNoiseY2 = step(gnoise01(vec3(0.0, uv.y * 6.0, bt * 1.2)), blockGlitch);
    float block        =
//  float block        =
    blockNoiseX2 *
//  blockNoiseX2 *
    blockNoiseY2 +
//  blockNoiseY2 +
    blockNoiseX  *
//  blockNoiseX  *
    blockNoiseY  ;
//  blockNoiseY  ;
    st     = vec2(uv.x + sin(bt) * hash33(vec3(uv, 0.5)).x, uv.y);
//  st     = vec2(uv.x + sin(bt) * hash33(vec3(uv, 0.5)).x, uv.y);
    col *= 1.00 - block;
//  col *= 1.00 - block;
    block *= 1.15        ;
//  block *= 1.15        ;
    col.r += texture(tex0, st + eps).r * block;
//  col.r += texture(tex0, st + eps).r * block;
    col.g += texture(tex0, st      ).g * block;
//  col.g += texture(tex0, st      ).g * block;
    col.b += texture(tex0, st - eps).b * block;
//  col.b += texture(tex0, st - eps).b * block;
    #endif
//  #endif

    // White noise + scanlines
//  // White noise + scanlines
    // White noise + scanlines
//  // White noise + scanlines
    displayNoise = clamp(displayNoise, 0.0, 1.0);
//  displayNoise = clamp(displayNoise, 0.0, 1.0);
    col += (0.15 + 0.65 * glitchAmount) * (hash33(vec3(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy, mod(float(frameCount), 1000.0))).r) * displayNoise;
//  col += (0.15 + 0.65 * glitchAmount) * (hash33(vec3(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy, mod(float(frameCount), 1000.0))).r) * displayNoise;
    col -= (0.25 + 0.75 * glitchAmount) * (sin   (4.0    *   t + uv.y * canvasSize.y * 1.750)             ) * displayNoise;
//  col -= (0.25 + 0.75 * glitchAmount) * (sin   (4.0    *   t + uv.y * canvasSize.y * 1.750)             ) * displayNoise;

    #ifdef CRT
//  #ifdef CRT
    // CRT vignette effect
//  // CRT vignette effect
    // CRT vignette effect
//  // CRT vignette effect
    float vig  =  8.0 * uv.x * uv.y
//  float vig  =  8.0 * uv.x * uv.y
    * (1.0 - uv.x)
//  * (1.0 - uv.x)
    * (1.0 - uv.y);
//  * (1.0 - uv.y);
    col *= vec3(pow(vig, 0.25)) * 1.5;
//  col *= vec3(pow(vig, 0.25)) * 1.5;
    if (uv.x < 0.0
//  if (uv.x < 0.0
    ||  uv.x > 1.0)  col *= 0.0 ;
//  ||  uv.x > 1.0)  col *= 0.0 ;
    #endif
//  #endif

    fragColor = vec4(col ,  1.0);
//  fragColor = vec4(col ,  1.0);
    }

    // https://www.shadertoy.com/view/wld3WN
//  // https://www.shadertoy.com/view/wld3WN
