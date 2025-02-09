#version 300 es
//  precision lowp float;
    precision lowp float;
//  precision lowp float;

//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

float hash(vec2 a) {
    return fract(sin(a.x * 3433.8f + a.y * 3843.98f) * 45933.8f);
//  return fract(sin(a.x * 3433.8f + a.y * 3843.98f) * 45933.8f);
}

float noise(vec2 uv) {

    vec2 lv = fract(uv);
    lv = lv * lv * (3.0f - 2.0f * lv);
    vec2 id = floor(uv);

    float bl = hash(id);
    float br = hash(id + vec2(1, 0));
    float b  = mix (bl
             ,      br
             ,      lv.x           );

    float tl = hash(id + vec2(0, 1));
    float tr = hash(id + vec2(1, 1));
    float t  = mix (tl
             ,      tr
             ,      lv.x           );

    float  c = mix (b
             ,      t
             ,      lv.y           );

    return c                        ;

}

float fbm(vec2 uv) {

    vec2 mou = mousePosition.xy / canvasSize.y;

    float  f  = noise(uv * 04.0f)          ;
           f += noise(uv * 08.0f) * 0.5000f;
           f += noise(uv * 16.0f) * 0.2500f;
           f += noise(uv * 32.0f) * 0.1250f;
           f += noise(uv * 64.0f) * 0.0625f;
           f /= 2.0f;

    return f;

}

void main() {
    vec2 uv = (2.f * gl_FragCoord.xy - canvasSize.xy) / canvasSize.y; vec2 mou = mousePosition.xy / canvasSize.y; vec2 q = vec2(0.0f); vec2 r = vec2(0.0f); float tim = time * 0.2f; float a = fbm(uv + fbm(uv + mod(tim, 200.0f) + fbm(uv))); float b = fbm(uv + vec2(mou) + fbm(uv + mod(tim, 200.0f) + fbm(uv))); vec3 col = vec3(a);
//  vec2 uv = (2.f * gl_FragCoord.xy - canvasSize.xy) / canvasSize.y; vec2 mou = mousePosition.xy / canvasSize.y; vec2 q = vec2(0.0f); vec2 r = vec2(0.0f); float tim = time * 0.2f; float a = fbm(uv + fbm(uv + mod(tim, 200.0f) + fbm(uv))); float b = fbm(uv + vec2(mou) + fbm(uv + mod(tim, 200.0f) + fbm(uv))); vec3 col = vec3(a);
    // vec3 col = vec3( mix( r.y, q.x, c ) );
//  // vec3 col = vec3( mix( r.y, q.x, c ) );
    // Output to screen
//  // Output to screen
    fragColor = vec4(col, 1.0f);
//  fragColor = vec4(col, 1.0f);
}

// https://www.shadertoy.com/view/4sVfzd
// https://www.shadertoy.com/view/4sVfzd
// https://www.shadertoy.com/view/4sVfzd
