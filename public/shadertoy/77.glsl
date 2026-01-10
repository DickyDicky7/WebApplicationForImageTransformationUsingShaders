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

#define S(x, y      , z) smoothstep(x, y       , z)
// #define S(x, y      , z) smoothstep(x, y       , z)
#define B(a, b, edge, t) S(a - edge  , a + edge, t) * S(b + edge, b - edge, t)
// #define B(a, b, edge, t) S(a - edge  , a + edge, t) * S(b + edge, b - edge, t)
#define sat(x) clamp(x, 0.0f, 1.0f)
// #define sat(x) clamp(x, 0.0f, 1.0f)

#define streetLightCol vec3(1.0f, 0.7f, 0.3f)
// #define streetLightCol vec3(1.0f, 0.7f, 0.3f)
#define   headLightCol vec3(0.8f, 0.8f, 1.0f)
// #define   headLightCol vec3(0.8f, 0.8f, 1.0f)
#define   tailLightCol vec3(1.0f, 0.1f, 0.1f)
// #define   tailLightCol vec3(1.0f, 0.1f, 0.1f)

#define HIGH_QUALITY
// #define HIGH_QUALITY
#define  CAM_SHAKE   1.0f
// #define  CAM_SHAKE   1.0f
#define LANE_BIAS    0.5f
// #define LANE_BIAS    0.5f
#define      RAIN
// #define      RAIN
    //#define DROP_DEBUG
//  //#define DROP_DEBUG

    vec3 ro, rd;
//  vec3 ro, rd;

    float N(float t) {
//  float N(float t) {
    return fract(sin(t * 010234.32400f)
//  return fract(sin(t * 010234.32400f)
    * 123423.23512f);
//  * 123423.23512f);
    }
//  }
    vec3 N31(float p) {
//  vec3 N31(float p) {
    //  3 out, 1 in... DAVE HOSKINS
//  //  3 out, 1 in... DAVE HOSKINS
    //  3 out, 1 in... DAVE HOSKINS
//  //  3 out, 1 in... DAVE HOSKINS
    vec3 p3  = fract(vec3(p) * vec3(.10310f
//  vec3 p3  = fract(vec3(p) * vec3(.10310f
    , .11369f
//  , .11369f
    , .13787f));
//  , .13787f));
    p3 +=   dot(      p3   , p3.yzx + 19.19f);
//  p3 +=   dot(      p3   , p3.yzx + 19.19f);
    return     fract(vec3((p3.x + p3.y)  * p3.z
//  return     fract(vec3((p3.x + p3.y)  * p3.z
    , (p3.x + p3.z)  * p3.y
//  , (p3.x + p3.z)  * p3.y
    , (p3.y + p3.z)  * p3.x ));
//  , (p3.y + p3.z)  * p3.x ));
    }
//  }
    float N2(vec2 p) {
//  float N2(vec2 p) {
    // Dave Hoskins - https://www.shadertoy.com/view/4djSRW
//  // Dave Hoskins - https://www.shadertoy.com/view/4djSRW
    // Dave Hoskins - https://www.shadertoy.com/view/4djSRW
//  // Dave Hoskins - https://www.shadertoy.com/view/4djSRW
    vec3 p3  = fract(vec3(p.xyx) * vec3(443.897f
//  vec3 p3  = fract(vec3(p.xyx) * vec3(443.897f
    , 441.423f
//  , 441.423f
    , 437.195f));
//  , 437.195f));
    p3 +=   dot( p3   , p3.yzx + 19.19f);
//  p3 +=   dot( p3   , p3.yzx + 19.19f);
    return     fract((p3.x + p3.y ) * p3.z  );
//  return     fract((p3.x + p3.y ) * p3.z  );
    }
//  }

    float DistLine(vec3 ro, vec3 rd, vec3 p) {
//  float DistLine(vec3 ro, vec3 rd, vec3 p) {
    return  length(cross(p - ro, rd)) ;
//  return  length(cross(p - ro, rd)) ;
    }
//  }

    vec3 ClosestPoint(vec3 ro, vec3 rd, vec3 p) {
//  vec3 ClosestPoint(vec3 ro, vec3 rd, vec3 p) {
    // returns the closest point on ray r to point p
//  // returns the closest point on ray r to point p
    // returns the closest point on ray r to point p
//  // returns the closest point on ray r to point p
    return   ro + max(0.f, dot(p - ro, rd)) * rd;
//  return   ro + max(0.f, dot(p - ro, rd)) * rd;
    }
