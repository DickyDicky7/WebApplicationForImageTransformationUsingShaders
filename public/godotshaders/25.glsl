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

    // const int resX = 32;
//  // const int resX = 32;
    // const int resY = 32;
//  // const int resY = 32;

    // // 0.100392156862 is the cube root of 255
//  // // 0.100392156862 is the cube root of 255
    // const vec3 rgb255 = vec3(0.100392156862, 0.100392156862, 0.100392156862);
//  // const vec3 rgb255 = vec3(0.100392156862, 0.100392156862, 0.100392156862);

    uniform int resX ; // 32
//  uniform int resX ; // 32
    uniform int resY ; // 32
//  uniform int resY ; // 32

    // 0.100392156862 is the cube root of 255
//  // 0.100392156862 is the cube root of 255
    uniform vec3 rgb255 ; // 0.100392156862, 0.100392156862, 0.100392156862
//  uniform vec3 rgb255 ; // 0.100392156862, 0.100392156862, 0.100392156862

    void main() {
    float uvX = vTexCoord.x - mod(vTexCoord.x * float(resX), 1.0) / float(resX);
//  float uvX = vTexCoord.x - mod(vTexCoord.x * float(resX), 1.0) / float(resX);
    float uvY = vTexCoord.y - mod(vTexCoord.y * float(resY), 1.0) / float(resY);
//  float uvY = vTexCoord.y - mod(vTexCoord.y * float(resY), 1.0) / float(resY);
    vec2 grid_uv = vec2(uvX ,
//  vec2 grid_uv = vec2(uvX ,
    uvY);
//  uvY);
    
    vec4 col  = texture(tex0, grid_uv);
//  vec4 col  = texture(tex0, grid_uv);
    
    if ( col.r < 1.0
//  if ( col.r < 1.0
    &&   col.g < 1.0
//  &&   col.g < 1.0
    &&   col.b < 1.0 ) {
//  &&   col.b < 1.0 ) {
    vec3       remainder = mod(col.rgb, rgb255);
//  vec3       remainder = mod(col.rgb, rgb255);
    col.rgb =
//  col.rgb =
    col.rgb - remainder;
//  col.rgb - remainder;
    }
//  }
    
    fragColor = col;
//  fragColor = col;
    }

    // https://godotshaders.com/shader/256-colour-pixelation/
//  // https://godotshaders.com/shader/256-colour-pixelation/












