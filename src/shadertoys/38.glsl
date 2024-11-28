#version 300 es
precision highp float;

uniform         sampler2D          tex0; //texture
uniform         sampler2D          tex1; //bayer
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float angle      = 20.0;
const float scale      = 01.5;
const float     amount = 04.0;
const float saturation = 01.2;
const bool   greyscale = true;
const bool   colorOn   = true;

#define   LINE
#define DOT
#define DITHER

float greyScale(in    vec3 col) {
    return  dot(col , vec3(0.2126
                    ,      0.7152
                    ,      0.0722
                          )
               )    ;
}

mat2 rotate2d(float angle) {
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

void main(void) {
    vec2  uv = gl_FragCoord. xy
             /   canvasSize. xy     ;
    vec3 col = texture(tex0, uv).rgb;
    if (greyscale) col = vec3(greyScale(col));
    
    uv      *=   canvasSize. xy;
    vec2 p   =   rotate2d(angle)
            *                uv
            *             scale;
    
    float pattern;
    #ifdef   LINE
    pattern = sin(p.x)   *              amount       ;
    col     = col * 10.0 * saturation - 5.0 + pattern;
    #endif

    #ifdef DOT
    pattern = sin(p.x)   * sin(p.y)   * amount       ;
    col     = col * 10.0 * saturation - 5.0 + pattern;
    #endif
    
    #ifdef DITHER
    pattern = texture(tex1, gl_FragCoord.xy / 4.0 * scale).r * amount / 5.0;
    col     =                                                               step(pattern, col * saturation / 1.2);
    #endif

        fragColor  =    vec4(col ,  1.0     );
    if (colorOn) {
        fragColor *= texture(tex0, vTexCoord);
    }
}



// https://www.shadertoy.com/view/tdBSRc
