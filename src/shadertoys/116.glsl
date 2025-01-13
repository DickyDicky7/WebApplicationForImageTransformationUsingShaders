#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4XVcDV

// Based on https://www.shadertoy.com/view/MttXRB

float luma(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}

float luma(vec4 color) {
    return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}

// Simple pseudo-random noise function
float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453123);
}

// Adjustable parameters
float scale = 0.85;       // Controls the width of the lines (0.1 to 5.0 for visible results)
float noiseScale = 0.1;   // Noise intensity (0.0 to disable noise)
float rotation = 0.0;     // Rotation angle for the orientation of the lines (in radians)

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Simplified center calculation
    vec2 center = 0.5 * iResolution.xy;

    // Fragment coordinates
    vec2 uv = fragCoord.xy;

    // Apply rotation using mat2
    vec2 d = uv - center;
    mat2 rotMat = mat2(cos(rotation), -sin(rotation), sin(rotation), cos(rotation));
    vec2 rotatedD = d * rotMat;

    // Calculate radial distance and angle
    float r = length(rotatedD) / (1000.0 / max(scale, 0.01)); // Normalize to avoid artifacts
    float a = atan(rotatedD.y, rotatedD.x) + scale * (0.5 - r) / 0.5;

    // Transformed coordinates
    vec2 uvt = center + r * vec2(cos(a), sin(a));

    // Normalize UV coordinates
    vec2 uv2 = fragCoord.xy / iResolution.xy;

    // Load the texture and convert to linear space
    vec4 color = texture(iChannel0, uv2);
    color.rgb = color.rgb * color.rgb; // Approximation of sRGB to linear

    // Convert to grayscale
    float l = luma(color);

    // Add noise
    float n = noise(uv2 * 10.0); // Generate noise
    l += noiseScale * (n - 0.5); // Apply noise perturbation

    // Generate sinusoidal line patterns
    float c = (0.75 + 0.25 * sin(uvt.x * 1000.0 * max(scale, 0.01))); // Prevent excessive distortions

    // Apply smoothing to achieve the linocut effect
    float f = smoothstep(0.5 * c, c, l);
    f = smoothstep(0.0, 0.5, f);

    // Convert final color back to sRGB space
    vec3 finalColor = sqrt(vec3(f)); // Approximation of linear to sRGB

    // Output the final color
    fragColor = vec4(finalColor, 1.0);
}
