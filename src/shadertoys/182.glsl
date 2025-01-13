#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/X32fDG

float NUM = 30.0;
float DIST = 0.01;
float THRESH = 0.03;

const float pi = 3.14159265358;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    vec3 col = vec3(0.0);
    float place = 0.0;
    
    for (float i=1.0; i<=NUM; i++) {
        place = ((2.0*pi)/(NUM/i))+(pi/2.0);
        col += texture(iChannel0, uv+DIST*vec2(cos(place)*(iResolution.y/iResolution.x),sin(place))).rgb;
    }
    
    col /= NUM;
    
    col = texture(iChannel0, uv).rgb - col;
    
    if ((col.r+col.g+col.b)/3.0 > THRESH) {
        col = vec3(1.0);
    } else {
        col = vec3(0.0);
    }
    
    // Output to screen
    fragColor = vec4(col,1.0);
}