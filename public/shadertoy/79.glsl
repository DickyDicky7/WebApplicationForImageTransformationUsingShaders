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

    // Maximum number of cells a ripple can cross.
//  // Maximum number of cells a ripple can cross.
    // Maximum number of cells a ripple can cross.
//  // Maximum number of cells a ripple can cross.
#define    MAX_RADIUS 2
// #define    MAX_RADIUS 2

    // Set to 1 to hash twice. Slower, but less patterns.
//  // Set to 1 to hash twice. Slower, but less patterns.
    // Set to 1 to hash twice. Slower, but less patterns.
//  // Set to 1 to hash twice. Slower, but less patterns.
#define DOUBLE_HASH   0
// #define DOUBLE_HASH   0

    // Hash functions shamefully stolen from:
//  // Hash functions shamefully stolen from:
    // Hash functions shamefully stolen from:
//  // Hash functions shamefully stolen from:
    // https://www.shadertoy.com/view/4djSRW
//  // https://www.shadertoy.com/view/4djSRW
    // https://www.shadertoy.com/view/4djSRW
//  // https://www.shadertoy.com/view/4djSRW
#define HASHSCALE1      .1031
// #define HASHSCALE1      .1031
#define HASHSCALE3 vec3(.1031, .1030, .0973)
// #define HASHSCALE3 vec3(.1031, .1030, .0973)

    float hash12(vec2 p)
//  float hash12(vec2 p)
    {
//  {
    vec3 p3  = fract(vec3(p.xyx) * HASHSCALE1);
//  vec3 p3  = fract(vec3(p.xyx) * HASHSCALE1);
    p3 +=   dot( p3    , p3.yzx  + 19.19);
//  p3 +=   dot( p3    , p3.yzx  + 19.19);
    return     fract((p3.x  + p3.y  ) * p3.z );
//  return     fract((p3.x  + p3.y  ) * p3.z );
    }
//  }

    vec2 hash22(vec2 p)
//  vec2 hash22(vec2 p)
    {
//  {
    vec3 p3  = fract(vec3(p.xyx) * HASHSCALE3);
//  vec3 p3  = fract(vec3(p.xyx) * HASHSCALE3);
    p3 +=   dot( p3    , p3.yzx  + 19.19);
//  p3 +=   dot( p3    , p3.yzx  + 19.19);
    return     fract((p3.xx + p3.yz ) * p3.zy);
//  return     fract((p3.xx + p3.yz ) * p3.zy);

    }
