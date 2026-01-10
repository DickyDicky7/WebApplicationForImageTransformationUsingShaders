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

    // https://godotshaders.com/shader/very-simple-crt-shader/
//  // https://godotshaders.com/shader/very-simple-crt-shader/
    // https://godotshaders.com/shader/very-simple-crt-shader/
//  // https://godotshaders.com/shader/very-simple-crt-shader/
    // https://godotshaders.com/shader/crt-visual-shader-godot-4-0/
//  // https://godotshaders.com/shader/crt-visual-shader-godot-4-0/
    // https://godotshaders.com/shader/crt-visual-shader-godot-4-0/
//  // https://godotshaders.com/shader/crt-visual-shader-godot-4-0/



    // Add required screen texture uniform
//  // Add required screen texture uniform
    // Add required screen texture uniform
//  // Add required screen texture uniform


    // Display settings
//  // Display settings
    // Display settings
//  // Display settings
    uniform bool  overlay    ; // false
//  uniform bool  overlay    ; // false
    uniform vec2  resolution ; // 640.0, 480.0
//  uniform vec2  resolution ; // 640.0, 480.0
    uniform float brightness ; // 001.4
//  uniform float brightness ; // 001.4

    // Scanline settings
//  // Scanline settings
    // Scanline settings
//  // Scanline settings
    uniform float scanlines_opacity ; // 0.40
//  uniform float scanlines_opacity ; // 0.40
    uniform float scanlines_width   ; // 0.25
//  uniform float scanlines_width   ; // 0.25
    uniform float    grille_opacity ; // 0.30
//  uniform float    grille_opacity ; // 0.30

    // Distortion settings
//  // Distortion settings
    // Distortion settings
//  // Distortion settings
    uniform bool     roll           ; // true
//  uniform bool     roll           ; // true
    uniform float    roll_speed     ; // 08.00
//  uniform float    roll_speed     ; // 08.00
    uniform float    roll_size      ; // 15.00
//  uniform float    roll_size      ; // 15.00
    uniform float    roll_variation ; // 01.80
//  uniform float    roll_variation ; // 01.80
    uniform float distort_intensity ; // 00.05
//  uniform float distort_intensity ; // 00.05
    uniform float        aberration ; // 00.03
//  uniform float        aberration ; // 00.03

    // Noise settings
//  // Noise settings
    // Noise settings
//  // Noise settings
    uniform float        noise_opacity   ; // 0.40
//  uniform float        noise_opacity   ; // 0.40
    //const float        noise_opacity   =    0.40;
//  //const float        noise_opacity   =    0.40;
    uniform float        noise_speed     ; // 5.00
//  uniform float        noise_speed     ; // 5.00
    uniform float static_noise_intensity ; // 0.06
//  uniform float static_noise_intensity ; // 0.06

    // Additional effects
//  // Additional effects
    // Additional effects
//  // Additional effects
    uniform bool  pixelate    ; // true
//  uniform bool  pixelate    ; // true
    uniform bool  discolor    ; // true
//  uniform bool  discolor    ; // true
    uniform float warp_amount ; // 1.0
//  uniform float warp_amount ; // 1.0
    //const float warp_amount =    1.0
//  //const float warp_amount =    1.0
    uniform bool  clip_warp   ; // false
//  uniform bool  clip_warp   ; // false
    //const bool  clip_warp   =    false
//  //const bool  clip_warp   =    false
    uniform float vignette_intensity ; // 0.4
//  uniform float vignette_intensity ; // 0.4
    uniform float vignette_opacity   ; // 0.5
//  uniform float vignette_opacity   ; // 0.5
    //const float vignette_opacity   =    0.5
//  //const float vignette_opacity   =    0.5

    // The rest of the shader code remains exactly the same from here...
//  // The rest of the shader code remains exactly the same from here...
    // The rest of the shader code remains exactly the same from here...
//  // The rest of the shader code remains exactly the same from here...
    // (All the functions and fragment shader code remain unchanged)
