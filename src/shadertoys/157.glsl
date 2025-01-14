#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/3dGyR3

float perspective = 0.3;

const int samples = 25;
const float minBlur = 0.0;
const float maxBlur = 0.3;
const float speed = 3.;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{   
    float speed_1 = 2.;
    float speed_2 = 20.;

    ////////////////////////////

    float alpha = smoothstep(
        0.,1., pow(sin(speed_1*iTime)/2., 2.) * 4.
    ) * (sin(speed_2*iTime)+1.)/2.;
    
    ////////////////////////////
    
    float timeQ = mix(minBlur, maxBlur, alpha);
	
    
    vec2 p = fragCoord.xy / iResolution.xy;
    vec4 result = vec4(0);
    
    for (int i=0; i<=samples; i++)
    {        
        float q = float(i)/float(samples);
        result += texture(iChannel0, p + (vec2(0.5)-p)*q*timeQ)/float(samples);
    }
    result += alpha/2.;
    
	
	fragColor = result;
}