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

    //const int pixel_size =    16;
//  //const int pixel_size =    16;
    uniform int pixel_size ; // 16
//  uniform int pixel_size ; // 16

    void main() {
    vec2 pos = vTexCoord
//  vec2 pos = vTexCoord
    / texelSize;
//  / texelSize;
    vec2   square = vec2(float(pixel_size)
//  vec2   square = vec2(float(pixel_size)
    ,      float(pixel_size));
//  ,      float(pixel_size));
    vec2 top_left = floor(pos / square) * square;
//  vec2 top_left = floor(pos / square) * square;
    vec4                                        total = vec4(0., 0., 0., 0.);
//  vec4                                        total = vec4(0., 0., 0., 0.);
    for     (int x = int(top_left.x); x < int(top_left.x) + pixel_size; x++) {
//  for     (int x = int(top_left.x); x < int(top_left.x) + pixel_size; x++) {
    for (int y = int(top_left.y); y < int(top_left.y) + pixel_size; y++) {
//  for (int y = int(top_left.y); y < int(top_left.y) + pixel_size; y++) {
    total += texture(tex0, vec2(float(x), float(y)) * texelSize);
//  total += texture(tex0, vec2(float(x), float(y)) * texelSize);
    }
//  }
    }
//  }
    fragColor = total / float(pixel_size * pixel_size);
//  fragColor = total / float(pixel_size * pixel_size);
    }


    // https://godotshaders.com/shader/square-pixelation/
//  // https://godotshaders.com/shader/square-pixelation/
