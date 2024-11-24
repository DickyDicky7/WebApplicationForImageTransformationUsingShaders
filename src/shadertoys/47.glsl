#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4      glslFragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

int intMod(int a, int b) {
    return a - (b * (a / b));
}

void main(void) {
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy / canvasSize.xy;
    vec2 uv_r = uv;
    vec2 uv_g = uv;
    vec2 uv_b = uv;
    
    // Add color glitch stripes
    if(intMod(int(uv.y / 0.05), 2) == 0) {
        uv_r.x += 0.05;     
    }
    
    if(intMod(int((uv.y + 0.002) / 0.05),  2) == 0) {
        uv_g.x -= 0.03;     
    }
    
    // iChannel0 texture
    vec4 pic_r = texture(tex0, uv_r);
    vec4 pic_g = texture(tex0, uv_g);
    vec4 pic_b = texture(tex0, uv_b);
    
    // Output to screen
    vec4 fragColor = vec4(pic_r.r, pic_g.g, pic_b.b, 1.0);
    
    // Color correction
    fragColor += vec4(-0.4, -0.7, -0.1, 0.0);
    
    // Old TV/monitor vibe
    fragColor = fragColor + 0.1 * sin(uv.y * 700.0);
    
    // Vignette
    uv *= 1.0 - uv.yx;
    float vig = uv.x * uv.y * 15.0; // Multiply with sth for intensity
    vig = pow(vig, 0.2); // Change pow for modifying the extent of the vignette
    fragColor *= vec4(vig);
    
    glslFragColor = fragColor;
}





// https://www.shadertoy.com/view/ctjGzh
