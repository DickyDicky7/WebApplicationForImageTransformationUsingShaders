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

    // https://godotshaders.com/shader/multilayer-snowfall-shader/
//  // https://godotshaders.com/shader/multilayer-snowfall-shader/



    // Snow appearance parameters
//  // Snow appearance parameters
    // Snow appearance parameters
//  // Snow appearance parameters
    // Snowflake spread
//  // Snowflake spread
    // Snowflake spread
//  // Snowflake spread
    uniform float spread ; // 0.5
//  uniform float spread ; // 0.5
    //const float spread =    0.5;
//  //const float spread =    0.5;
    // Snowflake size
//  // Snowflake size
    // Snowflake size
//  // Snowflake size
    uniform float size ; // 0.5
//  uniform float size ; // 0.5
    //const float size =    0.5;
//  //const float size =    0.5;
    // Snow color
//  // Snow color
    // Snow color
//  // Snow color
    uniform vec4 snow_color ; //   1.0, 1.0, 1.0, 1.0
//  uniform vec4 snow_color ; //   1.0, 1.0, 1.0, 1.0
    //const vec4 snow_color = vec4(1.0, 1.0, 1.0, 1.0);
//  //const vec4 snow_color = vec4(1.0, 1.0, 1.0, 1.0);
    // Intensity of the snow transparency
//  // Intensity of the snow transparency
    // Intensity of the snow transparency
//  // Intensity of the snow transparency
    uniform float snow_transparency ; // 0.2
//  uniform float snow_transparency ; // 0.2
    //const float snow_transparency =    0.2;
//  //const float snow_transparency =    0.2;

    // Snow movement parameters
//  // Snow movement parameters
    // Snow movement parameters
//  // Snow movement parameters
    // Fall speed
//  // Fall speed
    // Fall speed
//  // Fall speed
    uniform float speed ; // 0.5
//  uniform float speed ; // 0.5
    //const float speed =    0.5;
//  //const float speed =    0.5;
    // Wind direction and strength
//  // Wind direction and strength
    // Wind direction and strength
//  // Wind direction and strength
    uniform float wind ; // 0.0
//  uniform float wind ; // 0.0
    //const float wind =    0.0;
//  //const float wind =    0.0;
    // Depth layers
//  // Depth layers
    // Depth layers
//  // Depth layers
    uniform int num_of_layers ; // 40
//  uniform int num_of_layers ; // 40
    //const int num_of_layers =    40;
//  //const int num_of_layers =    40;

    // Constants for noise generation
//  // Constants for noise generation
    // Constants for noise generation
//  // Constants for noise generation
    const mat3 NOISE_MATRIX = mat3(
//  const mat3 NOISE_MATRIX = mat3(
    vec3(13.323122, 23.511200, 21.711230),
//  vec3(13.323122, 23.511200, 21.711230),
    vec3(21.121200, 28.731200, 11.931200),
//  vec3(21.121200, 28.731200, 11.931200),
    vec3(21.811200, 14.721200, 61.393400)
//  vec3(21.811200, 14.721200, 61.393400)
    );
//  );

    // Helper function to generate snowflake pattern
//  // Helper function to generate snowflake pattern
    // Helper function to generate snowflake pattern