//  }

    float Remap(float a, float b, float c, float d, float t) {
//  float Remap(float a, float b, float c, float d, float t) {
    return ((t - a) / (b - a)) * (d - c) + c;
//  return ((t - a) / (b - a)) * (d - c) + c;
    }
//  }

    float BokehMask(vec3 ro, vec3 rd, vec3 p, float size, float blur) {
//  float BokehMask(vec3 ro, vec3 rd, vec3 p, float size, float blur) {
    float d = DistLine(ro  ,  rd                 , p);
//  float d = DistLine(ro  ,  rd                 , p);
    float m =        S(size,  size * (1.f - blur), d);
//  float m =        S(size,  size * (1.f - blur), d);

    #ifdef HIGH_QUALITY
//  #ifdef HIGH_QUALITY
    m *= mix(.7f, 1.f, S(.8f * size, size, d));
//  m *= mix(.7f, 1.f, S(.8f * size, size, d));
    #endif
//  #endif

    return m;
//  return m;
    }
//  }

    float      SawTooth(float t) {
//  float      SawTooth(float t) {
    return cos(t + cos(t)) + sin(2.f * t) * .20f
//  return cos(t + cos(t)) + sin(2.f * t) * .20f
    + sin(4.f * t) * .02f;
//  + sin(4.f * t) * .02f;
    }
//  }

    float DeltaSawTooth(float t) {
//  float DeltaSawTooth(float t) {
    return 0.4f * cos(2.f * t) +  0.08f
//  return 0.4f * cos(2.f * t) +  0.08f
    * cos(4.f * t) - (1.00f - sin(t        ))
//  * cos(4.f * t) - (1.00f - sin(t        ))
    * sin(t + cos(t));
//  * sin(t + cos(t));
    }
//  }

    vec2 GetDrops(vec2 uv, float seed, float m) {
//  vec2 GetDrops(vec2 uv, float seed, float m) {

    float t = time + m * 30.f;
//  float t = time + m * 30.f;
    vec2  o = vec2(0.f)      ;
//  vec2  o = vec2(0.f)      ;

    #ifndef DROP_DEBUG
//  #ifndef DROP_DEBUG
    uv.y += t * .05f;
//  uv.y += t * .05f;
    #endif
//  #endif

    uv      *= vec2(10.f, 2.5f) * 2.f               ;
//  uv      *= vec2(10.f, 2.5f) * 2.f               ;
    vec2 id  = floor(uv)                            ;
//  vec2 id  = floor(uv)                            ;
    vec3 n   = N31(id.x + (id.y + seed) * 546.3524f);
//  vec3 n   = N31(id.x + (id.y + seed) * 546.3524f);
    vec2 bd  = fract(uv)                            ;
//  vec2 bd  = fract(uv)                            ;

    vec2 uv2 = bd;
//  vec2 uv2 = bd;

    bd   -= 0.5f ;
//  bd   -= 0.5f ;

    bd.y *= 4.0f ;
//  bd.y *= 4.0f ;

    bd.x += (n.x - .5f) * .6f;
//  bd.x += (n.x - .5f) * .6f;

    t           += n.z * 6.28f;
//  t           += n.z * 6.28f;
    float slide  = SawTooth(t);
//  float slide  = SawTooth(t);

    float ts       = 1.5f                                                           ;
//  float ts       = 1.5f                                                           ;
    vec2  trailPos = vec2(bd.x * ts, (fract(bd.y * ts * 2.f - t * 2.f) - .5f) * .5f);
//  vec2  trailPos = vec2(bd.x * ts, (fract(bd.y * ts * 2.f - t * 2.f) - .5f) * .5f);

    bd.y += slide * 2.f;
//  bd.y += slide * 2.f;
    // make drops slide down
//  // make drops slide down
    // @@@@ @@@@@ @@@@@ @@@@
//  // @@@@ @@@@@ @@@@@ @@@@

    #ifdef HIGH_QUALITY
//  #ifdef HIGH_QUALITY
    float   dropShape  = bd.x
//  float   dropShape  = bd.x
    *  bd.x            ;
//  *  bd.x            ;
    dropShape *= DeltaSawTooth(t);
//  dropShape *= DeltaSawTooth(t);
    bd.y += dropShape                    ;
//  bd.y += dropShape                    ;
    // change shape of drop when it is falling
//  // change shape of drop when it is falling
    // @@@@@@ @@@@@ @@ @@@@ @@@@ @@ @@ @@@@@@@
//  // @@@@@@ @@@@@ @@ @@@@ @@@@ @@ @@ @@@@@@@
    #endif
//  #endif

    float  d = length(bd);
//  float  d = length(bd);
    // distance to main drop
//  // distance to main drop
    // @@@@@@@@ @@ @@@@ @@@@
//  // @@@@@@@@ @@ @@@@ @@@@

    float trailMask  = S(-.2f, .2f, bd.y); // mask out drops@@@ that are below the main
//  float trailMask  = S(-.2f, .2f, bd.y); // mask out drops@@@ that are below the main
    trailMask *=              bd.y ; // fade @@@ dropsize @@@@ @@@ @@@@@ @@@ @@@@
//  trailMask *=              bd.y ; // fade @@@ dropsize @@@@ @@@ @@@@@ @@@ @@@@
    float td = length(trailPos * max(.5f, trailMask));
//  float td = length(trailPos * max(.5f, trailMask));
    // distance to trail drops
//  // distance to trail drops
    // @@@@@@@@ @@ @@@@@ @@@@@
//  // @@@@@@@@ @@ @@@@@ @@@@@

    float mainDrop  = S(.2f, .10f,  d);
//  float mainDrop  = S(.2f, .10f,  d);
    float dropTrail = S(.1f, .02f, td);
//  float dropTrail = S(.1f, .02f, td);

    dropTrail *= trailMask;
//  dropTrail *= trailMask;
    o = mix(bd * mainDrop, trailPos, dropTrail)            ;
//  o = mix(bd * mainDrop, trailPos, dropTrail)            ;
    //  mix main drop and drop trail
//  //  mix main drop and drop trail
    //  @@@ @@@@ @@@@ @@@ @@@@ @@@@@
//  //  @@@ @@@@ @@@@ @@@ @@@@ @@@@@

    #ifdef DROP_DEBUG
//  #ifdef DROP_DEBUG
    if (uv2.x < .02f
//  if (uv2.x < .02f
    ||  uv2.y < .01f)
//  ||  uv2.y < .01f)
    o = vec2(1.f);
//  o = vec2(1.f);
    #endif
//  #endif

    return o;
//  return o;
    }
