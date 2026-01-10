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


    uniform float     noise_scale; // 4.0
//  uniform float     noise_scale; // 4.0
    uniform float fog_density    ; // 0.5
//  uniform float fog_density    ; // 0.5
    uniform float fog_speed      ; // 0.3
//  uniform float fog_speed      ; // 0.3
    uniform float fog_opacity    ; // 0.5
//  uniform float fog_opacity    ; // 0.5

    // Classic Perlin noise function
//  // Classic Perlin noise function
    // Classic Perlin noise function
//  // Classic Perlin noise function
    float noise(vec2 p) {
//  float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898
//  return fract(sin(dot(p, vec2(12.9898
    ,      78.2330))) * 43758.5453);
//  ,      78.2330))) * 43758.5453);
    }
//  }

    void main() {
    vec2 uv = vTexCoord * noise_scale  ;
//  vec2 uv = vTexCoord * noise_scale  ;

    // Animate the fog with time
//  // Animate the fog with time
    // Animate the fog with time
//  // Animate the fog with time
    uv += vec2(time * fog_speed * 0.10
//  uv += vec2(time * fog_speed * 0.10
    ,      time * fog_speed * 0.05);
//  ,      time * fog_speed * 0.05);

    // Sample the noise
//  // Sample the noise
    // Sample the noise
//  // Sample the noise
    float n = noise(uv);
//  float n = noise(uv);

    // Apply fog density and opacity
//  // Apply fog density and opacity
    // Apply fog density and opacity
//  // Apply fog density and opacity
    float fog  = smoothstep(1.0 - fog_density, 1.0, n);
//  float fog  = smoothstep(1.0 - fog_density, 1.0, n);
    fog *=                  fog_opacity         ;
//  fog *=                  fog_opacity         ;

    // Output color with transparency
//  // Output color with transparency
    // Output color with transparency
//  // Output color with transparency
    fragColor  = vec4(vec3(0.5), fog) * texture(tex0, vTexCoord);
//  fragColor  = vec4(vec3(0.5), fog) * texture(tex0, vTexCoord);
    // Gray fog (0.5 for gray)
//  // Gray fog (0.5 for gray)
    // Gray fog (0.5 for gray)
//  // Gray fog (0.5 for gray)
    }


    // https://godotshaders.com/shader/vhs-2/
//  // https://godotshaders.com/shader/vhs-2/
    // https://godotshaders.com/shader/vhs-2/
//  // https://godotshaders.com/shader/vhs-2/
    // https://godotshaders.com/shader/vhs-2/
//  // https://godotshaders.com/shader/vhs-2/
