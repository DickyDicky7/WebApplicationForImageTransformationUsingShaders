#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D    uploadtex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/Xf3BR8

void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
    

    // Time varying pixel color
    // Time varying pixel color
    vec3 col = texture(tex0, uv).rgb;
    if ((col.r
    +    col.g
    +    col.b
        ) / 3.0 > 0.5
       )
    {
        float a = sin(texture(uploadtex0, uv).r * 3.1415926 + time * 2.0) * 3.1415926; uv += vec2(sin(a), cos(a)) / 200.0; col=texture(tex0, uv).rgb;
//      float a = sin(texture(uploadtex0, uv).r * 3.1415926 + time * 2.0) * 3.1415926; uv += vec2(sin(a), cos(a)) / 200.0; col=texture(tex0, uv).rgb;      
    }
        
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
}







