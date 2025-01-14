#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4fGfzR

#define Pi         3.1415926535897932384626433832795
#define Distortion 0.5 * 1.0 * (sin(time - 0.5 * Pi) + 1.0)

   float GetRot(vec2 uv, vec2 a) { vec2 b = uv - a; b.x *= canvasSize.x / canvasSize.y; vec2 j = vec2(0.0, 1.0); return acos(dot(b, j) / length(b)) * (abs(mod(b.x, 4.0 * Pi) - 2.0 * Pi) / (2.0 * Pi - mod(b.x, 4.0 * Pi))); }
// float GetRot(vec2 uv, vec2 a) { vec2 b = uv - a; b.x *= canvasSize.x / canvasSize.y; vec2 j = vec2(0.0, 1.0); return acos(dot(b, j) / length(b)) * (abs(mod(b.x, 4.0 * Pi) - 2.0 * Pi) / (2.0 * Pi - mod(b.x, 4.0 * Pi))); }

   float f(float a, float x) { return 0.5 * (sin(x - 0.5 * Pi) + 1.0) * a; }
// float f(float a, float x) { return 0.5 * (sin(x - 0.5 * Pi) + 1.0) * a; }

void main()
{
    vec2 uv = vTexCoord; vec2 P = vec2(0.5, 0.5); float d = length((uv - P) * vec2(canvasSize.x / canvasSize.y, 1.0)); float a = GetRot(uv, P) - (Distortion / d); uv = vec2(sin(a) / (canvasSize.x / canvasSize.y), cos(a)) * d + P; fragColor = texture(tex0, uv);
//  vec2 uv = vTexCoord; vec2 P = vec2(0.5, 0.5); float d = length((uv - P) * vec2(canvasSize.x / canvasSize.y, 1.0)); float a = GetRot(uv, P) - (Distortion / d); uv = vec2(sin(a) / (canvasSize.x / canvasSize.y), cos(a)) * d + P; fragColor = texture(tex0, uv);
}


