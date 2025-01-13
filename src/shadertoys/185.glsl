#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/XccBDB

/*
	Glitch Effect Shader by Yui Kinomoto @arlez80
	Converted for ShaderToy by ChatGPT

	MIT License
*/

// Random number function
float random(float seed) {
    return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3415))));
}
    
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Screen UV coordinates (0.0 - 1.0)
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Shake parameters
    float shake_power = 0.03;
    float shake_rate = 0.2; // Adjusted
    float shake_speed = 5.0;
    float shake_block_size = 30.5;
    float shake_color_rate = 0.01;



    // Enable shift based on random condition
    float enable_shift = float(
        random(floor(iTime * shake_speed)) < shake_rate
    );

    // Adjusted UV with shake effect
    vec2 fixed_uv = uv;
    fixed_uv.x += (
        random(
            (floor(uv.y * shake_block_size) / shake_block_size)
        +   iTime
        ) - 0.5
    ) * shake_power * enable_shift;

    // Sample the screen texture
    vec4 pixel_color = texture(iChannel0, fixed_uv);

    // Red channel shift
    pixel_color.r = mix(
        pixel_color.r,
        texture(iChannel0, fixed_uv + vec2(shake_color_rate, 0.0)).r,
        enable_shift
    );

    // Blue channel shift
    pixel_color.b = mix(
        pixel_color.b,
        texture(iChannel0, fixed_uv + vec2(-shake_color_rate, 0.0)).b,
        enable_shift
    );

    // Set the output color
    fragColor = pixel_color;
}