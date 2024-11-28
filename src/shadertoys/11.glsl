#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float stepH = 1.0;
const float stepV = 1.0;

float rgbToGray(vec4 rgba) {
    const vec3 W = vec3(0.2125
                 ,      0.7154
                 ,      0.0721);
    return                      dot(rgba.xyz, W);
}

void main() {
    float posterSteps = 8.0;
    
    // current location & color
    // current location & color
    vec2       uv = gl_FragCoord. xy
                  /   canvasSize. xy ;
    vec4 curColor = texture(tex0, uv);
    
    // get samples around pixel
    // get samples around pixel
    float colors[9];
    float stepX = stepH / canvasSize.x;
    float stepY = stepV / canvasSize.y;
    colors[0] = rgbToGray(texture(tex0, uv + vec2(-stepX,  stepY)));
    colors[1] = rgbToGray(texture(tex0, uv + vec2(   0.0,  stepY)));
    colors[2] = rgbToGray(texture(tex0, uv + vec2( stepX,  stepY)));
    colors[3] = rgbToGray(texture(tex0, uv + vec2(-stepX,    0.0)));
    colors[4] = rgbToGray(texture(tex0, uv));
    colors[5] = rgbToGray(texture(tex0, uv + vec2( stepX,    0.0)));
    colors[6] = rgbToGray(texture(tex0, uv + vec2(-stepX, -stepY)));
    colors[7] = rgbToGray(texture(tex0, uv + vec2(   0.0, -stepY)));
    colors[8] = rgbToGray(texture(tex0, uv + vec2( stepX, -stepY)));
    
    // apply color steps to original color
    // apply color steps to original color
    for(int i = 0; i < 9; i++) {
        colors[i]
= floor(colors[i] * posterSteps)
                  / posterSteps;
    }
    
    // count up colors in totals count array
    // count up colors in totals count array
    int                                colorsCount[9]     ;
    for     (int i = 0; i < 9; i++) {
                                       colorsCount[i]  = 0;
        for (int j = 0; j < 9; j++) {
            if(colors[i] == colors[j]) colorsCount[i] += 1;
        }
    }
    
    // find most common color in kernel
    // find most common color in kernel
    int maxColors = 0;
    // int maxIndex = 0;
    // int maxIndex = 0;
    float  colorMax  ;
    for(int i = 0; i < 9; i++) {
        if(colorsCount[i] > maxColors) {
                            maxColors = colorsCount[i];
            // maxIndex = i;
            // maxIndex = i;
            colorMax                  = colors     [i];
        }
    }
            
    // draw most common color in kernel (or original)
    // draw most common color in kernel (or original)
    if (mod(time, 1.0) > 0.5) {
        fragColor = vec4(vec3(colors[4]), 1.0);
    } else {
        fragColor = vec4(vec3(colorMax ), 1.0);
    }
}



// https://www.shadertoy.com/view/lsjBWW
// https://www.shadertoy.com/view/lsjBWW