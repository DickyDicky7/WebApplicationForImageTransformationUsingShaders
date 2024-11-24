#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;
uniform vec4       mousePosition;

void main() {
    vec2  uv = vTexCoord;
    vec4 col = texture(tex0, uv);
    
    float colorQuality = 2.0 + (mousePosition.y / canvasSize.y) * 8.0; // (1-255)
    
    if (gl_FragCoord.x <        mousePosition.x               )
        fragColor = col;
    else
    {
        // output
        vec3       q = vec3(colorQuality);
        fragColor = vec4(floor(col.rgb * q) / q, col.a);
    }
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/Ml33Dl
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
