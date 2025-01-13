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

float rand(vec2 co){ return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453); }

mat2 get_rotation_matirx(float rot) {
    return mat2(
        cos(rot), -sin(rot), 
        sin(rot), cos(rot)
    );
}

vec2 rotate_uv(vec2 uv, mat2 rotation, float zoom) {
    uv -= 0.5;
    uv.x = uv.x * iResolution.x / iResolution.y;
    uv = rotation * uv;
    uv *= 1. - zoom;
    uv.x = uv.x / iResolution.x * iResolution.y;
    uv += 0.5;
    uv = abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv;
    return uv;
}


const float rotation = 0.3;
const float rot_freq = 7.0;

const float flesh_freq = 10.0;

const float zoom_speed = 0.3;
const float zoom_power = 0.15;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    float time = float(int(iTime*rot_freq))/rot_freq;
    float time1 = float(int(iTime*flesh_freq))/flesh_freq;
    
    float random = rand(vec2(mod(time, 1.0)));
    float random1 = rand(vec2(mod(time+0.1, 1.0)));
    float random2 = rand(vec2(mod(time1, 1.0)));
    
    
    float rot = rotation * random - rotation*0.35;
    float rot1 = rotation * random1 - rotation*0.35;
    
    float zoom = mod(zoom_speed * iTime, zoom_power);
    
    mat2 rot_matrix = get_rotation_matirx(rot);
    uv = rotate_uv(uv, rot_matrix, zoom);
    vec3 col = texture(iChannel0, uv).rgb;
    
    rot_matrix = get_rotation_matirx(rot1);
    uv = rotate_uv(uv, rot_matrix, zoom);
    vec3 col1 = texture(iChannel0, uv).rgb;
    
    
    col = mix(col, col1, 0.5 * random);
    
    
    col = vec3(smoothstep(0.05, 0.9, length(col) / sqrt(3.0)));
    col *= 0.35 + random2; // smoothstep(0.1, 1.0, random2);
    
    fragColor = vec4(col,1.0);
}


























