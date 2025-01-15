#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/DtlXW8

#define pi 3.14159265359

float random2d(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float randomRange(vec2 seed, float _min, float _max) {
    return _min + random2d(seed) * (_max - _min);
}


const float speed = 10.0;

const float x_density = 20.0;
const float y_density = 25.0;

const float x_randomness = 4.0;
const float y_randomness = 4.0;

const float x_in_between_thickness = 0.0;  // 0.01;
const float y_in_between_thickness = 0.0; // 0.02;

const float x_shift_power = 0.02;
const float y_shift_power = 0.05;

const float col_shift_x_power = 0.02;
const float col_shift_y_power = 0.02;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = floor(iTime * speed);
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    float x_coef_1 = randomRange(vec2(time, 32.34), 5.0, 10.0);
    float y_coef_1 = randomRange(vec2(time, 98.45), 5.0, 10.0);
    float x_coef_2 = random2d(vec2(15.43, time));
    float y_coef_2 = random2d(vec2(45.34, time));
    
    float x = x_coef_1 * (uv.x + x_coef_2);
    float y = y_coef_1 * (uv.y + y_coef_2);
    
    float x_coef_3 = x_randomness * sin(4.0 * x);
    float y_coef_3 = y_randomness * sin(4.0 * y);
    
    float final_x = sin(x_density * x + x_coef_3);
    float final_y = sin(y_density * y + y_coef_3);
    
    float x_threshold = 1.0-step(1.0-x_in_between_thickness, final_x);
    float y_threshold = step(y_in_between_thickness-1.0, final_y);
    
    final_x = floor((x_density * x + x_coef_3 - 0.5*pi) / (2.0 * pi));
    final_y = floor((y_density * y + y_coef_3 + 0.5*pi) / (2.0 * pi));    
    
    float x_shift = randomRange(vec2(time, final_x), -x_shift_power, x_shift_power);
    float y_shift = randomRange(vec2(time, final_y), -y_shift_power, y_shift_power);    
    
    uv.y += x_threshold * x_shift;
    uv.x += y_threshold * y_shift;
    
    vec3 col = texture(iChannel0, uv).rgb;
    
    /////////////////////
    //   Color shift   //
    /////////////////////
    float rnd = random2d(vec2(time , 95.45));
    vec2 col_shift_uv = uv + vec2(
        randomRange(vec2(time , 48.64), -col_shift_x_power, col_shift_x_power), 
        randomRange(vec2(time , 25.63), -col_shift_y_power, col_shift_y_power)
    );
    if (rnd < 0.33)
        col.r = texture(iChannel0, col_shift_uv).r;
    else if (rnd < 0.66)
        col.g = texture(iChannel0, col_shift_uv).g;
    else
        col.b = texture(iChannel0, col_shift_uv).b;
    
    ///////////////////////////////////////////////
    ///////////////////////////////////////////////    
    
    fragColor = vec4(col, 1.0);
}

















