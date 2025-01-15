#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const mat4 bayerIndex = mat4(
    vec4(00.0/16.0, 12.0/16.0, 03.0/16.0, 15.0/16.0),
    vec4(08.0/16.0, 04.0/16.0, 11.0/16.0, 07.0/16.0),
    vec4(02.0/16.0, 14.0/16.0, 01.0/16.0, 13.0/16.0),
    vec4(10.0/16.0, 06.0/16.0, 09.0/16.0, 05.0/16.0));
    
void main() {
    vec4 col =                     texture(tex0, vTexCoord);
         col = vec4(pow(col.rgb, vec3(2.2)) - 0.004, col.a);
    

    float bayerValue = bayerIndex[int(gl_FragCoord.x) % 4][int(gl_FragCoord.y) % 4];
    
    
    fragColor = vec4(
        step(bayerValue, col.r),
        step(bayerValue, col.g),
        step(bayerValue, col.b),
        col.a);
}

// https://godotshaders.com/shader/bayer-dithering/