//  }

    void CameraSetup(vec2 uv, vec3 pos, vec3 lookat, float zoom, float m) {
//  void CameraSetup(vec2 uv, vec3 pos, vec3 lookat, float zoom, float m) {
    ro =                 pos              ;
//  ro =                 pos              ;
    vec3  f  = normalize(lookat - ro);
//  vec3  f  = normalize(lookat - ro);
    vec3  r  =     cross(vec3(0.f, 1.f, 0.f), f);
//  vec3  r  =     cross(vec3(0.f, 1.f, 0.f), f);
    vec3  u  =     cross(                 f , r);
//  vec3  u  =     cross(                 f , r);
    float t  = time                             ;
//  float t  = time                             ;

    vec2 offs   = vec2(0.f);
//  vec2 offs   = vec2(0.f);
    #ifdef RAIN
//  #ifdef RAIN
    vec2 dropUv = uv       ;
//  vec2 dropUv = uv       ;

    #ifdef HIGH_QUALITY
//  #ifdef HIGH_QUALITY
    float x = (sin(t * .1f) * .5f + .5f) * .5f;
//  float x = (sin(t * .1f) * .5f + .5f) * .5f;
    x  = -x * x;
//  x  = -x * x;
    float s = sin(x);
//  float s = sin(x);
    float c = cos(x);
//  float c = cos(x);

    mat2 rot = mat2(c, -s, s, c);
//  mat2 rot = mat2(c, -s, s, c);

    #ifndef DROP_DEBUG
//  #ifndef DROP_DEBUG
    dropUv    =           uv  * rot;
//  dropUv    =           uv  * rot;
    dropUv.x += -sin(t * .1f) * .5f;
//  dropUv.x += -sin(t * .1f) * .5f;
    #endif
//  #endif
    #endif
//  #endif

    offs  = GetDrops(dropUv       , 01.f, m);
//  offs  = GetDrops(dropUv       , 01.f, m);

    #ifndef DROP_DEBUG
//  #ifndef DROP_DEBUG
    offs += GetDrops(dropUv * 1.4f, 10.f, m);
//  offs += GetDrops(dropUv * 1.4f, 10.f, m);
    #ifdef HIGH_QUALITY
//  #ifdef HIGH_QUALITY
    offs += GetDrops(dropUv * 2.4f, 25.f, m);
//  offs += GetDrops(dropUv * 2.4f, 25.f, m);
    //  offs += GetDrops(dropUv * 3.4f, 11.f   );
//  //  offs += GetDrops(dropUv * 3.4f, 11.f   );
    //  offs += GetDrops(dropUv * 3.0f, 02.f   );
//  //  offs += GetDrops(dropUv * 3.0f, 02.f   );
    #endif
//  #endif

    float ripple  = sin(t + uv.y * 003.1415f * 30.f
//  float ripple  = sin(t + uv.y * 003.1415f * 30.f
    + uv.x * 124.0000f)
//  + uv.x * 124.0000f)
    * .5f
//  * .5f
    + .5f;
//  + .5f;
    ripple *= .005f;
//  ripple *= .005f;
    offs += vec2(
//  offs += vec2(
    ripple *
//  ripple *
    ripple ,
//  ripple ,
    ripple);
//  ripple);
    #endif
//  #endif
    #endif
//  #endif
    vec3     center =  ro + f * zoom;
//  vec3     center =  ro + f * zoom;
    vec3 i = center + (uv.x - offs.x) * r
//  vec3 i = center + (uv.x - offs.x) * r
    + (uv.y - offs.y) * u;
//  + (uv.y - offs.y) * u;

    rd = normalize(i - ro);
//  rd = normalize(i - ro);
    }
