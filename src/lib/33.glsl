#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;


// const float lookupSize = 64.0;
// const float errorCarry = 00.3;

uniform float lookupSize ; // 64.0
uniform float errorCarry ; // 00.3


float getGrayscale(vec2 coords, vec2 iResolution) {
    vec2          uv =  coords/      iResolution.xy ;
    // uv.y = 1.0
    //-uv.y ;
    vec3          sourcePixel = texture(tex0,uv).rgb;
    return length(sourcePixel * vec3( 0.2126,
                                      0.7152,
                                      0.0722));
}

    
void main() {
    // vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    // #### ########### # ### # ##################
    int topGapY = int(canvasSize.y - gl_FragCoord.y);
    
    int cornerGapX = int((gl_FragCoord.x < 10.0) ? gl_FragCoord.x : canvasSize.x - gl_FragCoord.x);
    int cornerGapY = int((gl_FragCoord.y < 10.0) ? gl_FragCoord.y : canvasSize.y - gl_FragCoord.y);
    int cornerThreshhold = ((cornerGapX == 0) || (topGapY == 0)) ? 5 : 4;
    // Place fragment code here.
    // ##### ######## #### #####
    if (cornerGapX +
        cornerGapY <
        cornerThreshhold
       )
    {
                
        fragColor = vec4(0,0,0,1);
        
    }
    else
    if (topGapY <  20)
    {
            
    if (topGapY == 19)
    {

        fragColor = vec4(0,0,0,1);            
    
    }
    else
    {
        
        fragColor = vec4(1,1,1,1);        
    }
        
    }
    else
    {
        
            float xError = 0.0f;
        for(float xLookk = 0.0f;
                  xLookk < lookupSize;
                  xLookk++) {
            float           grayscale  = getGrayscale(gl_FragCoord.xy + vec2(-lookupSize + xLookk, 0/*---------------*/), canvasSize);
                            grayscale +=
                  xError ;
            float    bit =  grayscale >= 0.5f ? 1.0f : 0.0;
                  xError = (grayscale  - bit) * errorCarry;
        }

            float yError = 0.0f;
        for(float yLookk = 0.0f;
                  yLookk < lookupSize;
                  yLookk++) {
            float           grayscale  = getGrayscale(gl_FragCoord.xy + vec2(0/*---------------*/, -lookupSize + yLookk), canvasSize);
                            grayscale +=
                  yError ;
            float    bit =  grayscale >= 0.5f ? 1.0f : 0.0;
                  yError = (grayscale  - bit) * errorCarry;
        }

        float            finalGrayscale  = getGrayscale(gl_FragCoord.xy, canvasSize);
                         finalGrayscale += xError * 0.5f
                                        +  yError * 0.5f;
        float finalBit = finalGrayscale >= 0.5f ?
                                           1.0f :
                                           0.0f ;

        fragColor = vec4(finalBit, finalBit, finalBit, 1);
            
    }
    
}



// https://godotshaders.com/shader/floyd-steinberg-dither/





