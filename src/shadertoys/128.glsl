#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/tsdyWf

////////////////////////////
////////////////////////////

const float SAMPLES = 10.; 

float decay = 0.97; 
float density = 0.15;

float threshold = 0.7;

////////////////////////////
////////////////////////////


float hash( vec2 p ){ return fract(sin(dot(p, vec2(41, 289)))*45758.5453); }
vec3 lOff(){ return vec3(0., 0., 0.); }
	

vec3 rainbow_1(float x) {    
    return vec3(
        (tanh(-10.*x + 2.) + 1.) * 0.5 + (tanh(10.*x - 7.) + 1.) * 0.5,
        (tanh(-10.*x + 3.) + 1.) * 0.5,
        (tanh(-10.*x + 6.) + 1.) * 0.5
    );
}
vec3 rainbow_2(float x) {
    return vec3(
        1.,
        (tanh(-10.*x + 6.) + 1.) * 0.5,
        (tanh(-10.*x + 3.) + 1.) * 0.5
    );
}
vec3 rainbow_3(float x) {
    return vec3(
        (tanh(-10.*x + 3.) + 1.) * 0.5,
        (tanh(-10.*x + 6.) + 1.) * 0.5,
        1.
    );
}



vec3 shine(vec2 original_uv, vec2 tuv) {
    vec2 dTuv = tuv*density/SAMPLES;
    vec4 currentColor;
    vec3 result = vec3(0.);
    
    float weight = 0.05;
    vec2 uv = original_uv;
    uv += dTuv*(hash(uv.xy)*2. - 1.);
    
    for(float i=0.; i < SAMPLES; i++){
        uv -= dTuv;
        currentColor = texture(iChannel0, uv);
        result += (
            step(threshold, length(currentColor.rgb)/sqrt(3.)) *
            currentColor.rgb * 
            rainbow_2(i/SAMPLES) * 
            weight
        );
        weight *= decay;
    }
    
    ////////////////////////////////
    ////////////////////////////////
    
    dTuv *= -1.;
    weight = 0.05;
    uv = original_uv;
    uv += dTuv*(hash(uv.xy)*2. - 1.);

    for(float i=0.; i < SAMPLES; i++){
        uv -= dTuv;
        currentColor = texture(iChannel0, uv);
        result += (
            step(threshold, length(currentColor.rgb)/sqrt(3.)) *
            currentColor.rgb * 
            rainbow_3(i/SAMPLES) * 
            weight
        );
        weight *= decay;
    }
    
    return result;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord ){
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    vec2 tuv;
    vec4 col = texture(iChannel0, uv.xy)*0.8;
    
    float x = 0.5;
    float y = 0.5;
    
    tuv = vec2(x, y);
    col.rgb += shine(uv, tuv);
    
    
    tuv = vec2(x, -y);
    col.rgb += shine(uv, tuv);
    
    fragColor = sqrt(smoothstep(0., 1., col));
}

