    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4          fragColor;
//  out             vec4          fragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    // const float  cellXCount = 200.0;
//  // const float  cellXCount = 200.0;
    // const float smoothRange = 000.1;
//  // const float smoothRange = 000.1;
    // const float       gamma = 001.8;
//  // const float       gamma = 001.8;

    uniform float  cellXCount ; // 200.0
//  uniform float  cellXCount ; // 200.0
    uniform float smoothRange ; // 000.1
//  uniform float smoothRange ; // 000.1
    uniform float       gamma ; // 001.8
//  uniform float       gamma ; // 001.8

    const mat2 cRot = mat2( 0.258819, -0.965926 , // 75 degrees
//  const mat2 cRot = mat2( 0.258819, -0.965926 , // 75 degrees
    0.965926,  0.258810);
//  0.965926,  0.258810);
    const mat2 mRot = mat2( 0.965926, -0.258819 , // 15 degrees
//  const mat2 mRot = mat2( 0.965926, -0.258819 , // 15 degrees
    0.258819, 0.9659260);
//  0.258819, 0.9659260);
    const mat2 yRot = mat2( 1.0     ,  0.0      , // 00 degrees
//  const mat2 yRot = mat2( 1.0     ,  0.0      , // 00 degrees
    0.0     ,  1.0     );
//  0.0     ,  1.0     );
    const mat2 kRot = mat2( 0.707106, -0.707106 , // 45 degrees
//  const mat2 kRot = mat2( 0.707106, -0.707106 , // 45 degrees
    0.707106,  0.707106);
//  0.707106,  0.707106);

    float halftoneLookup(vec2 uv, mat2 rotationMat) {
//  float halftoneLookup(vec2 uv, mat2 rotationMat) {
    // Rotate uv into grid space
//  // Rotate uv into grid space
    // Rotate uv into grid space
//  // Rotate uv into grid space
    vec2 uvRot = uv * rotationMat;
//  vec2 uvRot = uv * rotationMat;
    // Repeat grid
//  // Repeat grid
    // Repeat grid
//  // Repeat grid
    vec2 cellPosition = vec2(mod(uvRot.x, 1.0 / cellXCount)
//  vec2 cellPosition = vec2(mod(uvRot.x, 1.0 / cellXCount)
    ,      mod(uvRot.y, 1.0 / cellXCount)      );
//  ,      mod(uvRot.y, 1.0 / cellXCount)      );
    vec2 cellCentre   = vec2(   (         1.0 / cellXCount) / 2.0);
//  vec2 cellCentre   = vec2(   (         1.0 / cellXCount) / 2.0);
    
    // Sample grid
//  // Sample grid
    // Sample grid
//  // Sample grid
    float  fragDistToGrid = length(cellPosition - cellCentre) * sqrt(cellXCount * cellXCount * 2.0);
//  float  fragDistToGrid = length(cellPosition - cellCentre) * sqrt(cellXCount * cellXCount * 2.0);
    // Gamma correction
//  // Gamma correction
    // Gamma correction
//  // Gamma correction
    fragDistToGrid =  pow  (
//  fragDistToGrid =  pow  (
    fragDistToGrid , gamma );
//  fragDistToGrid , gamma );
    return fragDistToGrid;
//  return fragDistToGrid;
    }
//  }

    float threshold(float val, float                              thresholdVal              ) {
//  float threshold(float val, float                              thresholdVal              ) {
    float                       valToStepSpace = 1.0 - (val - thresholdVal + smoothRange) / smoothRange;
//  float                       valToStepSpace = 1.0 - (val - thresholdVal + smoothRange) / smoothRange;
    return smoothstep(0.0, 1.0, valToStepSpace);
//  return smoothstep(0.0, 1.0, valToStepSpace);
    }