//  }

    vec3 HeadLights(float i, float t) {
//  vec3 HeadLights(float i, float t) {
    float z = fract(-t * 2.f + i);
//  float z = fract(-t * 2.f + i);
    vec3  p =                     vec3(-.3f, .1f, z * 40.f);
//  vec3  p =                     vec3(-.3f, .1f, z * 40.f);
    float d =                                               length(p - ro);
//  float d =                                               length(p - ro);

    float size = mix(.03f, .05f, S(.02f, .07f, z)) * d;
//  float size = mix(.03f, .05f, S(.02f, .07f, z)) * d;
    float m    = 0.0f;
//  float m    = 0.0f;
    float blur = 0.1f;
//  float blur = 0.1f;
    m += BokehMask(ro, rd, p - vec3(.08f, 0.f, 0.f), size, blur);
//  m += BokehMask(ro, rd, p - vec3(.08f, 0.f, 0.f), size, blur);
    m += BokehMask(ro, rd, p + vec3(.08f, 0.f, 0.f), size, blur);
//  m += BokehMask(ro, rd, p + vec3(.08f, 0.f, 0.f), size, blur);

    #ifdef HIGH_QUALITY
//  #ifdef HIGH_QUALITY
    m += BokehMask(ro, rd, p + vec3(.1f, 0.f, 0.f), size, blur);
//  m += BokehMask(ro, rd, p + vec3(.1f, 0.f, 0.f), size, blur);
    m += BokehMask(ro, rd, p - vec3(.1f, 0.f, 0.f), size, blur);
//  m += BokehMask(ro, rd, p - vec3(.1f, 0.f, 0.f), size, blur);
    #endif
//  #endif

    float distFade = max(.01f, pow(1.f - z, 9.f));
//  float distFade = max(.01f, pow(1.f - z, 9.f));

    blur     = 0.8f;
//  blur     = 0.8f;
    size    *= 2.5f;
//  size    *= 2.5f;
    float r  = 0.0f;
//  float r  = 0.0f;
    r += BokehMask(ro, rd, p + vec3(-.09f, -.2f, 0.f), size, blur);
//  r += BokehMask(ro, rd, p + vec3(-.09f, -.2f, 0.f), size, blur);
    r += BokehMask(ro, rd, p + vec3( .09f, -.2f, 0.f), size, blur);
//  r += BokehMask(ro, rd, p + vec3( .09f, -.2f, 0.f), size, blur);
    r *= distFade * distFade;
//  r *= distFade * distFade;

    return headLightCol * (m + r) * distFade;
//  return headLightCol * (m + r) * distFade;
    }
