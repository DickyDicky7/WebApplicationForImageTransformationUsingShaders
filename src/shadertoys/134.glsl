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

uniform float       shake_speed ; // 30.000
uniform float       shake_power ; // 00.300
uniform float        zoom_power ; // 00.400
uniform float motion_blur_power ; // 00.005
uniform float motion_blur_iters ; // 10.000


void main()
{
    float timee = mod(time, 1.0f); float ratio = pow(1.0f - timee, 2.0f); ratio *= -tanh(5.0f * (timee - 0.5f)) * 0.5f + 0.5f;
//  float timee = mod(time, 1.0f); float ratio = pow(1.0f - timee, 2.0f); ratio *= -tanh(5.0f * (timee - 0.5f)) * 0.5f + 0.5f;

    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;

    ///////////////
    //   Shake   //
    ///////////////
    uv -= 0.5;
    uv +=  shake_power * ratio
* vec2(sin(shake_speed * timee)
,      cos(shake_speed * timee));
    uv *= 1.0
       -    zoom_power * ratio  ;
    uv += 0.5;
    
    uv =                  abs(uv);
    uv = step(1.0 , uv) * 2.0
       + sign(1.0 - uv) *     uv ;

    /////////////////////
    //   Motion blur   //
    /////////////////////
    vec3 col = vec3(0.0);
    vec2 hold_uv;
    for (float i = - motion_blur_iters / 2.0;
               i   < motion_blur_iters / 2.0;
             ++i
        ) {
         hold_uv = vec2(uv.x + ratio * motion_blur_power * i
                 ,      uv.y + ratio * motion_blur_power * i);
         col += texture(tex0 , hold_uv).rgb;
//       col += texture(tex0 , hold_uv).rgb;
    }
    col /= motion_blur_iters;
//  col /= motion_blur_iters;
    col += pow(ratio, 2.0) * col;
//  col += pow(ratio, 2.0) * col;    
    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
}














