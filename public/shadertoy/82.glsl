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

    // const float iterations = 17.00;
//  // const float iterations = 17.00;
    // const float formuparam = 00.53;
//  // const float formuparam = 00.53;

    // const float volsteps = 20.0;
//  // const float volsteps = 20.0;
    // const float stepsize = 00.1;
//  // const float stepsize = 00.1;

    // const float zoom  = 0.800;
//  // const float zoom  = 0.800;
    // const float tile  = 0.850;
//  // const float tile  = 0.850;
    // const float speed = 0.010;
//  // const float speed = 0.010;

    // const float brightness = 0.0015;
//  // const float brightness = 0.0015;
    // const float darkmatter = 0.3000;
//  // const float darkmatter = 0.3000;
    // const float distfading = 0.7300;
//  // const float distfading = 0.7300;
    // const float saturation = 0.8500;
//  // const float saturation = 0.8500;


    uniform float iterations ; // 17.00
//  uniform float iterations ; // 17.00
    uniform float formuparam ; // 00.53
//  uniform float formuparam ; // 00.53

    uniform float volsteps ; // 20.0
//  uniform float volsteps ; // 20.0
    uniform float stepsize ; // 00.1
//  uniform float stepsize ; // 00.1

    uniform float zoom  ; // 0.800
//  uniform float zoom  ; // 0.800
    uniform float tile  ; // 0.850
//  uniform float tile  ; // 0.850
    uniform float speed ; // 0.010
//  uniform float speed ; // 0.010

    uniform float brightness ; // 0.0015
//  uniform float brightness ; // 0.0015
    uniform float darkmatter ; // 0.3000
//  uniform float darkmatter ; // 0.3000
    uniform float distfading ; // 0.7300
//  uniform float distfading ; // 0.7300
    uniform float saturation ; // 0.8500
//  uniform float saturation ; // 0.8500


    void main(  )
    {
    //get coords and direction
//  //get coords and direction
    //get coords and direction
//  //get coords and direction
    vec2 uv     = vTexCoord - 0.5;
//  vec2 uv     = vTexCoord - 0.5;
    uv.y  *=   canvasSize.y  / canvasSize.x       ;
//  uv.y  *=   canvasSize.y  / canvasSize.x       ;
    vec3    dir = vec3(uv * zoom,   1.  );
//  vec3    dir = vec3(uv * zoom,   1.  );
    float timee = time    * speed +  .25 ;
//  float timee = time    * speed +  .25 ;

    //mouse rotation
//  //mouse rotation
    //mouse rotation
//  //mouse rotation
    float a1 = 0.5 + mousePosition.x / canvasSize.x * 2.0;
//  float a1 = 0.5 + mousePosition.x / canvasSize.x * 2.0;
    float a2 = 0.8 + mousePosition.y / canvasSize.y * 2.0;
//  float a2 = 0.8 + mousePosition.y / canvasSize.y * 2.0;
    mat2  rot1 = mat2(cos(a1), sin(a1), -sin(a1), cos(a1));
//  mat2  rot1 = mat2(cos(a1), sin(a1), -sin(a1), cos(a1));
    mat2  rot2 = mat2(cos(a2), sin(a2), -sin(a2), cos(a2));
//  mat2  rot2 = mat2(cos(a2), sin(a2), -sin(a2), cos(a2));
    dir.xz *= rot1;
//  dir.xz *= rot1;
    dir.xy *= rot2;
//  dir.xy *= rot2;
    vec3 from     = vec3(        1.0,  0.5 ,  0.5);
//  vec3 from     = vec3(        1.0,  0.5 ,  0.5);
    from    += vec3(timee * 2.0, timee, -2.0);
//  from    += vec3(timee * 2.0, timee, -2.0);
    from.xz *= rot1;
//  from.xz *= rot1;
    from.xy *= rot2;
//  from.xy *= rot2;
    
    //volumetric rendering
//  //volumetric rendering
    //volumetric rendering
//  //volumetric rendering
    float s = 0.1, fade = 1.0 ;
//  float s = 0.1, fade = 1.0 ;
    vec3  v =      vec3  (0.0);
//  vec3  v =      vec3  (0.0);
    for (int r = 0       ;
//  for (int r = 0       ;
    r < volsteps;
//  r < volsteps;
    r++         ) {
//  r++         ) {
    vec3 p = from +  s  * dir * 0.5   ;
//  vec3 p = from +  s  * dir * 0.5   ;
    p = abs(   vec3(tile        )
//  p = abs(   vec3(tile        )
    - mod(p, vec3(tile * 2.0)));
//  - mod(p, vec3(tile * 2.0)));
    // tiling fold
//  // tiling fold
    // tiling fold
//  // tiling fold
    float pa, a = pa = 0.0 ;
//  float pa, a = pa = 0.0 ;
    for (int i = 0         ;
//  for (int i = 0         ;
    i < iterations;
//  i < iterations;
    i++           ) {
//  i++           ) {
    p    = abs(p) / dot(p, p) - formuparam;
//  p    = abs(p) / dot(p, p) - formuparam;
    // the magic formula
//  // the magic formula
    // the magic formula
//  // the magic formula
    a   += abs(length(p) - pa);
//  a   += abs(length(p) - pa);
    // absolute sum of average change
//  // absolute sum of average change
    // absolute sum of average change
//  // absolute sum of average change
    pa   =     length(p)      ;
//  pa   =     length(p)      ;
    }
//  }
    float dm = max(0.0, darkmatter - a * a * 0.001);
//  float dm = max(0.0, darkmatter - a * a * 0.001);
    //dark matter
//  //dark matter
    //dark matter
//  //dark matter
    a *= a * a;
//  a *= a * a;
    // add contrast
//  // add contrast
    // add contrast
//  // add contrast
    if (r > 6) fade *= 1. - dm;
//  if (r > 6) fade *= 1. - dm;
    // dark matter, don't render near
//  // dark matter, don't render near
    // dark matter, don't render near
//  // dark matter, don't render near
    //v += vec3(dm, dm * .5, 0.);
//  //v += vec3(dm, dm * .5, 0.);
    //v += vec3(dm, dm * .5, 0.);
//  //v += vec3(dm, dm * .5, 0.);
    v +=                                                  fade;
//  v +=                                                  fade;
    v += vec3(s, s * s, s * s * s * s) * a * brightness * fade;
//  v += vec3(s, s * s, s * s * s * s) * a * brightness * fade;
    // coloring based on distance
//  // coloring based on distance
    // coloring based on distance
//  // coloring based on distance
    fade *= distfading;
//  fade *= distfading;
    // distance fading
//  // distance fading
    // distance fading
//  // distance fading
    s    +=   stepsize;
//  s    +=   stepsize;
    }
//  }
    v = mix(vec3(length(v)), v, saturation);
//  v = mix(vec3(length(v)), v, saturation);
    //color adjust
//  //color adjust
    //color adjust
//  //color adjust
    fragColor =    vec4(v * 0.01, 1.0     )
//  fragColor =    vec4(v * 0.01, 1.0     )
    * texture(    tex0,vTexCoord);
//  * texture(    tex0,vTexCoord);
    
    }

    // https://www.shadertoy.com/view/XlfGRj
//  // https://www.shadertoy.com/view/XlfGRj

    // Star Nest by Pablo Roman Andrioli
//  // Star Nest by Pablo Roman Andrioli
    // Star Nest by Pablo Roman Andrioli
//  // Star Nest by Pablo Roman Andrioli
    // License: MIT
//  // License: MIT
    // License: MIT
//  // License: MIT


