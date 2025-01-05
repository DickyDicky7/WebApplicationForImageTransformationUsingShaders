#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// const float mask_softness  = 1.4; // negative values result in mask being inverted
// const float mask_threshold = 0.6;

// const float sort = 1.0;

uniform float mask_softness  ; // 1.4
uniform float mask_threshold ; // 0.6
uniform float sort           ; // 1.0

void main() {
    vec2  uv = vTexCoord;
    vec4 tex = texture(tex0, uv);
    
    // Masking
    // Masking
    float f = mask_softness / 2.0;
    float a = mask_threshold - f;
    float b = mask_threshold + f;
    float average =           (tex.x + tex.y +  tex.z ) / 3.0;
    float    mask = smoothstep(a     , b     , average)      ;
    
    // Pseudo Pixel Sorting
    // Pseudo Pixel Sorting
    float                      sort_threshold = 1.0 - clamp(sort / 2.6, 0.0, 1.0);
    vec2  sort_uv = vec2(uv.x, sort_threshold                                   );
    
    // Curved melting transition
    // Curved melting transition
    vec2  transition_uv    = uv;
    float turbulance       = fract(sin(dot(vec2(transition_uv.x), vec2(12.9, 78.2))) * 437.5);
          transition_uv.y += pow(sort , 2.0
                          +     (sort * 2.0))
                          *      mask
                          *   turbulance    ;
    fragColor = texture(tex0, transition_uv);
    
    // Draw pixel sorting effect behind the melting transition
    // Draw pixel sorting effect behind the melting transition
    if (transition_uv.y > 1.) {
        fragColor = texture(tex0, sort_uv);
    }   else                  {
        fragColor = texture(tex0,      uv);
    }
    
//	gl_FragColor = vec4(mask, mask, mask, 1.0); // Uncomment this to check mask
}

// https://godotshaders.com/shader/pseudo-pixel-sorting-v2/




