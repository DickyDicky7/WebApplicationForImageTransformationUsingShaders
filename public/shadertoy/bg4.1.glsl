#version 300 es
// #version 300 es
    //  precision lowp float;
//  //  precision lowp float;
    precision lowp float;
//  precision lowp float;

    //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

    mat2 rot( float a )
//  mat2 rot( float a )
    {
//  {
    float s = sin(a);
//  float s = sin(a);
    float c = cos(a);
//  float c = cos(a);
    return mat2(  s
//  return mat2(  s
    ,  c
//  ,  c
    , -c
//  , -c
    ,  s);
//  ,  s);
    }
//  }

    float noise( in vec2 x ){ return smoothstep(0.,1.,sin(1.5*x.x)*sin(1.5*x.y)); }
//  float noise( in vec2 x ){ return smoothstep(0.,1.,sin(1.5*x.x)*sin(1.5*x.y)); }

    float fbm( vec2 p )
//  float fbm( vec2 p )
    {
//  {
    mat2  m = rot(.4);
//  mat2  m = rot(.4);
    float f = 0.0    ;
//  float f = 0.0    ;
    f += 0.500000*(0.5+0.5*noise( p )); p = m*p*2.02;
//  f += 0.500000*(0.5+0.5*noise( p )); p = m*p*2.02;
    f += 0.250000*(0.5+0.5*noise( p )); p = m*p*2.03;
//  f += 0.250000*(0.5+0.5*noise( p )); p = m*p*2.03;
    f += 0.125000*(0.5+0.5*noise( p )); p = m*p*2.01;
//  f += 0.125000*(0.5+0.5*noise( p )); p = m*p*2.01;
    f += 0.062500*(0.5+0.5*noise( p )); p = m*p*2.04;
//  f += 0.062500*(0.5+0.5*noise( p )); p = m*p*2.04;
    f += 0.031250*(0.5+0.5*noise( p )); p = m*p*2.01;
//  f += 0.031250*(0.5+0.5*noise( p )); p = m*p*2.01;
    f += 0.015625*(0.5+0.5*noise( p ));
//  f += 0.015625*(0.5+0.5*noise( p ));
    return f/0.96875;
//  return f/0.96875;
    }
//  }


    float pattern (in vec2 p, out vec2 q, out vec2 r, float t){
//  float pattern (in vec2 p, out vec2 q, out vec2 r, float t){
   
    
    q.x  = fbm( p + vec2(0.0,0.0) + 0.7*t );
//  q.x  = fbm( p + vec2(0.0,0.0) + 0.7*t );
    q.y  = fbm( p + vec2(5.2,1.3) + 1.0*t );
//  q.y  = fbm( p + vec2(5.2,1.3) + 1.0*t );

    r.x  = fbm( p + 10.0*q + vec2(1.7,9.2) + sin(t) );
//  r.x  = fbm( p + 10.0*q + vec2(1.7,9.2) + sin(t) );
    r.y  = fbm( p + 12.0*q + vec2(8.3,2.8) + cos(t) );
//  r.y  = fbm( p + 12.0*q + vec2(8.3,2.8) + cos(t) );

    return fbm( p + 03.0*r );
//  return fbm( p + 03.0*r );
    
    }
//  }

    void main() {
    vec2 uv = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - mousePosition.xy) / canvasSize.xy * 2.f; uv.x *= canvasSize.x / canvasSize.y; vec2 q, r; vec3 col1 = vec3(0.f, .9f, .8f); vec3 col2 = vec3(1.f, .6f, .5f); float f = pattern(uv, q, r, 0.1f * time); vec3 c = mix(col1, vec3(0), smoothstep(.0f, .95f, f)); vec3 a = col2 * smoothstep(0.f, .8f, dot(q, r) * 0.6f); c = sqrt(c * c + a * a); fragColor = vec4(c, 1.f);
//  vec2 uv = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - mousePosition.xy) / canvasSize.xy * 2.f; uv.x *= canvasSize.x / canvasSize.y; vec2 q, r; vec3 col1 = vec3(0.f, .9f, .8f); vec3 col2 = vec3(1.f, .6f, .5f); float f = pattern(uv, q, r, 0.1f * time); vec3 c = mix(col1, vec3(0), smoothstep(.0f, .95f, f)); vec3 a = col2 * smoothstep(0.f, .8f, dot(q, r) * 0.6f); c = sqrt(c * c + a * a); fragColor = vec4(c, 1.f);
    }


    // https://www.shadertoy.com/view/MlVcDt
//  // https://www.shadertoy.com/view/MlVcDt
    // https://www.shadertoy.com/view/MlVcDt
//  // https://www.shadertoy.com/view/MlVcDt
    // https://www.shadertoy.com/view/MlVcDt
//  // https://www.shadertoy.com/view/MlVcDt