//  // (All the functions and fragment shader code remain unchanged)
    // (All the functions and fragment shader code remain unchanged)
//  // (All the functions and fragment shader code remain unchanged)

    // Generate random value
//  // Generate random value
    // Generate random value
//  // Generate random value
    vec2 random(vec2 uv) { uv = vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(269.5, 183.3))); return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123); }
//  vec2 random(vec2 uv) { uv = vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(269.5, 183.3))); return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123); }
    // //  vec2 random(vec2 uv) { uv = vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(269.5, 183.3))); return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123); }
//  // //  vec2 random(vec2 uv) { uv = vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(269.5, 183.3))); return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123); }

    // Generate noise
//  // Generate noise
    // Generate noise
//  // Generate noise
    float noise(vec2 uv) {
//  float noise(vec2 uv) {
    vec2 uv_index =  floor(uv);
//  vec2 uv_index =  floor(uv);
    vec2 uv_fract =  fract(uv);
//  vec2 uv_fract =  fract(uv);
    vec2 blur = smoothstep(0.0, 1.0, uv_fract);
//  vec2 blur = smoothstep(0.0, 1.0, uv_fract);
    
    return mix(
//  return mix(
    mix(
//  mix(
    dot(random(uv_index + vec2(0.0, 0.0)), uv_fract - vec2(0.0, 0.0)),
//  dot(random(uv_index + vec2(0.0, 0.0)), uv_fract - vec2(0.0, 0.0)),
    dot(random(uv_index + vec2(1.0, 0.0)), uv_fract - vec2(1.0, 0.0)),
//  dot(random(uv_index + vec2(1.0, 0.0)), uv_fract - vec2(1.0, 0.0)),
    blur.x
//  blur.x
    ),
//  ),
    mix(
//  mix(
    dot(random(uv_index + vec2(0.0, 1.0)), uv_fract - vec2(0.0, 1.0)),
//  dot(random(uv_index + vec2(0.0, 1.0)), uv_fract - vec2(0.0, 1.0)),
    dot(random(uv_index + vec2(1.0, 1.0)), uv_fract - vec2(1.0, 1.0)),
//  dot(random(uv_index + vec2(1.0, 1.0)), uv_fract - vec2(1.0, 1.0)),
    blur.x
//  blur.x
    ),
//  ),
    blur.y
//  blur.y
    ) * 0.5
//  ) * 0.5
    + 0.5;
//  + 0.5;
    }
//  }

    // Screen warping
//  // Screen warping
    // Screen warping
//  // Screen warping
    vec2 warp(vec2 uv) { vec2 delta = uv - 0.5; float delta2 = dot(delta.xy, delta.xy); float delta4 = delta2 * delta2; return uv + delta * (delta4 * warp_amount); }
//  vec2 warp(vec2 uv) { vec2 delta = uv - 0.5; float delta2 = dot(delta.xy, delta.xy); float delta4 = delta2 * delta2; return uv + delta * (delta4 * warp_amount); }
    // //  vec2 warp(vec2 uv) { vec2 delta = uv - 0.5; float delta2 = dot(delta.xy, delta.xy); float delta4 = delta2 * delta2; return uv + delta * (delta4 * warp_amount); }
//  // //  vec2 warp(vec2 uv) { vec2 delta = uv - 0.5; float delta2 = dot(delta.xy, delta.xy); float delta4 = delta2 * delta2; return uv + delta * (delta4 * warp_amount); }

    // Screen border
//  // Screen border
    // Screen border
//  // Screen border
    float border(vec2 uv) { float radius = min(warp_amount, 0.08); radius = max(min(min(abs(radius * 2.0), abs(1.0)), abs(1.0)), 1e-5); vec2 abs_uv = abs(uv * 2.0 - 1.0) - vec2(1.0, 1.0) + radius; float dist = length(max(vec2(0.0), abs_uv)) / radius; return clamp(1.0 - smoothstep(0.96, 1.0, dist), 0.0, 1.0); }