//  // Helper function to generate snowflake pattern
    vec3 generate_snowflake(vec2 coord, float layer_index, float time, float wind_strength) {
//  vec3 generate_snowflake(vec2 coord, float layer_index, float time, float wind_strength) {
    // Scale coordinates based on layer depth
//  // Scale coordinates based on layer depth
    // //  // Scale coordinates based on layer depth
//  // //  // Scale coordinates based on layer depth
    float layer_scale = 1.0 + layer_index * 0.5 / (max(size, 0.01) * 2.0); vec2 scaled_coord = coord * layer_scale;
//  float layer_scale = 1.0 + layer_index * 0.5 / (max(size, 0.01) * 2.0); vec2 scaled_coord = coord * layer_scale;
    // //  float layer_scale = 1.0 + layer_index * 0.5 / (max(size, 0.01) * 2.0); vec2 scaled_coord = coord * layer_scale;
//  // //  float layer_scale = 1.0 + layer_index * 0.5 / (max(size, 0.01) * 2.0); vec2 scaled_coord = coord * layer_scale;

    // Apply movement (falling + wind)
//  // Apply movement (falling + wind)
    // //  // Apply movement (falling + wind)
//  // //  // Apply movement (falling + wind)
    // Reverse the wind direction by negating wind_strength
//  // Reverse the wind direction by negating wind_strength
    // //  // Reverse the wind direction by negating wind_strength
//  // //  // Reverse the wind direction by negating wind_strength
    vec2 movement = vec2(scaled_coord.y * (spread * mod(layer_index * 7.238917, 1.0) - spread * 0.5) + (-wind_strength) * speed * time * 0.5, -speed * time / (1.0 + layer_index * 0.5 * 0.03)); vec2 final_coord = scaled_coord + movement;
//  vec2 movement = vec2(scaled_coord.y * (spread * mod(layer_index * 7.238917, 1.0) - spread * 0.5) + (-wind_strength) * speed * time * 0.5, -speed * time / (1.0 + layer_index * 0.5 * 0.03)); vec2 final_coord = scaled_coord + movement;
    // //  vec2 movement = vec2(scaled_coord.y * (spread * mod(layer_index * 7.238917, 1.0) - spread * 0.5) + (-wind_strength) * speed * time * 0.5, -speed * time / (1.0 + layer_index * 0.5 * 0.03)); vec2 final_coord = scaled_coord + movement;
//  // //  vec2 movement = vec2(scaled_coord.y * (spread * mod(layer_index * 7.238917, 1.0) - spread * 0.5) + (-wind_strength) * speed * time * 0.5, -speed * time / (1.0 + layer_index * 0.5 * 0.03)); vec2 final_coord = scaled_coord + movement;

    // Generate noise pattern
//  // Generate noise pattern
    // //  // Generate noise pattern
//  // //  // Generate noise pattern
    vec3 noise_input = vec3(floor(final_coord), 31.189 + layer_index); vec3 noise_val = floor(noise_input) * 0.00001 + fract(noise_input); vec3 random = fract((31415.9 + noise_val) / fract(NOISE_MATRIX * noise_val));
//  vec3 noise_input = vec3(floor(final_coord), 31.189 + layer_index); vec3 noise_val = floor(noise_input) * 0.00001 + fract(noise_input); vec3 random = fract((31415.9 + noise_val) / fract(NOISE_MATRIX * noise_val));
    // //  vec3 noise_input = vec3(floor(final_coord), 31.189 + layer_index); vec3 noise_val = floor(noise_input) * 0.00001 + fract(noise_input); vec3 random = fract((31415.9 + noise_val) / fract(NOISE_MATRIX * noise_val));
//  // //  vec3 noise_input = vec3(floor(final_coord), 31.189 + layer_index); vec3 noise_val = floor(noise_input) * 0.00001 + fract(noise_input); vec3 random = fract((31415.9 + noise_val) / fract(NOISE_MATRIX * noise_val));

    // Calculate snowflake shape
//  // Calculate snowflake shape
    // //  // Calculate snowflake shape
//  // //  // Calculate snowflake shape
    vec2 shape = abs(mod(final_coord, 1.0) - 0.5 + 0.9 * random.xy - 0.45); shape += 0.01 * abs(2.0 * fract(10.0 * final_coord.yx) - 1.0);
//  vec2 shape = abs(mod(final_coord, 1.0) - 0.5 + 0.9 * random.xy - 0.45); shape += 0.01 * abs(2.0 * fract(10.0 * final_coord.yx) - 1.0);
    // //  vec2 shape = abs(mod(final_coord, 1.0) - 0.5 + 0.9 * random.xy - 0.45); shape += 0.01 * abs(2.0 * fract(10.0 * final_coord.yx) - 1.0);
//  // //  vec2 shape = abs(mod(final_coord, 1.0) - 0.5 + 0.9 * random.xy - 0.45); shape += 0.01 * abs(2.0 * fract(10.0 * final_coord.yx) - 1.0);

    // Calculate edge softness
//  // Calculate edge softness
    // //  // Calculate edge softness
//  // //  // Calculate edge softness
    float depth_offset = 5.0 * sin(time * 0.1); float edge_softness = 0.005 + 0.05 * min(0.5 * abs(layer_index - 5.0 - depth_offset), 1.0);
//  float depth_offset = 5.0 * sin(time * 0.1); float edge_softness = 0.005 + 0.05 * min(0.5 * abs(layer_index - 5.0 - depth_offset), 1.0);
    // //  float depth_offset = 5.0 * sin(time * 0.1); float edge_softness = 0.005 + 0.05 * min(0.5 * abs(layer_index - 5.0 - depth_offset), 1.0);
//  // //  float depth_offset = 5.0 * sin(time * 0.1); float edge_softness = 0.005 + 0.05 * min(0.5 * abs(layer_index - 5.0 - depth_offset), 1.0);

    // Calculate final shape
//  // Calculate final shape
    // //  // Calculate final shape
//  // //  // Calculate final shape
    float shape_value = 0.6 * max(shape.x - shape.y, shape.x + shape.y) + max(shape.x, shape.y) - 0.01; return vec3(smoothstep(edge_softness, -edge_softness, shape_value) * (random.x / (1.0 + 0.02 * layer_index * 0.5)));
//  float shape_value = 0.6 * max(shape.x - shape.y, shape.x + shape.y) + max(shape.x, shape.y) - 0.01; return vec3(smoothstep(edge_softness, -edge_softness, shape_value) * (random.x / (1.0 + 0.02 * layer_index * 0.5)));
    // //  float shape_value = 0.6 * max(shape.x - shape.y, shape.x + shape.y) + max(shape.x, shape.y) - 0.01; return vec3(smoothstep(edge_softness, -edge_softness, shape_value) * (random.x / (1.0 + 0.02 * layer_index * 0.5)));
//  // //  float shape_value = 0.6 * max(shape.x - shape.y, shape.x + shape.y) + max(shape.x, shape.y) - 0.01; return vec3(smoothstep(edge_softness, -edge_softness, shape_value) * (random.x / (1.0 + 0.02 * layer_index * 0.5)));
    }
