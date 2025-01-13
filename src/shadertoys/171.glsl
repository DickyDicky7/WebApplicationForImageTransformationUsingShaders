#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/MfGBDz

#define S 0.05

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec2 P = vec2(0.5, 0.5)*vec2(iResolution.x/iResolution.y, 1.);
    float z = -S/length(uv*vec2(iResolution.x/iResolution.y, 1.)-P);
    vec2 dir = normalize(P-uv*vec2(iResolution.x/iResolution.y, 1.));
    uv -= dir*z;
    fragColor = texture(iChannel0, uv);
}