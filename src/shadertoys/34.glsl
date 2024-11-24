#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// color palette to use
vec3 palette[10];



void main(void) {


palette[0] =    vec3(0.19, 0.21, 0.20);
palette[1] =    vec3(0.34, 0.09, 0.30);
palette[2] =    vec3(0.51, 0.05, 0.24);
palette[3] =    vec3(0.72, 0.20, 0.42);
palette[4] =    vec3(0.92, 0.39, 0.62);
palette[5] =    vec3(0.98, 0.72, 0.75);
palette[6] =    vec3(0.78, 0.85, 0.83);
palette[7] =    vec3(0.67, 0.85, 0.99);
palette[8] =    vec3(0.50, 0.72, 0.75);
palette[9] =    vec3(0.20, 0.38, 0.51);

    vec2 uv = gl_FragCoord.xy / canvasSize.xy; // Normalized coordinates
    
    vec3 col = texture(tex0, uv).rgb;
    
    // loop through all the colors of the palette and see which one is closest to the texture color
    float closest = 9999999.0;
    // int closeIndex = -1;
     vec3 newcolor ;
    for (int i = 0; i < 10; i++) {
        vec3 dCol = col - palette[i];
        float d = length(dCol); // RGB distance
        
        if (d < closest) {
            closest = d;
            newcolor = palette[i];
        }
    }

     
    
    fragColor = vec4(newcolor, 1.0);
}



// https://www.shadertoy.com/view/stXXW8
