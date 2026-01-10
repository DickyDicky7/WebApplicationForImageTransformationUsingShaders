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


#define S(a, b, t) smoothstep(a, b, t)
// #define S(a, b, t) smoothstep(a, b, t)
    //#define CHEAP_NORMALS
//  //#define CHEAP_NORMALS
#define HAS_HEART
// #define HAS_HEART
#define USE_POST_PROCESSING
// #define USE_POST_PROCESSING

    vec3 N13(float p) {
//  vec3 N13(float p) {
    //  from DAVE HOSKINS
//  //  from DAVE HOSKINS
    //  from DAVE HOSKINS
//  //  from DAVE HOSKINS
    vec3 p3  = fract(vec3(p) * vec3(.10310f
//  vec3 p3  = fract(vec3(p) * vec3(.10310f
    , .11369f
//  , .11369f
    , .13787f));
//  , .13787f));
    p3 += dot  (      p3   , p3.yzx + 19.19f);
//  p3 += dot  (      p3   , p3.yzx + 19.19f);
    return     fract(vec3((p3.x + p3.y ) * p3.z
//  return     fract(vec3((p3.x + p3.y ) * p3.z
    , (p3.x + p3.z ) * p3.y
//  , (p3.x + p3.z ) * p3.y
    , (p3.y + p3.z ) * p3.x) );
//  , (p3.y + p3.z ) * p3.x) );
    }
//  }

    vec4 N14(float t) {
//  vec4 N14(float t) {
    return fract(sin(t * vec4(0123.f, 1024.f, 1456.f, 0264.f))
//  return fract(sin(t * vec4(0123.f, 1024.f, 1456.f, 0264.f))
    * vec4(6547.f, 0345.f, 8799.f, 1564.f));
//  * vec4(6547.f, 0345.f, 8799.f, 1564.f));
    }
//  }
    float N(float t) {
//  float N(float t) {
    return fract(sin(t * 12345.564f)
//  return fract(sin(t * 12345.564f)
    * 07658.760f);
//  * 07658.760f);
    }
//  }

    float Saw(float b, float t) {
//  float Saw(float b, float t) {
    return S(0.f, b, t)
//  return S(0.f, b, t)
    * S(1.f, b, t);
//  * S(1.f, b, t);
    }
//  }

    vec2 DropLayer2(vec2 uv, float t) {
//  vec2 DropLayer2(vec2 uv, float t) {
    vec2 UV = uv;
//  vec2 UV = uv;

    uv.y     += t * 0.75f       ;
//  uv.y     += t * 0.75f       ;
    vec2 a    = vec2(6.f, 1.f)  ;
//  vec2 a    = vec2(6.f, 1.f)  ;
    vec2 grid = a * 2.00f       ;
//  vec2 grid = a * 2.00f       ;
    vec2 id   = floor(uv * grid);
//  vec2 id   = floor(uv * grid);

    float   colShift = N(id.x);
//  float   colShift = N(id.x);
    uv.y += colShift          ;
//  uv.y += colShift          ;

    id      = floor(uv * grid)                  ;
//  id      = floor(uv * grid)                  ;
    vec3 n  = N13(id.x * 35.2f + id.y * 2376.1f);
//  vec3 n  = N13(id.x * 35.2f + id.y * 2376.1f);
    vec2 st = fract(uv * grid) - vec2(.5f, 0)   ;
//  vec2 st = fract(uv * grid) - vec2(.5f, 0)   ;

    float x = n.x - .5f;
//  float x = n.x - .5f;

    float y = UV.y * 20.f                         ;
//  float y = UV.y * 20.f                         ;
    float wiggle = sin(y   + sin(y))              ;
//  float wiggle = sin(y   + sin(y))              ;
    x +=  wiggle *    (.5f - abs(x)) * (n.z - .5f);
//  x +=  wiggle *    (.5f - abs(x)) * (n.z - .5f);
    x *= .7f                                      ;
//  x *= .7f                                      ;
    float ti = fract(t + n.z)                     ;
//  float ti = fract(t + n.z)                     ;
    y        = (Saw(.85f , ti) - .5f)*   .9f+ .5f ;
//  y        = (Saw(.85f , ti) - .5f)*   .9f+ .5f ;
    vec2 p   = vec2( x   , y )                    ;
//  vec2 p   = vec2( x   , y )                    ;

    float d = length((st - p) * a.yx);
//  float d = length((st - p) * a.yx);

    float mainDrop = S(.4f, .0f, d);
//  float mainDrop = S(.4f, .0f, d);

    float r          = sqrt(S(1.f , y, st.y));
//  float r          = sqrt(S(1.f , y, st.y));
    float cd         = abs ( st.x - x       );
//  float cd         = abs ( st.x - x       );
    float trail      = S( .23f * r, .15f * r * r, cd      );
//  float trail      = S( .23f * r, .15f * r * r, cd      );
    float trailFront = S(-.02f    , .02f        , st.y - y);
//  float trailFront = S(-.02f    , .02f        , st.y - y);
    trail *= trailFront * r * r;
//  trail *= trailFront * r * r;

    y              = UV.y;
//  y              = UV.y;
    float trail2   = S(.2f * r, 0.0f, cd);
//  float trail2   = S(.2f * r, 0.0f, cd);
    float droplets =   max(0.f, (sin(y * ( 1.f - y  ) * 120.f) - st.y)) * trail2 * trailFront * n.z;
//  float droplets =   max(0.f, (sin(y * ( 1.f - y  ) * 120.f) - st.y)) * trail2 * trailFront * n.z;
    y              = fract(y * 10.0f)  + (st.y - .5f)                                              ;
//  y              = fract(y * 10.0f)  + (st.y - .5f)                                              ;
    float dd       = length(st - vec2(x, y));
//  float dd       = length(st - vec2(x, y));
    droplets       = S(.3f    , 0.0f, dd)   ;
//  droplets       = S(.3f    , 0.0f, dd)   ;
    float m        = mainDrop + droplets * r * trailFront;
//  float m        = mainDrop + droplets * r * trailFront;

    //m += st.x > a.y * .45 || st.y > a.x * .165 ? 1.2 : 0.;
//  //m += st.x > a.y * .45 || st.y > a.x * .165 ? 1.2 : 0.;
    return vec2(m, trail);
//  return vec2(m, trail);
    }