//  }

    vec3 TailLights(float i, float t) {
//  vec3 TailLights(float i, float t) {
    t = t * 1.5f + i;
//  t = t * 1.5f + i;

    float id = floor(t ) + i;
//  float id = floor(t ) + i;
    vec3  n  =   N31(id)    ;
//  vec3  n  =   N31(id)    ;

    float laneId = S(LANE_BIAS, LANE_BIAS + .01f, n.y);
//  float laneId = S(LANE_BIAS, LANE_BIAS + .01f, n.y);

    float ft = fract(t)      ;
//  float ft = fract(t)      ;

    float  z = 3.f - ft * 3.f; // distance ahead
//  float  z = 3.f - ft * 3.f; // distance ahead
    // @@@@@@@@ @@@@@
//  // @@@@@@@@ @@@@@

    laneId     *=   S(.2f, 1.5f, z     ); // get out of the way!
//  laneId     *=   S(.2f, 1.5f, z     ); // get out of the way!
    float lane  = mix(.6f, 0.3f, laneId); // @@@ @@@ @@ @@@ @@@@
//  float lane  = mix(.6f, 0.3f, laneId); // @@@ @@@ @@ @@@ @@@@
    vec3  p     =   vec3(lane, .1f, z);
//  vec3  p     =   vec3(lane, .1f, z);
    float d     = length(p   -  ro   );
//  float d     = length(p   -  ro   );

    float size = .05f * d;
//  float size = .05f * d;
    float blur = .10f    ;
//  float blur = .10f    ;
    float m    = BokehMask(ro, rd, p - vec3(.08f, 0.f, 0.f), size, blur) +
//  float m    = BokehMask(ro, rd, p - vec3(.08f, 0.f, 0.f), size, blur) +
    BokehMask(ro, rd, p + vec3(.08f, 0.f, 0.f), size, blur);
//  BokehMask(ro, rd, p + vec3(.08f, 0.f, 0.f), size, blur);

    #ifdef HIGH_QUALITY
//  #ifdef HIGH_QUALITY
    float bs     = n.z  *3.f;						       // start braking at random distance
//  float bs     = n.z  *3.f;						       // start braking at random distance
    float brake  = S(bs       , bs + .01f, z            ); // @@@@@ @@@@@@@ @@ @@@@@@ @@@@@@@@
//  float brake  = S(bs       , bs + .01f, z            ); // @@@@@ @@@@@@@ @@ @@@@@@ @@@@@@@@
    brake *= S(bs + .01f, bs       , z - .5f * n.y); //                                 n.y = random brake duration
//  brake *= S(bs + .01f, bs       , z - .5f * n.y); //                                 n.y = random brake duration

    m += (BokehMask(ro, rd, p + vec3(.1f, 0.f, 0.f), size, blur)  +
//  m += (BokehMask(ro, rd, p + vec3(.1f, 0.f, 0.f), size, blur)  +
    BokehMask(ro, rd, p - vec3(.1f, 0.f, 0.f), size, blur)) * brake;
//  BokehMask(ro, rd, p - vec3(.1f, 0.f, 0.f), size, blur)) * brake;
    #endif
//  #endif

    float refSize = size * 2.5f;
//  float refSize = size * 2.5f;
    m += BokehMask(ro, rd, p + vec3(-.09f, -.2f, 0.f), refSize, .8f);
//  m += BokehMask(ro, rd, p + vec3(-.09f, -.2f, 0.f), refSize, .8f);
    m += BokehMask(ro, rd, p + vec3( .09f, -.2f, 0.f), refSize, .8f);
//  m += BokehMask(ro, rd, p + vec3( .09f, -.2f, 0.f), refSize, .8f);
    vec3 col = tailLightCol * m * ft;
//  vec3 col = tailLightCol * m * ft;

    float b  = BokehMask(ro, rd, p + vec3(.12f,  0.0f, 0.f),    size, blur)      ;
//  float b  = BokehMask(ro, rd, p + vec3(.12f,  0.0f, 0.f),    size, blur)      ;
    b += BokehMask(ro, rd, p + vec3(.12f, -0.2f, 0.f), refSize, .8f ) * .2f;
//  b += BokehMask(ro, rd, p + vec3(.12f, -0.2f, 0.f), refSize, .8f ) * .2f;

    vec3   blinker  = vec3(1.0f, 0.7f, 0.2f);
//  vec3   blinker  = vec3(1.0f, 0.7f, 0.2f);
    blinker *=    S(1.5f, 1.4f, z   )
//  blinker *=    S(1.5f, 1.4f, z   )
    *     S(0.2f, 0.3f, z   );
//  *     S(0.2f, 0.3f, z   );
    blinker *= sat(sin(t * 200.f) * 100.f);
//  blinker *= sat(sin(t * 200.f) * 100.f);
    blinker *=                      laneId;
//  blinker *=                      laneId;
    col += blinker *                   b         ;
//  col += blinker *                   b         ;

    return col;
//  return col;
    }
