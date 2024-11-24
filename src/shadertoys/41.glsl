#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float tau = 2.0 * acos(-1.0);

void main(void)
{
    // Parameters
    float magnitude = 0.25; // From 0 to 1
    float density = 5.0; // Number of wave cycles on x-axis
    float speed = 0.5; // Frequency (Hz) on x-axis
    
    vec2 a = gl_FragCoord.xy / canvasSize.xy;
    vec2 b = vec2(density, density * canvasSize.y / canvasSize.x);
    vec2 c = vec2(speed, speed * canvasSize.x / canvasSize.y);
    vec2 d = magnitude / (tau * b + 2.0);
    
    vec2 uv = a * (-2.0 * d + 1.0) + d - sin(tau * a * b + time * c * tau) * d;
    
    fragColor = texture(tex0, uv);
}


// https://www.shadertoy.com/view/wlffRn
