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


    // const float lookupSize = 64.0;
//  // const float lookupSize = 64.0;
    // const float errorCarry = 00.3;
//  // const float errorCarry = 00.3;

    uniform float lookupSize ; // 64.0
//  uniform float lookupSize ; // 64.0
    uniform float errorCarry ; // 00.3
//  uniform float errorCarry ; // 00.3


    float getGrayscale(vec2 uv) {
//  float getGrayscale(vec2 uv) {
    // uv.y = 1.0
//  // uv.y = 1.0
    //-uv.y ;
//  //-uv.y ;
    vec3          sourcePixel = texture(tex0,uv).rgb;
//  vec3          sourcePixel = texture(tex0,uv).rgb;
    return length(sourcePixel * vec3( 0.2126,
//  return length(sourcePixel * vec3( 0.2126,
    0.7152,
//  0.7152,
    0.0722));
//  0.0722));
    }
//  }

    
    void main() {
    // vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
//  // vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    // #### ########### # ### # ##################
//  // #### ########### # ### # ##################
    int topGapY = int(canvasSize.y - vec4(vTexCoord * canvasSize, 0.0, 1.0).y);
//  int topGapY = int(canvasSize.y - vec4(vTexCoord * canvasSize, 0.0, 1.0).y);
    
    int cornerGapX = int((vec4(vTexCoord * canvasSize, 0.0, 1.0).x < 10.0) ? vec4(vTexCoord * canvasSize, 0.0, 1.0).x : canvasSize.x - vec4(vTexCoord * canvasSize, 0.0, 1.0).x);
//  int cornerGapX = int((vec4(vTexCoord * canvasSize, 0.0, 1.0).x < 10.0) ? vec4(vTexCoord * canvasSize, 0.0, 1.0).x : canvasSize.x - vec4(vTexCoord * canvasSize, 0.0, 1.0).x);
    int cornerGapY = int((vec4(vTexCoord * canvasSize, 0.0, 1.0).y < 10.0) ? vec4(vTexCoord * canvasSize, 0.0, 1.0).y : canvasSize.y - vec4(vTexCoord * canvasSize, 0.0, 1.0).y);
//  int cornerGapY = int((vec4(vTexCoord * canvasSize, 0.0, 1.0).y < 10.0) ? vec4(vTexCoord * canvasSize, 0.0, 1.0).y : canvasSize.y - vec4(vTexCoord * canvasSize, 0.0, 1.0).y);
    int cornerThreshhold = ((cornerGapX == 0) || (topGapY == 0)) ? 5 : 4;
//  int cornerThreshhold = ((cornerGapX == 0) || (topGapY == 0)) ? 5 : 4;
    // Place fragment code here.
//  // Place fragment code here.
    // ##### ######## #### #####
//  // ##### ######## #### #####
    if (cornerGapX +
//  if (cornerGapX +
    cornerGapY <
//  cornerGapY <
    cornerThreshhold
//  cornerThreshhold
    )
//  )
    {
//  {
                
    fragColor = vec4(0,0,0,1);
//  fragColor = vec4(0,0,0,1);
        
    }
//  }
    else
//  else
    if (topGapY <  20)
//  if (topGapY <  20)
    {
//  {
            
    if (topGapY == 19)
//  if (topGapY == 19)
    {
//  {

    fragColor = vec4(0,0,0,1);
//  fragColor = vec4(0,0,0,1);
    
    }
//  }
    else
//  else
    {
//  {
        
    fragColor = vec4(1,1,1,1);
//  fragColor = vec4(1,1,1,1);
    }
//  }
        
    }
//  }
    else
//  else
    {
//  {
        
    float xError = 0.0f;
//  float xError = 0.0f;
    for(float xLookk = 0.0f;
//  for(float xLookk = 0.0f;
    xLookk < lookupSize;
//  xLookk < lookupSize;
    xLookk++) {
//  xLookk++) {
    float           grayscale  = getGrayscale(vTexCoord + vec2(-lookupSize + xLookk, 0/*---------------*/) / canvasSize);
//  float           grayscale  = getGrayscale(vTexCoord + vec2(-lookupSize + xLookk, 0/*---------------*/) / canvasSize);
    grayscale +=
//  grayscale +=
    xError ;
//  xError ;
    float    bit =  grayscale >= 0.5f ? 1.0f : 0.0;
//  float    bit =  grayscale >= 0.5f ? 1.0f : 0.0;
    xError = (grayscale  - bit) * errorCarry;
//  xError = (grayscale  - bit) * errorCarry;
    }
//  }

    float yError = 0.0f;
//  float yError = 0.0f;
    for(float yLookk = 0.0f;
//  for(float yLookk = 0.0f;
    yLookk < lookupSize;
//  yLookk < lookupSize;
    yLookk++) {
//  yLookk++) {
    float           grayscale  = getGrayscale(vTexCoord + vec2(0/*---------------*/, -lookupSize + yLookk) / canvasSize);
//  float           grayscale  = getGrayscale(vTexCoord + vec2(0/*---------------*/, -lookupSize + yLookk) / canvasSize);
    grayscale +=
//  grayscale +=
    yError ;
//  yError ;
    float    bit =  grayscale >= 0.5f ? 1.0f : 0.0;
//  float    bit =  grayscale >= 0.5f ? 1.0f : 0.0;
    yError = (grayscale  - bit) * errorCarry;
//  yError = (grayscale  - bit) * errorCarry;
    }
//  }

    float            finalGrayscale  = getGrayscale(vTexCoord);
//  float            finalGrayscale  = getGrayscale(vTexCoord);
    finalGrayscale += xError * 0.5f
//  finalGrayscale += xError * 0.5f
    +  yError * 0.5f;
//  +  yError * 0.5f;
    float finalBit = finalGrayscale >= 0.5f ?
//  float finalBit = finalGrayscale >= 0.5f ?
    1.0f :
//  1.0f :
    0.0f ;
//  0.0f ;

    fragColor = vec4(finalBit, finalBit, finalBit, 1);
//  fragColor = vec4(finalBit, finalBit, finalBit, 1);
            
    }
//  }
    
    }



    // https://godotshaders.com/shader/floyd-steinberg-dither/
//  // https://godotshaders.com/shader/floyd-steinberg-dither/





