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

    // https://www.shadertoy.com/view/lXKczD
//  // https://www.shadertoy.com/view/lXKczD

    uniform float GRID_HEIGHT   ; // 48.00000000
//  uniform float GRID_HEIGHT   ; // 48.00000000
    uniform float MIN_RADIUS    ; // 00.00000000
//  uniform float MIN_RADIUS    ; // 00.00000000
    uniform float MAX_RADIUS    ; // 01.20000000
//  uniform float MAX_RADIUS    ; // 01.20000000
    uniform float MIN_INTENSITY ; // 00.10000000
//  uniform float MIN_INTENSITY ; // 00.10000000
    uniform float MAX_INTENSITY ; // 01.00000000
//  uniform float MAX_INTENSITY ; // 01.00000000
    uniform float BACKGROUND    ; // 00.05859375
//  uniform float BACKGROUND    ; // 00.05859375
    uniform vec3  FOREGROUND    ; // 00.96875000, 0.93359375, 0.88281250
//  uniform vec3  FOREGROUND    ; // 00.96875000, 0.93359375, 0.88281250

    float circle(in vec2 st, in float radius) { float dist = length(st - 0.5f); return radius == 0.0f ? 0.0f : smoothstep(GRID_HEIGHT / canvasSize.y * 1.5f, 0.0f, dist - radius / 2.0f); }
//  float circle(in vec2 st, in float radius) { float dist = length(st - 0.5f); return radius == 0.0f ? 0.0f : smoothstep(GRID_HEIGHT / canvasSize.y * 1.5f, 0.0f, dist - radius / 2.0f); }

    float intensity(in vec3 col) { return 0.299f * col.r + 0.587f * col.g + 0.114f * col.b; }
//  float intensity(in vec3 col) { return 0.299f * col.r + 0.587f * col.g + 0.114f * col.b; }

    float remap(float inMin, float inMax, float outMin, float outMax, float value) { float normalizedValue = clamp((value - inMin) / (inMax - inMin), 0.0f, 1.0f); return mix(outMin, outMax, normalizedValue); }
//  float remap(float inMin, float inMax, float outMin, float outMax, float value) { float normalizedValue = clamp((value - inMin) / (inMax - inMin), 0.0f, 1.0f); return mix(outMin, outMax, normalizedValue); }

    void main() {
    vec2 mc  =                        mousePosition.xy  / canvasSize.y;
//  vec2 mc  =                        mousePosition.xy  / canvasSize.y;
    vec2 uv  =  vec4(vTexCoord * canvasSize, 0.0, 1.0).xy                         / canvasSize.y;
//  vec2 uv  =  vec4(vTexCoord * canvasSize, 0.0, 1.0).xy                         / canvasSize.y;
    vec2 gv  = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - 0.5f * canvasSize.xy) / canvasSize.y;
//  vec2 gv  = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - 0.5f * canvasSize.xy) / canvasSize.y;
    vec2 ouv =       gv  +     0.5f    ;
//  vec2 ouv =       gv  +     0.5f    ;
    gv  = fract(gv  * GRID_HEIGHT);
//  gv  = fract(gv  * GRID_HEIGHT);
    ouv = floor(ouv * GRID_HEIGHT) / GRID_HEIGHT;
//  ouv = floor(ouv * GRID_HEIGHT) / GRID_HEIGHT;

    // Mouse
//  // Mouse
    float blur = 50.0f / canvasSize.y; float r = 0.1f + 0.05f * sin(time); vec3 col = 0.9f * vec3(smoothstep(r + blur, r - blur, length(mc - uv)));  //vec3 col = vec3(0.0);
//  float blur = 50.0f / canvasSize.y; float r = 0.1f + 0.05f * sin(time); vec3 col = 0.9f * vec3(smoothstep(r + blur, r - blur, length(mc - uv)));  //vec3 col = vec3(0.0);

    vec3 texCol = texture(tex0, ouv).rgb; float mask = BACKGROUND;
//  vec3 texCol = texture(tex0, ouv).rgb; float mask = BACKGROUND;
    // NOTE: Support for MAX_RADIUS exceeding 1.
//  // NOTE: Support for MAX_RADIUS exceeding 1.
    // NOTE: Support for MAX_RADIUS exceeding 1.
//  // NOTE: Support for MAX_RADIUS exceeding 1.
    for (float y = -1.0f; y <= 1.0f; y++) {
//  for (float y = -1.0f; y <= 1.0f; y++) {
    for (float x = -1.0f; x <= 1.0f; x++) {
//  for (float x = -1.0f; x <= 1.0f; x++) {
    vec2 offset = vec2(x, y); texCol = texture(tex0, ouv + offset / GRID_HEIGHT).rgb; col = max(col, texCol); float intensity = intensity(col); float radius = remap(MIN_INTENSITY, MAX_INTENSITY, MIN_RADIUS, MAX_RADIUS, intensity * intensity); mask = max(mask, circle(gv - offset, radius));
//  vec2 offset = vec2(x, y); texCol = texture(tex0, ouv + offset / GRID_HEIGHT).rgb; col = max(col, texCol); float intensity = intensity(col); float radius = remap(MIN_INTENSITY, MAX_INTENSITY, MIN_RADIUS, MAX_RADIUS, intensity * intensity); mask = max(mask, circle(gv - offset, radius));
    //          vec2 offset = vec2(x, y); texCol = texture(tex0, ouv + offset / GRID_HEIGHT).rgb; col = max(col, texCol); float intensity = intensity(col); float radius = remap(MIN_INTENSITY, MAX_INTENSITY, MIN_RADIUS, MAX_RADIUS, intensity * intensity); mask = max(mask, circle(gv - offset, radius));
//  //          vec2 offset = vec2(x, y); texCol = texture(tex0, ouv + offset / GRID_HEIGHT).rgb; col = max(col, texCol); float intensity = intensity(col); float radius = remap(MIN_INTENSITY, MAX_INTENSITY, MIN_RADIUS, MAX_RADIUS, intensity * intensity); mask = max(mask, circle(gv - offset, radius));
    }
//  }
    }
//  }

    fragColor = vec4(min(FOREGROUND, vec3(mask)), 1.0f); /* fragColor = vec4(vec3(mask * texCol), 1.0f); */ /* fragColor = vec4(gv.r, gv.g, 0.0f, 1.0f); */ /* fragColor = vec4(ouv.r, ouv.g, 0.0f, 1.0f); */ /* fragColor = vec4(max(col, texCol), 1.0f); */
//  fragColor = vec4(min(FOREGROUND, vec3(mask)), 1.0f); /* fragColor = vec4(vec3(mask * texCol), 1.0f); */ /* fragColor = vec4(gv.r, gv.g, 0.0f, 1.0f); */ /* fragColor = vec4(ouv.r, ouv.g, 0.0f, 1.0f); */ /* fragColor = vec4(max(col, texCol), 1.0f); */
    }



