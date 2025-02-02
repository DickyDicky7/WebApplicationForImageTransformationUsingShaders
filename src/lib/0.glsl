#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

uniform float     value_float    ; // 1.0
uniform int       value_int      ; // 2.0
uniform uint      value_uint     ; // 3.0
uniform bool      value_bool     ; // true
uniform vec2      value_vec2     ; // 1.0, 2.0
uniform vec3      value_vec3     ; // 1.0, 2.0, 3.0
uniform vec4      value_vec4     ; // 1.0, 2.0, 3.0, 4.0
uniform ivec2     value_ivec2    ; // 1.0, 2.0
uniform ivec3     value_ivec3    ; // 1.0, 2.0, 3.0
uniform ivec4     value_ivec4    ; // 1.0, 2.0, 3.0, 4.0
uniform uvec2     value_uvec2    ; // 1.0, 2.0
uniform uvec3     value_uvec3    ; // 1.0, 2.0, 3.0
uniform uvec4     value_uvec4    ; // 1.0, 2.0, 3.0, 4.0
uniform mat2      value_mat2     ; // 1.0, 2.0, 3.0, 4.0
uniform mat3      value_mat3     ; // 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0
uniform mat4      value_mat4     ; // 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0
uniform sampler2D noise_sampler2D; // null

void main()
{
//  fragColor = texture(tex0, vTexCoord);
    fragColor = texture(tex0, vTexCoord);
//  fragColor = texture(tex0, vTexCoord);
}