//  }

    void main() {
    vec3 snow_accumulation = vec3(0.0);
//  vec3 snow_accumulation = vec3(0.0);
    // //  vec3 snow_accumulation = vec3(0.0);
//  // //  vec3 snow_accumulation = vec3(0.0);

    // Generate snow for each layer
//  // Generate snow for each layer
    // Generate snow for each layer
//  // Generate snow for each layer
    for (int i = 0; i < num_of_layers; i++) { snow_accumulation += generate_snowflake(vTexCoord, float(i), time, wind); }
//  for (int i = 0; i < num_of_layers; i++) { snow_accumulation += generate_snowflake(vTexCoord, float(i), time, wind); }
    // //  for (int i = 0; i < num_of_layers; i++) { snow_accumulation += generate_snowflake(vTexCoord, float(i), time, wind); }
//  // //  for (int i = 0; i < num_of_layers; i++) { snow_accumulation += generate_snowflake(vTexCoord, float(i), time, wind); }

    // Calculate final color
//  // Calculate final color
    // Calculate final color
//  // Calculate final color
    float snow_intensity = clamp(length(snow_accumulation), 0.0, 1.0); vec4 base_color = texture(tex0, vTexCoord);
//  float snow_intensity = clamp(length(snow_accumulation), 0.0, 1.0); vec4 base_color = texture(tex0, vTexCoord);
    // //  float snow_intensity = clamp(length(snow_accumulation), 0.0, 1.0); vec4 base_color = texture(tex0, vTexCoord);
//  // //  float snow_intensity = clamp(length(snow_accumulation), 0.0, 1.0); vec4 base_color = texture(tex0, vTexCoord);

    // Apply transparency effect to the snow color
//  // Apply transparency effect to the snow color
    // Apply transparency effect to the snow color
//  // Apply transparency effect to the snow color
    vec4 transparency_color = vec4(snow_color.rgb * (1.0 + snow_transparency), snow_intensity); fragColor = mix(base_color, transparency_color, snow_intensity);
//  vec4 transparency_color = vec4(snow_color.rgb * (1.0 + snow_transparency), snow_intensity); fragColor = mix(base_color, transparency_color, snow_intensity);
    // //  vec4 transparency_color = vec4(snow_color.rgb * (1.0 + snow_transparency), snow_intensity); fragColor = mix(base_color, transparency_color, snow_intensity);
//  // //  vec4 transparency_color = vec4(snow_color.rgb * (1.0 + snow_transparency), snow_intensity); fragColor = mix(base_color, transparency_color, snow_intensity);
    }
