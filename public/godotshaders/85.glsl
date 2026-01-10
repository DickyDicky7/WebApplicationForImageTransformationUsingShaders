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




    uniform bool  dithering       ; // true
//  uniform bool  dithering       ; // true
    uniform int   dithering_size  ; // 10.0
//  uniform int   dithering_size  ; // 10.0
    uniform int   resolution_scale; // 02.0
//  uniform int   resolution_scale; // 02.0
    uniform float threshold       ; // 60.0
//  uniform float threshold       ; // 60.0
    uniform vec4             white; // 1.0, 1.0, 1.0, 1.0
//  uniform vec4             white; // 1.0, 1.0, 1.0, 1.0
    uniform vec4             black; // 0.0, 0.0, 0.0, 1.0
//  uniform vec4             black; // 0.0, 0.0, 0.0, 1.0

    int dithering_pattern(ivec2 fragcoord) {
//  int dithering_pattern(ivec2 fragcoord) {
    const int pattern[16] = int[](
//  const int pattern[16] = int[](
    -4, +0, -3, +1,
//  -4, +0, -3, +1,
    +2, -2, +3, -1,
//  +2, -2, +3, -1,
    -3, +1, -4, +0,
//  -3, +1, -4, +0,
    +3, -1, +2, -2
//  +3, -1, +2, -2
    );
//  );
    int x = fragcoord.x % 4;
//  int x = fragcoord.x % 4;
    int y = fragcoord.y % 4;
//  int y = fragcoord.y % 4;

    return pattern[y * 4 + x] * dithering_size;
//  return pattern[y * 4 + x] * dithering_size;
    }
//  }

    void main() {
    ivec2    uv = ivec2     ((vTexCoord * canvasSize) / float(resolution_scale)  )    ;
//  ivec2    uv = ivec2     ((vTexCoord * canvasSize) / float(resolution_scale)  )    ;
    vec3 color = texelFetch(        tex0, uv *       resolution_scale, 0).rgb;
//  vec3 color = texelFetch(        tex0, uv *       resolution_scale, 0).rgb;

    // Convert from [0.0, 1.0] range to [0, 255] range
//  // Convert from [0.0, 1.0] range to [0, 255] range
    // Convert from [0.0, 1.0] range to [0, 255] range
//  // Convert from [0.0, 1.0] range to [0, 255] range
    ivec3 c  = ivec3(round(color * 255.00));
//  ivec3 c  = ivec3(round(color * 255.00));

    // Apply the dithering pattern
//  // Apply the dithering pattern
    // Apply the dithering pattern
//  // Apply the dithering pattern
    if (dithering) {
//  if (dithering) {
    c += ivec3(dithering_pattern(uv));
//  c += ivec3(dithering_pattern(uv));
    }
//  }

    // Convert back to [0.0, 1.0] range
//  // Convert back to [0.0, 1.0] range
    // Convert back to [0.0, 1.0] range
//  // Convert back to [0.0, 1.0] range
    float avg = float(c.x
//  float avg = float(c.x
    +       c.y
//  +       c.y
    +       c.z)
//  +       c.z)
    /       3.0;
//  /       3.0;
    if (  avg < threshold  ) {
//  if (  avg < threshold  ) {
    fragColor = black;
//  fragColor = black;
    }   else                 {
//  }   else                 {
    fragColor = white;
//  fragColor = white;
    }
//  }
    }

    // https://godotshaders.com/shader/1-bit-3d-shader-with-dithering/
//  // https://godotshaders.com/shader/1-bit-3d-shader-with-dithering/
    // https://godotshaders.com/shader/1-bit-3d-shader-with-dithering/
//  // https://godotshaders.com/shader/1-bit-3d-shader-with-dithering/
    // https://godotshaders.com/shader/1-bit-3d-shader-with-dithering/
//  // https://godotshaders.com/shader/1-bit-3d-shader-with-dithering/