//  }

    void main(  )
    {
    float resolution = 10. * exp2(-3. * mousePosition.x  / canvasSize.x             );
//  float resolution = 10. * exp2(-3. * mousePosition.x  / canvasSize.x             );
    vec2  uv         =                   vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.y * resolution ;
//  vec2  uv         =                   vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.y * resolution ;
    vec2  p0         =                          floor(uv);
//  vec2  p0         =                          floor(uv);

    vec2 circles = vec2(0.);
//  vec2 circles = vec2(0.);
    for     (int j = -MAX_RADIUS; j <= MAX_RADIUS; ++j)
//  for     (int j = -MAX_RADIUS; j <= MAX_RADIUS; ++j)
    {
//  {
    for (int i = -MAX_RADIUS; i <= MAX_RADIUS; ++i)
//  for (int i = -MAX_RADIUS; i <= MAX_RADIUS; ++i)
    {
//  {
    vec2  pi =
//  vec2  pi =
    p0 + vec2 (i , j);
//  p0 + vec2 (i , j);
            #if DOUBLE_HASH
//          #if DOUBLE_HASH
    vec2 hsh =      hash22(
//  vec2 hsh =      hash22(
    pi         );
//  pi         );
            #else
//          #else
    vec2 hsh = pi          ;
//  vec2 hsh = pi          ;
            #endif
//          #endif
    vec2   p = pi + hash22(
//  vec2   p = pi + hash22(
    hsh              );
//  hsh              );

    float t  = fract(0.3 * time + hash12(hsh));
//  float t  = fract(0.3 * time + hash12(hsh));
    vec2  v  =                                 p - uv;
//  vec2  v  =                                 p - uv;
    float d  =                                        length(v) - (float(MAX_RADIUS) + 1.) * t;
//  float d  =                                        length(v) - (float(MAX_RADIUS) + 1.) * t;

    float h  = 1e-3 ;
//  float h  = 1e-3 ;
    float d1 = d - h;
//  float d1 = d - h;
    float d2 = d + h;
//  float d2 = d + h;
    float p1 = sin(31. * d1) * smoothstep(-0.6, -0.3, d1) * smoothstep(0., -0.3, d1);
//  float p1 = sin(31. * d1) * smoothstep(-0.6, -0.3, d1) * smoothstep(0., -0.3, d1);
    float p2 = sin(31. * d2) * smoothstep(-0.6, -0.3, d2) * smoothstep(0., -0.3, d2);
//  float p2 = sin(31. * d2) * smoothstep(-0.6, -0.3, d2) * smoothstep(0., -0.3, d2);
    circles += 0.5 * normalize(v) * ((p2 - p1) / (2. * h) * (1. - t) * (1. - t));
//  circles += 0.5 * normalize(v) * ((p2 - p1) / (2. * h) * (1. - t) * (1. - t));
    }
//  }
    }
//  }
    circles /= float((MAX_RADIUS * 2 + 1)
//  circles /= float((MAX_RADIUS * 2 + 1)
    *        (MAX_RADIUS * 2 + 1));
//  *        (MAX_RADIUS * 2 + 1));

    float intensity = mix(0.01, 0.15, smoothstep(0.1, 0.6, abs(fract(0.05 * time + 0.5) * 2. - 1.)));
//  float intensity = mix(0.01, 0.15, smoothstep(0.1, 0.6, abs(fract(0.05 * time + 0.5) * 2. - 1.)));
    vec3  n         =                                                                                vec3(circles, sqrt(1. - dot(circles, circles)));
//  vec3  n         =                                                                                vec3(circles, sqrt(1. - dot(circles, circles)));
    vec3      color =                                                                                                                                texture(tex0, uv / resolution - intensity * n.xy).rgb + 5. * pow(clamp(dot(n, normalize(vec3(1., 0.7, 0.5))), 0., 1.), 6.);
//  vec3      color =                                                                                                                                texture(tex0, uv / resolution - intensity * n.xy).rgb + 5. * pow(clamp(dot(n, normalize(vec3(1., 0.7, 0.5))), 0., 1.), 6.);
    fragColor =                                                                                                                                                                                                                                                           vec4(color, 1.0);
//  fragColor =                                                                                                                                                                                                                                                           vec4(color, 1.0);
    }


    // https://www.shadertoy.com/view/ldfyzl
//  // https://www.shadertoy.com/view/ldfyzl
    // https://www.shadertoy.com/view/ldfyzl
//  // https://www.shadertoy.com/view/ldfyzl

    /*
//  /*

    A quick experiment with rain drop ripples.
//  A quick experiment with rain drop ripples.
    A quick experiment with rain drop ripples.
//  A quick experiment with rain drop ripples.

    This effect was written for and used in the launch scene of the
//  This effect was written for and used in the launch scene of the
    This effect was written for and used in the launch scene of the
//  This effect was written for and used in the launch scene of the
    64kB PC intro "H - Immersion", by Ctrl-Alt-Test.
//  64kB PC intro "H - Immersion", by Ctrl-Alt-Test.
    64kB PC intro "H - Immersion", by Ctrl-Alt-Test.
//  64kB PC intro "H - Immersion", by Ctrl-Alt-Test.

    > http://www.ctrl-alt-test.fr/productions/h-immersion/
//  > http://www.ctrl-alt-test.fr/productions/h-immersion/
    > http://www.ctrl-alt-test.fr/productions/h-immersion/
//  > http://www.ctrl-alt-test.fr/productions/h-immersion/
    > https://www.youtube.com/watch?v=27PN1SsXbjM
//  > https://www.youtube.com/watch?v=27PN1SsXbjM
    > https://www.youtube.com/watch?v=27PN1SsXbjM
//  > https://www.youtube.com/watch?v=27PN1SsXbjM

    --
//  --
    --
//  --
    Zavie / Ctrl-Alt-Test
//  Zavie / Ctrl-Alt-Test
    Zavie / Ctrl-Alt-Test
//  Zavie / Ctrl-Alt-Test

    */
//  */
