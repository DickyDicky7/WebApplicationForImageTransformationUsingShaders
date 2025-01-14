#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/WsVcR3

void main()
{
    /////////////////////////
    
    float ratio = 4.5 * (sin(5. * time) + 1.5) / 2.;
    
    /////////////////////////
    
    
    vec2 uv = vTexCoord;
    vec3 col;
    
    mat3 sobelX = mat3(-2.0, -3.0, -2.0,
                        0.0,  0.0,  0.0,
                        2.0,  3.0,  2.0);
    
    mat3 sobelY = mat3(-2.0,  0.0,  2.0,
                       -3.0,  0.0,  3.0,
                       -2.0,  0.0,  2.0);
    
    float sumX = 0.0;
    float sumY = 0.0;
    
    float current_val;
    
    for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
            float x = (gl_FragCoord.x + float(i)) / canvasSize.x;	
            float y = (gl_FragCoord.y + float(j)) / canvasSize.y;
            
            current_val = length(texture(tex0, vec2(x, y)).xyz);
            
            sumX += current_val * float(sobelX[1 + i][1 + j]);
            sumY += current_val * float(sobelY[1 + i][1 + j]);
        }
    }
    col  = vec3(abs(sumX)
        +       abs(sumY)
               );
    col *= ratio;
    col  = 1. - smoothstep(0.3, 1., col);
    
    
    fragColor.xyz = col;
}

