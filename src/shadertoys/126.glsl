#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D    uploadTex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/3dVcDV

#define pi 3.14159265359

    vec3 rgb2hsv(vec3 c) { vec4 K = vec4(0.0f, -1.0f / 3.0f, 2.0f / 3.0f, -1.0f); vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g)); vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r)); float d = q.x - min(q.w, q.y); float e = 1.0e-10f; return vec3(abs(q.z + (q.w - q.y) / (6.0f * d + e)), d / (q.x + e), q.x); }
//  vec3 rgb2hsv(vec3 c) { vec4 K = vec4(0.0f, -1.0f / 3.0f, 2.0f / 3.0f, -1.0f); vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g)); vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r)); float d = q.x - min(q.w, q.y); float e = 1.0e-10f; return vec3(abs(q.z + (q.w - q.y) / (6.0f * d + e)), d / (q.x + e), q.x); }

    vec3 hsv2rgb(vec3 c) { vec4 K = vec4(1.0f, 2.0f / 3.0f, 1.0f / 3.0f, 3.0f); vec3 p = abs(fract(c.xxx + K.xyz) * 6.0f - K.www); return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0f, 1.0f), c.y); }
//  vec3 hsv2rgb(vec3 c) { vec4 K = vec4(1.0f, 2.0f / 3.0f, 1.0f / 3.0f, 3.0f); vec3 p = abs(fract(c.xxx + K.xyz) * 6.0f - K.www); return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0f, 1.0f), c.y); }

/////////////////////////////////////
/////////////////////////////////////

    mat2 get_rotation_matirx(float rot) { return mat2(cos(rot), -sin(rot), sin(rot), cos(rot)); }
//  mat2 get_rotation_matirx(float rot) { return mat2(cos(rot), -sin(rot), sin(rot), cos(rot)); }

    vec2 rotate_uv(vec2 uv, vec2 iResolution, mat2 rotation, float zoom) { uv -= 0.5; uv.x = uv.x * iResolution.x / iResolution.y; uv = rotation * uv; uv *= 1. - zoom; uv.x = uv.x / iResolution.x * iResolution.y; uv += 0.5; uv = abs(uv); uv = step(1., uv) * 2. + sign(1.-uv) * uv; return uv; }
//  vec2 rotate_uv(vec2 uv, vec2 iResolution, mat2 rotation, float zoom) { uv -= 0.5; uv.x = uv.x * iResolution.x / iResolution.y; uv = rotation * uv; uv *= 1. - zoom; uv.x = uv.x / iResolution.x * iResolution.y; uv += 0.5; uv = abs(uv); uv = step(1., uv) * 2. + sign(1.-uv) * uv; return uv; }

/////////////////////////////////////
/////////////////////////////////////



uniform float rotation_count ; // 3.0
uniform float          speed ; // 3.0
//const float diameter       =    0.2;



void main()
{
    
    float rotation_ratio = 2.f * rotation_count * pi; float remapTime = mod(speed * time, 2.f * pi) - pi; remapTime *= step(0.f, remapTime); float diameter = 0.2f + 0.07f * (-(cos(2.f * remapTime) - 1.f) / 2.f); vec2 uv = (gl_FragCoord / canvasSize.x - vec2(0.5f, 0.5f * canvasSize.y / canvasSize.x));
//  float rotation_ratio = 2.f * rotation_count * pi; float remapTime = mod(speed * time, 2.f * pi) - pi; remapTime *= step(0.f, remapTime); float diameter = 0.2f + 0.07f * (-(cos(2.f * remapTime) - 1.f) / 2.f); vec2 uv = (gl_FragCoord / canvasSize.x - vec2(0.5f, 0.5f * canvasSize.y / canvasSize.x));
    
    float rot = rotation_ratio * (-(cos(remapTime) - 1.f) / 2.f); bool is_inside = length(uv) < diameter; float zoom = 0.f; if (is_inside) { rot *= -1.f; /* zoom = 0. * (-(cos(2. * time) - 1.) / 2.); */ } mat2 rotation = get_rotation_matirx(rot); uv = vTexCoord; uv = rotate_uv(uv, canvasSize, rotation, zoom); bool change_scene = int((speed * time + pi / 2.f) / (2.f * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb;
//  float rot = rotation_ratio * (-(cos(remapTime) - 1.f) / 2.f); bool is_inside = length(uv) < diameter; float zoom = 0.f; if (is_inside) { rot *= -1.f; /* zoom = 0. * (-(cos(2. * time) - 1.) / 2.); */ } mat2 rotation = get_rotation_matirx(rot); uv = vTexCoord; uv = rotate_uv(uv, canvasSize, rotation, zoom); bool change_scene = int((speed * time + pi / 2.f) / (2.f * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb;
    
    
    //////////////////////////
    ///    Spining blur    ///
    //////////////////////////
    
    float numSteps = float(int(15.f * (-(cos(2.f * remapTime) - 1.f) / 2.f))); float sigma = 0.01f; for (float i = 1.f; i < numSteps; i++) { rotation = get_rotation_matirx(i * sigma); uv = rotate_uv(uv, canvasSize, rotation, zoom); col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.f) col /= numSteps;
//  float numSteps = float(int(15.f * (-(cos(2.f * remapTime) - 1.f) / 2.f))); float sigma = 0.01f; for (float i = 1.f; i < numSteps; i++) { rotation = get_rotation_matirx(i * sigma); uv = rotate_uv(uv, canvasSize, rotation, zoom); col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.f) col /= numSteps;
    
    //////////////////////////
    //////////////////////////
    
    if (!is_inside) { vec3 hsv = rgb2hsv(col); hsv.g *= 1.f - (-(cos(2.f * remapTime) - 1.f) / 2.f); col = hsv2rgb(hsv); } fragColor = vec4(col, 1.0f);
//  if (!is_inside) { vec3 hsv = rgb2hsv(col); hsv.g *= 1.f - (-(cos(2.f * remapTime) - 1.f) / 2.f); col = hsv2rgb(hsv); } fragColor = vec4(col, 1.0f);
}