//  }

    float StaticDrops(vec2 uv, float t) {
//  float StaticDrops(vec2 uv, float t) {
    uv *= 40.f;
//  uv *= 40.f;

    vec2 id = floor(uv)      ;
//  vec2 id = floor(uv)      ;
    uv      = fract(uv) - .5f;
//  uv      = fract(uv) - .5f;
    vec3  n = N13(id.x  * 107.45f + id.y * 3543.654f);
//  vec3  n = N13(id.x  * 107.45f + id.y * 3543.654f);
    vec2  p =    (n .xy - .5f)    *   .7f            ;
//  vec2  p =    (n .xy - .5f)    *   .7f            ;
    float d = length(uv - p  )                       ;
//  float d = length(uv - p  )                       ;

    float  fade = Saw(.025f,           fract(t   +  n.z)       );
//  float  fade = Saw(.025f,           fract(t   +  n.z)       );
    float  c    = S  (.3f  , 0.f, d) * fract(n.z * 10.f) * fade ;
//  float  c    = S  (.3f  , 0.f, d) * fract(n.z * 10.f) * fade ;
    return c;
//  return c;
    }
//  }

    vec2 Drops(vec2 uv, float t, float l0, float l1, float l2) {
//  vec2 Drops(vec2 uv, float t, float l0, float l1, float l2) {
    float s = StaticDrops(uv        , t) * l0;
//  float s = StaticDrops(uv        , t) * l0;
    vec2 m1 = DropLayer2 (uv        , t) * l1;
//  vec2 m1 = DropLayer2 (uv        , t) * l1;
    vec2 m2 = DropLayer2 (uv * 1.85f, t) * l2;
//  vec2 m2 = DropLayer2 (uv * 1.85f, t) * l2;

    float c = s + m1.x + m2.x;
//  float c = s + m1.x + m2.x;
    c = S(.3f, 1.f, c) ;
//  c = S(.3f, 1.f, c) ;

    return vec2(c, max(m1.y * l0, m2.y * l1));
//  return vec2(c, max(m1.y * l0, m2.y * l1));
    }
//  }

    void main() {
    vec2 uv   = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - .5f * canvasSize.xy) / canvasSize.y;
//  vec2 uv   = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - .5f * canvasSize.xy) / canvasSize.y;
    uv.y = 1.0f - uv.y;
//  uv.y = 1.0f - uv.y;
    vec2 UV   =  vTexCoord                ;
