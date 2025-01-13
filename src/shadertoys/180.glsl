#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4fdBD2

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;

    
    vec2 range = vec2(1.25,1.75);
    
    float seed = float(int(fragCoord.x/4.0))*1938.92317123;
    
    float seconds = range.x + fract(sin(seed)*1937.3781371839)*(range.y-range.x);
    
    float t = mod(iTime,range.y*1.25);
    
    float speed = 1.0/seconds;
    float offset = clamp(t*speed,0.0,1.0);
    uv.y -= offset;

    vec3 col = texture(iChannel0,uv).xyz;
    
    if(uv.y<0.0){
        
       uv = vec2(uv.x,mod(uv.y,1.0));
       
       if(uv.y<0.0){
          uv.y += offset;
       }
       
       
       col = texture(iChannel1,uv).xyz;
    }
    fragColor = vec4(col,1.0);
}