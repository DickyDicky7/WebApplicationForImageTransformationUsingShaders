#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

//const float gamma =    0.5; // 0.0 -> 2.0

uniform float gamma ; // 0.5  // 0.0 -> 2.0

void main() {
    vec4 color     = texture(tex0, vTexCoord                       );
         color.rgb =     pow(          color.rgb, vec3(1.0 / gamma));
     fragColor     =                   color;
}

// https://godotshaders.com/shader/gamma-correction/