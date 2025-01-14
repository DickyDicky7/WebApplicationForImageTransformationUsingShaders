#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/wsGczt

float perspective = 0.3;

const int samples = 25;
const float minBlur = 0.0;
const float maxBlur = 0.3;
const float speed = 3.;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{   
    float speed = 4.; // 6.;
    float rotation_ratio = 0.1;
    float zoom_ratio = 0.2;
    
    /////////////////////////
    
    float alpha = smoothstep(
        0.,1., pow(sin(speed*iTime)/2., 2.) * 4.
    );
    // rotation_ratio *= alpha;
    
    /////////////////////////
    
    float timeQ = mix(minBlur, maxBlur, alpha);
        
    float rot = rotation_ratio * sin(speed*iTime); // pi/20.;
    mat2 rotation = mat2(
        cos(rot), -sin(rot), 
        sin(rot), cos(rot)
    );
    
    vec2 uv = fragCoord/iResolution.xy - 0.5;
    uv.x = uv.x * iResolution.x / iResolution.y;
    uv = rotation * uv;
    
    uv *= 1. - alpha*zoom_ratio;
    
    uv.x = uv.x / iResolution.x * iResolution.y;
    uv += 0.5;
    
    ////////////////////////
    ////////////////////////
    
    
    vec4 result = vec4(0);
    
    for (int i=0; i<=samples; i++)
    {        
        float q = float(i)/float(samples);
        result += texture(iChannel0, uv + (vec2(0.5)-uv)*q*timeQ)/float(samples);
    }
    if (alpha > 0.75)
        result = vec4(vec3(1.0 - result.rgb), result.a);
    
    fragColor = result;
}










