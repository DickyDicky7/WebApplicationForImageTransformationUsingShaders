#version 300 es
precision highp float;

uniform         sampler2D          tex0; //texture
uniform         sampler2D          tex1; //noise1
uniform         sampler2D          tex2; //noise2
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// Constants
#define pi 3.1415926

// Uniforms


// Color channel splitting function
vec3 colorSplit(vec2 uv, vec2 s) {
    vec3 color;
    color.r = texture(tex0, uv - s).r;
    color.g = texture(tex0, uv).g;
    color.b = texture(tex0, uv + s).b;
    return color;
}

// Interlace effect
vec2 interlace(vec2 uv, float s) {
    uv.x += s * (4.0 * fract((uv.y * canvasSize.y) / 2.0) - 1.0);
    return uv;
}

// Fault effect (horizontal glitch)
vec2 fault(vec2 uv, float s) {
    float v = pow(0.5 - 0.5 * cos(2.0 * pi * uv.y), 100.0) * sin(2.0 * pi * uv.y);
    uv.x += v * s;
    return uv;
}

// Random distortion effect
vec2 rnd(vec2 uv, float s) {
    uv.x += s * (2.0 * texture(tex1, uv * 0.05).x - 1.0);
    return uv;
}

void main() {
    // Time variable for animation
    float t = time / 10.0;

    // Normalize fragment coordinates
    vec2 uv = gl_FragCoord.xy / canvasSize.xy;

    // Create a smooth interlacing effect
    float s = texture(tex1, vec2(t * 0.2, 0.5)).r;

    uv = interlace(uv, s * 0.005);
    
    // Fault effect with time-based horizontal glitch
    float r = texture(tex2, vec2(t, 0.0)).x;
    uv = fault(uv + vec2(0.0, fract(t * 2.0)), 5.0 * sign(r) * pow(abs(r), 5.0)) - vec2(0.0, fract(t * 2.0));

    // Random horizontal noise
    uv = rnd(uv, s * 0.02);

    // Color split effect for simulating RGB offset
    vec3 color = colorSplit(uv, vec2(s * 0.02, 0.0));

    // Mix with background noise texture
    color = mix(color, texture(tex1, 0.5 * uv + t * 100.0).rgb, 0.25);

    // Output the final color
    fragColor = vec4(color, 1.0);
}


// https://www.shadertoy.com/view/ltSSWV