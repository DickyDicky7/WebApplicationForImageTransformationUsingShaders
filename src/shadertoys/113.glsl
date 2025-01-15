#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/X3GczK


void main()
{
    float t      = time * .5;
    float radius = 100.     ;
    
    vec2   uv =        vTexCoord;
    vec4 tex1 = texture(tex0,uv);
    
    float cord = smoothstep(0.0
               ,            0.1
               , sin(uv.x * 1. + cos(uv.y + t) * radius * (uv.x     ))
                               + sin(uv.x + t) * radius * (uv.x - .5));
    
    vec3 col = tex1.rgb * clamp(
               cord,
               0.00,
               1.00            );
    
    // Output to screen
    // Output to screen
    fragColor = vec4(col
              ,      1.0
                    ) ;
}











