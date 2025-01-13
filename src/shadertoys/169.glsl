#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/wlKyWm


float speed = 6.0;
float wave_count = 20.0;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy / iResolution.xy;   
    vec2 pixelSize = vec2(1,1) / iResolution.xy;
    vec3 col = texture(iChannel0, uv).rgb; 
    float mirrorPos = 0.3;
    if (uv.y < mirrorPos) {
        float distanceFromMirror = mirrorPos - uv.y;
        float sine = sin((log(distanceFromMirror)*wave_count) + (iTime*speed));
        float dy = 30.0*sine;
        float dx = 0.0;
        dy *= distanceFromMirror;
        vec2 pixelOff = pixelSize * vec2(dx, dy);
        vec2 tex_uv = uv + pixelOff;
        tex_uv.y = (0.6 /* magic number! */) - tex_uv.y;
        col = texture(iChannel0, tex_uv).rgb;
        
        float shine = (sine + dx*0.05) * 0.05;
        col += vec3(shine, shine, shine);
    }
   	
    fragColor = vec4(col,1.);
}