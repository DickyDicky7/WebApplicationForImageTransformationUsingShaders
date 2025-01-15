#version 300 es
precision  lowp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;

#define COLORED 1

void main() {
    vec2 center = floor(gl_FragCoord.xy / 16.0) * 16.0 + 8.0;
    vec3    col =                                           texture(tex0, center / canvasSize.xy).rgb;
    float  l    =                                                                                    max(0.1, dot(col, vec3(0.2125, 0.7154, 0.0721)));
    float  dist =                                                                                                                                      distance(center, gl_FragCoord.xy) / 8.0;
    float alpha =                                                                                                                                                                             smoothstep(1.0, 0.5, dist / l);

    #if defined(COLORED)
        fragColor.rgb = col * alpha  ;
    #else
        fragColor.rgb = vec3( alpha );
    #endif

    fragColor.a = 1.0;
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/MtcXRB
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



















