#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/ddVyzG

#define pi 3.14159265359


const float speed = 0.3;
const float density = 4.0;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    vec2 uv = fragCoord/iResolution.xy;
    vec3 original_col = texture(iChannel0, uv).rgb;
        
    vec3 col = vec3(length(original_col) / sqrt(3.0));
    
    col *= density;
    col += speed * iTime;
    col = mod(col, 1.0);
    
    col = 0.5 * sin(col * 2.0 * pi) + 0.5;

    fragColor = vec4(col,1.0);
}