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

    // https://www.shadertoy.com/view/XcVfDG
//  // https://www.shadertoy.com/view/XcVfDG

    void main()
    {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    
    // Calculate step size to sample adjacent pixels
//  // Calculate step size to sample adjacent pixels
    // Calculate step size to sample adjacent pixels
//  // Calculate step size to sample adjacent pixels
    float step  = 1.0                ;
//  float step  = 1.0                ;
    float stepX = step / canvasSize.x;
//  float stepX = step / canvasSize.x;
    float stepY = step / canvasSize.y;
//  float stepY = step / canvasSize.y;
    
    // Sample adjacent pixels (center one isn't needed)
//  // Sample adjacent pixels (center one isn't needed)
    // Sample adjacent pixels (center one isn't needed)
//  // Sample adjacent pixels (center one isn't needed)
    vec4 TL = texture(tex0, uv + vec2(-stepX,  stepY));
//  vec4 TL = texture(tex0, uv + vec2(-stepX,  stepY));
    vec4 TC = texture(tex0, uv + vec2(     0,  stepY));
//  vec4 TC = texture(tex0, uv + vec2(     0,  stepY));
    vec4 TR = texture(tex0, uv + vec2( stepX,  stepY));
//  vec4 TR = texture(tex0, uv + vec2( stepX,  stepY));
    
    vec4 CL = texture(tex0, uv + vec2(-stepX,      0));
//  vec4 CL = texture(tex0, uv + vec2(-stepX,      0));
    vec4 CR = texture(tex0, uv + vec2( stepX,      0));
//  vec4 CR = texture(tex0, uv + vec2( stepX,      0));
    
    vec4 BL = texture(tex0, uv + vec2(-stepX, -stepY));
//  vec4 BL = texture(tex0, uv + vec2(-stepX, -stepY));
    vec4 BC = texture(tex0, uv + vec2(     0, -stepY));
//  vec4 BC = texture(tex0, uv + vec2(     0, -stepY));
    vec4 BR = texture(tex0, uv + vec2( stepX, -stepY));
//  vec4 BR = texture(tex0, uv + vec2( stepX, -stepY));
    
    // Calculate gradients for horizontal and vertical edges using convolution and Sobel kernels
//  // Calculate gradients for horizontal and vertical edges using convolution and Sobel kernels
    // Calculate gradients for horizontal and vertical edges using convolution and Sobel kernels
//  // Calculate gradients for horizontal and vertical edges using convolution and Sobel kernels
    // Not sure if I have the rotate the Sobel masks 180°, it seems to work without it, too...
//  // Not sure if I have the rotate the Sobel masks 180°, it seems to work without it, too...
    // Not sure if I have the rotate the Sobel masks 180°, it seems to work without it, too...
//  // Not sure if I have the rotate the Sobel masks 180°, it seems to work without it, too...
    vec4 gradX = TL -       TR + 2.0 * CL - 2.0 * CR +       BL - BR;
//  vec4 gradX = TL -       TR + 2.0 * CL - 2.0 * CR +       BL - BR;
    vec4 gradY = TL + 2.0 * TC +       TR -       BL - 2.0 * BC - BR;
//  vec4 gradY = TL + 2.0 * TC +       TR -       BL - 2.0 * BC - BR;
    
    // Calculate final pixel color by combining gradients and using their luma value
//  // Calculate final pixel color by combining gradients and using their luma value
    // Calculate final pixel color by combining gradients and using their luma value
//  // Calculate final pixel color by combining gradients and using their luma value
    vec4  grad = sqrt(gradX
//  vec4  grad = sqrt(gradX
    *      gradX
//  *      gradX
    +      gradY
//  +      gradY
    *      gradY );
//  *      gradY );
    float luma = sqrt(grad.x
//  float luma = sqrt(grad.x
    *      grad.x
//  *      grad.x
    +      grad.y
//  +      grad.y
    *      grad.y
//  *      grad.y
    +      grad.z
//  +      grad.z
    *      grad.z);
//  *      grad.z);
    
    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    fragColor.rgb = vec3(luma);
//  fragColor.rgb = vec3(luma);
    }







