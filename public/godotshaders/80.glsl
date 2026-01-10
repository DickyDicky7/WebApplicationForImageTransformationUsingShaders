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

    // const float strength = 1.0;
//  // const float strength = 1.0;
    // const float    speed = 1.0;
//  // const float    speed = 1.0;
    // const vec2 disp = vec2(1.0, 1.0);
//  // const vec2 disp = vec2(1.0, 1.0);

    uniform float strength ; // 1.0
//  uniform float strength ; // 1.0
    uniform float    speed ; // 1.0
//  uniform float    speed ; // 1.0
    uniform vec2  disp     ; // 1.0, 1.0
//  uniform vec2  disp     ; // 1.0, 1.0


    vec2 GetGradient(vec2 intPos, float t) {
//  vec2 GetGradient(vec2 intPos, float t) {
    
    // Uncomment for calculated rand
//  // Uncomment for calculated rand
    // @@@@@@@@@ @@@ @@@@@@@@@@ @@@@
//  // @@@@@@@@@ @@@ @@@@@@@@@@ @@@@
    //float rand = fract(sin(dot(intPos, vec2(12.9898, 78.233))) * 43758.5453);
//  //float rand = fract(sin(dot(intPos, vec2(12.9898, 78.233))) * 43758.5453);
    
    // Texture-based rand (a bit faster on my GPU)
//  // Texture-based rand (a bit faster on my GPU)
    // @@@@@@@@@@@@@ @@@@ @@ @@@ @@@@@@ @@ @@ @@@@
//  // @@@@@@@@@@@@@ @@@@ @@ @@@ @@@@@@ @@ @@ @@@@
    float rand = texture(tex0, intPos / 64.0).r;
//  float rand = texture(tex0, intPos / 64.0).r;
    
    // Rotate gradient: random starting rotation, random rotation rate
//  // Rotate gradient: random starting rotation, random rotation rate
    // @@@@@@ @@@@@@@@@ @@@@@@ @@@@@@@@ @@@@@@@@@ @@@@@@ @@@@@@@@ @@@@
//  // @@@@@@ @@@@@@@@@ @@@@@@ @@@@@@@@ @@@@@@@@@ @@@@@@ @@@@@@@@ @@@@
    float angle = 6.283185 * rand
//  float angle = 6.283185 * rand
    + 4.00 * t * rand;
//  + 4.00 * t * rand;
    return vec2(cos(angle), sin(angle));
//  return vec2(cos(angle), sin(angle));
    }
//  }


    float Pseudo3dNoise(vec3 pos) {
//  float Pseudo3dNoise(vec3 pos) {
    vec2 i = floor(pos.xy    );
//  vec2 i = floor(pos.xy    );
    vec2 f =       pos.xy - i ;
//  vec2 f =       pos.xy - i ;
    vec2  blend    = f * f * (3.0 - 2.0 * f);
//  vec2  blend    = f * f * (3.0 - 2.0 * f);
    float noiseVal =
//  float noiseVal =
    mix(
//  mix(
    mix(
//  mix(
    dot(GetGradient(i + vec2(0, 0), pos.z), f - vec2(0, 0)),
//  dot(GetGradient(i + vec2(0, 0), pos.z), f - vec2(0, 0)),
    dot(GetGradient(i + vec2(1, 0), pos.z), f - vec2(1, 0)),
//  dot(GetGradient(i + vec2(1, 0), pos.z), f - vec2(1, 0)),
    blend.x),
//  blend.x),
    mix(
//  mix(
    dot(GetGradient(i + vec2(0, 1), pos.z), f - vec2(0, 1)),
//  dot(GetGradient(i + vec2(0, 1), pos.z), f - vec2(0, 1)),
    dot(GetGradient(i + vec2(1, 1), pos.z), f - vec2(1, 1)),
//  dot(GetGradient(i + vec2(1, 1), pos.z), f - vec2(1, 1)),
    blend.x),
//  blend.x),
    blend.y
//  blend.y
    );
//  );
    return noiseVal / 0.7; // normalize to about [-1..1]
//  return noiseVal / 0.7; // normalize to about [-1..1]
    }
//  }


    void main() {
    float ratio    = canvasSize.x
//  float ratio    = canvasSize.x
    / canvasSize.y;
//  / canvasSize.y;
    vec2  noise_uv = vTexCoord / vec2(ratio, 1.0);
//  vec2  noise_uv = vTexCoord / vec2(ratio, 1.0);
    float noiseVal = 0.5 + 0.5 * Pseudo3dNoise(vec3(noise_uv * 10.0 * strength, time * speed));
//  float noiseVal = 0.5 + 0.5 * Pseudo3dNoise(vec3(noise_uv * 10.0 * strength, time * speed));
    
    vec2  uv          = vTexCoord;
//  vec2  uv          = vTexCoord;
    float noiseWeight = 0.05     ;
//  float noiseWeight = 0.05     ;
    uv.x += noiseVal * noiseWeight * disp.x;
//  uv.x += noiseVal * noiseWeight * disp.x;
    uv.y += noiseVal * noiseWeight * disp.y;
//  uv.y += noiseVal * noiseWeight * disp.y;
    vec3 col = texture(tex0, uv).rgb;
//  vec3 col = texture(tex0, uv).rgb;
    
    fragColor.rgb = vec3(col);
//  fragColor.rgb = vec3(col);
    
    }


    // https://godotshaders.com/shader/distort-filter-perlinnoise/
//  // https://godotshaders.com/shader/distort-filter-perlinnoise/
