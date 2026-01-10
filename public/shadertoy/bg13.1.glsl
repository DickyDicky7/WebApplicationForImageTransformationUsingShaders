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

    mat2 m = mat2(0.80f, 0.60f, -0.60f, 0.80f);
//  mat2 m = mat2(0.80f, 0.60f, -0.60f, 0.80f);

    float hash(float n) {
//  float hash(float n) {
    return fract(sin(n) * 43758.5453f);
//  return fract(sin(n) * 43758.5453f);
    }
//  }

    float noise(in vec2 x) {
//  float noise(in vec2 x) {
    vec2  p = floor(x);
//  vec2  p = floor(x);
    vec2  f = fract(x);
//  vec2  f = fract(x);

    f = f * f * (3.0f - 2.0f * f); float n = p.x + p.y * 57.0f;
//  f = f * f * (3.0f - 2.0f * f); float n = p.x + p.y * 57.0f;

    float  res = mix(mix(hash(n + 00.0f)
//  float  res = mix(mix(hash(n + 00.0f)
    ,         hash(n + 01.0f), f.x)
//  ,         hash(n + 01.0f), f.x)
    ,     mix(hash(n + 57.0f)
//  ,     mix(hash(n + 57.0f)
    ,         hash(n + 58.0f), f.x), f.y);
//  ,         hash(n + 58.0f), f.x), f.y);
    return res;
//  return res;
    }
//  }

    float fbm(vec2 p) {
//  float fbm(vec2 p) {
    float f = 0.0f;
//  float f = 0.0f;

    f += 0.50000f * noise(p); p = m * p * 2.02f;
//  f += 0.50000f * noise(p); p = m * p * 2.02f;
    f += 0.25000f * noise(p); p = m * p * 2.03f;
//  f += 0.25000f * noise(p); p = m * p * 2.03f;
    f += 0.12500f * noise(p); p = m * p * 2.01f;
//  f += 0.12500f * noise(p); p = m * p * 2.01f;
    f += 0.06250f * noise(p); p = m * p * 2.04f;
//  f += 0.06250f * noise(p); p = m * p * 2.04f;
    f += 0.03125f * noise(p);
//  f += 0.03125f * noise(p);

    return f / 0.984375f;
//  return f / 0.984375f;
    }
//  }

    float beat = 0.f;
//  float beat = 0.f;

    float pattern(vec2 p, out vec2 q, out vec2 r, out vec2 s) {
//  float pattern(vec2 p, out vec2 q, out vec2 r, out vec2 s) {
    float ct = 0.f; float remapTime = (time + sin(beat * 3.1416f)) * .1f; q = vec2(fbm(p - vec2(cos(remapTime), sin(remapTime))), fbm(p + vec2(4.f + remapTime * .25f, 2.8765f - remapTime * .25f))); r = vec2(fbm(p + 4.0f * (q + vec2(1.7f - cos(remapTime * .6f), 9.2f - +remapTime * .6f))), fbm(p + 4.0f * (q + vec2(8.3f - remapTime * .6f, 2.8f + remapTime * .6f)))); s = vec2(fbm(r + 4.0f * r + vec2(2.4f - sin(remapTime * .6f), 15.01f + cos(remapTime * .6f))), fbm(r + 4.0f * (r + vec2(21.3f + remapTime, 1.03f - remapTime)))); return fbm(p + 4.f * s);
//  float ct = 0.f; float remapTime = (time + sin(beat * 3.1416f)) * .1f; q = vec2(fbm(p - vec2(cos(remapTime), sin(remapTime))), fbm(p + vec2(4.f + remapTime * .25f, 2.8765f - remapTime * .25f))); r = vec2(fbm(p + 4.0f * (q + vec2(1.7f - cos(remapTime * .6f), 9.2f - +remapTime * .6f))), fbm(p + 4.0f * (q + vec2(8.3f - remapTime * .6f, 2.8f + remapTime * .6f)))); s = vec2(fbm(r + 4.0f * r + vec2(2.4f - sin(remapTime * .6f), 15.01f + cos(remapTime * .6f))), fbm(r + 4.0f * (r + vec2(21.3f + remapTime, 1.03f - remapTime)))); return fbm(p + 4.f * s);
    }
//  }

    void main() {
    vec2 uv = vTexCoord * 10.f; vec2 q, r, s; float f = pattern(uv, q, r, s); vec3 col = mix(vec3(dot(q, r)), vec3(dot(q, s)), f); fragColor = vec4(col, 1.0f);
//  vec2 uv = vTexCoord * 10.f; vec2 q, r, s; float f = pattern(uv, q, r, s); vec3 col = mix(vec3(dot(q, r)), vec3(dot(q, s)), f); fragColor = vec4(col, 1.0f);
    }

    // https://www.shadertoy.com/view/lsfSRj
//  // https://www.shadertoy.com/view/lsfSRj
    // https://www.shadertoy.com/view/lsfSRj
//  // https://www.shadertoy.com/view/lsfSRj
    // https://www.shadertoy.com/view/lsfSRj
//  // https://www.shadertoy.com/view/lsfSRj
