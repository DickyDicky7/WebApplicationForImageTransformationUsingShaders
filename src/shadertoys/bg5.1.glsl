#version 300 es
//  precision lowp float;
    precision lowp float;
//  precision lowp float;

//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

// Author: Thomas Stehle
// Author: Thomas Stehle
// Title: Sun Tracks
// Title: Sun Tracks
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
//
// Inspired by this long exposure photograph by Martin Cann:
// Inspired by this long exposure photograph by Martin Cann:
// https://twitter.com/MartinCann1/status/1408139994972278788
// https://twitter.com/MartinCann1/status/1408139994972278788

// Constants
// Constants
const vec3 INNER = vec3(131, 118, 117) / 255.0f;
const vec3 OUTER = vec3(001, 034, 046) / 255.0f;
const vec3 SUN   = vec3(224, 229, 180) / 255.0f;
const vec3 GLOW  = vec3(247, 251, 238) / 255.0f;

const int   NLINES   = 100          ;
const float NLINES_F = float(NLINES);

// 1D hash for 1D input by David Hoskins
// 1D hash for 1D input by David Hoskins
// https://www.shadertoy.com/view/4djSRW
// https://www.shadertoy.com/view/4djSRW
float hash(in float p) {
    p = fract(p * 0.011f); p *= p + 7.5f; p *= p + p; return fract(p);
//  p = fract(p * 0.011f); p *= p + 7.5f; p *= p + p; return fract(p);
}

// 1D hash for 2D input by David Hoskins
// 1D hash for 2D input by David Hoskins
// https://www.shadertoy.com/view/4djSRW
// https://www.shadertoy.com/view/4djSRW
float hash21(in vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.13f); p3 += dot(p3, p3.yzx + 3.333f); return fract((p3.x + p3.y) * p3.z);
//  vec3 p3 = fract(vec3(p.xyx) * 0.13f); p3 += dot(p3, p3.yzx + 3.333f); return fract((p3.x + p3.y) * p3.z);
}

// 1D hash for 3D input
// 1D hash for 3D input
float hash31(in vec3 p) {
    vec3 q = fract(p * 0.1031f); q += dot(q, q.yzx + 33.33f); return fract((q.x + q.y) * q.z);
//  vec3 q = fract(p * 0.1031f); q += dot(q, q.yzx + 33.33f); return fract((q.x + q.y) * q.z);
}

// 2D value noise by Morgan McGuire
// 2D value noise by Morgan McGuire
// https://www.shadertoy.com/view/4dS3Wd
// https://www.shadertoy.com/view/4dS3Wd
float vnoise(in vec2 p) {
    vec2  i = floor (p);
    vec2  f = fract (p);

    // Four corners in 2D of a tile
//  // Four corners in 2D of a tile
    float a = hash21(i);
    float b = hash21(i + vec2(1.0f, 0.0f));
    float c = hash21(i + vec2(0.0f, 1.0f));
    float d = hash21(i + vec2(1.0f, 1.0f));

    // Smooth interpolation (smoothstep without clamping)
//  // Smooth interpolation (smoothstep without clamping)
    vec2 u = f * f * (3.0f - 2.0f * f);
//  vec2 u = f * f * (3.0f - 2.0f * f);

    // Mix 4 coorners
//  // Mix 4 coorners
    return mix(a, b, u.x) + (c - a) * u.y * (1.0f - u.x) + (d - b) * u.x * u.y;
//  return mix(a, b, u.x) + (c - a) * u.y * (1.0f - u.x) + (d - b) * u.x * u.y;
}

// 2D Fractional Brownian motion based on value noise by Morgan McGuire
// 2D Fractional Brownian motion based on value noise by Morgan McGuire
// https://www.shadertoy.com/view/4dS3Wd
// https://www.shadertoy.com/view/4dS3Wd
float vfbm(in vec2 p) {
    float v = 0.0f;
    float a = 0.5f;
    vec2 shift = vec2(100.0f);
//  vec2 shift = vec2(100.0f);
    // Rotate to reduce axial bias
//  // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5f), sin(0.5f), -sin(0.5f), cos(0.5f)); const int NOCTAVES = 5; for(int i = 0; i < NOCTAVES; ++i) { v += a * vnoise(p); p = rot * p * 2.0f + shift; a *= 0.5f; } return v;
//  mat2 rot = mat2(cos(0.5f), sin(0.5f), -sin(0.5f), cos(0.5f)); const int NOCTAVES = 5; for(int i = 0; i < NOCTAVES; ++i) { v += a * vnoise(p); p = rot * p * 2.0f + shift; a *= 0.5f; } return v;
}

