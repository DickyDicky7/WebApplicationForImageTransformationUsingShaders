#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/McGyzd

uniform float Line_Smoothness ; // 00.045;
uniform float Line_Width      ; // 00.090;
uniform float Brightness      ; // 03.000;
uniform float Rotation_deg    ; // 30.000;
uniform float Distortion      ; // 01.800;
uniform float Speed           ; // 00.700;
uniform float Position        ; // 00.000;
uniform float Position_Min    ; // 00.250;
uniform float Position_Max    ; // 00.500;
uniform float      Alpha      ; // 01.000;
uniform vec3  Glow_Color      ; // 0.6, 0.7, 0.9

vec2 rotate_uv(vec2 uv, vec2 center, float rotation, bool use_degrees) {
        float _angle = rotation                      ;
        if (use_degrees) {
              _angle = rotation * (3.1415926 / 180.0);
        }
        mat2 _rotation = mat2(
            vec2(cos(_angle), -sin(_angle))
        ,   vec2(sin(_angle),  cos(_angle))
        );
        vec2   _delta =        uv - center;
               _delta = _rotation * _delta;
        return _delta +             center;
}

void main() {
    vec2 uv   = vTexCoord;
//       uv.y =  1.0 -
//       uv.y            ;
    vec2                             center_uv = uv - vec2(0.5, 0.5);
    float gradient_to_edge = max(abs(center_uv.x)
                           ,     abs(center_uv.y));
    gradient_to_edge =       gradient_to_edge * Distortion;
    gradient_to_edge = 1.0 - gradient_to_edge             ;
    vec2 rotaded_uv = rotate_uv(uv, vec2(0.5, 0.5), Rotation_deg, true);
    
    float remapped_position;
    {
    float                                    output_range =
                              Position_Max                - Position_Min;
          remapped_position = Position_Min + output_range * Position    ;
    }
    
    float remapped_time = time * Speed + remapped_position;
          remapped_time = fract(
          remapped_time        );
    {
        float                    output_range =
                           2.0 -
                         (-2.0) ;
          remapped_time = -2.0 + output_range *
          remapped_time         ;
    }
    
    vec2        offset_uv = vec2(
               rotaded_uv.xy    )
//             rotaded_uv.xy    )
                          + vec2(remapped_time, 0.0);
    float
    line = vec3(offset_uv, 0.0).x;
    line = abs (
    line       );
    line = gradient_to_edge * line;
//  line = gradient_to_edge * line;
    line = sqrt(
    line       );
    
    float                             line_smoothness = clamp(
                                      Line_Smoothness , 0.001
                                                      , 1.000);
    float offset_pluss = Line_Width + line_smoothness;
    float offset_minus = Line_Width - line_smoothness;
    
    float remapped_line;
    {
    float                                         input_range
                        =         offset_minus
                        -         offset_pluss               ;
          remapped_line = (line - offset_pluss) / input_range;
    }
    remapped_line =       remapped_line * Brightness ;
    remapped_line =  min (remapped_line ,      Alpha);
    remapped_line = clamp(remapped_line , -0.2
                                        , +1.0      );

    // Sample the original texture
    // Sample the original texture
    vec4 original_color = texture(tex0, uv);
    
    // Apply the effect as an additive blend
    // Apply the effect as an additive blend
    fragColor   = original_color + vec4(vec3(remapped_line) * Glow_Color, 0.0);
    fragColor.a = original_color.a                                            ;
}

