#version 300 es
precision  lowp float;

uniform sampler2D      tex0;
uniform sampler2D  palette0; // null
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


// const float        depth   = 0.03;
// const float line_thickness = 7.00;

uniform float        depth   ; // 0.03
uniform float line_thickness ; // 7.00

void main() {
    vec3 color = texture(tex0, vTexCoord).rgb;
    float grayscale_value  = dot(color, vec3(0.299, 0.587, 0.114));
    if(mod((gl_FragCoord.x  +
            gl_FragCoord.y) , (2.0 * line_thickness))
                                   < line_thickness) {
          grayscale_value -= depth;
    }

//  vec3 sampled_color = texture(gradient, vec2(grayscale_value, 0.0)).rgb;
    vec3 sampled_color = texture(palette0, vec2(grayscale_value, 0.0)).rgb;

    fragColor.rgb = sampled_color;
    fragColor.a   = 1.0          ;
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/line-pattern-cell-shading/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

















