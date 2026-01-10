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

    // https://www.shadertoy.com/view/lc3BW8
//  // https://www.shadertoy.com/view/lc3BW8

    uniform int         NUM_ITER; // 16
//  uniform int         NUM_ITER; // 16
    uniform float RECIP_NUM_ITER; // 00.0625
//  uniform float RECIP_NUM_ITER; // 00.0625
    // 1.0 / float(NUM_ITER)
//  // 1.0 / float(NUM_ITER)
    // 1.0 / float(NUM_ITER)
//  // 1.0 / float(NUM_ITER)
    uniform float GAMMA; // 1.0
//  uniform float GAMMA; // 1.0

    float sat(float t) { return clamp(t, 0.0, 1.0); }
//  float sat(float t) { return clamp(t, 0.0, 1.0); }

    float remap(float t, float a, float b) { return sat((t - a) / (b - a)); }
//  float remap(float t, float a, float b) { return sat((t - a) / (b - a)); }

    vec3 spectrum_offset(float t) { float lo = step(t, 0.5); float hi = 1.0 - lo; float w = 1.0 - abs(2.0 * t - 1.0); /* linterp function inlined for performance */ return pow(vec3(lo, 1.0, hi) * vec3(1.0 - w, w, 1.0 - w), vec3(1.0 / GAMMA)); }
//  vec3 spectrum_offset(float t) { float lo = step(t, 0.5); float hi = 1.0 - lo; float w = 1.0 - abs(2.0 * t - 1.0); /* linterp function inlined for performance */ return pow(vec3(lo, 1.0, hi) * vec3(1.0 - w, w, 1.0 - w), vec3(1.0 / GAMMA)); }

    float nrand(vec2 n) { return fract(sin(dot(n, vec2(12.9898, 78.233))) * 43758.5453); }
//  float nrand(vec2 n) { return fract(sin(dot(n, vec2(12.9898, 78.233))) * 43758.5453); }

    vec2 barrelDistortion(vec2 p, float amt) { p = 2.0 * p - 1.0; float theta = atan(p.y, p.x); float radius = pow(length(p), 1.0 + 3.0 * amt); /* maxBarrelPower inlined */ return 0.5 * (vec2(cos(theta), sin(theta)) * radius + 1.0); }
//  vec2 barrelDistortion(vec2 p, float amt) { p = 2.0 * p - 1.0; float theta = atan(p.y, p.x); float radius = pow(length(p), 1.0 + 3.0 * amt); /* maxBarrelPower inlined */ return 0.5 * (vec2(cos(theta), sin(theta)) * radius + 1.0); }

    uniform float amount ; // 0.25
//  uniform float amount ; // 0.25

    void main() {
    vec2 uv = vTexCoord; vec2 max_distort = vec2(amount * 0.5);  // Adjust the amount of barrel distortion here
//  vec2 uv = vTexCoord; vec2 max_distort = vec2(amount * 0.5);  // Adjust the amount of barrel distortion here

    vec3 sumcol = vec3(0.0); vec3 sumw = vec3(0.0); float rnd = nrand(uv + fract(time));
//  vec3 sumcol = vec3(0.0); vec3 sumw = vec3(0.0); float rnd = nrand(uv + fract(time));

    for (int i = 0; i < NUM_ITER; ++i) {
//  for (int i = 0; i < NUM_ITER; ++i) {
    float t = (float(i) + rnd) * RECIP_NUM_ITER; vec3 w = spectrum_offset(t); vec2 distortedUV = barrelDistortion(uv, max_distort.x * t); sumcol += w * texture(tex0, distortedUV).rgb; sumw += w;
//  float t = (float(i) + rnd) * RECIP_NUM_ITER; vec3 w = spectrum_offset(t); vec2 distortedUV = barrelDistortion(uv, max_distort.x * t); sumcol += w * texture(tex0, distortedUV).rgb; sumw += w;
    //  float t = (float(i) + rnd) * RECIP_NUM_ITER; vec3 w = spectrum_offset(t); vec2 distortedUV = barrelDistortion(uv, max_distort.x * t); sumcol += w * texture(tex0, distortedUV).rgb; sumw += w;
//  //  float t = (float(i) + rnd) * RECIP_NUM_ITER; vec3 w = spectrum_offset(t); vec2 distortedUV = barrelDistortion(uv, max_distort.x * t); sumcol += w * texture(tex0, distortedUV).rgb; sumw += w;
    }
//  }

    vec3 outcol = pow(sumcol / sumw, vec3(1.0 / GAMMA)); outcol += rnd / 255.0; fragColor = vec4(outcol, 1.0);
//  vec3 outcol = pow(sumcol / sumw, vec3(1.0 / GAMMA)); outcol += rnd / 255.0; fragColor = vec4(outcol, 1.0);
    }
