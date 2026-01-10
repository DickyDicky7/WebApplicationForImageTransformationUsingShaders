#version 300 es
// #version 300 es
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

    // https://www.shadertoy.com/view/XfVBzc
//  // https://www.shadertoy.com/view/XfVBzc

    uniform float offset; // 0.0010
//  uniform float offset; // 0.0010


    uniform bool  EdgeDetection; // false
//  uniform bool  EdgeDetection; // false
    uniform bool  Scharr       ; //  true
//  uniform bool  Scharr       ; //  true
    void main()
    {
    float edgeThreshold = .5;
//  float edgeThreshold = .5;

    vec2 uv  = vTexCoord;
//  vec2 uv  = vTexCoord;
    vec3 col = texture(tex0, uv                        ).rgb;
//  vec3 col = texture(tex0, uv                        ).rgb;
    
    vec3 TL  = texture(tex0, uv + vec2(-offset, offset)).rgb;
//  vec3 TL  = texture(tex0, uv + vec2(-offset, offset)).rgb;
    vec3 TM  = texture(tex0, uv + vec2(     0., offset)).rgb;
//  vec3 TM  = texture(tex0, uv + vec2(     0., offset)).rgb;
    vec3 TR  = texture(tex0, uv + vec2( offset, offset)).rgb;
//  vec3 TR  = texture(tex0, uv + vec2( offset, offset)).rgb;
    
    vec3 R   = texture(tex0, uv + vec2( offset, 0.)).rgb;
//  vec3 R   = texture(tex0, uv + vec2( offset, 0.)).rgb;
    vec3 L   = texture(tex0, uv + vec2(-offset, 0.)).rgb;
//  vec3 L   = texture(tex0, uv + vec2(-offset, 0.)).rgb;
    
    vec3 BL  = texture(tex0, uv + vec2(-offset, -offset)).rgb;
//  vec3 BL  = texture(tex0, uv + vec2(-offset, -offset)).rgb;
    vec3 BM  = texture(tex0, uv + vec2(     0., -offset)).rgb;
//  vec3 BM  = texture(tex0, uv + vec2(     0., -offset)).rgb;
    vec3 BR  = texture(tex0, uv + vec2( offset, -offset)).rgb;
//  vec3 BR  = texture(tex0, uv + vec2( offset, -offset)).rgb;
    
    if (EdgeDetection)
//  if (EdgeDetection)
    {
//  {
    //Sobel Operator Vertical
//  //Sobel Operator Vertical
    // 1  0 -1
//  // 1  0 -1
    // 2  0 -2
//  // 2  0 -2
    // 1  0 -1
//  // 1  0 -1
    vec3 verticalGradiant = TL + (2. * TM) + TR - BL - (2. * BM) - BR;
//  vec3 verticalGradiant = TL + (2. * TM) + TR - BL - (2. * BM) - BR;
    
    //Sobel -------- Vertical
//  //Sobel -------- Vertical
    // 1  2  1
//  // 1  2  1
    // 0  0  0
//  // 0  0  0
    //-1 -2 -1
//  //-1 -2 -1
    vec3 horizontalGradiant = -TL + TR + (2. * R) + (-2. * L) - BL + BR;
//  vec3 horizontalGradiant = -TL + TR + (2. * R) + (-2. * L) - BL + BR;
    
    vec3 gradiantmMagnitude = sqrt(verticalGradiant
//  vec3 gradiantmMagnitude = sqrt(verticalGradiant
    *      verticalGradiant
//  *      verticalGradiant
    +    horizontalGradiant
//  +    horizontalGradiant
    *    horizontalGradiant);
//  *    horizontalGradiant);
    
    float edgeValue = (0.299 * gradiantmMagnitude.r
//  float edgeValue = (0.299 * gradiantmMagnitude.r
    +  0.587 * gradiantmMagnitude.g
//  +  0.587 * gradiantmMagnitude.g
    +  0.114 * gradiantmMagnitude.b) > edgeThreshold ? 1. : 0.;
//  +  0.114 * gradiantmMagnitude.b) > edgeThreshold ? 1. : 0.;
    
    fragColor = vec4(edgeValue);
//  fragColor = vec4(edgeValue);
    }
//  }
    else
//  else
    if (Scharr)
//  if (Scharr)
    {
//  {
    //Sobel Vertical
//  //Sobel Vertical
    // 47   0 -47
//  // 47   0 -47
    // 162  0 -162
//  // 162  0 -162
    // 47   0 -47
//  // 47   0 -47
    vec3 verticalGradiant = (47. * TL) + (-47. * TR) + (162. * R) + (-162. * L) + (47. * BL) + (-47. * BR);
//  vec3 verticalGradiant = (47. * TL) + (-47. * TR) + (162. * R) + (-162. * L) + (47. * BL) + (-47. * BR);
    
    
    //Sobel Vertical
//  //Sobel Vertical
    // 47  162  47
//  // 47  162  47
    // 0   0    0
//  // 0   0    0
    //-47 -162 -47
//  //-47 -162 -47
    vec3 horizontalGradiant = (47. * TL) + (162. * TM) + (47. * TR) + (-47. * BL) - (162. * BM) + (-47. * BR);
//  vec3 horizontalGradiant = (47. * TL) + (162. * TM) + (47. * TR) + (-47. * BL) - (162. * BM) + (-47. * BR);
    
    vec3 gradiantmMagnitude = sqrt(verticalGradiant
//  vec3 gradiantmMagnitude = sqrt(verticalGradiant
    *      verticalGradiant
//  *      verticalGradiant
    +    horizontalGradiant
//  +    horizontalGradiant
    *    horizontalGradiant);
//  *    horizontalGradiant);
    
    float edgeValue = (0.299 * gradiantmMagnitude.r
//  float edgeValue = (0.299 * gradiantmMagnitude.r
    +  0.587 * gradiantmMagnitude.g
//  +  0.587 * gradiantmMagnitude.g
    +  0.114 * gradiantmMagnitude.b) / 35. > edgeThreshold ? 1. : 0.;
//  +  0.114 * gradiantmMagnitude.b) / 35. > edgeThreshold ? 1. : 0.;
    
    fragColor = vec4(edgeValue);
//  fragColor = vec4(edgeValue);
    }
//  }
    }














