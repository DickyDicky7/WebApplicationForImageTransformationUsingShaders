#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/Wdtyzj

#define pi 3.14159265359


float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float distortion(float x) {
    float y = (sin(5.*x) + sin(6.*x)*sin(7.*x) + sin(10.*x));
    return (y >= 0.5) ? y: 0.;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec3 col = texture(iChannel0, uv).rgb;
    
    
    /////////////////
    // Color shift //
    /////////////////
    
    float distortion_power = 5.*abs(sin(iTime)); // 0.0 -> 5.0
    
    float shift_count = 5.;
    float shift_power = distortion_power / 500.;
    float speed = 3.;
    
    float shift = (fragCoord.x + distortion_power * distortion((uv.y+speed*iTime)*shift_count)) / iResolution.x;
    col = vec3(
        texture(iChannel0, vec2(shift, uv.y)).r,
        texture(iChannel0, vec2(shift + shift_power, uv.y)).g,
        texture(iChannel0, vec2(shift + shift_power*2., uv.y)).b
    );
    
    
    /////////////////
    // Noise No. 1 //
    /////////////////
    float noise_ratio = distortion_power * 0.1;
    col += noise_ratio * (rand(iTime*uv)-0.5);
    col *= 1.5;
    
    
    fragColor = vec4(col,1.0);
}