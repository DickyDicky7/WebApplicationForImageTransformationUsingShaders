#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/wd3fR8

#define pi 3.14159265359

float get_ratio(float ratio, float start, 
                float finish, float power) 
{
    return pow(
        (
            step(start, ratio) * 
            step(-finish, -ratio) * 
            (ratio-start)/(finish-start)
        ),
        power
    );
}


const float speed = 0.6;
const float blur = 10.;
const float zoom = 0.3;

const vec3 strip_col = vec3(0.05); // vec3(30./255., 50./255., 50./255.);
const vec3 background_col = vec3(0.8);
const float strip_count = 5.;


////////////////////
///   Stage 1.   ///
////////////////////
const float start_1 = 0.0;
const float finish_1 = 0.3;
const float power_1 = 0.5;


////////////////////
///   Stage 2.   ///
////////////////////
const float start_2 = 0.3;
const float finish_2 = 0.7;
const float power_2 = 1.;


////////////////////
///   Stage 3.   ///
////////////////////
const float start_3 = 0.7;
const float finish_3 = 1.0;
const float power_3 = 2.;



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = mod(speed*iTime, 2.) - 1.;
    time *= step(0., time);
    
    bool change_scene = int((speed*iTime + start_2)/2.) % 2 == 0;
    float ratio = time;
    
    
    vec2 uv = fragCoord/iResolution.xy;
    
    float stage_1 = get_ratio(ratio, start_1, finish_1, power_1);
    float stage_2 = get_ratio(ratio, start_2, finish_2, power_2);
    float stage_3 = get_ratio(ratio, start_3, finish_3, power_3);
    
    
    ////////////////////
    ///   Stage 1.   ///
    ////////////////////
    uv -= 0.5;
    uv *= 1. + zoom * stage_1;
    uv += 0.5;
    
    
    ////////////////////
    ///   Stage 2.   ///
    ////////////////////
    uv -= 0.5;
    uv *= 1. + zoom * float(stage_2 > 0.);
    uv += 0.5;
    uv.y -= stage_2;
    
    
    ////////////////////
    ///   Stage 3.   ///
    ////////////////////
    uv -= 0.5;
    uv *= (stage_3 == 0.) ? 1. : 1. + zoom * (1.-stage_3);
    uv += 0.5;
    
    
    /////////////////////
    ///   Mirroring   ///
    /////////////////////
    if (uv.y < 0.) {
        if (stage_3 == 0.) {
            change_scene = !change_scene;
        }
        uv.y += 1.;
        if (uv.y < 0.) {
            if (stage_2 <= 0.) {
                change_scene = !change_scene;
            }
            uv.y += 1.;
        }
    } else if (uv.y > 1.) {
        if (stage_3 > 0.) {
            change_scene = !change_scene;
        }
        uv.y -= 1.;        
    }
        
    
    
    /////////////////////////////
    ///   Picking the color   ///
    /////////////////////////////
    vec3 col = (change_scene) 
        ? texture(iChannel0, uv).rgb 
        : texture(iChannel1, uv).rgb;
    
    
    
    //////////////////////
    ///   Background   ///
    //////////////////////
    vec2 real_uv = fragCoord/iResolution.xy;
    if (uv.x < 0. || uv.x > 1. ) {
        col = 1.5 * texture(iChannel2, real_uv).rgb;
        if (sin(strip_count*2.*pi*uv.y) >= 0.) {
            col = strip_col;
        }
    }
    if (uv.x < 0. && uv.x > -0.4*zoom/(2.*(1.+zoom)) ) {
        col = strip_col;
    }
    if (uv.x > 1. && uv.x < 1.+0.4*zoom/(2.*(1.+zoom)) ) {
        col = strip_col;
    }
    if (uv.x < -0.9*zoom/(2.*(1.+zoom))) 
    {
        col = strip_col;
    }
    if (uv.x > 1.+0.9*zoom/(2.*(1.+zoom)) ) {
        col = strip_col;
    }
    
    
    
    //////////////////////////
    ///    Sliding blur    ///
    //////////////////////////
    /*
    float numSteps = float(int(
        blur * sin(pi * pow(ratio, power))
    ));
    float sigma = 0.01;
    for (float i=1.; i<numSteps; i++)
    {
        uv.y -= sigma;
        col += (change_scene) 
            ? texture(iChannel0, uv).rgb 
            : texture(iChannel1, uv).rgb;
    }
    if (numSteps != 0.)
        col /= numSteps;
    */
    
    fragColor = vec4(col,1.0);
}









