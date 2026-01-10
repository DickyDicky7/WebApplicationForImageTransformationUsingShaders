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

    // https://www.shadertoy.com/view/XccBDB
//  // https://www.shadertoy.com/view/XccBDB

    /*
//  /*
    Glitch Effect Shader by Yui Kinomoto @arlez80
//  Glitch Effect Shader by Yui Kinomoto @arlez80
    Glitch Effect Shader by Yui Kinomoto @arlez80
//  Glitch Effect Shader by Yui Kinomoto @arlez80
    Converted for ShaderToy by ChatGPT
//  Converted for ShaderToy by ChatGPT
    Converted for ShaderToy by ChatGPT
//  Converted for ShaderToy by ChatGPT

    MIT License
//  MIT License
    MIT License
//  MIT License
    */
//  */

    // Shake parameters
//  // Shake parameters
    // Shake parameters
//  // Shake parameters
    uniform float shake_power      ; // 00.03
//  uniform float shake_power      ; // 00.03
    uniform float shake_rate       ; // 00.20 // Adjusted
//  uniform float shake_rate       ; // 00.20 // Adjusted
    uniform float shake_speed      ; // 05.00
//  uniform float shake_speed      ; // 05.00
    uniform float shake_block_size ; // 30.50
//  uniform float shake_block_size ; // 30.50
    uniform float shake_color_rate ; // 00.01
//  uniform float shake_color_rate ; // 00.01

    // Random number function
//  // Random number function
    // Random number function
//  // Random number function
    float random(float                         seed                                ) {
//  float random(float                         seed                                ) {
    return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3415))));
//  return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3415))));
    }
//  }
    
    void main() {
    // Screen UV coordinates (0.0 - 1.0)
//  // Screen UV coordinates (0.0 - 1.0)
    // Screen UV coordinates (0.0 - 1.0)
//  // Screen UV coordinates (0.0 - 1.0)
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;





    // Enable shift based on random condition
//  // Enable shift based on random condition
    // Enable shift based on random condition
//  // Enable shift based on random condition
    float enable_shift = float(random(floor(time * shake_speed)) < shake_rate);
//  float enable_shift = float(random(floor(time * shake_speed)) < shake_rate);

    // Adjusted UV with shake effect
//  // Adjusted UV with shake effect
    // Adjusted UV with shake effect
//  // Adjusted UV with shake effect
    vec2 fixed_uv = uv;
//  vec2 fixed_uv = uv;
    fixed_uv.x += (
//  fixed_uv.x += (
    random(
//  random(
    (floor(uv.y * shake_block_size)
//  (floor(uv.y * shake_block_size)
    / shake_block_size)
//  / shake_block_size)
    +   time
//  +   time
    ) - 0.50
//  ) - 0.50
    )   * shake_power
//  )   * shake_power
    * enable_shift;
//  * enable_shift;

    // Sample the screen texture
//  // Sample the screen texture
    // Sample the screen texture
//  // Sample the screen texture
    vec4 pixel_color = texture(tex0, fixed_uv);
//  vec4 pixel_color = texture(tex0, fixed_uv);

    // Red! channel shift
//  // Red! channel shift
    // Red! channel shift
//  // Red! channel shift
    pixel_color.r = mix(pixel_color.r, texture(tex0, fixed_uv + vec2(+shake_color_rate, 0.0)).r, enable_shift);
//  pixel_color.r = mix(pixel_color.r, texture(tex0, fixed_uv + vec2(+shake_color_rate, 0.0)).r, enable_shift);

    // Blue channel shift
//  // Blue channel shift
    // Blue channel shift
//  // Blue channel shift
    pixel_color.b = mix(pixel_color.b, texture(tex0, fixed_uv + vec2(-shake_color_rate, 0.0)).b, enable_shift);
//  pixel_color.b = mix(pixel_color.b, texture(tex0, fixed_uv + vec2(-shake_color_rate, 0.0)).b, enable_shift);

    // Set the output color
//  // Set the output color
    // Set the output color
//  // Set the output color
    fragColor = pixel_color;
//  fragColor = pixel_color;
    }