// OKLAB-based color mixing by iq
// OKLAB-based color mixing by iq
// https://www.shadertoy.com/view/ttcyRS
// https://www.shadertoy.com/view/ttcyRS
vec3 oklab_mix(vec3 colA, vec3 colB, float h) {
    // https://bottosson.github.io/posts/oklab
//  // https://bottosson.github.io/posts/oklab
    const mat3 kCONEtoLMS = mat3(0.4121656120f,  0.2118591070f,  0.0883097947f,  0.5362752080f, 0.6807189584f,  0.2818474174f, 0.0514575653f,  0.1074065790f, 0.6302613616f);
    const mat3 kLMStoCONE = mat3(4.0767245293f, -1.2681437731f, -0.0041119885f, -3.3072168827f, 2.6093323231f, -0.7034763098f, 0.2307590544f, -0.3411344290f, 1.7068625689f);

    // rgb to cone (arg of pow can't be negative)
//  // rgb to cone (arg of pow can't be negative)
    vec3 lmsA = pow(kCONEtoLMS * colA, vec3(1.0f / 3.0f));
    vec3 lmsB = pow(kCONEtoLMS * colB, vec3(1.0f / 3.0f));

    // lerp
//  // lerp
    vec3 lms = mix(lmsA, lmsB, h);
//  vec3 lms = mix(lmsA, lmsB, h);

    // gain in the middle (no oaklab anymore, but looks better?)
//  // gain in the middle (no oaklab anymore, but looks better?)
    // lms *= 1.0+0.2*h*(1.0-h);
//  // lms *= 1.0+0.2*h*(1.0-h);

    // cone to rgb
//  // cone to rgb
    return kLMStoCONE * (lms * lms * lms);
//  return kLMStoCONE * (lms * lms * lms);
}

float sdOrientedBox(in vec2 p, in vec2 a, in vec2 b, float th) {
    float l = length(b - a); vec2 d = (b - a) / l; vec2 q = (p - (a + b) * 0.5f); q = mat2(d.x, -d.y, d.y, d.x) * q; q = abs(q) - vec2(l, th) * 0.5f; return length(max(q, 0.0f)) + min(max(q.x, q.y), 0.0f);
//  float l = length(b - a); vec2 d = (b - a) / l; vec2 q = (p - (a + b) * 0.5f); q = mat2(d.x, -d.y, d.y, d.x) * q; q = abs(q) - vec2(l, th) * 0.5f; return length(max(q, 0.0f)) + min(max(q.x, q.y), 0.0f);
}

vec2 distort(in vec2 p) {
    vec2 q = 0.8f * p + vec2(-0.2f, 0.2f); float amp = -0.4f; float freq = 1.0f + 4.0f * q.y; float phase = 0.0f; return vec2(q.x, q.y + amp * sin(freq * q.x + phase));
//  vec2 q = 0.8f * p + vec2(-0.2f, 0.2f); float amp = -0.4f; float freq = 1.0f + 4.0f * q.y; float phase = 0.0f; return vec2(q.x, q.y + amp * sin(freq * q.x + phase));
}

float suntracks(in vec2 p) {
    vec2 st   = vec2( p.x, p.y   * NLINES_F);
         st.y = max (st.y, 0.10f * NLINES_F);
         st.y = min (st.y, 0.55f * NLINES_F);

    vec2 gv = vec2(st.x, fract(st.y)); float id = floor(st.y); int idx = int(id);
//  vec2 gv = vec2(st.x, fract(st.y)); float id = floor(st.y); int idx = int(id);

    float r1 = hash(13.1f * float(idx));
    float r2 = hash(37.3f * float(idx));

    float speed = 0.25f + 0.25f * r2; const float W = 0.25f; float d = sdOrientedBox(gv, vec2(-1.0f, 0.5f), vec2(2.0f, 0.5f), W); float n = vfbm(vec2(30.0f * (gv.x + id) - speed * time, 0.0f)); d += 0.25f * r2 + smoothstep(0.55f, 0.65f, n);
//  float speed = 0.25f + 0.25f * r2; const float W = 0.25f; float d = sdOrientedBox(gv, vec2(-1.0f, 0.5f), vec2(2.0f, 0.5f), W); float n = vfbm(vec2(30.0f * (gv.x + id) - speed * time, 0.0f)); d += 0.25f * r2 + smoothstep(0.55f, 0.65f, n);

    return d;
//  return d;
}

float foreground(in vec2 p) {
    vec2 q = vec2(p.x, p.y + 0.2f * vfbm(10.0f * p)); const float W = 0.25f; return sdOrientedBox(q, vec2(-1.0f, 0.0f), vec2(2.0f, 0.0f), W);
//  vec2 q = vec2(p.x, p.y + 0.2f * vfbm(10.0f * p)); const float W = 0.25f; return sdOrientedBox(q, vec2(-1.0f, 0.0f), vec2(2.0f, 0.0f), W);
}

