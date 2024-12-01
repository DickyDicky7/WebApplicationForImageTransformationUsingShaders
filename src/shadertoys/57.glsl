#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

vec3 colors[8];
// Declare color array with defined size
// Declare color array with defined size

void initializeColors() {
    colors[0] = vec3(  0.0                                      );
    colors[1] = vec3(116.0 / 256.0, 146.0 / 256.0, 104.0 / 256.0);
    colors[2] = vec3(108.0 / 256.0, 172.0 / 256.0, 148.0 / 256.0);
    colors[3] = vec3( 1.0                                       );
    colors[4] = vec3(116.0 / 256.0, 117.0 / 256.0,  67.0 / 256.0);
    colors[5] = vec3( 71.0 / 256.0,  79.0 / 256.0,  90.0 / 256.0);
    colors[6] = vec3( 66.0 / 256.0,  62.0 / 256.0,  38.0 / 256.0);
    colors[7] = vec3(134.0 / 256.0, 179.0 / 256.0, 130.0 / 256.0);
}

vec3 Quantize(vec3 col) {
    float dist      = distance(colors[0], col);
    // Initial distance set to first color
    // Initial distance set to first color
    vec3  tempColor =          colors[0]      ;
    // Placeholder color
    // Placeholder color

    for (int i = 1; i < 8; i++) {
        // Loop through color array
        // Loop through color array
        float           currentDist = distance(colors[i], col);
        if (            currentDist < dist)   {
            // Update if closer color found
            // Update if closer color found
            dist      = currentDist;
            tempColor = colors[ i ];
        }
    }

    return tempColor;
    // Return closest color
    // Return closest color
}

void main(void) {
    initializeColors();
    // Initialize color values in array
    // Initialize color values in array

    vec2   uv = gl_FragCoord. xy
              /   canvasSize. xy     ;
    vec3  col = texture(tex0, uv).rgb;
    
          col =                       Quantize(col);

    fragColor = vec4(col, 1.0);
    // Display quantized texture
    // Display quantized texture
}


// https://www.shadertoy.com/view/XcKGWD
