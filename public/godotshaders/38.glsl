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

    // const int   levels = 3   ;
//  // const int   levels = 3   ;
    // const float spread = 0.01;
//  // const float spread = 0.01;

    uniform int   levels ; // 3
//  uniform int   levels ; // 3
    uniform float spread ; // 0.01
//  uniform float spread ; // 0.01

    vec3 chromatic_slice(float t) {
//  vec3 chromatic_slice(float t) {
    vec3       res = vec3(1.0 - t, 1.0 - abs(t - 1.0), t - 1.0);
//  vec3       res = vec3(1.0 - t, 1.0 - abs(t - 1.0), t - 1.0);
    return max(res ,                                       0.0);
//  return max(res ,                                       0.0);
    }
//  }

    void main() {
    vec3 sum;
//  vec3 sum;
    fragColor.rgb  = vec3(0);
//  fragColor.rgb  = vec3(0);
    vec2               offset = (vTexCoord - vec2(0.5)) * vec2(1, -1);
//  vec2               offset = (vTexCoord - vec2(0.5)) * vec2(1, -1);
    for(int   i = 0; i <    levels;  i++) {
//  for(int   i = 0; i <    levels;  i++) {
    float t = 2.0*float(         i)
//  float t = 2.0*float(         i)
    /float(levels - 1);  // range 0.0  ->   2.0
//  /float(levels - 1);  // range 0.0  ->   2.0
    vec3   slice = vec3(1.0 - t, 1.0 - abs(t - 1.0), t - 1.0);
//  vec3   slice = vec3(1.0 - t, 1.0 - abs(t - 1.0), t - 1.0);
    slice =
//  slice =
    max (  slice , 0.0 );
//  max (  slice , 0.0 );
    sum += slice;
//  sum += slice;
    vec2                                               slice_offset = (t - 1.0) * spread * offset;
//  vec2                                               slice_offset = (t - 1.0) * spread * offset;
    fragColor.rgb += slice * texture(tex0, vTexCoord + slice_offset).rgb                         ;
//  fragColor.rgb += slice * texture(tex0, vTexCoord + slice_offset).rgb                         ;
    }
//  }
    fragColor.rgb /= sum;
//  fragColor.rgb /= sum;
    }

    // https://godotshaders.com/shader/chromatic-abberation/
//  // https://godotshaders.com/shader/chromatic-abberation/