//  float border(vec2 uv) { float radius = min(warp_amount, 0.08); radius = max(min(min(abs(radius * 2.0), abs(1.0)), abs(1.0)), 1e-5); vec2 abs_uv = abs(uv * 2.0 - 1.0) - vec2(1.0, 1.0) + radius; float dist = length(max(vec2(0.0), abs_uv)) / radius; return clamp(1.0 - smoothstep(0.96, 1.0, dist), 0.0, 1.0); }
    // //  float border(vec2 uv) { float radius = min(warp_amount, 0.08); radius = max(min(min(abs(radius * 2.0), abs(1.0)), abs(1.0)), 1e-5); vec2 abs_uv = abs(uv * 2.0 - 1.0) - vec2(1.0, 1.0) + radius; float dist = length(max(vec2(0.0), abs_uv)) / radius; return clamp(1.0 - smoothstep(0.96, 1.0, dist), 0.0, 1.0); }
//  // //  float border(vec2 uv) { float radius = min(warp_amount, 0.08); radius = max(min(min(abs(radius * 2.0), abs(1.0)), abs(1.0)), 1e-5); vec2 abs_uv = abs(uv * 2.0 - 1.0) - vec2(1.0, 1.0) + radius; float dist = length(max(vec2(0.0), abs_uv)) / radius; return clamp(1.0 - smoothstep(0.96, 1.0, dist), 0.0, 1.0); }

    // Vignette effect
//  // Vignette effect
    // Vignette effect
//  // Vignette effect
    float vignette(vec2 uv) { uv *= 1.0 - uv.xy; float vig = uv.x * uv.y * 15.0; return pow(vig, vignette_intensity * vignette_opacity); }
//  float vignette(vec2 uv) { uv *= 1.0 - uv.xy; float vig = uv.x * uv.y * 15.0; return pow(vig, vignette_intensity * vignette_opacity); }
    // //  float vignette(vec2 uv) { uv *= 1.0 - uv.xy; float vig = uv.x * uv.y * 15.0; return pow(vig, vignette_intensity * vignette_opacity); }
