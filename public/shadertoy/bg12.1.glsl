    #version 300 es
//  #version 300 es
    //  precision lowp float;
//  //  precision lowp float;
    precision lowp float;
//  precision lowp float;

    //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

    //  #define DEBUG_PALETTE
//  //  #define DEBUG_PALETTE

    float hash21(vec2 v) {
//  float hash21(vec2 v) {
    return fract(sin(dot(v, vec2(12.9898f, 78.233f))) * 43758.5453123f);
//  return fract(sin(dot(v, vec2(12.9898f, 78.233f))) * 43758.5453123f);
    }
//  }

    float noise(vec2 uv) {
//  float noise(vec2 uv) {
    vec2 f = fract(uv);
//  vec2 f = fract(uv);
    vec2 i = floor(uv);
//  vec2 i = floor(uv);
    f = f * f * (3.f - 2.f * f); return mix(mix(hash21(i), hash21(i + vec2(1, 0)), f.x), mix(hash21(i + vec2(0, 1)), hash21(i + vec2(1, 1)), f.x), f.y);
//  f = f * f * (3.f - 2.f * f); return mix(mix(hash21(i), hash21(i + vec2(1, 0)), f.x), mix(hash21(i + vec2(0, 1)), hash21(i + vec2(1, 1)), f.x), f.y);
    }
//  }

    float fbm(vec2 uv) {
//  float fbm(vec2 uv) {
    float freq = 2.f; float amp = .5f; float gain = .54f; float v = 0.f; for(int i = 0; i < 6; ++i) { v += amp * noise(uv); amp *= gain; uv *= freq; } return v;
//  float freq = 2.f; float amp = .5f; float gain = .54f; float v = 0.f; for(int i = 0; i < 6; ++i) { v += amp * noise(uv); amp *= gain; uv *= freq; } return v;
    }
//  }

    float fbmPattern(vec2 p, out vec2 q, out vec2 r) {
//  float fbmPattern(vec2 p, out vec2 q, out vec2 r) {
    float qCoef = 2.f;
//  float qCoef = 2.f;
    float rCoef = 3.f;
//  float rCoef = 3.f;
    q.x =  fbm(p +             .00f * time);
//  q.x =  fbm(p +             .00f * time);
    q.y =  fbm(p -             .02f * time + vec2(10.f, 7.36f));
//  q.y =  fbm(p -             .02f * time + vec2(10.f, 7.36f));
    r.x =  fbm(p + qCoef * q + .10f * time + vec2(05.f, 3.00f));
//  r.x =  fbm(p + qCoef * q + .10f * time + vec2(05.f, 3.00f));
    r.y =  fbm(p + qCoef * q - .07f * time + vec2(10.f, 7.36f));
//  r.y =  fbm(p + qCoef * q - .07f * time + vec2(10.f, 7.36f));
    return fbm(p + rCoef * r + .10f * time);
//  return fbm(p + rCoef * r + .10f * time);
    }
//  }

    vec3 basePalette(float t) {
//  vec3 basePalette(float t) {
    return .5f + .6f * cos(6.283185f * (-t + vec3(.0f, .1f, .2f) - .2f));
//  return .5f + .6f * cos(6.283185f * (-t + vec3(.0f, .1f, .2f) - .2f));
    }
//  }

    vec3 smokePalette(float t) {
//  vec3 smokePalette(float t) {
    return vec3(.6f, .5f, .5f) + .5f * cos(6.283185f * (-vec3(1.f, 1.f, .5f) * t + vec3(.2f, .15f, -.1f) - .2f));
//  return vec3(.6f, .5f, .5f) + .5f * cos(6.283185f * (-vec3(1.f, 1.f, .5f) * t + vec3(.2f, .15f, -.1f) - .2f));
    }
//  }

    void main() {
    vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.yy; uv.y = 1.0f - uv.y; float scale = 5.f; vec3 col = vec3(.1f); float n; vec2 q; vec2 r; n = fbmPattern(scale * uv, q, r); vec3 baseCol = basePalette(r.x); vec3 smokeCol = smokePalette(n); col = mix(baseCol, smokeCol, pow(q.y, 1.3f));
//  vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.yy; uv.y = 1.0f - uv.y; float scale = 5.f; vec3 col = vec3(.1f); float n; vec2 q; vec2 r; n = fbmPattern(scale * uv, q, r); vec3 baseCol = basePalette(r.x); vec3 smokeCol = smokePalette(n); col = mix(baseCol, smokeCol, pow(q.y, 1.3f));
    #ifdef DEBUG_PALETTE
//  #ifdef DEBUG_PALETTE
    float x = vec4(vTexCoord * canvasSize, 0.0, 1.0).x / canvasSize.x; col = mix(col, basePalette(x), step(abs(uv.y - .03f), .02f)); col = mix(col, smokePalette(x), step(abs(uv.y - .08f), .02f));
//  float x = vec4(vTexCoord * canvasSize, 0.0, 1.0).x / canvasSize.x; col = mix(col, basePalette(x), step(abs(uv.y - .03f), .02f)); col = mix(col, smokePalette(x), step(abs(uv.y - .08f), .02f));
    #endif
//  #endif

    fragColor = vec4(col, 1);
//  fragColor = vec4(col, 1);
    }

    // https://www.shadertoy.com/view/WsjGRz
//  // https://www.shadertoy.com/view/WsjGRz
    // https://www.shadertoy.com/view/WsjGRz
//  // https://www.shadertoy.com/view/WsjGRz
    // https://www.shadertoy.com/view/WsjGRz
//  // https://www.shadertoy.com/view/WsjGRz






