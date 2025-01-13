#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D    shaderToy0; // null
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// Function to calculate the channel based on phase
vec4 calcChannel(float phase)
{
    return texture(shaderToy0, vec2(0.5 + 0.5 * sin(phase * 3.14159), 0.5));
}

void main(void)
{
    vec2 uv = gl_FragCoord.xy / canvasSize.xy;
    vec4 color = texture(tex0, uv);
    
    float brightness = (color.r + color.g + color.b) * 0.3333;
    float phase1 = mod(brightness + time * 0.25, 1.0);
    float phase2 = mod(brightness + time * 0.28, 1.0);
    float phase3 = mod(brightness + time * 0.33, 1.0);
    
    color.r = calcChannel(phase1).r;
    color.g = calcChannel(phase2).g;
    color.b = calcChannel(phase3).b;
    
    fragColor = color;
}


// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/MtdGzM
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
