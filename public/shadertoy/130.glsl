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

    // https://www.shadertoy.com/view/sdlSRM
//  // https://www.shadertoy.com/view/sdlSRM

    float random(float     x) {
//  float random(float     x) {
    return fract(sin(x) * 10000.);
//  return fract(sin(x) * 10000.);
    }
//  }

    float
//  float
    noise(vec2 p) {
//  noise(vec2 p) {
    return
//  return
    random(
//  random(
    p.x +
//  p.x +
    p.y *
//  p.y *
    10000.);
//  10000.);
    }
//  }

    vec2 sw(vec2 p) { return vec2(floor(p.x), floor(p.y)); }
//  vec2 sw(vec2 p) { return vec2(floor(p.x), floor(p.y)); }
    vec2 se(vec2 p) { return vec2(ceil (p.x), floor(p.y)); }
//  vec2 se(vec2 p) { return vec2(ceil (p.x), floor(p.y)); }
    vec2 nw(vec2 p) { return vec2(floor(p.x), ceil (p.y)); }
//  vec2 nw(vec2 p) { return vec2(floor(p.x), ceil (p.y)); }
    vec2 ne(vec2 p) { return vec2(ceil (p.x), ceil (p.y)); }
//  vec2 ne(vec2 p) { return vec2(ceil (p.x), ceil (p.y)); }

    float smoothNoise(vec2 p) {
//  float smoothNoise(vec2 p) {

    vec2 interp = smoothstep(0., 1., fract(p));
//  vec2 interp = smoothstep(0., 1., fract(p));
    float s = mix(noise(sw(p)), noise(se(p)), interp.x);
//  float s = mix(noise(sw(p)), noise(se(p)), interp.x);
    float n = mix(noise(nw(p)), noise(ne(p)), interp.x);
//  float n = mix(noise(nw(p)), noise(ne(p)), interp.x);
    return mix(s, n, interp.y);
//  return mix(s, n, interp.y);
        
    }
//  }

    float speed = 18.0;
//  float speed = 18.0;
    float power = 00.5;
//  float power = 00.5;
    float zoom  = 00.2;
//  float zoom  = 00.2;


    void main()
    {
    float timee = mod(time ,        1.);
//  float timee = mod(time ,        1.);
    float ratio = pow(1.00 - timee, 3.);
//  float ratio = pow(1.00 - timee, 3.);
    ratio *= (
//  ratio *= (
    (-tanh(05. * (timee - 0.50)) * 0.5 + 0.5) *
//  (-tanh(05. * (timee - 0.50)) * 0.5 + 0.5) *
    ( tanh(20. * (timee - 0.05)) * 0.5 + 0.5) *
//  ( tanh(20. * (timee - 0.05)) * 0.5 + 0.5) *
    1.35
//  1.35
    );
//  );
    
    vec2    uv = vTexCoord;
//  vec2    uv = vTexCoord;
    vec2 noise = vec2(
//  vec2 noise = vec2(
    smoothNoise(5. * uv + vec2(0., 10. * timee + 5.))
//  smoothNoise(5. * uv + vec2(0., 10. * timee + 5.))
    ,    smoothNoise(3. * uv + vec2(0., 10. * timee + 1.))
//  ,    smoothNoise(3. * uv + vec2(0., 10. * timee + 1.))
    );
//  );
    uv += noise * power * ratio * sin(speed * timee);
//  uv += noise * power * ratio * sin(speed * timee);
    
    
    uv =  abs(     uv     );
//  uv =  abs(     uv     );
    uv = step(1. , uv) * 2.
//  uv = step(1. , uv) * 2.
    + sign(1. - uv) * uv;
//  + sign(1. - uv) * uv;

    vec3 col  = texture(tex0, uv).rgb;
//  vec3 col  = texture(tex0, uv).rgb;
    col += ratio * col          ;
//  col += ratio * col          ;
    fragColor = vec4(   col , 1.)    ;
//  fragColor = vec4(   col , 1.)    ;
    }