//  }

    vec3 StreetLights(float i, float t) {
//  vec3 StreetLights(float i, float t) {
    float side      = sign(rd.x);
//  float side      = sign(rd.x);
    float offset    =            max(side, 0.f) * (1.f / 16.f);
//  float offset    =            max(side, 0.f) * (1.f / 16.f);
    float z         =                                          fract(i - t + offset);
//  float z         =                                          fract(i - t + offset);
    vec3  p         =                                                                vec3(2.f * side, 2.f, z * 60.f);
//  vec3  p         =                                                                vec3(2.f * side, 2.f, z * 60.f);
    float d         =                                                                                                length(p - ro);
//  float d         =                                                                                                length(p - ro);
    float blur      =                                                                                                               0.1f;
//  float blur      =                                                                                                               0.1f;
    vec3  rp        =                                                                                                                    ClosestPoint(ro, rd, p);
//  vec3  rp        =                                                                                                                    ClosestPoint(ro, rd, p);
    float distFade  =                                                                                                                                            Remap(1.f, .7f, .1f, 1.5f, 1.f - pow(1.f - z, 6.f));
//  float distFade  =                                                                                                                                            Remap(1.f, .7f, .1f, 1.5f, 1.f - pow(1.f - z, 6.f));
    distFade *=                                                                                                                                                                                (1.f - z      );
//  distFade *=                                                                                                                                                                                (1.f - z      );
    float  m        =                                                                                                                                                                                                BokehMask(ro, rd, p, .05f * d, blur) * distFade;
//  float  m        =                                                                                                                                                                                                BokehMask(ro, rd, p, .05f * d, blur) * distFade;

    return m * streetLightCol;
//  return m * streetLightCol;
    }
//  }

    vec3 EnvironmentLights(float i, float t) {
//  vec3 EnvironmentLights(float i, float t) {
    float n = N(i + floor(t));
//  float n = N(i + floor(t));

    float   side   =                                                             sign(rd.x);
//  float   side   =                                                             sign(rd.x);
    float offset   =                                          max(side, 0.f) * (1.f / 16.f);
//  float offset   =                                          max(side, 0.f) * (1.f / 16.f);
    float z        = fract(i - t + offset + fract(n * 234.f));
//  float z        = fract(i - t + offset + fract(n * 234.f));
    float n2       =                        fract(n * 100.f) ;
//  float n2       =                        fract(n * 100.f) ;
    vec3  p        = vec3((3.f + n) * side, n2 * n2 * n2 * 1.f, z * 60.f);
//  vec3  p        = vec3((3.f + n) * side, n2 * n2 * n2 * 1.f, z * 60.f);
    float d        =                                                      length(p - ro);
//  float d        =                                                      length(p - ro);
    float blur     = .1f;
//  float blur     = .1f;
    vec3  rp       =                                                                     ClosestPoint(ro , rd , p);
//  vec3  rp       =                                                                     ClosestPoint(ro , rd , p);
    float distFade =                                                                            Remap(1.f, .7f, .1f, 1.5f, 1.f - pow(1.f - z, 6.f));
//  float distFade =                                                                            Remap(1.f, .7f, .1f, 1.5f, 1.f - pow(1.f - z, 6.f));
    float m        = BokehMask(ro, rd, p, .05f * d, blur);
//  float m        = BokehMask(ro, rd, p, .05f * d, blur);
    m *= distFade
//  m *= distFade
    *  distFade
//  *  distFade
    *  0.5f;
//  *  0.5f;

    m *= 1.0f - pow(sin(z * 6.28f * 20.f * n) * .5f + .5f, 20.f);
//  m *= 1.0f - pow(sin(z * 6.28f * 20.f * n) * .5f + .5f, 20.f);
    vec3 randomCol = vec3(fract(n * -0034.50f)
//  vec3 randomCol = vec3(fract(n * -0034.50f)
    , fract(n *  4572.00f)
//  , fract(n *  4572.00f)
    , fract(n *  1264.00f));
//  , fract(n *  1264.00f));
    vec3 col = mix(  tailLightCol
//  vec3 col = mix(  tailLightCol
    , streetLightCol
//  , streetLightCol
    ,        fract(n * -0065.42f));
//  ,        fract(n * -0065.42f));
    col = mix(col, randomCol, n);
//  col = mix(col, randomCol, n);
    return m *
//  return m *
    col *
//  col *
    0.2f;
//  0.2f;
    }
