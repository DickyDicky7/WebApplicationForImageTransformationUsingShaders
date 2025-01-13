#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/mddyD4

float randomNoise(float x, float y){
    return fract(sin(dot(vec2(x,y), vec2(12.9, 78.2))) * 43758.0);
}
vec4 methed1(in vec2 uv){
    // 简单版，运动恒定的左右RGB色彩分离
    float _Intensity = 0.05;
    float splitAmount = _Intensity * randomNoise(iTime, 2.0);
    vec4 ColorR = texture(iChannel0, vec2(uv.x + splitAmount, uv.y));
    vec4 ColorG = texture(iChannel0, uv);
    vec4 ColorB = texture(iChannel0, vec2(uv.x - splitAmount, uv.y));
    return vec4(ColorR.r,ColorG.g,ColorB.b, ColorR.a);
}

vec4 methed2(in vec2 uv){
    // 利用sin和pow控制抖动间隔、幅度，以及抖动的曲线
    float _Amplitude = 2.0;
    float _Amount = 0.2;
    float splitAmount = (1.0 + sin(iTime * 6.0) * 0.5);
    splitAmount *= 1.0 + sin(iTime * 16.0) * 0.5;
    splitAmount *= 1.0 + sin(iTime * 19.0) * 0.5;
    splitAmount *= 1.0 + sin(iTime * 27.0) * 0.5;
    splitAmount = pow(splitAmount, _Amplitude);
    splitAmount *= (0.05 * _Amount);
    vec3 finalColor;
    finalColor.r = texture(iChannel0, vec2(uv.x + splitAmount, uv.y)).r;
    finalColor.g = texture(iChannel0, uv).g;
    finalColor.b = texture(iChannel0, vec2(uv.x - splitAmount, uv.y)).b;
    finalColor *= (1.0 - splitAmount * 0.5);
    return vec4(finalColor, 1.0);
}
vec4 methed3(vec2 uv){
    // 利用sin函数，实现平缓左右摇摆RGB分离
    float strength = 0.5 + 0.5 * cos(iTime * 15.2);
    float _Amount = 0.08 *strength;
    vec3 splitAmountX = vec3(uv.x, uv.x, uv.x);
    splitAmountX.r += sin(iTime * 0.2) * _Amount;
    splitAmountX.g += sin(iTime * 0.1) * _Amount;
    vec4 splitColor = vec4(0.0);
    splitColor.r = texture(iChannel0, vec2(splitAmountX.r, uv.y)).r;
    splitColor.g = texture(iChannel0, vec2(splitAmountX.g, uv.y)).g;
    splitColor.b = texture(iChannel0, vec2(splitAmountX.b, uv.y)).b;
    splitColor.a = 1.0;
    vec3 color = splitColor.rgb;
    return vec4(color, 1.0);
}
vec4 methed4(vec2 uv){
    // 利用sin函数，实现平缓上下摇摆RGB分离
    float strength = 0.5 + 0.5 * cos(iTime * 15.2);
    float _Amount = 0.08 * strength;
    vec3 splitAmountY = vec3(uv.y);
    splitAmountY.r += sin(iTime * 0.2) * _Amount;
    splitAmountY.g += sin(iTime * 0.1) * _Amount;
    vec4 splitColor = vec4(0.0);
    splitColor.r = texture(iChannel0, vec2(uv.x, splitAmountY.r)).r;
    splitColor.g = texture(iChannel0, vec2(uv.x, splitAmountY.g)).g;
    splitColor.b = texture(iChannel0, vec2(uv.x, splitAmountY.b)).b;
    splitColor.a = 1.0;
    return splitColor;
}
vec4 methed5(vec2 uv){
   // 利用sin函数，实现平缓左下右上摇摆RGB分离
    float strength = 0.5 + 0.5 * sin(iTime * 15.2);
    float _Amount = 0.08 * strength;
    float splitAmountR = sin(iTime * 0.2) * _Amount;
    float splitAmountG = sin(iTime * 0.2) * _Amount;
    vec4 splitColor = vec4(0.0);
    splitColor.r = (texture(iChannel0, vec2(uv.x +splitAmountR, uv.y +splitAmountR)).rgb).x;;
    splitColor.g = (texture(iChannel0, vec2(uv.x, uv.y)).rgb).y;
    splitColor.b = (texture(iChannel0, vec2(uv.x + splitAmountG, uv.y + splitAmountG)).rgb).z;
    splitColor.a = 1.0;
    return splitColor;
}

vec4 methed6(vec2 uv){
    //使用随机噪声，实现左下右上RGB色彩分离
    float _Indensity = 0.05;
    float splitAmount = _Indensity * randomNoise(iTime, 2.0);
    vec4 ColorR = texture(iChannel0, uv);
    vec4 ColorG = texture(iChannel0, vec2(uv.x + splitAmount, uv.y + splitAmount));
    vec4 ColorB = texture(iChannel0, vec2(uv.x - splitAmount, uv.y - splitAmount));
    return vec4(ColorR.r, ColorG.g, ColorB.b, 1.0);
}
vec4 Pow4(vec4 v, float p){
    return vec4(pow(v.x, p), pow(v.y, p), pow(v.z, p), v.w);
}



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    fragColor = methed2(uv);
}