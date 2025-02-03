#version 300 es
//  precision lowp float;
    precision lowp float;
//  precision lowp float;

//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;



float hash (vec2 p) { return fract(1e4 * sin(17.0 * p.x + p.y * 0.1) * (0.1 + abs(sin(p.y * 13.0 + p.x)))); }
float noise(vec2 x) {
    vec2 i = floor(x);
    vec2 f = fract(x);
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    vec2  u =                    f  *   f * (3.0 - 2.0  *  f    )            ;
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

#define octaves 14
float fbm    (in vec2 p) { float value = 0.0; float freq = 1.0; float amp = 0.5; for (int i = 0; i < octaves; i++) { value += amp * (noise((p - vec2(1.0)) * freq)); freq *= 1.9; amp *= 0.6; } return value; }
float pattern(in vec2 p) {
    vec2 offset = vec2(-0.5      ) ;
    vec2 aPos   =                    vec2(sin( time * 0.005), sin(time * 0.01)) * 6.; vec2 aScale = vec2(3.0); float a = fbm( p      * aScale + aPos);
    vec2 bPos   =                    vec2(sin( time * 0.010), sin(time * 0.01)) * 1.; vec2 bScale = vec2(0.6); float b = fbm((p + a) * bScale + bPos);
    vec2 cPos   = vec2(-0.6, -0.5) + vec2(sin(-time * 0.001), sin(time * 0.01)) * 2.; vec2 cScale = vec2(2.6); float c = fbm((p + b) * cScale + cPos);
    return  c                      ;
}

vec3 palette(in float t) {
    vec3 a = vec3(0.50, 0.50, 0.50);
    vec3 b = vec3(0.45, 0.25, 0.14);
    vec3 c = vec3(1.00, 1.00, 1.00);
    vec3 d = vec3(0.00, 0.10, 0.20);
    return a + b * cos(06.28318 * (c * t + d));
}

    void main () { vec2 p = vTexCoord; p.x = 1.0 - p.x; p.x *= canvasSize.x / canvasSize.y; float value = pow(pattern(p), 2.); vec3 color = palette(value); fragColor = vec4(color, 1.0); }
//  void main () { vec2 p = vTexCoord; p.x = 1.0 - p.x; p.x *= canvasSize.x / canvasSize.y; float value = pow(pattern(p), 2.); vec3 color = palette(value); fragColor = vec4(color, 1.0); }
//  void main () { vec2 p = vTexCoord; p.x = 1.0 - p.x; p.x *= canvasSize.x / canvasSize.y; float value = pow(pattern(p), 2.); vec3 color = palette(value); fragColor = vec4(color, 1.0); }

// https://www.shadertoy.com/view/3lf3z2
// https://www.shadertoy.com/view/3lf3z2
// https://www.shadertoy.com/view/3lf3z2