//  }

    void main() {
    float t   = time;
//  float t   = time;
    vec3  col = vec3(0.f);
//  vec3  col = vec3(0.f);
    vec2   uv = vTexCoord; // 0 <> 1
//  vec2   uv = vTexCoord; // 0 <> 1

    uv.y  = 1.0f - uv.y;
//  uv.y  = 1.0f - uv.y;

    uv   -= 0.5f       ;
//  uv   -= 0.5f       ;
    uv.x *=    canvasSize.x  / canvasSize.y ;
//  uv.x *=    canvasSize.x  / canvasSize.y ;

    vec2 mouse  = mousePosition.xy / canvasSize.xy;
//  vec2 mouse  = mousePosition.xy / canvasSize.xy;

    vec3 pos = vec3(0.30f, 0.15f, 0.00f);
//  vec3 pos = vec3(0.30f, 0.15f, 0.00f);

    float bt = t * 5.f;
//  float bt = t * 5.f;
    float h1 = N(floor(bt      ));
//  float h1 = N(floor(bt      ));
    float h2 = N(floor(bt + 1.f));
//  float h2 = N(floor(bt + 1.f));
    float bumps = mix(h1, h2, fract(bt)) * .1f;
//  float bumps = mix(h1, h2, fract(bt)) * .1f;
    bumps = bumps
//  bumps = bumps
    * bumps
//  * bumps
    * bumps
//  * bumps
    * CAM_SHAKE;
//  * CAM_SHAKE;

    pos.y += bumps;
//  pos.y += bumps;
    float lookatY = pos.y +  bumps;
//  float lookatY = pos.y +  bumps;
    vec3  lookat  = vec3(0.3f , lookatY, 1.0f);
//  vec3  lookat  = vec3(0.3f , lookatY, 1.0f);
    vec3  lookat2 = vec3(0.0f , lookatY, 0.7f);
//  vec3  lookat2 = vec3(0.0f , lookatY, 0.7f);
    lookat  = mix(lookat, lookat2, sin(t * .1f) * .5f + .5f);
//  lookat  = mix(lookat, lookat2, sin(t * .1f) * .5f + .5f);

    uv.y += bumps *         4.f          ;
//  uv.y += bumps *         4.f          ;
    CameraSetup(uv    , pos   , lookat, 2.f, mouse.x);
//  CameraSetup(uv    , pos   , lookat, 2.f, mouse.x);

    t *= 00.03f ;
//  t *= 00.03f ;
    t += mouse.x;
//  t += mouse.x;

    // fix for GLES devices by MacroMachines
//  // fix for GLES devices by MacroMachines
    // fix for GLES devices by MacroMachines
//  // fix for GLES devices by MacroMachines
    #ifdef GL_ES
//  #ifdef GL_ES
    const float stp = 1.f / 8.f;
//  const float stp = 1.f / 8.f;
    #else
//  #else
    float stp = 1.f / 8.f;
//  float stp = 1.f / 8.f;
    #endif
//  #endif

    for(float i = 0.f; i < 1.f;  i += stp) {
//  for(float i = 0.f; i < 1.f;  i += stp) {
    col +=      StreetLights(i                , t );
//  col +=      StreetLights(i                , t );
    }
//  }

    for(float i = 0.f; i < 1.f;  i += stp) {
//  for(float i = 0.f; i < 1.f;  i += stp) {
    float n =              N(i +          floor(t));
//  float n =              N(i +          floor(t));
    col +=        HeadLights(i + n * stp * .7f, t );
//  col +=        HeadLights(i + n * stp * .7f, t );
    }
//  }

    #ifndef  GL_ES
//  #ifndef  GL_ES
    #ifdef HIGH_QUALITY
//  #ifdef HIGH_QUALITY
    stp = 1.f / 32.f;
//  stp = 1.f / 32.f;
    #else
//  #else
    stp = 1.f / 16.f;
//  stp = 1.f / 16.f;
    #endif
//  #endif
    #endif
//  #endif

    for(float i = 0.f; i < 1.f;  i += stp) {
//  for(float i = 0.f; i < 1.f;  i += stp) {
    col += EnvironmentLights(i                , t );
//  col += EnvironmentLights(i                , t );
    }
//  }

    col += TailLights(0.0f, t);
//  col += TailLights(0.0f, t);
    col += TailLights(0.5f, t);
//  col += TailLights(0.5f, t);

    col += sat(rd.y) * vec3(.6f, .5f, .9f);
//  col += sat(rd.y) * vec3(.6f, .5f, .9f);

    fragColor = vec4(col, 0.f) * texture(tex0, vTexCoord);
//  fragColor = vec4(col, 0.f) * texture(tex0, vTexCoord);
    }

    // https://www.shadertoy.com/view/MdfBRX
