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






    uniform float     brightness    ; // 0.0
//  uniform float     brightness    ; // 0.0
    uniform sampler2D palette_source; // null
//  uniform sampler2D palette_source; // null
    uniform sampler2D palette_target; // null
//  uniform sampler2D palette_target; // null

    void main() {
    vec4 screens_color = texture    (tex0          , vTexCoord);
//  vec4 screens_color = texture    (tex0          , vTexCoord);
    ivec2 palette_sizes = textureSize(palette_source, 0        );
//  ivec2 palette_sizes = textureSize(palette_source, 0        );
    
    float colours_diffAm = 1.0;
//  float colours_diffAm = 1.0;
    int   nearest_swatch = 0  ;
//  int   nearest_swatch = 0  ;
        
    for (int swatch = 0;
//  for (int swatch = 0;
    swatch < palette_sizes.x;
//  swatch < palette_sizes.x;
    swatch++) {
//  swatch++) {
    vec4  sampled_color_____ = texelFetch(palette_source    , ivec2(swatch, 0), 0);
//  vec4  sampled_color_____ = texelFetch(palette_source    , ivec2(swatch, 0), 0);
    float ____new_color_diff =  distance (sampled_color_____,
//  float ____new_color_diff =  distance (sampled_color_____,
    screens_color);
//  screens_color);
        
    if (                 ____new_color_diff
//  if (                 ____new_color_diff
    <   colours_diffAm) {
//  <   colours_diffAm) {
    colours_diffAm = ____new_color_diff;
//  colours_diffAm = ____new_color_diff;
    nearest_swatch =
//  nearest_swatch =
    swatch                     ;
//  swatch                     ;
    }
//  }
    }
//  }
    
    int swatch_offset =   int(  brightness   * float(palette_sizes.x )  );
//  int swatch_offset =   int(  brightness   * float(palette_sizes.x )  );
    int target_swatch = clamp(nearest_swatch +
//  int target_swatch = clamp(nearest_swatch +
    swatch_offset , 0                    ,       palette_sizes.x - 1);
//  swatch_offset , 0                    ,       palette_sizes.x - 1);
    
    fragColor = texelFetch(palette_target, ivec2(target_swatch, 0), 0);
//  fragColor = texelFetch(palette_target, ivec2(target_swatch, 0), 0);
    }

    // https://godotshaders.com/shader/game-boy-palette-overlay/
//  // https://godotshaders.com/shader/game-boy-palette-overlay/
    // https://godotshaders.com/shader/game-boy-palette-overlay/
//  // https://godotshaders.com/shader/game-boy-palette-overlay/
    // https://godotshaders.com/shader/game-boy-palette-overlay/
//  // https://godotshaders.com/shader/game-boy-palette-overlay/







