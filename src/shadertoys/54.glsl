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
// const vec2 rt = vec2( 0.00,  0.20);
// const vec2 rb = vec2( 0.00,  0.30);
// const vec2 rl = vec2(-0.10,  0.10);
// const vec2 rr = vec2( 0.00,  0.05);

uniform vec2 rt ; //  0.00,  0.20
uniform vec2 rb ; //  0.00,  0.30
uniform vec2 rl ; // -0.10,  0.10
uniform vec2 rr ; //  0.00,  0.05

void main(void)
{
    vec2 uv = gl_FragCoord.xy / canvasSize.xy;
    
    vec3 col = texture(tex0, uv).rgb;
    float vt = smoothstep(1.0 - rt.x, 1.0 - rt.y, uv.y);    
    float vb = smoothstep(      rb.x,       rb.y, uv.y);
    float vl = smoothstep(      rl.x,       rl.y, uv.x);    
    float vr = smoothstep(1.0 - rr.x, 1.0 - rr.y, uv.x);

    col *= (vt * vb * vl * vr);

    // Output to screen
    fragColor = vec4(col, 1.0);
}

// https://www.shadertoy.com/view/7ls3D2
