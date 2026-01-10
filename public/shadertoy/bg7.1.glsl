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

    float rand(vec2 p) {
//  float rand(vec2 p) {
    return fract(sin(dot(p, vec2(12.99f, 78.233f))) * 43758.545f);
//  return fract(sin(dot(p, vec2(12.99f, 78.233f))) * 43758.545f);
    }
//  }

    float noise(vec2 p) {
//  float noise(vec2 p) {
    vec2 f = fract(p); f = f * f * f * f * (3.f - 2.f * f) * (3.f - 2.f * f); vec2 i = floor(p); return mix(mix(rand(i + vec2(0, 0)), rand(i + vec2(1, 0)), f.x), mix(rand(i + vec2(0, 1)), rand(i + vec2(1, 1)), f.x), f.y);
//  vec2 f = fract(p); f = f * f * f * f * (3.f - 2.f * f) * (3.f - 2.f * f); vec2 i = floor(p); return mix(mix(rand(i + vec2(0, 0)), rand(i + vec2(1, 0)), f.x), mix(rand(i + vec2(0, 1)), rand(i + vec2(1, 1)), f.x), f.y);
    }
//  }

    float fbm(vec2 p) {
//  float fbm(vec2 p) {
    float v = 0.f; float a = 1.f; for(int i = 0; i < 4; ++i) { p = 1.5f * p + 15.f; a *= 0.5f; v += a * noise(p); } return v;
//  float v = 0.f; float a = 1.f; for(int i = 0; i < 4; ++i) { p = 1.5f * p + 15.f; a *= 0.5f; v += a * noise(p); } return v;
    }
//  }

    void main() {
    vec2 p = 2.f * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.y;
//  vec2 p = 2.f * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.y;
    vec2 r1 = vec2(fbm(p + 0.02f * time            ), fbm(p + 0.005f * time            ));
//  vec2 r1 = vec2(fbm(p + 0.02f * time            ), fbm(p + 0.005f * time            ));
    vec2 r2 = vec2(fbm(p + 0.15f * time + 10.f * r1), fbm(p + 0.120f * time + 12.f * r1));
//  vec2 r2 = vec2(fbm(p + 0.15f * time + 10.f * r1), fbm(p + 0.120f * time + 12.f * r1));
    //  fragColor = vec4(1.8f * pow(fbm(p + r2), 2.f) + 0.03f);
//  //  fragColor = vec4(1.8f * pow(fbm(p + r2), 2.f) + 0.03f);
    fragColor = vec4(1.8f * pow(fbm(p + r2), 2.f) + 0.03f);
//  fragColor = vec4(1.8f * pow(fbm(p + r2), 2.f) + 0.03f);
    }

    // https://www.shadertoy.com/view/ftd3zX
//  // https://www.shadertoy.com/view/ftd3zX
    // https://www.shadertoy.com/view/ftd3zX
//  // https://www.shadertoy.com/view/ftd3zX
    // https://www.shadertoy.com/view/ftd3zX
//  // https://www.shadertoy.com/view/ftd3zX












