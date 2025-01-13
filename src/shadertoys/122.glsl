#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/3scBzH

#define pi 3.14159265359

const float speed = 3.;
const float side = 0.19;
const vec2 move = vec2(-0.12, 0.1);

const float rotation_count = 1.;
const float zoom_ratio = 2.;



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = mod(speed * iTime, 2.*pi) - pi;
    time *= step(0., time);
    
    ////////////////////////
    ///   Zoom formula   ///
    ////////////////////////
    float zoom = zoom_ratio * sign(time-pi/2.) * ( 1.-abs(cos(time)) );
    
    //////////////////////////////
    ///   Getting the center   ///
    //////////////////////////////
    vec2 uv = fragCoord/iResolution.x;
    vec2 center = side * round((uv + move)/side);
    center -= move;
    center.y = center.y * iResolution.x / iResolution.y;
    uv = fragCoord/iResolution.xy;
    
    /////////////////////////////
    ///   Applying the zoom   ///
    /////////////////////////////
    uv -= zoom * (center-vec2(0.5, 0.5));
    
    //////////////////
    ///   Mirror   ///
    //////////////////
    uv = abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv;
    
    ////////////////////////
    ///   Scene change   ///
    ////////////////////////
    bool change_scene = int((speed*iTime+pi/2.)/(2.*pi)) % 2 == 0;
    vec3 col = (change_scene) 
        ? texture(iChannel0, uv).rgb 
        : texture(iChannel1, uv).rgb;    
    
    
    fragColor = vec4(col,1.0);
}









