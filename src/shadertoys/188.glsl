#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/Xf3BR8

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    

    // Time varying pixel color
    vec3 col = texture(iChannel0,uv).rgb;
    if((col.r+col.g+col.b)/3.>0.5){
        float a = sin(texture(iChannel1,uv).r*3.1415926+iTime*2.)*3.1415926;
        uv+=vec2(sin(a),cos(a))/200.;
        col=texture(iChannel0,uv).rgb;
    }
        
    fragColor=vec4(col,1.);
}