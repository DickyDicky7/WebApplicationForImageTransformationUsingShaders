#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D    uploadTex0; // null
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/wdKyDt

#define pi 3.14159265359

    mat2 get_rotation_matirx(float rot) { return mat2( cos(rot), -sin(rot), sin(rot), cos(rot) ); }
//  mat2 get_rotation_matirx(float rot) { return mat2( cos(rot), -sin(rot), sin(rot), cos(rot) ); }

    vec2 rotate_uv(vec2 uv, vec2 center, vec2 iResolution, mat2 rotation) { uv -= center; uv.x = uv.x * iResolution.x / iResolution.y; uv = rotation * uv; uv.x = uv.x / iResolution.x * iResolution.y; uv += center; uv = abs(uv); uv = step(1., uv) * 2. + sign(1. - uv) * uv; return uv; }
//  vec2 rotate_uv(vec2 uv, vec2 center, vec2 iResolution, mat2 rotation) { uv -= center; uv.x = uv.x * iResolution.x / iResolution.y; uv = rotation * uv; uv.x = uv.x / iResolution.x * iResolution.y; uv += center; uv = abs(uv); uv = step(1., uv) * 2. + sign(1. - uv) * uv; return uv; }

/////////////////////////////////////
/////////////////////////////////////



uniform float rotation_count ; //  3.00
uniform float          speed ; //  3.00
uniform float side           ; //  0.19
uniform vec2  move           ; // -0.02, 0.1



void main()
{
    float rotation_ratio = 2. * rotation_count * pi; float remapTime = mod(speed * time, 2. * pi) - pi; remapTime *= step(0., remapTime); float rot = rotation_ratio * (-(cos(remapTime) - 1.) / 2.); mat2 rotation = get_rotation_matirx(rot); vec2 uv = gl_FragCoord.xy / canvasSize.x; vec2 center = side * round((uv + move) / side); center -= move; center.y = center.y * canvasSize.x / canvasSize.y; uv = gl_FragCoord.xy/canvasSize.xy; uv = rotate_uv(uv, center, canvasSize, rotation);
//  float rotation_ratio = 2. * rotation_count * pi; float remapTime = mod(speed * time, 2. * pi) - pi; remapTime *= step(0., remapTime); float rot = rotation_ratio * (-(cos(remapTime) - 1.) / 2.); mat2 rotation = get_rotation_matirx(rot); vec2 uv = gl_FragCoord.xy / canvasSize.x; vec2 center = side * round((uv + move) / side); center -= move; center.y = center.y * canvasSize.x / canvasSize.y; uv = gl_FragCoord.xy/canvasSize.xy; uv = rotate_uv(uv, center, canvasSize, rotation);
    
    bool change_scene = int((speed * time + pi / 2.) / (2. * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb  : texture(uploadTex0, uv).rgb;
//  bool change_scene = int((speed * time + pi / 2.) / (2. * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb  : texture(uploadTex0, uv).rgb;
    
    //////////////////////////
    ///    Spining blur    ///
    //////////////////////////
    
    float numSteps = float(int(10. * (-(cos(2. * remapTime) - 1.) / 2.))); float sigma = 0.01; for (float i = 1.; i < numSteps; i++) { rotation = get_rotation_matirx(i * sigma); uv = rotate_uv(uv, center, canvasSize, rotation); col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.) col /= numSteps;
//  float numSteps = float(int(10. * (-(cos(2. * remapTime) - 1.) / 2.))); float sigma = 0.01; for (float i = 1.; i < numSteps; i++) { rotation = get_rotation_matirx(i * sigma); uv = rotate_uv(uv, center, canvasSize, rotation); col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.) col /= numSteps;
    
    //////////////////////////
    //////////////////////////
    
    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
}













