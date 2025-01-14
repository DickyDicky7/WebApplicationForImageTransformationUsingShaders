#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/7dy3zV

    float rand(vec2 co) { return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453); }
//  float rand(vec2 co) { return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453); }

mat2 get_rotation_matirx(float rot) {
    return mat2(
        cos(rot), -sin(rot)
    ,   sin(rot),  cos(rot)
    );
}

vec2 rotate_uv(vec2 uv, mat2 rotation, float zoom) {
    uv -= 0.5       ; uv.x = uv.x * canvasSize.x / canvasSize.y; uv  = rotation * uv;
    uv *= 1.0 - zoom; uv.x = uv.x / canvasSize.x * canvasSize.y; uv += 0.5          ;
    uv =        abs(uv)     ;
    uv = step(1.0 , uv) * 2.0
       + sign(1.0 - uv) * uv;
    return uv;
}


uniform float   rotation ; // 00.30
uniform float   rot_freq ; // 07.00
uniform float flesh_freq ; // 10.00
uniform float zoom_speed ; // 00.30
uniform float zoom_power ; // 00.15




void main()
{
    vec2 uv = vTexCoord;
    
    float time1 = float(int(time *   rot_freq)) /   rot_freq;
    float time2 = float(int(time * flesh_freq)) / flesh_freq;
    
    float random1 = rand(vec2(mod(time1      , 1.0)));
    float random2 = rand(vec2(mod(time1 + 0.1, 1.0)));
    float random3 = rand(vec2(mod(time2      , 1.0)));
    
    
    float rot1 = rotation * random1 - rotation * 0.35;
    float rot2 = rotation * random2 - rotation * 0.35;
    
    float zoom = mod(zoom_speed * time, zoom_power);
    
    mat2
    rot_matrix = get_rotation_matirx(rot1); uv = rotate_uv(uv, rot_matrix, zoom); vec3 col1 = texture(tex0, uv).rgb;
    rot_matrix = get_rotation_matirx(rot2); uv = rotate_uv(uv, rot_matrix, zoom); vec3 col2 = texture(tex0, uv).rgb;
    
    
    col1 = mix          (
    col1 ,
    col2 , 0.5 * random1);
    
    
    col1  = vec3(smoothstep(0.05, 0.9, length(col1) / sqrt(3.0)));
//  col1  = vec3(smoothstep(0.05, 0.9, length(col1) / sqrt(3.0)));
    col1 *= 0.35 + random3; // smoothstep(0.1, 1.0, random3);
//  col1 *= 0.35 + random3; // smoothstep(0.1, 1.0, random3);
    
    fragColor = vec4(col1, 1.0);
//  fragColor = vec4(col1, 1.0);
}
































