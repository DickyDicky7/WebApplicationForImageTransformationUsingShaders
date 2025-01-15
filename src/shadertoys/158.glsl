#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/WsKcz1

#define pi 3.14159265359

vec4 blend_with_center(vec2 center, vec2 uv, vec2 diff) {
    vec2 centered_uv = uv - center;
    float shift = 0.03;
    vec3 col = vec3(
        texture(iChannel0, centered_uv).r,
        texture(iChannel0, vec2(centered_uv.x, 
                                centered_uv.y+shift)).g,
        texture(iChannel0, vec2(centered_uv.x, 
                                centered_uv.y+2.*shift)).b
    );
    float alpha = 1.-smoothstep(0.,0.3,length(centered_uv-diff));
    return vec4(col, alpha);
}

// Position of each reflection 
/*
vec2 centers[8] = vec2[](
    vec2(0.4, 0.0), vec2(-0.4, 0.0),
    vec2(0.0, 0.5), vec2(0.0, -0.5),
    vec2(0.25, 0.3), vec2(0.25, -0.3),
    vec2(-0.25, 0.3), vec2(-0.25, -0.3)
);
*/

// Center of each reflection 
// something around vec2(0.5, 0.5)

vec2 diff[8] = vec2[](
    vec2(0.55, 0.6), vec2(0.5, 0.4),
    vec2(0.4, 0.55), vec2(0.6, 0.6),
    vec2(0.5, 0.5), vec2(0.55, 0.45),
    vec2(0.4, 0.6), vec2(0.5, 0.4)
);


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    ///////////////////////////
    
    float speed = 1.;
    float alpha = 2.*pi/8.;
    float radius = 0.4;
    
    ///////////////////////////
    
    vec2 centers[8] = vec2[](
        vec2(radius*cos(0. * alpha+speed*iTime), 
             radius*sin(0. * alpha+speed*iTime)),
        vec2(radius*cos(1. * alpha+speed*iTime), 
             radius*sin(1. * alpha+speed*iTime)),
        vec2(radius*cos(2. * alpha+speed*iTime), 
             radius*sin(2. * alpha+speed*iTime)),
        vec2(radius*cos(3. * alpha+speed*iTime), 
             radius*sin(3. * alpha+speed*iTime)),
        vec2(radius*cos(4. * alpha+speed*iTime), 
             radius*sin(4. * alpha+speed*iTime)),
        vec2(radius*cos(5. * alpha+speed*iTime), 
             radius*sin(5. * alpha+speed*iTime)),
        vec2(radius*cos(6. * alpha+speed*iTime), 
             radius*sin(6. * alpha+speed*iTime)),
        vec2(radius*cos(7. * alpha+speed*iTime), 
             radius*sin(7. * alpha+speed*iTime))
    );
    
    
    ////////////////////
    ///    Clones    ///
    ////////////////////
    
    vec2 uv = fragCoord/iResolution.xy; 
    vec4 base = texture(iChannel0, uv);
    
    ////////////////
    ////////////////
    
    float count = 8.;
    
    ////////////////
    ////////////////
    
    vec4 final_col = vec4(0.);
    float sum_alpha = 0.;
    
    for (float i=0.; i<count; ++i) {
        vec4 col = blend_with_center(
            centers[int(i)], uv, diff[int(i)]
        );
        final_col += col.a * col;
        sum_alpha += col.a;
    }
    final_col /= sum_alpha;
    if (sum_alpha == 0.)
        final_col = vec4(0.5);
    sum_alpha = (sum_alpha > 1.) ? 1.: sum_alpha;

    fragColor = mix(base, final_col, sum_alpha);
    // fragColor = max(base, final_col*sum_alpha);
    
    
    ///////////////////////////////////////
    ///    Overlaying with "plyonka"    ///
    ///////////////////////////////////////
    
    vec2 new_pos;
    vec2 shift = vec2(15./iResolution.x, 0.);
    
    if (uv.x < 0.5) {
        new_pos = vec2(uv.x/2., uv.y);
        // new_pos = vec2((uv.x+0.5+1.)/2., uv.y);
    } else {
        new_pos = vec2((uv.x+1.)/2., uv.y);        
        shift *= -1.;
    	// new_pos = vec2((uv.x-0.5)/2., uv.y);
    }
    
    vec4 overlay = vec4(
        texture(iChannel0, new_pos).r,
        texture(iChannel0, new_pos+shift).g,
        texture(iChannel0, new_pos+2.*shift).b,
        1.
    );
    
    fragColor = mix(fragColor, overlay, pow(2.*abs(uv.x-0.5), 2.));
}