//  // //  float vignette(vec2 uv) { uv *= 1.0 - uv.xy; float vig = uv.x * uv.y * 15.0; return pow(vig, vignette_intensity * vignette_opacity); }

    void main() {
    // Get base UV and handle overlay
//  // Get base UV and handle overlay
    // Get base UV and handle overlay
//  // Get base UV and handle overlay
    vec2 uv = overlay ? warp(vTexCoord) : warp(vTexCoord); vec2 text_uv = uv;
//  vec2 uv = overlay ? warp(vTexCoord) : warp(vTexCoord); vec2 text_uv = uv;
    // //  vec2 uv = overlay ? warp(vTexCoord) : warp(vTexCoord); vec2 text_uv = uv;
//  // //  vec2 uv = overlay ? warp(vTexCoord) : warp(vTexCoord); vec2 text_uv = uv;
    
    // Handle pixelation
//  // Handle pixelation
    // Handle pixelation
//  // Handle pixelation
    if (pixelate) { text_uv = ceil(uv * resolution) / resolution; }
//  if (pixelate) { text_uv = ceil(uv * resolution) / resolution; }
    // //  if (pixelate) { text_uv = ceil(uv * resolution) / resolution; }
//  // //  if (pixelate) { text_uv = ceil(uv * resolution) / resolution; }
    
    // Calculate roll effect
//  // Calculate roll effect
    // Calculate roll effect
//  // Calculate roll effect
    float roll_line = 0.0; vec2 roll_uv = vec2(0.0);
//  float roll_line = 0.0; vec2 roll_uv = vec2(0.0);
    // //  float roll_line = 0.0; vec2 roll_uv = vec2(0.0);
//  // //  float roll_line = 0.0; vec2 roll_uv = vec2(0.0);
    
    if (roll || noise_opacity > 0.0) { float remapTime = roll ? time : 0.0; roll_line = smoothstep(0.3, 0.9, sin(uv.y * roll_size - (remapTime * roll_speed))); roll_line *= roll_line * smoothstep(0.3, 0.9, sin(uv.y * roll_size * roll_variation - (remapTime * roll_speed * roll_variation))); roll_uv = vec2(roll_line * distort_intensity * (1.0 - vTexCoord.x), 0.0); }
//  if (roll || noise_opacity > 0.0) { float remapTime = roll ? time : 0.0; roll_line = smoothstep(0.3, 0.9, sin(uv.y * roll_size - (remapTime * roll_speed))); roll_line *= roll_line * smoothstep(0.3, 0.9, sin(uv.y * roll_size * roll_variation - (remapTime * roll_speed * roll_variation))); roll_uv = vec2(roll_line * distort_intensity * (1.0 - vTexCoord.x), 0.0); }
    // //  if (roll || noise_opacity > 0.0) { float remapTime = roll ? time : 0.0; roll_line = smoothstep(0.3, 0.9, sin(uv.y * roll_size - (remapTime * roll_speed))); roll_line *= roll_line * smoothstep(0.3, 0.9, sin(uv.y * roll_size * roll_variation - (remapTime * roll_speed * roll_variation))); roll_uv = vec2(roll_line * distort_intensity * (1.0 - vTexCoord.x), 0.0); }
//  // //  if (roll || noise_opacity > 0.0) { float remapTime = roll ? time : 0.0; roll_line = smoothstep(0.3, 0.9, sin(uv.y * roll_size - (remapTime * roll_speed))); roll_line *= roll_line * smoothstep(0.3, 0.9, sin(uv.y * roll_size * roll_variation - (remapTime * roll_speed * roll_variation))); roll_uv = vec2(roll_line * distort_intensity * (1.0 - vTexCoord.x), 0.0); }
    
    // Sample texture with chromatic aberration
//  // Sample texture with chromatic aberration
    // Sample texture with chromatic aberration
//  // Sample texture with chromatic aberration
    vec4    text;
//  vec4    text;
    if (roll) {
//  if (roll) {
    text.r = texture(tex0, text_uv + roll_uv * 0.8 + vec2(aberration, 0.0) * 0.1).r;
//  text.r = texture(tex0, text_uv + roll_uv * 0.8 + vec2(aberration, 0.0) * 0.1).r;
    text.g = texture(tex0, text_uv + roll_uv * 1.2 - vec2(aberration, 0.0) * 0.1).g;
//  text.g = texture(tex0, text_uv + roll_uv * 1.2 - vec2(aberration, 0.0) * 0.1).g;
    text.b = texture(tex0, text_uv + roll_uv                                    ).b;
//  text.b = texture(tex0, text_uv + roll_uv                                    ).b;
    } else {
//  } else {
    text.r = texture(tex0, text_uv + vec2(aberration, 0.0) * 0.1).r;
//  text.r = texture(tex0, text_uv + vec2(aberration, 0.0) * 0.1).r;
    text.g = texture(tex0, text_uv - vec2(aberration, 0.0) * 0.1).g;
//  text.g = texture(tex0, text_uv - vec2(aberration, 0.0) * 0.1).g;
    text.b = texture(tex0, text_uv                              ).b;
//  text.b = texture(tex0, text_uv                              ).b;
    }
//  }
    text.a = 1.0;
//  text.a = 1.0;
    
    // Apply CRT grille
//  // Apply CRT grille
    // Apply CRT grille
//  // Apply CRT grille
    if (grille_opacity > 0.0) {
//  if (grille_opacity > 0.0) {
    float gr = smoothstep(0.85, 0.95, abs(sin(       uv.x * (resolution.x * 3.14159265))));
//  float gr = smoothstep(0.85, 0.95, abs(sin(       uv.x * (resolution.x * 3.14159265))));
    float gg = smoothstep(0.85, 0.95, abs(sin(1.05 + uv.x * (resolution.x * 3.14159265))));
//  float gg = smoothstep(0.85, 0.95, abs(sin(1.05 + uv.x * (resolution.x * 3.14159265))));
    float gb = smoothstep(0.85, 0.95, abs(sin(2.10 + uv.x * (resolution.x * 3.14159265))));
//  float gb = smoothstep(0.85, 0.95, abs(sin(2.10 + uv.x * (resolution.x * 3.14159265))));
        
    text.r = mix(text.r, text.r * gr, grille_opacity);
//  text.r = mix(text.r, text.r * gr, grille_opacity);
    text.g = mix(text.g, text.g * gg, grille_opacity);
//  text.g = mix(text.g, text.g * gg, grille_opacity);
    text.b = mix(text.b, text.b * gb, grille_opacity);
//  text.b = mix(text.b, text.b * gb, grille_opacity);
    }
//  }
    
    // Apply brightness
//  // Apply brightness
    // Apply brightness
//  // Apply brightness
    text.rgb = clamp(text.rgb * brightness, 0.0, 1.0);
//  text.rgb = clamp(text.rgb * brightness, 0.0, 1.0);
    // //  text.rgb = clamp(text.rgb * brightness, 0.0, 1.0);
//  // //  text.rgb = clamp(text.rgb * brightness, 0.0, 1.0);
    
    // Apply scanlines
//  // Apply scanlines
    // Apply scanlines
//  // Apply scanlines
    if (scanlines_opacity > 0.0) { float scan = smoothstep(scanlines_width, scanlines_width + 0.5, abs(sin(uv.y * (resolution.y * 3.14159265)))); text.rgb = mix(text.rgb, text.rgb * vec3(scan), scanlines_opacity); }
//  if (scanlines_opacity > 0.0) { float scan = smoothstep(scanlines_width, scanlines_width + 0.5, abs(sin(uv.y * (resolution.y * 3.14159265)))); text.rgb = mix(text.rgb, text.rgb * vec3(scan), scanlines_opacity); }
    // //  if (scanlines_opacity > 0.0) { float scan = smoothstep(scanlines_width, scanlines_width + 0.5, abs(sin(uv.y * (resolution.y * 3.14159265)))); text.rgb = mix(text.rgb, text.rgb * vec3(scan), scanlines_opacity); }
//  // //  if (scanlines_opacity > 0.0) { float scan = smoothstep(scanlines_width, scanlines_width + 0.5, abs(sin(uv.y * (resolution.y * 3.14159265)))); text.rgb = mix(text.rgb, text.rgb * vec3(scan), scanlines_opacity); }
    
    // Apply noise
//  // Apply noise
    // Apply noise
//  // Apply noise
    if (noise_opacity > 0.0) { float n = smoothstep(0.4, 0.5, noise(uv * vec2(2.0, 200.0) + vec2(10.0, time * noise_speed))); float nl = n * roll_line * clamp(random((ceil(uv * resolution) / resolution) + vec2(time * 0.8, 0.0)).x + 0.8, 0.0, 1.0); text.rgb = clamp(mix(text.rgb, text.rgb + nl, noise_opacity), vec3(0.0), vec3(1.0)); }
//  if (noise_opacity > 0.0) { float n = smoothstep(0.4, 0.5, noise(uv * vec2(2.0, 200.0) + vec2(10.0, time * noise_speed))); float nl = n * roll_line * clamp(random((ceil(uv * resolution) / resolution) + vec2(time * 0.8, 0.0)).x + 0.8, 0.0, 1.0); text.rgb = clamp(mix(text.rgb, text.rgb + nl, noise_opacity), vec3(0.0), vec3(1.0)); }
    // //  if (noise_opacity > 0.0) { float n = smoothstep(0.4, 0.5, noise(uv * vec2(2.0, 200.0) + vec2(10.0, time * noise_speed))); float nl = n * roll_line * clamp(random((ceil(uv * resolution) / resolution) + vec2(time * 0.8, 0.0)).x + 0.8, 0.0, 1.0); text.rgb = clamp(mix(text.rgb, text.rgb + nl, noise_opacity), vec3(0.0), vec3(1.0)); }
//  // //  if (noise_opacity > 0.0) { float n = smoothstep(0.4, 0.5, noise(uv * vec2(2.0, 200.0) + vec2(10.0, time * noise_speed))); float nl = n * roll_line * clamp(random((ceil(uv * resolution) / resolution) + vec2(time * 0.8, 0.0)).x + 0.8, 0.0, 1.0); text.rgb = clamp(mix(text.rgb, text.rgb + nl, noise_opacity), vec3(0.0), vec3(1.0)); }
    
    // Apply static
//  // Apply static
    // Apply static
//  // Apply static
    if (static_noise_intensity > 0.0) { text.rgb += clamp(random((ceil(uv * resolution) / resolution) + fract(time)).x, 0.0, 1.0) * static_noise_intensity; }
//  if (static_noise_intensity > 0.0) { text.rgb += clamp(random((ceil(uv * resolution) / resolution) + fract(time)).x, 0.0, 1.0) * static_noise_intensity; }
    // //  if (static_noise_intensity > 0.0) { text.rgb += clamp(random((ceil(uv * resolution) / resolution) + fract(time)).x, 0.0, 1.0) * static_noise_intensity; }
//  // //  if (static_noise_intensity > 0.0) { text.rgb += clamp(random((ceil(uv * resolution) / resolution) + fract(time)).x, 0.0, 1.0) * static_noise_intensity; }
    
    // Apply border and vignette
//  // Apply border and vignette
    // Apply border and vignette
//  // Apply border and vignette
    text.rgb *= border  (uv);
//  text.rgb *= border  (uv);
    // //  text.rgb *= border  (uv);
//  // //  text.rgb *= border  (uv);
    text.rgb *= vignette(uv);
//  text.rgb *= vignette(uv);
    // //  text.rgb *= vignette(uv);
//  // //  text.rgb *= vignette(uv);
    
    // Handle clip warp
//  // Handle clip warp
    // Handle clip warp
//  // Handle clip warp
    if (clip_warp) { text.a = border(uv); }
//  if (clip_warp) { text.a = border(uv); }
    // //  if (clip_warp) { text.a = border(uv); }
//  // //  if (clip_warp) { text.a = border(uv); }
    
    // Apply VHS discoloration
//  // Apply VHS discoloration
    // Apply VHS discoloration
//  // Apply VHS discoloration
    if (discolor) { vec3 greyscale = vec3(dot(text.rgb, vec3(0.333))); text.rgb = mix(text.rgb, greyscale, 0.5); float midpoint = pow(0.5, 2.2); text.rgb = (text.rgb - vec3(midpoint)) * 1.2 + midpoint; } fragColor = text;
//  if (discolor) { vec3 greyscale = vec3(dot(text.rgb, vec3(0.333))); text.rgb = mix(text.rgb, greyscale, 0.5); float midpoint = pow(0.5, 2.2); text.rgb = (text.rgb - vec3(midpoint)) * 1.2 + midpoint; } fragColor = text;
    // //  if (discolor) { vec3 greyscale = vec3(dot(text.rgb, vec3(0.333))); text.rgb = mix(text.rgb, greyscale, 0.5); float midpoint = pow(0.5, 2.2); text.rgb = (text.rgb - vec3(midpoint)) * 1.2 + midpoint; } fragColor = text;
//  // //  if (discolor) { vec3 greyscale = vec3(dot(text.rgb, vec3(0.333))); text.rgb = mix(text.rgb, greyscale, 0.5); float midpoint = pow(0.5, 2.2); text.rgb = (text.rgb - vec3(midpoint)) * 1.2 + midpoint; } fragColor = text;
    }