//  // https://www.shadertoy.com/view/MdfBRX

    // "The Drive Home" by Martijn Steinrucken aka BigWings - 2017
//  // "The Drive Home" by Martijn Steinrucken aka BigWings - 2017
    // "The Drive Home" by Martijn Steinrucken aka BigWings - 2017
//  // "The Drive Home" by Martijn Steinrucken aka BigWings - 2017
    // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//  // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
    // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//  // License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
    // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
//  // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
    // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
//  // Email:countfrolic@gmail.com Twitter:@The_ArtOfCode
    //
//  //
    // I was looking for something 3d, that can be made just with a point-line distance function.
//  // I was looking for something 3d, that can be made just with a point-line distance function.
    // I was looking for something 3d, that can be made just with a point-line distance function.
//  // I was looking for something 3d, that can be made just with a point-line distance function.
    // Then I saw the cover graphic of the song I'm using here on soundcloud, which is a bokeh traffic
//  // Then I saw the cover graphic of the song I'm using here on soundcloud, which is a bokeh traffic
    // Then I saw the cover graphic of the song I'm using here on soundcloud, which is a bokeh traffic
//  // Then I saw the cover graphic of the song I'm using here on soundcloud, which is a bokeh traffic
    // shot which is a perfect for for what I was looking for.
//  // shot which is a perfect for for what I was looking for.
    // shot which is a perfect for for what I was looking for.
//  // shot which is a perfect for for what I was looking for.
    //
//  //
    // It took me a while to get to a satisfying rain effect. Most other people use a render buffer for
//  // It took me a while to get to a satisfying rain effect. Most other people use a render buffer for
    // It took me a while to get to a satisfying rain effect. Most other people use a render buffer for
//  // It took me a while to get to a satisfying rain effect. Most other people use a render buffer for
    // this so that is how I started. In the end though, I got a better effect without. Uncomment the
//  // this so that is how I started. In the end though, I got a better effect without. Uncomment the
    // this so that is how I started. In the end though, I got a better effect without. Uncomment the
//  // this so that is how I started. In the end though, I got a better effect without. Uncomment the
    // DROP_DEBUG define to get a better idea of what is going on.
//  // DROP_DEBUG define to get a better idea of what is going on.
    // DROP_DEBUG define to get a better idea of what is going on.
//  // DROP_DEBUG define to get a better idea of what is going on.
    //
//  //
    // If you are watching this on a weaker device, you can uncomment the HIGH_QUALITY define
//  // If you are watching this on a weaker device, you can uncomment the HIGH_QUALITY define
    // If you are watching this on a weaker device, you can uncomment the HIGH_QUALITY define
//  // If you are watching this on a weaker device, you can uncomment the HIGH_QUALITY define
    //
//  //
    // Music:
//  // Music:
    // Music:
//  // Music:
    // Mr. Bill - Cheyah (Zefora's digital rain remix)
//  // Mr. Bill - Cheyah (Zefora's digital rain remix)
    // Mr. Bill - Cheyah (Zefora's digital rain remix)
//  // Mr. Bill - Cheyah (Zefora's digital rain remix)
    // https://soundcloud.com/zefora/cheyah
//  // https://soundcloud.com/zefora/cheyah
    // https://soundcloud.com/zefora/cheyah
//  // https://soundcloud.com/zefora/cheyah
    //
//  //
    // Video can be found here:
//  // Video can be found here:
    // Video can be found here:
//  // Video can be found here:
    // https://www.youtube.com/watch?v=WrxZ4AZPdOQ
//  // https://www.youtube.com/watch?v=WrxZ4AZPdOQ
    // https://www.youtube.com/watch?v=WrxZ4AZPdOQ
//  // https://www.youtube.com/watch?v=WrxZ4AZPdOQ
    //
//  //
    // Making of tutorial:
//  // Making of tutorial:
    // Making of tutorial:
//  // Making of tutorial:
    // https://www.youtube.com/watch?v=eKtsY7hYTPg
//  // https://www.youtube.com/watch?v=eKtsY7hYTPg
    // https://www.youtube.com/watch?v=eKtsY7hYTPg
//  // https://www.youtube.com/watch?v=eKtsY7hYTPg
    //
//  //
