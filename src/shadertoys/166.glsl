#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/3dKcR3

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    /////////////////////////
    
    float ratio = 4.5 * (sin(5. * iTime)+1.5)/2.;
    
    /////////////////////////
    
    
	vec2 uv = fragCoord.xy / iResolution.xy;
    vec3 col;
    
    mat3 sobelX = mat3(-2.0, -3.0, -2.0,
                        0.0,  0.0,  0.0,
                        2.0,  3.0,  2.0);
    
    mat3 sobelY = mat3(-2.0,  0.0,  2.0,
                       -3.0,  0.0,  3.0,
                       -2.0,  0.0,  2.0);
    
    vec3 sumX = vec3(0.0);
    vec3 sumY = vec3(0.0);
    
    for(int i = -1; i <= 1; i++) {
        for(int j = -1; j <= 1; j++) {
            float x = (fragCoord.x + float(i))/iResolution.x;	
    		float y =  (fragCoord.y + float(j))/iResolution.y;
            
            sumX += texture(iChannel0, vec2(x, y)).xyz * float(sobelX[1+i][1+j]);
            sumY += texture(iChannel0, vec2(x, y)).xyz * float(sobelY[1+i][1+j]);
        }
    }
    col = abs(sumX) + abs(sumY);
    col *= ratio;
    // col = smoothstep(0., 1., col);
    
    
	fragColor.xyz = col;
}
