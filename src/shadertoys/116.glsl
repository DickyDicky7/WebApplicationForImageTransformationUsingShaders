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
// Based on https://www.shadertoy.com/view/MttXRB

    float luma(vec3 color) { return dot(color    , vec3(0.299f, 0.587f, 0.114f)); }
//  float luma(vec3 color) { return dot(color    , vec3(0.299f, 0.587f, 0.114f)); }

    float luma(vec4 color) { return dot(color.rgb, vec3(0.299f, 0.587f, 0.114f)); }
//  float luma(vec4 color) { return dot(color.rgb, vec3(0.299f, 0.587f, 0.114f)); }

// Simple pseudo-random noise function
// Simple pseudo-random noise function
    float noise(vec2 p) { return fract(sin(dot(p, vec2(12.9898f, 78.233f))) * 43758.5453123f); }
//  float noise(vec2 p) { return fract(sin(dot(p, vec2(12.9898f, 78.233f))) * 43758.5453123f); }

// Adjustable parameters
// Adjustable parameters
uniform float      scale ; // 0.85
uniform float noiseScale ; // 0.10
uniform float rotation   ; // 0.00
// Controls the width of the lines (0.1 to 5.0 for visible results)
// Controls the width of the lines (0.1 to 5.0 for visible results)
// Noise intensity (0.0 to disable noise)
// Noise intensity (0.0 to disable noise)
// Rotation angle for the orientation of the lines (in radians)
// Rotation angle for the orientation of the lines (in radians)

void main() {
    // Simplified center calculation
    // Simplified center calculation
    vec2 center = 0.5f * canvasSize.xy;
//  vec2 center = 0.5f * canvasSize.xy;

    // Fragment coordinates
    // Fragment coordinates
    vec2 uv = gl_FragCoord.xy;
//  vec2 uv = gl_FragCoord.xy;

    // Apply rotation using mat2
    // Apply rotation using mat2
    vec2 d = uv - center; mat2 rotMat = mat2(cos(rotation), -sin(rotation), sin(rotation), cos(rotation)); vec2 rotatedD = d * rotMat;
//  vec2 d = uv - center; mat2 rotMat = mat2(cos(rotation), -sin(rotation), sin(rotation), cos(rotation)); vec2 rotatedD = d * rotMat;

    // Calculate radial distance and angle
    // Calculate radial distance and angle
    float r = length(rotatedD) / (1000.0f / max(scale, 0.01f));
//  float r = length(rotatedD) / (1000.0f / max(scale, 0.01f));
    // Normalize to avoid artifacts
    // Normalize to avoid artifacts
    float a = atan(rotatedD.y, rotatedD.x) + scale * (0.5f - r) / 0.5f;
//  float a = atan(rotatedD.y, rotatedD.x) + scale * (0.5f - r) / 0.5f;

    // Transformed coordinates
    // Transformed coordinates
    vec2 uvt = center + r * vec2(cos(a), sin(a));
//  vec2 uvt = center + r * vec2(cos(a), sin(a));

    // Normalize UV coordinates
    // Normalize UV coordinates
    vec2 uv2 = vTexCoord;
//  vec2 uv2 = vTexCoord;

    // Load the texture and convert to linear space
    // Load the texture and convert to linear space
    vec4 color = texture(tex0, uv2); color.rgb = color.rgb * color.rgb;
//  vec4 color = texture(tex0, uv2); color.rgb = color.rgb * color.rgb;
    // Approximation of sRGB to linear
    // Approximation of sRGB to linear

    // Convert to grayscale
    // Convert to grayscale
    float l = luma(color);
//  float l = luma(color);

    // Add noise
    // Add noise
    float n = noise(uv2 * 10.0f);
//  float n = noise(uv2 * 10.0f);
    // Generate noise
    // Generate noise
    l += noiseScale * (n - 0.5f);
//  l += noiseScale * (n - 0.5f);
    // Apply noise perturbation
    // Apply noise perturbation

    // Generate sinusoidal line patterns
    // Generate sinusoidal line patterns
    float c = (0.75f + 0.25f * sin(uvt.x * 1000.0f * max(scale, 0.01f)));
//  float c = (0.75f + 0.25f * sin(uvt.x * 1000.0f * max(scale, 0.01f)));
    // Prevent excessive distortions
    // Prevent excessive distortions

    // Apply smoothing to achieve the linocut effect
    // Apply smoothing to achieve the linocut effect
    float f = smoothstep(0.5f * c, c, l); f = smoothstep(0.0f, 0.5f, f);
//  float f = smoothstep(0.5f * c, c, l); f = smoothstep(0.0f, 0.5f, f);

    // Convert final color back to sRGB space
    // Convert final color back to sRGB space
    vec3 finalColor = sqrt(vec3(f));
//  vec3 finalColor = sqrt(vec3(f));
    // Approximation of linear to sRGB
    // Approximation of linear to sRGB

    // Output the final color
    // Output the final color
    fragColor = vec4(finalColor, 1.0f);
//  fragColor = vec4(finalColor, 1.0f);
}








