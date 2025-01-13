#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/sslXzf

mat2 get_rotation_matirx(float rot) {
    return mat2(
        cos(rot), -sin(rot), 
        sin(rot), cos(rot)
    );
}

vec2 rotate_uv(vec2 uv, mat2 rotation) {
    uv -= 0.5;
    uv.x = uv.x * iResolution.x / iResolution.y;
    uv = rotation * uv;
    uv.x = uv.x / iResolution.x * iResolution.y;
    uv += 0.5;
    
    uv = abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv;
    return uv;
}

vec3 blur(vec2 uv, float strength) {
    vec2 power = vec2(strength) / iResolution.xy;    
    vec3 result = vec3(0.);
    for (float i = -2.0; i <= 1.0; ++i) {
        for (float j = -2.0; j <= 1.0; ++j) {
            result += texture(iChannel0, uv + power * vec2(i,j)).rgb;
        }
    }
    result /= 16.0;
    return result;
}


const float shake_speed = 20.;
const float shake_power = 0.7;
const float rot_power = 0.3;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = mod(0.7 * iTime, 1.);
    float ratio = 1. - time;
    ratio *= -tanh(5. * (time - 0.5)) * 0.5 + 0.5;
    
    vec2 uv = fragCoord/iResolution.xy;
    
    float rot = rot_power * pow(ratio, 2.2) * sin(1.5 * shake_speed * time);
    uv += pow(ratio, 3.) * shake_power * vec2(0., -cos(shake_speed * time));
    
    mat2 rotation = get_rotation_matirx(rot);
    uv = rotate_uv(uv, rotation);
    
    vec3 col = blur(uv, 5.*ratio); // texture(iChannel0, uv).rgb;
    col += ratio * ratio * col;
    
    fragColor = vec4(col, 1.);
}





















