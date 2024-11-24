#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float strength = 0.05;
const vec4     color = vec4(1.0);

void main() {
    vec2                                                   SCREEN_PIXEL_SIZE  = 1.0 / canvasSize;
    vec3 current_color = texture(tex0, vTexCoord                                  ).rgb;
    vec3   right_color = texture(tex0, vTexCoord + vec2(   SCREEN_PIXEL_SIZE.x, 0)).rgb;
    vec3  bottom_color = texture(tex0, vTexCoord - vec2(0, SCREEN_PIXEL_SIZE.y   )).rgb;
    float r_distance = length(current_color -  right_color);
    float b_distance = length(current_color - bottom_color);
     
    fragColor.rgba = (r_distance > strength || b_distance > strength) ? color : vec4(0);
}


// https://godotshaders.com/shader/line-art/