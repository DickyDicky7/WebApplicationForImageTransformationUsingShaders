#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// VIGNETTE RANGE
#define rt vec2(0.0,0.2)
#define rb vec2(0.0,0.3)
#define rl vec2(-0.1,0.1)
#define rr vec2(0.0,0.05)

void main(void)
{
    vec2 uv = gl_FragCoord.xy / canvasSize.xy;
    
    vec3 col = texture(tex0, uv).rgb;
    float vt = smoothstep(1.0 - rt.x, 1.0 - rt.y, uv.y);    
    float vb = smoothstep(rb.x, rb.y, uv.y);
    float vl = smoothstep(rl.x, rl.y, uv.x);    
    float vr = smoothstep(1.0 - rr.x, 1.0 - rr.y, uv.x);

    col *= (vt * vb * vl * vr);

    // Output to screen
    fragColor = vec4(col, 1.0);
}

// https://www.shadertoy.com/view/7ls3D2
