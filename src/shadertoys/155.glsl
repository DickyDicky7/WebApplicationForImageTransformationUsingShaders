#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/3dGczK

#define pi 3.14159265359

vec4 blend_with_center(vec2 center, vec2 uv, vec2 diff) {
    vec2        centered_uv =
                         uv -
                            center;
    float      shift = 0.03       ;
    vec3 col = vec3(
        texture(tex0,      centered_uv                ).r,
        texture(tex0, vec2(centered_uv.x
                    ,      centered_uv.y +      shift)).g,
        texture(tex0, vec2(centered_uv.x
                    ,      centered_uv.y + 2. * shift)).b
    );
    float            alpha = 1. - smoothstep(0., 0.4, length(centered_uv - diff));
    return vec4(col, alpha);
}


void main()
{
    ////////////////////
    ///    Clones    ///
    ////////////////////
    
    vec2 uv = vTexCoord; vec4 base = texture(tex0, uv);
//  vec2 uv = vTexCoord; vec4 base = texture(tex0, uv);
    
    vec4 col_1 = blend_with_center(vec2( 0.1, 0.), uv, vec2(0.75, 0.5));
    vec4 col_2 = blend_with_center(vec2(-0.1, 0.), uv, vec2(0.25, 0.5));
    
    float alpha_clone      = col_1.a +         col_2.a        ;
    vec4        clone_col  = col_1.a * col_1 + col_2.a * col_2;
                clone_col /=
          alpha_clone;
    if (  alpha_clone == 0.0  )
                clone_col = vec4(1.);
    alpha_clone =   (
    alpha_clone > 1.) ? 1.:
    alpha_clone ;
    
    fragColor = mix(base , clone_col , alpha_clone);
//  fragColor = max(base , clone_col * alpha_clone);
    
    
    ///////////////////////////////////////
    ///    Overlaying with "plyonka"    ///
    ///////////////////////////////////////
    
vec2    new_pos                             ;
vec2    shift = vec2(15. / canvasSize.x, 0.);
    
    if (uv.x < 0.5) {
        new_pos = vec2( uv.x             / 2., uv.y);
//      new_pos = vec2((uv.x + 0.5 + 1.) / 2., uv.y);
    } else          {
        new_pos = vec2((uv.x       + 1.) / 2., uv.y);        
        shift  *= -1.;
//      new_pos = vec2((uv.x - 0.5     ) / 2., uv.y);
    }
    
    vec4 overlay = vec4(
        texture(tex0, new_pos             ).r,
        texture(tex0, new_pos +      shift).g,
        texture(tex0, new_pos + 2. * shift).b,
        1.
    );
    
    fragColor = mix(fragColor, overlay, pow(2. * abs(uv.x - 0.5), 2.));
}
















