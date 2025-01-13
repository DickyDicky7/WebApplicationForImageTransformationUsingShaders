#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4cdfWl


float easeInOutQuad(float t) {
    return t < 0.5 ? 2.0 * t * t : -1.0 + (4.0 - 2.0 * t) * t;
}

// Cubic Easing
float easeInCubic(float t) {
    return t * t * t;
}

float easeOutCubic(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

float easeInOutCubic(float t) {
    return t < 0.5 ? 4.0 * t * t * t : (t - 1.0) * (2.0 * t - 2.0) * (2.0 * t - 2.0) + 1.0;
}

// Quartic Easing
float easeInQuart(float t) {
    return t * t * t * t;
}

float easeOutQuart(float t) {
    float f = t - 1.0;
    return 1.0 - f * f * f * f;
}

float easeInOutQuart(float t) {
    return t < 0.5 ? 8.0 * t * t * t * t : 1.0 - 8.0 * (t - 1.0) * (t - 1.0) * (t - 1.0) * (t - 1.0);
}

// Sine Easing
float easeInSine(float t) {
    return 1.0 - cos((t * 3.141592653589793) / 2.0);
}

float easeOutSine(float t) {
    return sin((t * 3.141592653589793) / 2.0);
}

float easeInOutSine(float t) {
    return -0.5 * (cos(3.141592653589793 * t) - 1.0);
}

// Exponential Easing
float easeInExpo(float t) {
    return t == 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0));
}

float easeOutExpo(float t) {
    return t == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

float easeInOutExpo(float t) {
    if (t == 0.0) return 0.0;
    if (t == 1.0) return 1.0;
    return t < 0.5 ? 0.5 * pow(2.0, 20.0 * t - 10.0) : 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0);
}

// Back Easing
float easeInBack(float t) {
    const float c1 = 1.70158;
    return (c1 + 1.0) * t * t * t - c1 * t * t;
}

float easeOutBack(float t) {
    const float c1 = 1.70158;
    float f = t - 1.0;
    return 1.0 + (c1 + 1.0) * f * f * f + c1 * f * f;
}

float easeInOutBack(float t) {
    const float c1 = 1.70158;
    const float c2 = c1 * 1.525;
    return t < 0.5
        ? (pow(2.0 * t, 2.0) * ((c2 + 1.0) * 2.0 * t - c2)) / 2.0
        : (pow(2.0 * t - 2.0, 2.0) * ((c2 + 1.0) * (t * 2.0 - 2.0) + c2) + 2.0) / 2.0;
}



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    vec4 color = vec4(0.0,1.0,1.0,1.0);
    color *= 1.0;

    float T_MAX = 1.50;
    float time = mod(iTime, T_MAX);
    float t = time/ T_MAX;
    //t = 0.5;
    //t = 1.0-t;
    
    //t = 1.0;
    //t = 0.01;
    //t = 0.25;
    
    float progress = t;
    //progress = easeOutExpo(progress);
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    

    float stretch  = 0.0;
    float ts = mix(0.0,1.5,progress);
    stretch = abs(ts-uv.y) ; // / 0.25 ;
    stretch = 1.0 - stretch;
    stretch =  clamp(stretch,0.0 ,1.0);
    
    
    float thickness= mix(100.0,2.0,0.99);
    stretch = pow(stretch,thickness);
    
    float xmask = 1.0;
    if (ts-uv.y < 0.0)
    {
        xmask = 0.0;
        stretch = 0.0;
    }
    
    fragColor = vec4(stretch);
    
    vec4 oColor =  vec4(0.0);
    
    
    //uv.y += stretch*0.15*-1.0;
    //oColor = texture(iChannel0, uv);
    
    float y = uv.y;
    uv.y = y + (stretch*0.25*-1.0);
    oColor.r = texture(iChannel0, uv).r * mix(1.0,5.0,stretch);
    uv.y = y + (stretch*0.20*-1.0);
    oColor.g = texture(iChannel0, uv).g * mix(1.0,5.0,stretch);
    uv.y = y + (stretch*0.15*-1.0);
    oColor.b = texture(iChannel0, uv).b * mix(1.0,5.0,stretch);
    oColor.a = 1.0;
    
    
    //float xcolor = pow((1.0 - stretch),1.0);
    //oColor *= xmask * (1.0 - stretch);
    oColor *= xmask * (1.0 - stretch);
    //oColor *= xmask;
    
    //oColor = mix(oColor * color,oColor,1.0 - stretch);
    
    /*
    oColor.r *= pow((1.0 - stretch),20.0) ;
    oColor.g *= pow((1.0 - stretch),1.0) ;
    oColor.b *= pow((1.0 - stretch),20.0) ;
    */
    fragColor = oColor;
    
}