//  vec2 UV   =  vTexCoord                ;
    // UV.y = 1.0 - UV.y;
//  // UV.y = 1.0 - UV.y;
    vec3  M   = mousePosition.xyz / vec3(canvasSize.x, canvasSize.y, 1.0f);
//  vec3  M   = mousePosition.xyz / vec3(canvasSize.x, canvasSize.y, 1.0f);
    float T   =                                    time + M.x * 2.f       ;
//  float T   =                                    time + M.x * 2.f       ;

    #ifdef HAS_HEART
//  #ifdef HAS_HEART
    T = mod(time,       102.f                       );
//  T = mod(time,       102.f                       );
    T = mix(T   , M.x * 102.f, M.z > 0.f ? 1.f : 0.f);
//  T = mix(T   , M.x * 102.f, M.z > 0.f ? 1.f : 0.f);
    #endif
//  #endif

    float t = T * 0.2f;
//  float t = T * 0.2f;

    float rainAmount = mousePosition.z > 0.f ? M.y : sin(T * .05f) * .3f + .7f;
//  float rainAmount = mousePosition.z > 0.f ? M.y : sin(T * .05f) * .3f + .7f;

    float maxBlur = mix(3.f, 6.f, rainAmount);
//  float maxBlur = mix(3.f, 6.f, rainAmount);
    float minBlur = 2.f                      ;
//  float minBlur = 2.f                      ;

    float story = 0.f;
//  float story = 0.f;
    float heart = 0.f;
//  float heart = 0.f;

    #ifdef HAS_HEART
//  #ifdef HAS_HEART
    story = S(0.f, 70.f, T);
//  story = S(0.f, 70.f, T);

    t = min(1.f , T      / 70.f); // remap drop time so it goes slower when it freezes
//  t = min(1.f , T      / 70.f); // remap drop time so it goes slower when it freezes
    t =     1.f - t             ; // -------------------------------------------------
//  t =     1.f - t             ; // -------------------------------------------------
    t =    (1.f - t * t) * 70.f ; // -------------------------------------------------
//  t =    (1.f - t * t) * 70.f ; // -------------------------------------------------

    float zoom =  mix(.3f, 1.2f, story); // slowly zoom out
//  float zoom =  mix(.3f, 1.2f, story); // slowly zoom out
    uv *= zoom                         ; // ---------------
//  uv *= zoom                         ; // ---------------
    minBlur = 4.f + S(.5f, 1.0f, story) * 3.0f; // more opaque glass towards the end
//  minBlur = 4.f + S(.5f, 1.0f, story) * 3.0f; // more opaque glass towards the end
    maxBlur = 6.f + S(.5f, 1.0f, story) * 1.5f; // ---------------------------------
//  maxBlur = 6.f + S(.5f, 1.0f, story) * 1.5f; // ---------------------------------

    vec2 hv     = uv - vec2(.0f, -.1f);	    // build heart
//  vec2 hv     = uv - vec2(.0f, -.1f);	    // build heart
    hv.x       *=                      .5f; // -----------
//  hv.x       *=                      .5f; // -----------
    float s     =                          S(110.f, 70.f, T);                           // heart gets smaller and fades towards the end
//  float s     =                          S(110.f, 70.f, T);                           // heart gets smaller and fades towards the end
    hv.y       -=                                            sqrt(abs(hv.x)) * .5f * s; // --------------------------------------------
//  hv.y       -=                                            sqrt(abs(hv.x)) * .5f * s; // --------------------------------------------
    heart       =                                                                      length(hv);
//  heart       =                                                                      length(hv);
    heart       =                                                                                 S(.4f * s, .2f * s, heart) * s; // ------------------------------
//  heart       =                                                                                 S(.4f * s, .2f * s, heart) * s; // ------------------------------
    rainAmount  =                                                                                                     heart     ; // the rain is where the heart is
//  rainAmount  =                                                                                                     heart     ; // the rain is where the heart is

    maxBlur    -= heart; // inside the heart slighly less foggy
//  maxBlur    -= heart; // inside the heart slighly less foggy
    uv         *= 1.50f; // -zoom- out a bit ------- more -----
//  uv         *= 1.50f; // -zoom- out a bit ------- more -----
    t          *= 0.25f;
//  t          *= 0.25f;
    #else
//  #else
    float zoom  = -cos(T * .2f);
//  float zoom  = -cos(T * .2f);
    uv         *=               .7f + zoom * .3f       ;
