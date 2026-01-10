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

    // const float  chaos = 4.0;
//  // const float  chaos = 4.0;
    // const float radius = 2.0;
//  // const float radius = 2.0;
    // const float attenuation = 8.0;
//  // const float attenuation = 8.0;

    vec2 amount_r;
//  vec2 amount_r;
    vec2 amount_g;
//  vec2 amount_g;
    vec2 amount_b;
//  vec2 amount_b;

    uniform float  chaos      ; // 4.0
//  uniform float  chaos      ; // 4.0
    uniform float radius      ; // 2.0
//  uniform float radius      ; // 2.0
    uniform float attenuation ; // 8.0
//  uniform float attenuation ; // 8.0

    // const vec2 amount_r; // 1.0, 1.0
//  // const vec2 amount_r; // 1.0, 1.0
    // const vec2 amount_g; // 1.0, 1.0
//  // const vec2 amount_g; // 1.0, 1.0
    // const vec2 amount_b; // 1.0, 1.0
//  // const vec2 amount_b; // 1.0, 1.0

    float rand(vec2 co){
//  float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453) - .5;
//  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453) - .5;
    }
//  }

    void vertex() {
//  void vertex() {
    vec2 shifted_uv = (vTexCoord * 2.) - 1.;
//  vec2 shifted_uv = (vTexCoord * 2.) - 1.;
    amount_r = normalize(
//  amount_r = normalize(
    vec2(rand(time * 1.30 * shifted_uv),
//  vec2(rand(time * 1.30 * shifted_uv),
    rand(time * 1.64 * shifted_uv)));
//  rand(time * 1.64 * shifted_uv)));
    amount_g = normalize(
//  amount_g = normalize(
    vec2(rand(time * 1.50 * shifted_uv),
//  vec2(rand(time * 1.50 * shifted_uv),
    rand(time * 1.70 * shifted_uv)));
//  rand(time * 1.70 * shifted_uv)));
    amount_b = normalize(
//  amount_b = normalize(
    vec2(rand(time * 1.17 * shifted_uv),
//  vec2(rand(time * 1.17 * shifted_uv),
    rand(time * 1.23 * shifted_uv)));
//  rand(time * 1.23 * shifted_uv)));
    }
//  }

    void main() {
    
    vec2 shifted_uv = (vTexCoord * 2.) - 1.;
//  vec2 shifted_uv = (vTexCoord * 2.) - 1.;
    amount_r = normalize(
//  amount_r = normalize(
    vec2(rand(time * 1.30 * shifted_uv),
//  vec2(rand(time * 1.30 * shifted_uv),
    rand(time * 1.64 * shifted_uv)));
//  rand(time * 1.64 * shifted_uv)));
    amount_g = normalize(
//  amount_g = normalize(
    vec2(rand(time * 1.50 * shifted_uv),
//  vec2(rand(time * 1.50 * shifted_uv),
    rand(time * 1.70 * shifted_uv)));
//  rand(time * 1.70 * shifted_uv)));
    amount_b = normalize(
//  amount_b = normalize(
    vec2(rand(time * 1.17 * shifted_uv),
//  vec2(rand(time * 1.17 * shifted_uv),
    rand(time * 1.23 * shifted_uv)));
//  rand(time * 1.23 * shifted_uv)));

    vec2 chaos_v = vec2(chaos, -chaos) * (1.0 / canvasSize);
//  vec2 chaos_v = vec2(chaos, -chaos) * (1.0 / canvasSize);
    
    float dist = length((vTexCoord - vec2(0.5)) * 2.);
//  float dist = length((vTexCoord - vec2(0.5)) * 2.);
    float  att =  clamp(      dist / radius, 0. , 1.);
//  float  att =  clamp(      dist / radius, 0. , 1.);
    
    chaos_v *= 1. - pow(att, attenuation);
//  chaos_v *= 1. - pow(att, attenuation);
    
    fragColor = vec4(
//  fragColor = vec4(
    texture(tex0, vTexCoord + chaos_v * amount_r).r,
//  texture(tex0, vTexCoord + chaos_v * amount_r).r,
    texture(tex0, vTexCoord + chaos_v * amount_g).g,
//  texture(tex0, vTexCoord + chaos_v * amount_g).g,
    texture(tex0, vTexCoord + chaos_v * amount_b).b,
//  texture(tex0, vTexCoord + chaos_v * amount_b).b,
    1.);
//  1.);
    }

    // https://godotshaders.com/shader/chromatic-chaos-distortion-godot4/
//  // https://godotshaders.com/shader/chromatic-chaos-distortion-godot4/

    //shader by CasualGarageCoder, updated to Godot 4
//  //shader by CasualGarageCoder, updated to Godot 4
    //shader by CasualGarageCoder, updated to Godot 4
//  //shader by CasualGarageCoder, updated to Godot 4


