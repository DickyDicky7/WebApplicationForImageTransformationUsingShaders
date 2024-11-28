#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// Use texture
// Use texture
float rand(float x) {
    return fract(sin(x * (09251.2043))
                       *  47453.5453); 
}
float rand(vec2 uv) {
    return fract(sin(dot(uv.xy , vec2(12.9898, 78.233))) * rand(uv.y - cos(time * 0.4) * -16.0) * 11162.59863); 
}


void main(  )
{
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
    
    // Hint, it's a few lines of code, and makes use of a tan function :)
    // Hint, it's a few lines of code, and makes use of a tan function :)
    vec2 warpedUv   = uv;
         warpedUv.x = uv.x + tan(cos(uv.y) + time + rand(uv.y)) * min(0.0, cos(uv.y * 10.0 + time) + 0.9);
    float     pi = 3.141592;
    vec2 offset1 = vec2(cos(time *  0.8            ), sin(time *  0.8            )) * 0.01 + 0.01;
    vec2 offset2 = vec2(cos(time + (2.0 / 3.0 * pi)), sin(time + (2.0 / 3.0 * pi))) * 0.01 - 0.01;
    vec2 offset3 = vec2(cos(time *  0.9 +      (pi)), sin(time *  0.9 +      (pi))) * 0.00 - 0.01;
    
    float r = texture(tex0, warpedUv + offset1).r;
    float g = texture(tex0, warpedUv + offset2).g;
    float b = texture(tex0, warpedUv + offset3).b;
    
    float magic =     (r + g + b)                                      / 3.0;                      
    vec3    col = vec3(r , g , b) + (rand(uv + cos(time * 0.1)) - 0.5) * 0.2;

    // Output to screen
    // Output to screen
    fragColor = vec4(vec3(magic) * col, 1.0);
}

// https://www.shadertoy.com/view/MXBBRz

