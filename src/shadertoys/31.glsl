#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D        bayer0; // null
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// #define H_STEPS 10.0
// #define S_STEPS 03.0
// #define V_STEPS 03.0
// #define DITHER_WIDTH 0.5
// #define TIME (time * 0.2)

uniform float H_STEPS      ; // 10.0
uniform float S_STEPS      ; // 03.0
uniform float V_STEPS      ; // 03.0
uniform float DITHER_WIDTH ; // 00.5
#define TIME (time * 0.2)



vec3 rgbToHsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg , K.wz ), vec4(c.gb , K.xy ), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r  ), vec4(c.r  , p.yzx), step(p.x, c.r));

    float d =    q.x - min(q.w , q.y);
    float e =    1.0e-10             ;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsvToRgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p =     abs(       fract(c.xxx + K.xyz) * 6.0 -       K.www);
    return c.z * mix(K.xxx, clamp(p     - K.xxx  , 0.0 , 1.0), c.y  );
}

float orderedDither(float     value, 
                    vec2  fragCoord, 
                    float     steps, 
                    float     width) {
    float bayer  =  texture(bayer0, (fragCoord / canvasSize.xy) * 0.1250).r;
          value *=          steps ;
    float ditherMix = fract(value);
          ditherMix = smoothstep(0.5 - width * 0.5
                    ,            0.5 + width * 0.5,  ditherMix          )  ;
    float  darkerColor = floor(value      ) / steps;
    float lighterColor = floor(value + 1.0) / steps;
    
    return mix(darkerColor, lighterColor, 1.0 - step(ditherMix, bayer)  )  ;
}

void main() {
    vec2       fragCoord =     gl_FragCoord.xy;
    vec2 uv = (fragCoord * 2.0 - canvasSize.xy) 
                               / canvasSize.x ;

    vec4 color  = vec4 (smoothstep(1.0, 0.0,   length(uv                                   ))) * vec4(0.5, 0.3, 1.0, 0.0);
         color += vec4 (smoothstep(0.4, 0.0, distance(uv, 0.4 *  vec2(sin(TIME), cos(TIME))))) * vec4(1.0, 0.5, 0.2, 0.0);
         color += vec4 (smoothstep(0.4, 0.0, distance(uv, 0.4 * -vec2(sin(TIME), cos(TIME))))) * vec4(0.4, 1.0, 0.6, 0.0);
         color  = clamp(color    , 0.0, 1.0);
    
    if (fragCoord.y > mousePosition.y) {
        uv = fragCoord / canvasSize.xy;
                                       color = texture(tex0, uv);
    }
    
    if (fragCoord.x > mousePosition.x) {
        vec3 
        colorInHsv = rgbToHsv(color.rgb );
        
        colorInHsv.x = orderedDither(colorInHsv.x, fragCoord, H_STEPS, DITHER_WIDTH);
        colorInHsv.y = orderedDither(colorInHsv.y, fragCoord, S_STEPS, DITHER_WIDTH);
        colorInHsv.z = orderedDither(colorInHsv.z, fragCoord, V_STEPS, DITHER_WIDTH);
        
        color.rgb  = hsvToRgb(colorInHsv);
    }
    
    fragColor = vec4(color);
}



// https://www.shadertoy.com/view/tdsBzX

