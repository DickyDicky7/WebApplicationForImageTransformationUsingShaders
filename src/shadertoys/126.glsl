#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/3dVcDV

#define pi 3.14159265359

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

/////////////////////////////////////
/////////////////////////////////////

mat2 get_rotation_matirx(float rot) {
    return mat2(
        cos(rot), -sin(rot), 
        sin(rot), cos(rot)
    );
}

vec2 rotate_uv(vec2 uv, vec3 iResolution, mat2 rotation, float zoom) {
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

/////////////////////////////////////
/////////////////////////////////////



const float rotation_count = 3.;
const float speed = 3.;
// const float diameter = 0.2;



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    float rotation_ratio = 2. * rotation_count * pi;
    float time = mod(speed * iTime, 2.*pi) - pi;
    time *= step(0., time);
    
    
    float diameter = 0.2 + 0.07 * (-(cos(2.*time)-1.)/2.);
    
    
    vec2 uv = (fragCoord/iResolution.x - 
               vec2(0.5, 0.5*iResolution.y/iResolution.x));
    
    float rot = rotation_ratio * (-(cos(time)-1.)/2.);
    bool is_inside = length(uv) < diameter;
    float zoom = 0.;
    if (is_inside) {
        rot *= -1.;
        // zoom = 0. * (-(cos(2.*time)-1.)/2.);
    }
    
    mat2 rotation = get_rotation_matirx(rot);
    uv = fragCoord/iResolution.xy;
    uv = rotate_uv(uv, iResolution, rotation, zoom);
    
    bool change_scene = int((speed*iTime+pi/2.)/(2.*pi)) % 2 == 0;
    vec3 col = (change_scene) 
        ? texture(iChannel0, uv).rgb 
        : texture(iChannel1, uv).rgb;
    
    
    //////////////////////////
    ///    Spining blur    ///
    //////////////////////////
    
    float numSteps = float(int(15. * (-(cos(2.*time)-1.)/2.)));
    float sigma = 0.01;
    for (float i=1.; i<numSteps; i++)
    {
        rotation = get_rotation_matirx(i*sigma);
        uv = rotate_uv(uv, iResolution, rotation, zoom);
        col += (change_scene) 
            ? texture(iChannel0, uv).rgb 
            : texture(iChannel1, uv).rgb;
    }
    if (numSteps != 0.)
        col /= numSteps;
    
    //////////////////////////
    //////////////////////////
    
    if (!is_inside) {
        vec3 hsv = rgb2hsv(col);
        hsv.g *= 1. - (-(cos(2.*time)-1.)/2.);
        col = hsv2rgb(hsv);
    }
    
    fragColor = vec4(col,1.0);
}









