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

    void main(void) {
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    vec2                                      p = floor(uv * 80.0 + 0.5) / 80.0;
//  vec2                                      p = floor(uv * 80.0 + 0.5) / 80.0;
    float                                                                       k = 1.0;
//  float                                                                       k = 1.0;
    if (length(p - uv) < 0.005) {
//  if (length(p - uv) < 0.005) {
    vec3 col = texture(tex0, p).xyz;
//  vec3 col = texture(tex0, p).xyz;
    k = 0.3 + 0.7 * dot(col, vec3(1.0, 1.0, 1.0));
//  k = 0.3 + 0.7 * dot(col, vec3(1.0, 1.0, 1.0));
    }
//  }
    fragColor = vec4(k, k, k, 1.0);
//  fragColor = vec4(k, k, k, 1.0);
    }



    // https://www.shadertoy.com/view/ldGXRh
//  // https://www.shadertoy.com/view/ldGXRh




