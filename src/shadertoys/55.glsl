#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#define speed 4.0
#define strength 40.0
#define distortion 0.03

void main(void)
{
    vec2 uv = gl_FragCoord.xy / canvasSize.xy;
    float legsx = 1.0 - length((2.0 * gl_FragCoord.xy - canvasSize.xy) / canvasSize.x);
    float legsy = 1.0 - length((2.0 * gl_FragCoord.xy - canvasSize.xy) / canvasSize.y);
    
    vec4 tex = texture(tex0, uv + vec2(
        sin((time * speed) + uv.y * strength) * (distortion * legsx), 
        sin((time * speed) + uv.x * strength) * (distortion * legsy)
    ));
    
    // tex.xyz *= 1.0 - length((2.0 * gl_FragCoord.xy - canvasSize.xy) / canvasSize.x);
    
    fragColor = tex;
}



// https://www.shadertoy.com/view/4Xc3DM
