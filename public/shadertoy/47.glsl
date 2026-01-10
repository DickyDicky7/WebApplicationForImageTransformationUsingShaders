    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4      glslFragColor;
//  out             vec4      glslFragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    int intMod(int  a , int  b) {
//  int intMod(int  a , int  b) {
    return a - (b * (a / b));
//  return a - (b * (a / b));
    }
//  }

    void main(void) {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    vec2 uv_r = uv;
//  vec2 uv_r = uv;
    vec2 uv_g = uv;
//  vec2 uv_g = uv;
    vec2 uv_b = uv;
//  vec2 uv_b = uv;

    // Add color glitch stripes
//  // Add color glitch stripes
    // Add color glitch stripes
//  // Add color glitch stripes
    if(intMod(int( uv.y          / 0.05), 2) == 0) {
//  if(intMod(int( uv.y          / 0.05), 2) == 0) {
    uv_r.x  +=  0.05;
//  uv_r.x  +=  0.05;
    }
//  }

    if(intMod(int((uv.y + 0.002) / 0.05), 2) == 0) {
//  if(intMod(int((uv.y + 0.002) / 0.05), 2) == 0) {
    uv_g.x  -=  0.03;
//  uv_g.x  -=  0.03;
    }
//  }

    // iChannel0 texture
//  // iChannel0 texture
    // iChannel0 texture
//  // iChannel0 texture
    vec4 pic_r = texture(tex0, uv_r);
//  vec4 pic_r = texture(tex0, uv_r);
    vec4 pic_g = texture(tex0, uv_g);
//  vec4 pic_g = texture(tex0, uv_g);
    vec4 pic_b = texture(tex0, uv_b);
//  vec4 pic_b = texture(tex0, uv_b);

    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    vec4 fragColor =
//  vec4 fragColor =
    vec4(pic_r.r
//  vec4(pic_r.r
    ,    pic_g.g
//  ,    pic_g.g
    ,    pic_b.b
//  ,    pic_b.b
    ,    1.0);
//  ,    1.0);

    // Color correction
//  // Color correction
    // Color correction
//  // Color correction
    fragColor += vec4(-0.4, -0.7, -0.1, 0.0);
//  fragColor += vec4(-0.4, -0.7, -0.1, 0.0);

    // Old TV/monitor vibe
//  // Old TV/monitor vibe
    // Old TV/monitor vibe
//  // Old TV/monitor vibe
    fragColor =
//  fragColor =
    fragColor + 0.1
//  fragColor + 0.1
    * sin(uv.y
//  * sin(uv.y
    *    700.0);
//  *    700.0);

    // Vignette
//  // Vignette
    // Vignette
//  // Vignette
    uv *= 1.0 - uv.yx;
//  uv *= 1.0 - uv.yx;
    float vig = uv.x * uv.y * 15.0;
//  float vig = uv.x * uv.y * 15.0;
    // Multiply with sth for intensity
//  // Multiply with sth for intensity
    // Multiply with sth for intensity
//  // Multiply with sth for intensity
    vig = pow(vig , 0.2);
//  vig = pow(vig , 0.2);
    // Change pow for modifying the extent of the vignette
//  // Change pow for modifying the extent of the vignette
    // Change pow for modifying the extent of the vignette
//  // Change pow for modifying the extent of the vignette
    fragColor *= vec4(vig);
//  fragColor *= vec4(vig);

    glslFragColor  = fragColor;
//  glslFragColor  = fragColor;
    }





    // https://www.shadertoy.com/view/ctjGzh
//  // https://www.shadertoy.com/view/ctjGzh


