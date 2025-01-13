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

uniform bool less ; // true

// Control constants
// Control constants
#define DITHER
#define     COLORDEPTH   1.0
#define GREYSCALEINPUT
#define               GREYSCALEOUTPUT
#define RESOLUTIONFACTOR 2.0
#define     TRUETRIANGLE

// Triangular function-based noise remapping
// Triangular function-based noise remapping
float remap_noise_tri_erp(const float v) {
    #if defined(TRUETRIANGLE)
    return  abs(fract(v + 0.5
                     )  - 0.5) + 0.25 ;
    #else
    float  r2 = 0.5  * v              ;
    float  f1 =        sqrt(r2       );
    float  f2 = 1.0  - sqrt(r2 - 0.25);
    return (v < 0.5) ? f1 : f2        ;
    #endif
}

vec3 ValveScreenSpaceDither(vec2 vScreenPos, float colorDepth) {
    vec3 vDither     =                                          vec3(dot(vec2(171.0, 231.0), vScreenPos.xy));
         vDither.rgb =                                                                                       fract(vDither.rgb / vec3(103.0, 71.0, 97.0));
    
    // Apply triangular function-based noise remapping
    // Apply triangular function-based noise remapping
    vDither.r = remap_noise_tri_erp(vDither.r) * 2.0 - 1.0;
    vDither.g = remap_noise_tri_erp(vDither.g) * 2.0 - 1.0;
    vDither.b = remap_noise_tri_erp(vDither.b) * 2.0 - 1.0;
    
    return vDither.rgb / colorDepth;
}

vec3 TextureDither(vec2 vScreenPos, float colorDepth) {
    vec2 bayer0Size = vec2(textureSize(bayer0, 0));
    float x = mod(vScreenPos.x / bayer0Size.x, float(canvasSize.x));
    float y = mod(vScreenPos.y / bayer0Size.y, float(canvasSize.y));
    vec3 vDither = texture(bayer0 , vec2(x, y) / RESOLUTIONFACTOR).rrr;
    
    return (0.5 - vDither);
}

void main() {
    float colorDepth = COLORDEPTH;
    vec2   fragCoord = floor(gl_FragCoord.xy 
                     / RESOLUTIONFACTOR) 
                     * RESOLUTIONFACTOR;
    
    // Fetch pixel color from the texture
    // Fetch pixel color from the texture
    vec3  finalColor = texture(tex0, fragCoord / canvasSize.xy).rgb;
    
    #if defined(GREYSCALEINPUT)
    finalColor = finalColor.rrr;
    #endif

    #if defined(DITHER)
//  if ( fragCoord.x < 0.5 * canvasSize.x )
    if (!less                             )
        finalColor += ValveScreenSpaceDither(fragCoord, colorDepth);
    else
        finalColor +=          TextureDither(fragCoord, colorDepth);
    #endif

    #if defined(GREYSCALEOUTPUT)
    finalColor = vec3(0.333 * (
    finalColor.r + 
    finalColor.g + 
    finalColor.b));
    #endif

    // Limiting color depth and outputting final color
    // Limiting color depth and outputting final color
    fragColor = vec4(floor(finalColor * colorDepth + 0.5) / colorDepth, 1.0);
}


// https://www.shadertoy.com/view/3tsSzl