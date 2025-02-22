#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// // MODES
// // 0 - @@DEBUG@@
// // 1 - @MULTIPLY
// // 2 - @SCREEN@@
// // 3 - SOFTLIGHT
// // 4 - HARDLIGHT
// // 5 - @OVERLAY@
// const int  mode = 5;
// const bool linearColorSpace = false;
// const vec4 color1 =  vec4(1.0, 0.5, 0.8, 1.0);
// const vec4 color2 =  vec4(0.4, 0.8, 1.0, 1.0);
// const vec2 direction = vec2(1.0, 1.0);
// const float  opacity =           0.5 ;

// MODES
// 0 - @@DEBUG@@
// 1 - @MULTIPLY
// 2 - @SCREEN@@
// 3 - SOFTLIGHT
// 4 - HARDLIGHT
// 5 - @OVERLAY@
uniform int   mode             ; // 5
uniform bool  linearColorSpace ; // false
uniform vec4  color1           ; // 1.0, 0.5, 0.8, 1.0
uniform vec4  color2           ; // 0.4, 0.8, 1.0, 1.0
uniform vec2  direction        ; // 1.0, 1.0
uniform float   opacity        ; // 0.5

 vec3 srgb_to_linear(vec3 c) {
    return c * (c * (c * 0.305306011
                       + 0.682171111)
                       + 0.012522878);
}

vec3 linear_to_srgb(vec3 c) {
    return max(1.055 * pow(c, vec3(0.416666667)) - 0.055, 0.0);
}

void main() {
    vec2 uv  = vTexCoord;
    vec4 src = texture(tex0, uv);
    
    vec3 c_a = src.rgb;
    vec3 grad1 = color1.rgb;
    vec3 grad2 = color2.rgb;
    vec3 c_f;
    
    if (linearColorSpace) { 
        c_a = linear_to_srgb(c_a);
        grad1 = linear_to_srgb(grad1);
        grad2 = linear_to_srgb(grad2);
    }

    float param = dot(uv    - 0.5, direction);
    vec3   c_b  = mix(grad1,
                      grad2,
                      param + 0.5           );
    
           if (mode == 0) { //@@DEBUG@@
        c_f = c_b;
    } else if (mode == 1) { //@MULTIPLY
        c_f = c_a * c_b;
    } else if (mode == 2) { //@SCREEN@@
        c_f = 1.0 - (1.0 - c_a)
                  * (1.0 - c_b);
    } else if (mode == 3) { //SOFTLIGHT
        vec3 c_u =        c_a  * c_b * 2.0 + (1.0 - c_b * 2.0) * c_a * c_a;
        vec3 c_d = (1.0 - c_b) * c_a * 2.0 + (c_b * 2.0 - 1.0) * sqrt(c_a);
        c_f = mix(c_u, c_d, c_b + 0.5);
    } else if (mode == 4) { //HARDLIGHT
        vec3 c_u =                      c_a * c_b  * 2.0;
        vec3 c_d = 1.0 - (1.0 - c_a) * (1.0 - c_b) * 2.0;
        c_f = mix(c_u, c_d, c_b + 0.5);
    } else if (mode == 5) { //@OVERLAY@
        vec3 c_u =                      c_a * c_b  * 2.0;
        vec3 c_d = 1.0 - (1.0 - c_a) * (1.0 - c_b) * 2.0;
        c_f = mix (c_u, c_d, c_a + 0.5);
    }
    
    if (linearColorSpace) {
        c_f = srgb_to_linear(c_f);
    }

                                 fragColor = vec4(c_f, opacity);
}

//#-----------------------------------------#
// https://godotshaders.com/shader/hoperamp/
//#-----------------------------------------#



