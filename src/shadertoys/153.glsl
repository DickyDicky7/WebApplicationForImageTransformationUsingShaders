#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/7dKGRK

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float ratio = (sin(50.0*iTime)*0.5+0.5);
    vec2 uv = fragCoord/iResolution.xy;
    vec3 col = vec3(
        1.2 * texture(iChannel0, uv).r, 
        1.2 * texture(iChannel0, uv + vec2(0.01 * ratio, 0.0)).r, 
        1.2 * texture(iChannel0, uv + vec2(0.02 * ratio, 0.0)).r
    );
    col *= 0.4 + 0.6 * ratio;
    
    fragColor = vec4(col,1.0);
}