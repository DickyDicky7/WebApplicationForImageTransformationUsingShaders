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

    // const float    RANGE = 0.7;
//  // const float    RANGE = 0.7;
    // const float    SPEED = 0.5;
//  // const float    SPEED = 0.5;
    // const float STRENGTH = 6.0;
//  // const float STRENGTH = 6.0;

    uniform float    RANGE ; // 0.7
//  uniform float    RANGE ; // 0.7
    uniform float    SPEED ; // 0.5
//  uniform float    SPEED ; // 0.5
    uniform float STRENGTH ; // 6.0
//  uniform float STRENGTH ; // 6.0

    mat2 rotate(float a)
//  mat2 rotate(float a)
    {
//  {
    float s = sin(a);
//  float s = sin(a);
    float c = cos(a);
//  float c = cos(a);
    return mat2(c, -s, s, c);
//  return mat2(c, -s, s, c);
    }
//  }

    void main() {
    vec2 aspect  = canvasSize.xy / canvasSize.y;
//  vec2 aspect  = canvasSize.xy / canvasSize.y;
    vec2 center  = 0.5           * aspect      ;
//  vec2 center  = 0.5           * aspect      ;
    
    vec2     uv  = vTexCoord     * aspect      ;
//  vec2     uv  = vTexCoord     * aspect      ;
    uv -=                 center      ;
//  uv -=                 center      ;
    
    float d        = length(       uv   );
//  float d        = length(       uv   );
    float progress =    sin(time * SPEED);
//  float progress =    sin(time * SPEED);
    
    //vortex
//  //vortex
    float cTime  = STRENGTH
//  float cTime  = STRENGTH
    * progress;
//  * progress;
    d      = smoothstep(0., RANGE, RANGE - d) * cTime;
//  d      = smoothstep(0., RANGE, RANGE - d) * cTime;
    uv *= rotate    (                   d)        ;
//  uv *= rotate    (                   d)        ;
    
    //shrink
//  //shrink
    float edge = 1. * abs(progress)       ;
//  float edge = 1. * abs(progress)       ;
    uv = uv + normalize(uv) * edge;
//  uv = uv + normalize(uv) * edge;
    
    uv += center;
//  uv += center;
    uv /= aspect;
//  uv /= aspect;
    if (uv.x > 1.
//  if (uv.x > 1.
    ||  uv.y > 1.
//  ||  uv.y > 1.
    ||  uv.x < 0.
//  ||  uv.x < 0.
    ||  uv.y < 0.)
//  ||  uv.y < 0.)
    {
//  {
    fragColor = vec4(0., 0., 0., 0.);
//  fragColor = vec4(0., 0., 0., 0.);
    }
//  }
    else
//  else
    {
//  {
    fragColor =
//  fragColor =
    texture(tex0, uv);
//  texture(tex0, uv);
    }
//  }
    }

    // https://www.shadertoy.com/view/l3t3R2
//  // https://www.shadertoy.com/view/l3t3R2
