#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/XfKBDW

const float tau = 6.28318530717958647692;

#define GAMMA (2.2)

vec3 ToLinear( in vec3 col )
{
    return pow( col, vec3(GAMMA) );
}

vec3 ToGamma( in vec3 col )
{
    return pow( col, vec3(1.0/GAMMA) );
}

vec4 Noise( in ivec2 x )
{
    return texture( iChannel0, (vec2(x)+0.5)/256.0, -100.0 );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalize coordinates
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 p = fragCoord.xy / iResolution.xy * 2.0 - 1.0;
    p.x *= iResolution.x / iResolution.y; // Maintain aspect ratio

    // Time for rain dynamics
    float t = iTime * 2.0;

    // Background color (overcast sky)
    vec3 bgColor = vec3(0.4, 0.45, 0.5); // Greyish-blue tone
    vec3 col = bgColor;

    // Rain amount increases with time
    float rainIntensity = clamp(t * 0.1, 0.0, 1.0);

    // Loop to simulate rain layers
    for (int i = 0; i < 20; i++) {
        float layer = float(i) / 20.0;
        float speed = 2.0 + layer * 5.0 * rainIntensity;

        // Rain drop position
        vec2 dropPos = fract(uv + vec2(0.0, t * speed + layer));
        dropPos.y -= fract(t * speed);

        // Add glow effect around the raindrops
        float drop = exp(-10.0 * length(dropPos - vec2(0.5, 0.5)));
        vec3 dropColor = vec3(0.2, 0.5 + 0.5 * layer, 1.0); // Blue-to-cyan gradient
        col += drop * dropColor;
    }

    // Add a soft vignette for depth effect
    float vignette = 1.0 - 0.4 * length(p);
    col *= vignette;

    // Apply gamma correction
    fragColor = vec4(ToGamma(col), 1.0);
}