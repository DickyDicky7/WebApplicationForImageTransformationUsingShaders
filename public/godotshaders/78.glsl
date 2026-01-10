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



    uniform bool EnableShader  ; // true
//  uniform bool EnableShader  ; // true
    // Wether the gradient distance is calculated towards to bottom edge of the pixel
//  // Wether the gradient distance is calculated towards to bottom edge of the pixel
    // Wether the gradient distance is calculated towards to bottom edge of the pixel
//  // Wether the gradient distance is calculated towards to bottom edge of the pixel
    // if disabled, uses a corner of the pixel
//  // if disabled, uses a corner of the pixel
    // if disabled, uses a corner of the pixel
//  // if disabled, uses a corner of the pixel
    uniform bool LinearGradient; // false
//  uniform bool LinearGradient; // false
    uniform bool ClampDistances; // true
//  uniform bool ClampDistances; // true
    // "Offsets the point" where the distance is measured from, effectively moving the gradient
//  // "Offsets the point" where the distance is measured from, effectively moving the gradient
    // "Offsets the point" where the distance is measured from, effectively moving the gradient
//  // "Offsets the point" where the distance is measured from, effectively moving the gradient
    uniform float DistanceOffset; // -0.10
//  uniform float DistanceOffset; // -0.10
    // Just a constant value to add to the gradient to control the strength
//  // Just a constant value to add to the gradient to control the strength
    // Just a constant value to add to the gradient to control the strength
//  // Just a constant value to add to the gradient to control the strength
    uniform float DistanceAddFor; // -0.13
//  uniform float DistanceAddFor; // -0.13
    // If you are using upscaled pixel art, you can use this value to scale the grid up
//  // If you are using upscaled pixel art, you can use this value to scale the grid up
    // If you are using upscaled pixel art, you can use this value to scale the grid up
//  // If you are using upscaled pixel art, you can use this value to scale the grid up
    uniform int   GridScale; // 1.0
//  uniform int   GridScale; // 1.0
    // Color of the gradient
//  // Color of the gradient
    // Color of the gradient
//  // Color of the gradient
    uniform vec4  ModulatingColor; // 0.0, 0.0, 0.0, 1.0
//  uniform vec4  ModulatingColor; // 0.0, 0.0, 0.0, 1.0
    uniform float GradientOpacity; // 0.5
//  uniform float GradientOpacity; // 0.5

    vec2  grid      (vec2 uv , vec2 tex_size) {
//  vec2  grid      (vec2 uv , vec2 tex_size) {
    return fract(     uv *      tex_size / vec2(float(GridScale)));
//  return fract(     uv *      tex_size / vec2(float(GridScale)));
    }
//  }


    void main() {
    if (EnableShader) {
//  if (EnableShader) {
    vec4 orig_color =      texture    (tex0, vTexCoord);
//  vec4 orig_color =      texture    (tex0, vTexCoord);
    vec2 text_sizes = vec2(textureSize(tex0, 0)       );
//  vec2 text_sizes = vec2(textureSize(tex0, 0)       );
    //      vec2 text_sizes =       canvasSize                 ;
//  //      vec2 text_sizes =       canvasSize                 ;
    vec2  grid_uv =   grid(vTexCoord, text_sizes);
//  vec2  grid_uv =   grid(vTexCoord, text_sizes);
    float dist    =     0.0                      ;
//  float dist    =     0.0                      ;
    if (LinearGradient) {
//  if (LinearGradient) {
    dist =          1.0 - (grid_uv.y + DistanceOffset);
//  dist =          1.0 - (grid_uv.y + DistanceOffset);
    } else              {
//  } else              {
    dist = sqrt(pow(1.0 - (grid_uv.x + DistanceOffset), 2.0)
//  dist = sqrt(pow(1.0 - (grid_uv.x + DistanceOffset), 2.0)
    +      pow(1.0 - (grid_uv.y + DistanceOffset), 2.0));
//  +      pow(1.0 - (grid_uv.y + DistanceOffset), 2.0));
    }
//  }
    dist +=            DistanceAddFor        ;
//  dist +=            DistanceAddFor        ;
    if (ClampDistances) dist  = clamp(
//  if (ClampDistances) dist  = clamp(
    dist  ,
//  dist  ,
    0.00  ,
//  0.00  ,
    1.00         );
//  1.00         );
    fragColor = mix(orig_color, ModulatingColor, (1.0 - dist) * GradientOpacity);
//  fragColor = mix(orig_color, ModulatingColor, (1.0 - dist) * GradientOpacity);
    }
//  }
    }

    // https://godotshaders.com/shader/pixel-art-gradient/
//  // https://godotshaders.com/shader/pixel-art-gradient/
    // https://godotshaders.com/shader/pixel-art-gradient/
//  // https://godotshaders.com/shader/pixel-art-gradient/
    // https://godotshaders.com/shader/pixel-art-gradient/
//  // https://godotshaders.com/shader/pixel-art-gradient/





