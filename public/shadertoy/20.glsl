#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    // Uniiform@s
//  // Uniiform@s
    uniform sampler2D  tex0;
//  uniform sampler2D  tex0;
    in      vec2           vTexCoord;
//  in      vec2           vTexCoord;
    out     vec4           fragColor;
//  out     vec4           fragColor;
    uniform float      time;
//  uniform float      time;
    uniform vec2 canvasSize;
//  uniform vec2 canvasSize;
    uniform vec2           texelSize;
//  uniform vec2           texelSize;

    // Constants
//  // Constants
    // const vec4    c   = vec4(0.2124,
//  // const vec4    c   = vec4(0.2124,
    //                          0.7153,
//  //                          0.7153,
    //                          0.0722, 0.0);
//  //                          0.0722, 0.0);
    // const float scale =              2.0 ;
//  // const float scale =              2.0 ;

    uniform vec4  c     ; // 0.2124, 0.7153, 0.0722, 0.0
//  uniform vec4  c     ; // 0.2124, 0.7153, 0.0722, 0.0
    uniform float scale ; //                         2.0
//  uniform float scale ; //                         2.0

    vec4 bleach(vec4 p, vec4 m, vec4 s)
//  vec4 bleach(vec4 p, vec4 m, vec4 s)
    {
//  {
    vec4  a = vec4(1.0);
//  vec4  a = vec4(1.0);
    vec4  b = vec4(2.0);
//  vec4  b = vec4(2.0);
    float l = dot(m, c);
//  float l = dot(m, c);
    float x = clamp((l - 0.45) * 10.0, 0.0, 1.0);
//  float x = clamp((l - 0.45) * 10.0, 0.0, 1.0);
    vec4  t = b *  m *  p                ;
//  vec4  t = b *  m *  p                ;
    vec4  w = a - (b * (a - m) * (a - p));
//  vec4  w = a - (b * (a - m) * (a - p));
    vec4  r = mix(t, w, vec4(x));
//  vec4  r = mix(t, w, vec4(x));
    return    mix(m, r,      s );
//  return    mix(m, r,      s );
    }
//  }

    void main()
    {
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    vec4 p  =          texture(tex0, uv);  // Texture sampling for GLSL 100
//  vec4 p  =          texture(tex0, uv);  // Texture sampling for GLSL 100
    vec4 k  =                             vec4(vec3(dot(p, c)),       p.a  );
//  vec4 k  =                             vec4(vec3(dot(p, c)),       p.a  );
    fragColor =                         bleach(         k, p  , vec4(scale));
//  fragColor =                         bleach(         k, p  , vec4(scale));
    }



    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/MlscRf
//  // https://www.shadertoy.com/view/MlscRf
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@








