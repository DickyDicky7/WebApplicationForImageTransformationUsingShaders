#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/X32fDG

uniform float NUMBER    ; // 30.00;
uniform float DISTANCES ; // 00.01;
uniform float THRESHOLD ; // 00.03;

  const float pi = 3.14159265358;
//const float pi = 3.14159265358;

void main() { vec2 uv = vTexCoord; vec3 col = vec3(0.0); float place = 0.0; for (float i = 1.0; i <= NUMBER; i++) { place = ((2.0 * pi) / (NUMBER / i)) + (pi / 2.0); col += texture(tex0, uv + DISTANCES * vec2(cos(place) * (canvasSize.y / canvasSize.x), sin(place))).rgb; } col /= NUMBER; col = texture(tex0, uv).rgb - col; if ((col.r + col.g + col.b) / 3.0 > THRESHOLD) { col = vec3(1.0); } else { col = vec3(0.0); } fragColor = vec4(col, 1.0);
//            vec2 uv = vTexCoord; vec3 col = vec3(0.0); float place = 0.0; for (float i = 1.0; i <= NUMBER; i++) { place = ((2.0 * pi) / (NUMBER / i)) + (pi / 2.0); col += texture(tex0, uv + DISTANCES * vec2(cos(place) * (canvasSize.y / canvasSize.x), sin(place))).rgb; } col /= NUMBER; col = texture(tex0, uv).rgb - col; if ((col.r + col.g + col.b) / 3.0 > THRESHOLD) { col = vec3(1.0); } else { col = vec3(0.0); } fragColor = vec4(col, 1.0);
            }