//  }

    vec4 rgbToCmyk(vec4 color) {
//  vec4 rgbToCmyk(vec4 color) {
    vec4      cmyk;
//  vec4      cmyk;
    
    float           white = max(color.r,
//  float           white = max(color.r,
    max(color.g,
//  max(color.g,
    color.b));
//  color.b));
    // Key (black)
//  // Key (black)
    // Key (black)
//  // Key (black)
    cmyk.a =  1.0 - white;
//  cmyk.a =  1.0 - white;
    
    // Cyan
//  // Cyan
    // Cyan
//  // Cyan
    cmyk.r = (1.0 - color.r - cmyk.a) / white;
//  cmyk.r = (1.0 - color.r - cmyk.a) / white;
    // Magenta
//  // Magenta
    // Magenta
//  // Magenta
    cmyk.g = (1.0 - color.g - cmyk.a) / white;
//  cmyk.g = (1.0 - color.g - cmyk.a) / white;
    // Yellow
//  // Yellow
    // Yellow
//  // Yellow
    cmyk.b = (1.0 - color.b - cmyk.a) / white;
//  cmyk.b = (1.0 - color.b - cmyk.a) / white;
    
    return cmyk;
//  return cmyk;
    }
//  }

    vec4 cmykToRgb(vec4 cmyk) {
//  vec4 cmykToRgb(vec4 cmyk) {
    vec4     color;
//  vec4     color;
    float oneMinusK = 1.0 - cmyk.a;
//  float oneMinusK = 1.0 - cmyk.a;
    
    color.r = (1.0 - cmyk.r) * oneMinusK;
//  color.r = (1.0 - cmyk.r) * oneMinusK;
    color.g = (1.0 - cmyk.g) * oneMinusK;
//  color.g = (1.0 - cmyk.g) * oneMinusK;
    color.b = (1.0 - cmyk.b) * oneMinusK;
//  color.b = (1.0 - cmyk.b) * oneMinusK;
    color.a =  1.0                      ;
//  color.a =  1.0                      ;
    
    return color;
//  return color;
    }
//  }

    void main(void) {
    vec2 fragUV       = vTexCoord  ;
//  vec2 fragUV       = vTexCoord  ;
    vec2 fragUVAspect = vec2( fragUV.x
//  vec2 fragUVAspect = vec2( fragUV.x
    ,       fragUV.y
//  ,       fragUV.y
    / ( canvasSize.x
//  / ( canvasSize.x
    /   canvasSize.y ));
//  /   canvasSize.y ));
    
    // Sample input texture
//  // Sample input texture
    // Sample input texture
//  // Sample input texture
    vec4                        sampleRGB = texture(tex0, fragUV);
//  vec4                        sampleRGB = texture(tex0, fragUV);
    vec4 sampleCMYK = rgbToCmyk(sampleRGB)                       ;
//  vec4 sampleCMYK = rgbToCmyk(sampleRGB)                       ;
    
    // Apply halftones
//  // Apply halftones
    // Apply halftones
//  // Apply halftones
    vec4 halftones = vec4(
//  vec4 halftones = vec4(
    threshold(halftoneLookup(fragUVAspect, cRot), sampleCMYK.r),
//  threshold(halftoneLookup(fragUVAspect, cRot), sampleCMYK.r),
    threshold(halftoneLookup(fragUVAspect, mRot), sampleCMYK.g),
//  threshold(halftoneLookup(fragUVAspect, mRot), sampleCMYK.g),
    threshold(halftoneLookup(fragUVAspect, yRot), sampleCMYK.b),
//  threshold(halftoneLookup(fragUVAspect, yRot), sampleCMYK.b),
    threshold(halftoneLookup(fragUVAspect, kRot), sampleCMYK.a)
//  threshold(halftoneLookup(fragUVAspect, kRot), sampleCMYK.a)
    );
//  );
    
    // Output the result in RGB
//  // Output the result in RGB
    // Output the result in RGB
//  // Output the result in RGB
    fragColor = cmykToRgb(halftones);
//  fragColor = cmykToRgb(halftones);
    }



    // https://www.shadertoy.com/view/mtSXRh
//  // https://www.shadertoy.com/view/mtSXRh


