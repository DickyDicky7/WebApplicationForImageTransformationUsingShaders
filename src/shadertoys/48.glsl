#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float  cellXCount = 200.0;
const float smoothRange = 000.1;
const float       gamma = 001.8;

const mat2 cRot = mat2( 0.258819, -0.965926 , // 75 degrees
                        0.965926,  0.258810);
const mat2 mRot = mat2( 0.965926, -0.258819 , // 15 degrees
                        0.258819, 0.9659260);
const mat2 yRot = mat2( 1.0     ,  0.0      , // 00 degrees
                        0.0     ,  1.0     );
const mat2 kRot = mat2( 0.707106, -0.707106 , // 45 degrees
                        0.707106,  0.707106);

float halftoneLookup(vec2 uv, mat2 rotationMat) {
    // Rotate uv into grid space
    // Rotate uv into grid space
    vec2 uvRot = uv * rotationMat;
    // Repeat grid
    // Repeat grid
    vec2 cellPosition = vec2(mod(uvRot.x, 1.0 / cellXCount)
                      ,      mod(uvRot.y, 1.0 / cellXCount)      );
    vec2 cellCentre   = vec2(   (         1.0 / cellXCount) / 2.0);
    
    // Sample grid
    // Sample grid
    float  fragDistToGrid = length(cellPosition - cellCentre) * sqrt(cellXCount * cellXCount * 2.0);
    // Gamma correction
    // Gamma correction
           fragDistToGrid =  pow  (
           fragDistToGrid , gamma );
    return fragDistToGrid;
}

float threshold(float val, float                              thresholdVal              ) {
    float                       valToStepSpace = 1.0 - (val - thresholdVal + smoothRange) / smoothRange;
    return smoothstep(0.0, 1.0, valToStepSpace);
}

vec4 rgbToCmyk(vec4 color) {
vec4      cmyk;
    
    float           white = max(color.r,
                            max(color.g,
                                color.b));
    // Key (black)
    // Key (black)
    cmyk.a =  1.0 - white;
    
    // Cyan
    // Cyan
    cmyk.r = (1.0 - color.r - cmyk.a) / white;
    // Magenta
    // Magenta
    cmyk.g = (1.0 - color.g - cmyk.a) / white;
    // Yellow
    // Yellow
    cmyk.b = (1.0 - color.b - cmyk.a) / white;
    
    return cmyk;
}

vec4 cmykToRgb(vec4 cmyk) {
    vec4     color;
    float oneMinusK = 1.0 - cmyk.a;
    
    color.r = (1.0 - cmyk.r) * oneMinusK;
    color.g = (1.0 - cmyk.g) * oneMinusK;
    color.b = (1.0 - cmyk.b) * oneMinusK;
    color.a =  1.0                      ;
    
    return color;
}

void main(void) {
    vec2 fragUV       = gl_FragCoord.xy
                      /   canvasSize.xy  ;
    vec2 fragUVAspect = vec2( fragUV.x
                      ,       fragUV.y
                      / ( canvasSize.x
                      /   canvasSize.y ));
    
    // Sample input texture
    // Sample input texture
    vec4                        sampleRGB = texture(tex0, fragUV);
    vec4 sampleCMYK = rgbToCmyk(sampleRGB)                       ;
    
    // Apply halftones
    // Apply halftones
    vec4 halftones = vec4(
        threshold(halftoneLookup(fragUVAspect, cRot), sampleCMYK.r),
        threshold(halftoneLookup(fragUVAspect, mRot), sampleCMYK.g),
        threshold(halftoneLookup(fragUVAspect, yRot), sampleCMYK.b),
        threshold(halftoneLookup(fragUVAspect, kRot), sampleCMYK.a)
    );
    
    // Output the result in RGB
    // Output the result in RGB
    fragColor = cmykToRgb(halftones);
}



// https://www.shadertoy.com/view/mtSXRh


