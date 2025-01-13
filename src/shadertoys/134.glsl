#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/sdlXRr

const float shake_speed = 30.;

const float shake_power = 0.3;
const float zoom_power = 0.4;

const float motion_blur_power = 0.005;
const float motion_blur_iter = 10.;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = mod(iTime, 1.);
    float ratio = pow(1. - time, 2.);
    ratio *= -tanh(5. * (time - 0.5)) * 0.5 + 0.5;
    
    vec2 uv = fragCoord/iResolution.xy;
    
    ///////////////
    //   Shake   //
    ///////////////
    uv -= 0.5;
    uv += shake_power * ratio * vec2(sin(shake_speed * time), 
                                     cos(shake_speed * time));
    uv *= 1. - zoom_power * ratio;
    uv += 0.5;
    
    uv = abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv;

    /////////////////////
    //   Motion blur   //
    /////////////////////
    vec3 col = vec3(0.);
    vec2 hold_uv;
    for (float i = -motion_blur_iter/2.; i < motion_blur_iter/2.; ++i) {
        hold_uv = vec2(uv.x + ratio * motion_blur_power * i, 
                       uv.y + ratio * motion_blur_power * i);
        col += texture(iChannel0, hold_uv).rgb;
    }
    col /= motion_blur_iter;
    col += pow(ratio, 2.) * col;
    
    
    fragColor = vec4(col,1.0);
}














