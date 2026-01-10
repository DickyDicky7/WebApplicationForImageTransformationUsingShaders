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


    float random(in vec2 st) {
//  float random(in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898f, 78.233f))) * 43758.5453123f);
//  return fract(sin(dot(st.xy, vec2(12.9898f, 78.233f))) * 43758.5453123f);
    }
//  }

    // Based on Morgan McGuire @morgan3d
//  // Based on Morgan McGuire @morgan3d
    // Based on Morgan McGuire @morgan3d
//  // Based on Morgan McGuire @morgan3d
    // https://www.shadertoy.com/view/4dS3Wd
//  // https://www.shadertoy.com/view/4dS3Wd
    // https://www.shadertoy.com/view/4dS3Wd
//  // https://www.shadertoy.com/view/4dS3Wd
    float noise(in vec2 st) {
//  float noise(in vec2 st) {
    vec2  i = floor  (st);
//  vec2  i = floor  (st);
    vec2  f = fract  (st);
//  vec2  f = fract  (st);

    // Four corners in 2D of a tile
//  // Four corners in 2D of a tile
    float a = random(i);
//  float a = random(i);
    float b = random(i + vec2(1.0f, 0.0f));
//  float b = random(i + vec2(1.0f, 0.0f));
    float c = random(i + vec2(0.0f, 1.0f));
//  float c = random(i + vec2(0.0f, 1.0f));
    float d = random(i + vec2(1.0f, 1.0f));
//  float d = random(i + vec2(1.0f, 1.0f));
    vec2  u = f * f * (3.0f - 2.0f * f); return mix(a, b, u.x) + (c - a) * u.y * (1.0f - u.x) + (d - b) * u.x * u.y;
//  vec2  u = f * f * (3.0f - 2.0f * f); return mix(a, b, u.x) + (c - a) * u.y * (1.0f - u.x) + (d - b) * u.x * u.y;
    }
//  }

    #define OCTAVES 16
//  #define OCTAVES 16
    float fbm(in vec2 st) {
//  float fbm(in vec2 st) {
    // Initial values
//  // Initial values
    float value     = 0.0f;
//  float value     = 0.0f;
    float amplitude = 1.f;
//  float amplitude = 1.f;
    float frequency = 2.f;
//  float frequency = 2.f;
    //
//  //
    // Loop of octaves
//  // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) { value += amplitude * noise(st); st *= 3.f; amplitude *= .5f; } return value;
//  for (int i = 0; i < OCTAVES; i++) { value += amplitude * noise(st); st *= 3.f; amplitude *= .5f; } return value;
    }
//  }

    float fbmWarp2(in vec2 st, out vec2 q, out vec2 r) {
//  float fbmWarp2(in vec2 st, out vec2 q, out vec2 r) {
    q.x  = fbm(st + vec2(0.0f, 0.0f));
//  q.x  = fbm(st + vec2(0.0f, 0.0f));
    q.y  = fbm(st + vec2(5.2f, 1.3f));
//  q.y  = fbm(st + vec2(5.2f, 1.3f));

    r.x  = fbm(st + 4.0f * q + vec2(1.7f, 9.2f) + 0.7f * time);
//  r.x  = fbm(st + 4.0f * q + vec2(1.7f, 9.2f) + 0.7f * time);
    r.y  = fbm(st + 4.0f * q + vec2(8.3f, 2.8f) + 0.7f * time);
//  r.y  = fbm(st + 4.0f * q + vec2(8.3f, 2.8f) + 0.7f * time);

    return fbm(st + 4.0f * r);
//  return fbm(st + 4.0f * r);
    }
//  }

    vec3 hsb2rgb(in vec3 c) {
//  vec3 hsb2rgb(in vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x * 6.0f + vec3(0.0f, 4.0f, 2.0f), 6.0f) - 3.0f) - 1.0f, 0.0f, 1.0f); rgb = rgb * rgb * (3.0f - 2.0f * rgb); return c.z * mix(vec3(1.0f), rgb, c.y);
//  vec3 rgb = clamp(abs(mod(c.x * 6.0f + vec3(0.0f, 4.0f, 2.0f), 6.0f) - 3.0f) - 1.0f, 0.0f, 1.0f); rgb = rgb * rgb * (3.0f - 2.0f * rgb); return c.z * mix(vec3(1.0f), rgb, c.y);
    }
//  }

    void main() {
    vec2 st = vTexCoord; st.y = 1.0f - st.y; st.x *= canvasSize.x / canvasSize.y;
//  vec2 st = vTexCoord; st.y = 1.0f - st.y; st.x *= canvasSize.x / canvasSize.y;

    vec3   color = vec3(0.0f);
//  vec3   color = vec3(0.0f);
    vec2  q      = vec2(0.0f);
//  vec2  q      = vec2(0.0f);
    vec2  r      = vec2(0.0f);
//  vec2  r      = vec2(0.0f);
    float height = fbmWarp2(st * 10.f, q, r);
//  float height = fbmWarp2(st * 10.f, q, r);

    color +=            hsb2rgb(vec3(0.30f,      1.0f - (0.50f * sin(       time) + 0.50f)  ,   height));
//  color +=            hsb2rgb(vec3(0.30f,      1.0f - (0.50f * sin(       time) + 0.50f)  ,   height));
    color  = mix(color, hsb2rgb(vec3(0.00f, q.x, 0.2f + (0.20f * sin(0.7f * time) + 0.20f))), length(q));
//  color  = mix(color, hsb2rgb(vec3(0.00f, q.x, 0.2f + (0.20f * sin(0.7f * time) + 0.20f))), length(q));
    color  = mix(color, hsb2rgb(vec3(0.58f, r.x, 0.0f + (0.25f * sin(0.3f * time) + 0.25f))), r.y      );
//  color  = mix(color, hsb2rgb(vec3(0.58f, r.x, 0.0f + (0.25f * sin(0.3f * time) + 0.25f))), r.y      );

    fragColor = vec4(color, 1.0f);
//  fragColor = vec4(color, 1.0f);
    }

    // https://www.shadertoy.com/view/XtKSWm
//  // https://www.shadertoy.com/view/XtKSWm
    // https://www.shadertoy.com/view/XtKSWm
//  // https://www.shadertoy.com/view/XtKSWm
    // https://www.shadertoy.com/view/XtKSWm
//  // https://www.shadertoy.com/view/XtKSWm