//  uv         *=               .7f + zoom * .3f       ;
    #endif
//  #endif
    UV          = (UV - .5f) * (.9f + zoom * .1f) + .5f;
//  UV          = (UV - .5f) * (.9f + zoom * .1f) + .5f;

    float staticDrops = S(-.50f, 1.00f, rainAmount) * 2.f;
//  float staticDrops = S(-.50f, 1.00f, rainAmount) * 2.f;
    float layer1      = S( .25f, 0.75f, rainAmount)      ;
//  float layer1      = S( .25f, 0.75f, rainAmount)      ;
    float layer2      = S( .00f, 0.50f, rainAmount)      ;
//  float layer2      = S( .00f, 0.50f, rainAmount)      ;

    vec2 c   = Drops(uv       , t, staticDrops, layer1, layer2)  ;
//  vec2 c   = Drops(uv       , t, staticDrops, layer1, layer2)  ;
   #ifdef CHEAP_NORMALS
// #ifdef CHEAP_NORMALS
    vec2 n   = vec2(dFdx(c.x)   // ---------------------------------------------------
//  vec2 n   = vec2(dFdx(c.x)   // ---------------------------------------------------
    ,      dFdy(c.x)); // cheap normals (3x cheaper, but 2 times shittier ;))
//  ,      dFdy(c.x)); // cheap normals (3x cheaper, but 2 times shittier ;))
    #else
//  #else
    vec2 e   = vec2(0.001f, 0.000f);
//  vec2 e   = vec2(0.001f, 0.000f);
    float cx = Drops(uv + e   , t, staticDrops, layer1, layer2).x;
//  float cx = Drops(uv + e   , t, staticDrops, layer1, layer2).x;
    float cy = Drops(uv + e.yx, t, staticDrops, layer1, layer2).x;
//  float cy = Drops(uv + e.yx, t, staticDrops, layer1, layer2).x;
    vec2 n   = vec2(cx - c.x   // -----------------
//  vec2 n   = vec2(cx - c.x   // -----------------
    ,      cy - c.x); // expensive normals
//  ,      cy - c.x); // expensive normals
    #endif
//  #endif

    #ifdef HAS_HEART
//  #ifdef HAS_HEART
    n   *= 1.f - S(60.f,  85.f, T)      ;
//  n   *= 1.f - S(60.f,  85.f, T)      ;
    c.y *= 1.f - S(80.f, 100.f, T) * .8f;
//  c.y *= 1.f - S(80.f, 100.f, T) * .8f;
    #endif
//  #endif

    float focus =        mix(maxBlur - c.y, minBlur, S(.1f, .2f, c.x))    ;
//  float focus =        mix(maxBlur - c.y, minBlur, S(.1f, .2f, c.x))    ;
    vec3  col   = textureLod(   tex0      , UV +  n, focus           ).rgb;
//  vec3  col   = textureLod(   tex0      , UV +  n, focus           ).rgb;

    #ifdef USE_POST_PROCESSING
//  #ifdef USE_POST_PROCESSING
    t                =    (T + 3.f) * .5f              ; // make time sync with first lightnoing
//  t                =    (T + 3.f) * .5f              ; // make time sync with first lightnoing
    float colFade    = sin(t * .2f) * .5f + .5f + story; // @@@@ @@@@ @@@@ @@@@ @@@@@ @@@@@@@@@@
//  float colFade    = sin(t * .2f) * .5f + .5f + story; // @@@@ @@@@ @@@@ @@@@ @@@@@ @@@@@@@@@@
    col             *= mix(vec3(1.f), vec3( .8f,   .9f, 1.3f), colFade); // subtle color @@@ shift
//  col             *= mix(vec3(1.f), vec3( .8f,   .9f, 1.3f), colFade); // subtle color @@@ shift
    float fade       =                   S(0.0f, 10.0f, T             ); // @fade@ in at the start
//  float fade       =                   S(0.0f, 10.0f, T             ); // @fade@ in at the start
    float lightning  =              sin(t * sin(t   * 10.f)); // lighting@ flicker
//  float lightning  =              sin(t * sin(t   * 10.f)); // lighting@ flicker
    lightning *= pow(max(0.f, sin(t + sin(t))), 10.f ); // lightning flash@@
//  lightning *= pow(max(0.f, sin(t + sin(t))), 10.f ); // lightning flash@@
    col             *= 1.f + lightning * fade * mix(1.f, .1f, story * story); // composite lightning
