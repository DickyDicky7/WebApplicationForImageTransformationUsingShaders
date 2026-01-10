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

    // https://www.shadertoy.com/view/l3dcD2
//  // https://www.shadertoy.com/view/l3dcD2

    // Simple Perlin Noise
//  // Simple Perlin Noise
    // Simple Perlin Noise
//  // Simple Perlin Noise
    vec2 n22(vec2 p) { vec3 a = fract(p.xyx * vec3(123.34f, 234.34f, 345.65f)); a += dot(a, a + 34.45f); return fract(vec2(a.x * a.y, a.y * a.z)); }
//  vec2 n22(vec2 p) { vec3 a = fract(p.xyx * vec3(123.34f, 234.34f, 345.65f)); a += dot(a, a + 34.45f); return fract(vec2(a.x * a.y, a.y * a.z)); }

    vec2 get_gradient(vec2 pos) { float twoPi = 6.283185f; float angle = n22(pos).x * twoPi; return vec2(cos(angle), sin(angle)); }
//  vec2 get_gradient(vec2 pos) { float twoPi = 6.283185f; float angle = n22(pos).x * twoPi; return vec2(cos(angle), sin(angle)); }

    float perlin_noise(vec2 uv, float cells_count) {
//  float perlin_noise(vec2 uv, float cells_count) {
    vec2       pos_in_grid = uv * cells_count  ;
//  vec2       pos_in_grid = uv * cells_count  ;
    vec2  cell_pos_in_grid = floor(pos_in_grid);
//  vec2  cell_pos_in_grid = floor(pos_in_grid);
    vec2 local_pos_in_cell =      (pos_in_grid - cell_pos_in_grid);
//  vec2 local_pos_in_cell =      (pos_in_grid - cell_pos_in_grid);
    vec2 blend =
//  vec2 blend =
    local_pos_in_cell *
//  local_pos_in_cell *
    local_pos_in_cell * (3.0f - 2.0f *
//  local_pos_in_cell * (3.0f - 2.0f *
    local_pos_in_cell                );
//  local_pos_in_cell                );

    vec2 lt = cell_pos_in_grid + vec2(0, 1);
//  vec2 lt = cell_pos_in_grid + vec2(0, 1);
    vec2 rt = cell_pos_in_grid + vec2(1, 1);
//  vec2 rt = cell_pos_in_grid + vec2(1, 1);
    vec2 lb = cell_pos_in_grid + vec2(0, 0);
//  vec2 lb = cell_pos_in_grid + vec2(0, 0);
    vec2 rb = cell_pos_in_grid + vec2(1, 0);
//  vec2 rb = cell_pos_in_grid + vec2(1, 0);

    float ltd = dot(pos_in_grid - lt, get_gradient(lt));
//  float ltd = dot(pos_in_grid - lt, get_gradient(lt));
    float rtd = dot(pos_in_grid - rt, get_gradient(rt));
//  float rtd = dot(pos_in_grid - rt, get_gradient(rt));
    float lbd = dot(pos_in_grid - lb, get_gradient(lb));
//  float lbd = dot(pos_in_grid - lb, get_gradient(lb));
    float rbd = dot(pos_in_grid - rb, get_gradient(rb));
//  float rbd = dot(pos_in_grid - rb, get_gradient(rb));

    float noise_value = mix(mix(lbd, rbd, blend.x)
//  float noise_value = mix(mix(lbd, rbd, blend.x)
    ,     mix(ltd, rtd, blend.x)
//  ,     mix(ltd, rtd, blend.x)
    ,                   blend.y);
//  ,                   blend.y);

    return (0.5f + 0.5f * (noise_value / 0.7f));
//  return (0.5f + 0.5f * (noise_value / 0.7f));
    }
//  }

    void main() {
    // Parametri
//  // Parametri
    // Parametri
//  // Parametri
    float remapTime = time;
//  float remapTime = time;
    vec2  uv        = (vTexCoord) + 1.f; // Coordinate UV normali
//  vec2  uv        = (vTexCoord) + 1.f; // Coordinate UV normali
    float waveAmplitude = 0.05f;         // Ampiezzaaa delle onde
//  float waveAmplitude = 0.05f;         // Ampiezzaaa delle onde
    float waveFrequency = 20.0f;         // Frequenzaa delle onde
//  float waveFrequency = 20.0f;         // Frequenzaa delle onde

    // Distorsione per l'effetto onde
//  // Distorsione per l'effetto onde
    // Distorsione per l'effetto onde
//  // Distorsione per l'effetto onde
    vec2 offset = vec2(perlin_noise(uv * waveFrequency + remapTime * 1.f, 1.f)
//  vec2 offset = vec2(perlin_noise(uv * waveFrequency + remapTime * 1.f, 1.f)
    ,      perlin_noise(uv * waveFrequency + remapTime * 1.f, 1.f)
//  ,      perlin_noise(uv * waveFrequency + remapTime * 1.f, 1.f)
    )                * waveAmplitude ;
//  )                * waveAmplitude ;
    vec2 distortedUv = uv + offset;
//  vec2 distortedUv = uv + offset;

    // Carica la texture
//  // Carica la texture
    // Carica la texture
//  // Carica la texture
    vec3 color  = texture(tex0, distortedUv).rgb; // Texture dell'acqua
//  vec3 color  = texture(tex0, distortedUv).rgb; // Texture dell'acqua
    color *=
//  color *=
    uv.x;
//  uv.x;

    fragColor = vec4(color, 1.0f);
//  fragColor = vec4(color, 1.0f);
    }








