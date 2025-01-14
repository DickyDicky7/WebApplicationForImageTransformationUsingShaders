#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/tsKcRV

#define pi 3.14159265359

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy; 
    vec4 base = texture(iChannel0, uv);
    
    vec2 new_pos;
    vec2 shift = vec2(15./iResolution.x, 0.);
    
    ///////////////////////////
    ///////////////////////////
    
    if (uv.x < 0.5) {
        // new_pos = vec2(uv.x/2., uv.y);
        new_pos = vec2((uv.x+0.5+1.)/2., uv.y);
    } else {
        //new_pos = vec2((uv.x+1.)/2., uv.y);        
        shift *= -1.;
    	new_pos = vec2((uv.x-0.5)/2., uv.y);
    }
    vec4 overlay = vec4(
        texture(iChannel0, new_pos).r,
        texture(iChannel0, new_pos+shift).g,
        texture(iChannel0, new_pos+2.*shift).b,
        1.
    );    
    fragColor = mix(base, overlay, pow(2.*abs(uv.x-0.5), 2.));
    
    ///////////////////////////
    ///////////////////////////
    
    shift = vec2(0., 15./iResolution.y);
    if (uv.y < 0.5) {
        // new_pos = vec2(uv.x/2., uv.y);
        new_pos = vec2(uv.x, (uv.y+0.5+1.)/2.);
    } else {
        //new_pos = vec2((uv.x+1.)/2., uv.y);        
        shift *= -1.;
    	new_pos = vec2(uv.x, (uv.y-0.5)/2.);
    }
    overlay = vec4(
        texture(iChannel0, new_pos).r,
        texture(iChannel0, new_pos+shift).g,
        texture(iChannel0, new_pos+2.*shift).b,
        1.
    );    
    fragColor = mix(fragColor, overlay, pow(2.*abs(uv.y-0.5), 2.));
}







