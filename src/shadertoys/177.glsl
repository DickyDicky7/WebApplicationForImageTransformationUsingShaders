#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4fGfzR

#define Pi 3.1415926535897932384626433832795
#define Distortion 0.5*1.*(sin(iTime-0.5*Pi)+1.)

float GetRot(vec2 uv, vec2 a){
    vec2 b = uv-a;
    b.x *= iResolution.x/iResolution.y;
    vec2 j = vec2(0., 1.);
    return acos(dot(b,j)/length(b))*(abs(mod(b.x, 4.*Pi)-2.*Pi)/(2.*Pi-mod(b.x, 4.*Pi)));
}

float f(float a, float x){
    return 0.5*(sin(x-0.5*Pi)+1.)*a;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec2 P = vec2(0.5, 0.5);
    float d = length((uv-P)*vec2(iResolution.x/iResolution.y, 1.));
    
    float a = GetRot(uv, P)-(Distortion/d);
    
    uv = vec2(sin(a)/(iResolution.x/iResolution.y), cos(a))*d+P;
    
    fragColor = texture(iChannel0, uv);
}
