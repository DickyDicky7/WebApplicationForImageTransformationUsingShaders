#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;



uniform sampler2D palette_texture_ ; // null
uniform float     mixture_strength ; // 1.0
uniform float     opacity_strength ; // 1.0
uniform int         blend_mode     ; // 0
// 0: Normal, 1: Darken, 2: Multiply, 3: Color Burn, 4: Linear Burn, 5: Lighten, 6: Color Dodge, 7: Screen, 7: color, 7: hue
// 0: Normal, 1: Darken, 2: Multiply, 3: Color Burn, 4: Linear Burn, 5: Lighten, 6: Color Dodge, 7: Screen, 7: color, 7: hue
uniform float hue_shift; // 0.0
// Adjusts the hue of the gradient
// Adjusts the hue of the gradient
vec3 rgb_to_hsl(vec3 color) {
    float r = color.r;
    float g = color.g;
    float b = color.b;

    float max_val = max(max(r, g), b);
    float min_val = min(min(r, g), b);

    float l = (max_val +  min_val) / 2.0;

    if        (max_val == min_val) {
        return vec3(0.0, 0.0, l);
    }

    float     delta = max_val - min_val            ;
    float s = delta /    (1.0 - abs(2.0 * l - 1.0));

    float h ;
           if (max_val == r) {
          h =        (g - b) / delta;
    } else if (max_val == g) {
          h = 2.0 +  (b - r) / delta;
    } else                   {
          h = 4.0 +  (r - g) / delta;
    }

        h *= 060.0;
    if (h <  000.0) {
        h += 360.0;
    }

    return vec3(h / 360.0, s, l);
}
vec3 hsl_to_rgb(vec3 color) {
    float h = color.x;
    float s = color.y;
    float l = color.z;

    if (s == 0.0) {
        return vec3(l, l, l);
    }

    float c =     (1.0 - abs(2.0   *  l - 1.0)) *  s   ;
    float x = c * (1.0 - abs(mod(h * 6.0, 2.0)  - 1.0));
    float m = l -                c / 2.0               ;

           if (h >= 0.0       && h < 1.0 / 6.0) {
        return vec3(c + m, x + m, m);
    } else if (h >= 1.0 / 6.0 && h < 2.0 / 6.0) {
        return vec3(x + m, c + m, m);
    } else if (h >= 2.0 / 6.0 && h < 3.0 / 6.0) {
        return vec3(m, c + m, x + m);
    } else if (h >= 3.0 / 6.0 && h < 4.0 / 6.0) {
        return vec3(m, x + m, c + m);
    } else if (h >= 4.0 / 6.0 && h < 5.0 / 6.0) {
        return vec3(x + m, m, c + m);
    } else                                      {
        return vec3(c + m, m, x + m);
    }
}
vec3 blend_colour(vec3 base , vec3  blend) {
    return                          blend;
}
vec3 shift_hue   (vec3 color, float shift) {
    // Create column vectors for the rotation matrix
    // Create column vectors for the rotation matrix
    vec3 col0 = vec3( cos(shift), sin(shift), 0.0);
    vec3 col1 = vec3(-sin(shift), cos(shift), 0.0);
    vec3 col2 = vec3( 0.0       , 0.0       , 1.0);

    // Construct the rotation matrix using column vectors
    // Construct the rotation matrix using column vectors
    mat3   rot = mat3(
                 col0
               , col1
               , col2);

    return rot * color;
}
vec3 blend_normal      (vec3 base, vec3 blend) { return                                            blend ; }
vec3 blend_darken      (vec3 base, vec3 blend) { return                                  min(base, blend); }
vec3 blend_multiply    (vec3 base, vec3 blend) { return              base  * blend;                        }
vec3 blend_colour_burn (vec3 base, vec3 blend) { return 1.0 - (1.0 - base) / blend;                        }
vec3 blend_linear_burn (vec3 base, vec3 blend) { return              base  + blend - 1.0;                  }
vec3 blend_lighten     (vec3 base, vec3 blend) { return                                  max(base, blend); }
vec3 blend_colour_dodge(vec3 base, vec3 blend) { return blend == vec3(1.0) ? blend : base / (1.0 - blend); }
vec3 blend_screen      (vec3 base, vec3 blend) { return 1.0 - (1.0 - base)                * (1.0 - blend); }
vec3 blend_hue         (vec3 base, vec3 blend) {
    // Convert colors to HSL
    // Convert colors to HSL
    vec3  base_hsl = rgb_to_hsl(base );
    vec3 blend_hsl = rgb_to_hsl(blend);

    // Blend the hue component
    // Blend the hue component
    float blended_hue    = mix( base_hsl.x
                         ,     blend_hsl.x
                         ,   mixture_strength);

    // Keep saturation and lightness unchanged
    // Keep saturation and lightness unchanged
    vec3 blended_hsl_out = vec3(blended_hue
                         ,         base_hsl.y
                         ,         base_hsl.z);

    // Convert back to RGB
    // Convert back to RGB
    return hsl_to_rgb(blended_hsl_out);
}
void main() {
    vec4  __screenColor     = texture  (tex0, vTexCoord);
    float luminance         =       dot(__screenColor.rgb, vec3(0.299
                                                         ,      0.587
                                                         ,      0.114         ));
    vec4  gradientColor     = texture  (palette_texture_ , vec2(luminance, 0.5));
          gradientColor.rgb = shift_hue(gradientColor.rgb,      hue_shift      );
    vec3    blendedColor;
    switch (blend_mode) {
        case 0: blendedColor = blend_normal      (__screenColor.rgb, gradientColor.rgb); break;
        case 1: blendedColor = blend_darken      (__screenColor.rgb, gradientColor.rgb); break;
        case 2: blendedColor = blend_multiply    (__screenColor.rgb, gradientColor.rgb); break;
        case 3: blendedColor = blend_colour_burn (__screenColor.rgb, gradientColor.rgb); break;
        case 4: blendedColor = blend_linear_burn (__screenColor.rgb, gradientColor.rgb); break;
        case 5: blendedColor = blend_lighten     (__screenColor.rgb, gradientColor.rgb); break;
        case 6: blendedColor = blend_colour_dodge(__screenColor.rgb, gradientColor.rgb); break;
        case 7: blendedColor = blend_screen      (__screenColor.rgb, gradientColor.rgb); break;
        case 8: blendedColor = blend_colour      (__screenColor.rgb, gradientColor.rgb); break;
        case 9: blendedColor = blend_hue         (__screenColor.rgb, gradientColor.rgb); break;
    }
    vec3 finalColor = mix(__screenColor.rgb
                    ,                     blendedColor
                    , mixture_strength * gradientColor.a);
          fragColor = vec4(
         finalColor , opacity_strength);
}

// https://godotshaders.com/shader/clip-studio-gradient-map-with-blend-mode/
// https://godotshaders.com/shader/clip-studio-gradient-map-with-blend-mode/









