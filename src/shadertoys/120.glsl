#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/wdKyDt

#define pi 3.14159265359

mat2 get_rotation_matirx(float rot) {
    return mat2(
        cos(rot), -sin(rot), 
        sin(rot), cos(rot)
    );
}

vec2 rotate_uv(vec2 uv, vec2 center, vec3 iResolution, mat2 rotation) {
    uv -= center;
    uv.x = uv.x * iResolution.x / iResolution.y;
    uv = rotation * uv;    
    uv.x = uv.x / iResolution.x * iResolution.y;
    uv += center;
    uv = abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv;
    return uv;
}

/////////////////////////////////////
/////////////////////////////////////



const float rotation_count = 3.;
const float speed = 3.;
const float side = 0.19;
const vec2 move = vec2(-0.02, 0.1);



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float rotation_ratio = 2. * rotation_count * pi;
    float time = mod(speed * iTime, 2.*pi) - pi;
    time *= step(0., time);
    
    float rot = rotation_ratio * (-(cos(time)-1.)/2.);
    mat2 rotation = get_rotation_matirx(rot);
    
    vec2 uv = fragCoord/iResolution.x;
    vec2 center = side * round((uv + move)/side);
    center -= move;
    center.y = center.y * iResolution.x / iResolution.y;
    
    uv = fragCoord/iResolution.xy;
    uv = rotate_uv(uv, center, iResolution, rotation);
    
    
    bool change_scene = int((speed*iTime+pi/2.)/(2.*pi)) % 2 == 0;
    vec3 col = (change_scene) 
        ? texture(iChannel0, uv).rgb 
        : texture(iChannel1, uv).rgb;
    
    //////////////////////////
    ///    Spining blur    ///
    //////////////////////////
    
    float numSteps = float(int(10. * (-(cos(2.*time)-1.)/2.)));
    float sigma = 0.01;
    for (float i=1.; i<numSteps; i++)
    {
        rotation = get_rotation_matirx(i*sigma);
        uv = rotate_uv(uv, center, iResolution, rotation);
        col += (change_scene) 
            ? texture(iChannel0, uv).rgb 
            : texture(iChannel1, uv).rgb;
    }
    if (numSteps != 0.)
        col /= numSteps;
    
    //////////////////////////
    //////////////////////////
    
    
    fragColor = vec4(col,1.0);
}








