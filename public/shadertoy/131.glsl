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

    // https://www.shadertoy.com/view/sslXzf
//  // https://www.shadertoy.com/view/sslXzf

    mat2 get_rotation_matirx(float rot) { return mat2( cos(rot), -sin(rot), sin(rot), cos(rot) ); }
//  mat2 get_rotation_matirx(float rot) { return mat2( cos(rot), -sin(rot), sin(rot), cos(rot) ); }

    vec2 rotate_uv(vec2 uv, mat2 rotation) {
//  vec2 rotate_uv(vec2 uv, mat2 rotation) {
    uv -= 0.5;
//  uv -= 0.5;
    uv.x = uv.x * canvasSize.x / canvasSize.y;
//  uv.x = uv.x * canvasSize.x / canvasSize.y;
    uv = rotation * uv;
//  uv = rotation * uv;
    uv.x = uv.x / canvasSize.x * canvasSize.y;
//  uv.x = uv.x / canvasSize.x * canvasSize.y;
    uv += 0.5;
//  uv += 0.5;
    
    uv =      abs(uv);
//  uv =      abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv;
//  uv = step(1., uv) * 2. + sign(1.-uv) * uv;
    return                                 uv;
//  return                                 uv;
    }
//  }

    vec3 blur(vec2 uv, float strength) {
//  vec3 blur(vec2 uv, float strength) {
    vec2 power = vec2(strength) / canvasSize.xy; vec3 result = vec3(0.);
//  vec2 power = vec2(strength) / canvasSize.xy; vec3 result = vec3(0.);
    for (float i = -2.0; i <= 1.0; ++i) {
//  for (float i = -2.0; i <= 1.0; ++i) {
    for (float j = -2.0; j <= 1.0; ++j) {
//  for (float j = -2.0; j <= 1.0; ++j) {
    result += texture(tex0, uv + power * vec2(i,j)).rgb;
//  result += texture(tex0, uv + power * vec2(i,j)).rgb;
    }
//  }
    }
//  }
    result /= 16.0;
//  result /= 16.0;
    return  result;
//  return  result;
    }
//  }


    uniform float shake_speed ; // 20.0
//  uniform float shake_speed ; // 20.0
    uniform float shake_power ; // 00.7
//  uniform float shake_power ; // 00.7
    uniform float   rot_power ; // 00.3
//  uniform float   rot_power ; // 00.3


    void main() { float remapTime = mod(0.7 * time, 1.); float ratio = 1. - remapTime; ratio *= -tanh(5. * (remapTime - 0.5)) * 0.5 + 0.5; vec2 uv = vTexCoord; float rot = rot_power * pow(ratio, 2.2) * sin(1.5 * shake_speed * remapTime); uv += pow(ratio, 3.) * shake_power * vec2(0., -cos(shake_speed * remapTime)); mat2 rotation = get_rotation_matirx(rot); uv = rotate_uv(uv, rotation); vec3 col = blur(uv, 5.*ratio); /* texture(tex0, uv).rgb; */ col += ratio * ratio * col; fragColor = vec4(col, 1.); }




