//  col             *= 1.f + lightning * fade * mix(1.f, .1f, story * story); // composite lightning
    col             *= 1.f -                              dot(UV -= .5f, UV); // @vignette @@@@@@@@@
//  col             *= 1.f -                              dot(UV -= .5f, UV); // @vignette @@@@@@@@@

    #ifdef HAS_HEART
//  #ifdef HAS_HEART
    col   = mix(pow(col  , vec3(1.2f)), col, heart);
//  col   = mix(pow(col  , vec3(1.2f)), col, heart);
    fade *=       S(102.f,     97.0f  , T         );
//  fade *=       S(102.f,     97.0f  , T         );
    #endif
//  #endif

    col  *= fade; // composite start and end fade
//  col  *= fade; // composite start and end fade
    #endif
//  #endif

    //col = vec3(heart);
//  //col = vec3(heart);
    fragColor = vec4(col, 1.f);
//  fragColor = vec4(col, 1.f);
    }

    // https://www.shadertoy.com/view/ltffzl
//  // https://www.shadertoy.com/view/ltffzl

    // Heartfelt - by Martijn Steinrucken aka BigWings - 2017
//  // Heartfelt - by Martijn Steinrucken aka BigWings - 2017
    // Heartfelt - by Martijn Steinrucken aka BigWings - 2017
//  // Heartfelt - by Martijn Steinrucken aka BigWings - 2017
    // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
//  // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
    // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
//  // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
    // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//  // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
    // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//  // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

    // I revisited the rain effect I did for another shader. This one is better in multiple ways:
//  // I revisited the rain effect I did for another shader. This one is better in multiple ways:
    // I revisited the rain effect I did for another shader. This one is better in multiple ways:
//  // I revisited the rain effect I did for another shader. This one is better in multiple ways:
    // 1. The glass gets foggy.
//  // 1. The glass gets foggy.
    // 1. The glass gets foggy.
//  // 1. The glass gets foggy.
    // 2. Drops cut trails in the fog on the glass.
//  // 2. Drops cut trails in the fog on the glass.
    // 2. Drops cut trails in the fog on the glass.
//  // 2. Drops cut trails in the fog on the glass.
    // 3. The amount of rain is adjustable (with Mouse.y)
//  // 3. The amount of rain is adjustable (with Mouse.y)
    // 3. The amount of rain is adjustable (with Mouse.y)
//  // 3. The amount of rain is adjustable (with Mouse.y)

    // To have full control over the rain, uncomment the HAS_HEART define
//  // To have full control over the rain, uncomment the HAS_HEART define
    // To have full control over the rain, uncomment the HAS_HEART define
//  // To have full control over the rain, uncomment the HAS_HEART define

    // A video of the effect can be found here:
//  // A video of the effect can be found here:
    // A video of the effect can be found here:
//  // A video of the effect can be found here:
    // https://www.youtube.com/watch?v=uiF5Tlw22PI&feature=youtu.be
//  // https://www.youtube.com/watch?v=uiF5Tlw22PI&feature=youtu.be
    // https://www.youtube.com/watch?v=uiF5Tlw22PI&feature=youtu.be
//  // https://www.youtube.com/watch?v=uiF5Tlw22PI&feature=youtu.be

    // Music - Alone In The Dark - Vadim Kiselev
//  // Music - Alone In The Dark - Vadim Kiselev
    // Music - Alone In The Dark - Vadim Kiselev
//  // Music - Alone In The Dark - Vadim Kiselev
    // https://soundcloud.com/ahmed-gado-1/sad-piano-alone-in-the-dark
//  // https://soundcloud.com/ahmed-gado-1/sad-piano-alone-in-the-dark
    // https://soundcloud.com/ahmed-gado-1/sad-piano-alone-in-the-dark
//  // https://soundcloud.com/ahmed-gado-1/sad-piano-alone-in-the-dark
    // Rain sounds:
//  // Rain sounds:
    // Rain sounds:
//  // Rain sounds:
    // https://soundcloud.com/elirtmusic/sleeping-sound-rain-and-thunder-1-hours
//  // https://soundcloud.com/elirtmusic/sleeping-sound-rain-and-thunder-1-hours
    // https://soundcloud.com/elirtmusic/sleeping-sound-rain-and-thunder-1-hours
//  // https://soundcloud.com/elirtmusic/sleeping-sound-rain-and-thunder-1-hours


