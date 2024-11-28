#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float hueFactor = 0.1; //[0.0, 1.0]

vec3 hueDegree(vec3 In, float Offset)
{
    vec4  K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4  P = mix(vec4(In.bg , K .wz), vec4(In.gb, K.xy ), step(In.b, In.g));
    vec4  Q = mix(vec4(P .xyw, In.r ), vec4(In.r , P.yzx), step(P .x, In.r));
    float D = Q.x - min(Q.w, Q.y);
    float E = 1e-10;
    vec3  hsv   =  vec3(abs(Q.z + (Q.w - Q.y) / (6.0 * D + E)), D / (Q.x + E), Q.x);
    float hue   =  hsv.x + Offset / 360.0;
          hsv.x = (hue < 0.0)
                ?  hue + 1.0
                : (hue > 1.0)
                ?  hue - 1.0
                :  hue;
    vec4 K2 = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 P2 =       abs(fract(hsv.xxx +     K2.xyz) *      6.0 - K2.www                  );
    vec3   result =           hsv.z   * mix(K2.xxx  , clamp(P2 - K2.xxx, 0.0, 1.0), hsv.y);
    return result;
}

void main(void)
{
    vec2    uv    = gl_FragCoord.xy
                  /   canvasSize.xy;
    vec3    color = texture(tex0, uv).rgb;
        fragColor = vec4(hueDegree(color, hueFactor * 360.0), 1.0);
}


// https://www.shadertoy.com/view/NlfBD8