void main() {
    // Coordinate normalization
//  // Coordinate normalization
    vec2 uv = vTexCoord; uv.y = 1.0f - uv.y; float ar = canvasSize.x / canvasSize.y; uv.x *= ar;
//  vec2 uv = vTexCoord; uv.y = 1.0f - uv.y; float ar = canvasSize.x / canvasSize.y; uv.x *= ar;

    // Background
//  // Background
    float bg = pow(10.0f * length(0.15f * uv - vec2(0.075f, 0.1f)), 1.5f); vec3 col = oklab_mix(INNER, OUTER, clamp(bg, 0.0f, 1.0f));
//  float bg = pow(10.0f * length(0.15f * uv - vec2(0.075f, 0.1f)), 1.5f); vec3 col = oklab_mix(INNER, OUTER, clamp(bg, 0.0f, 1.0f));

    // Foreground
//  // Foreground
    float fgd = foreground(uv); fgd = smoothstep(0.15f, 0.1f, fgd); col = mix(col, vec3(0.05f), fgd);
//  float fgd = foreground(uv); fgd = smoothstep(0.15f, 0.1f, fgd); col = mix(col, vec3(0.05f), fgd);

    // Distort
//  // Distort
    vec2 p = distort(uv);
//  vec2 p = distort(uv);

    // Fade out factors
//  // Fade out factors
    float fade = smoothstep(0.75f, 0.25f, length(p - vec2(0.5f)));
//  float fade = smoothstep(0.75f, 0.25f, length(p - vec2(0.5f)));
    // Fade out to the sides
//  // Fade out to the sides

    // Sun tracks
//  // Sun tracks
    float td = suntracks(p); td = smoothstep(0.5f, -0.5f, td) * fade; td *= smoothstep(0.05f, 0.2f, uv.y);
//  float td = suntracks(p); td = smoothstep(0.5f, -0.5f, td) * fade; td *= smoothstep(0.05f, 0.2f, uv.y);
    // Additional fade out near bottom
//  // Additional fade out near bottom
    col = mix(col, SUN, clamp(td, 0.0f, 1.0f));
//  col = mix(col, SUN, clamp(td, 0.0f, 1.0f));

    // Gas tracks
//  // Gas tracks
    float n = vfbm(2.0f * p - vec2(0.15f * time, 0.0f)); n *= (1.0f - fgd); col = oklab_mix(col, SUN, pow(n, 3.0f));
//  float n = vfbm(2.0f * p - vec2(0.15f * time, 0.0f)); n *= (1.0f - fgd); col = oklab_mix(col, SUN, pow(n, 3.0f));

    // Glow
//  // Glow
    float gl = vnoise(2.0f + sin(1.5f * time) * p); gl = pow(gl, 2.0f) * fade; gl *= smoothstep(0.7f, 0.4f, p.y) * smoothstep(-0.1f, 0.2f, p.y);
//  float gl = vnoise(2.0f + sin(1.5f * time) * p); gl = pow(gl, 2.0f) * fade; gl *= smoothstep(0.7f, 0.4f, p.y) * smoothstep(-0.1f, 0.2f, p.y);
    // Additional fade in sun space
//  // Additional fade in sun space
    gl *= smoothstep(0.05f, 0.2f, uv.y);
//  gl *= smoothstep(0.05f, 0.2f, uv.y);
    // Additional fade in screen space
//  // Additional fade in screen space
    col = mix(col, GLOW, clamp(gl, 0.0f, 1.0f));
//  col = mix(col, GLOW, clamp(gl, 0.0f, 1.0f));

    // Add animated noise
//  // Add animated noise
    float r = hash31(vec3(gl_FragCoord.xy, fract(0.001f * time))); col.rgb += 0.1f * vec3(r - 0.5f);
//  float r = hash31(vec3(gl_FragCoord.xy, fract(0.001f * time))); col.rgb += 0.1f * vec3(r - 0.5f);

    // Vignetting
//  // Vignetting
    // https://www.shadertoy.com/view/lsKSWR
//  // https://www.shadertoy.com/view/lsKSWR
    vec2 st = uv * (vec2(1.0f, ar) - uv.yx); float vig = st.x * st.y * 10.0f; col *= pow(vig, 0.2f);
//  vec2 st = uv * (vec2(1.0f, ar) - uv.yx); float vig = st.x * st.y * 10.0f; col *= pow(vig, 0.2f);

    // Final color
//  // Final color
    fragColor = vec4(col, 1.0f);
//  fragColor = vec4(col, 1.0f);
}

// https://www.shadertoy.com/view/ftSGWt
// https://www.shadertoy.com/view/ftSGWt
// https://www.shadertoy.com/view/ftSGWt












