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

    // https://www.shadertoy.com/view/fdBXzW
//  // https://www.shadertoy.com/view/fdBXzW

    float random(float     x) {
//  float random(float     x) {
    return fract(sin(x) * 10000.);
//  return fract(sin(x) * 10000.);
    }
//  }

    float noise(vec2 p) {
//  float noise(vec2 p) {
    return random(p.x + p.y * 10000.);
//  return random(p.x + p.y * 10000.);
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
    return    mix(         s  ,          n  , interp.y);
//  return    mix(         s  ,          n  , interp.y);
        
    }
//  }

    uniform float speed ; // 2.5
//  uniform float speed ; // 2.5
    uniform float power ; // 0.1
//  uniform float power ; // 0.1


    void main()
    {
    float reTime = time; vec2 uv = vTexCoord; vec2 noise = vec2(smoothNoise(5. * uv + vec2(0., speed * reTime + 5.)), smoothNoise(3. * uv + vec2(0., speed * reTime + 1.))) - 0.5; uv += noise * power; uv = abs(uv); uv = step(1., uv) * 2. + sign(1. - uv) * uv; vec3 col = texture(tex0, uv).rgb; fragColor = vec4(col, 1.);
//  float reTime = time; vec2 uv = vTexCoord; vec2 noise = vec2(smoothNoise(5. * uv + vec2(0., speed * reTime + 5.)), smoothNoise(3. * uv + vec2(0., speed * reTime + 1.))) - 0.5; uv += noise * power; uv = abs(uv); uv = step(1., uv) * 2. + sign(1. - uv) * uv; vec3 col = texture(tex0, uv).rgb; fragColor = vec4(col, 1.);
    }























