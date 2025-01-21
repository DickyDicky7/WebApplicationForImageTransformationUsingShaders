#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/43yyWD

uniform vec3 Color001; // 1.0, 0.0, 0.7
uniform vec3 Color002; // 0.3, 1.0, 0.9

void main() {
    int i = int(gl_FragCoord.y) & 31;
//  int i = int(gl_FragCoord.y) & 31;

    // reverse bits so order of lines is more pleasing
//  // reverse bits so order of lines is more pleasing
    i = ((i & 1) << 4) + ((i & 2) << 2) + (i & 4) + ((i & 8) >> 2) + ((i & 16) >> 8);
//  i = ((i & 1) << 4) + ((i & 2) << 2) + (i & 4) + ((i & 8) >> 2) + ((i & 16) >> 8);

    float a = float(i) / 32.f;
//  float a = float(i) / 32.f;

    vec2 uv = .5f + (gl_FragCoord.xy - canvasSize.xy * .5f) * vec2(canvasSize.y / canvasSize.x, 1) / canvasSize.y;
//  vec2 uv = .5f + (gl_FragCoord.xy - canvasSize.xy * .5f) * vec2(canvasSize.y / canvasSize.x, 1) / canvasSize.y;

    // stretch the sides out to fill the frame, but leave the middle the correct aspect ratio
//  // stretch the sides out to fill the frame, but leave the middle the correct aspect ratio
    const float r = .65f;
//  const float r = .65f;
    uv.x = mix(uv.x, gl_FragCoord.x / canvasSize.x, 2.f * smoothstep(1.f - r, 1.f + r, abs(1.f - 2.f * gl_FragCoord.x / canvasSize.x)));
//  uv.x = mix(uv.x, gl_FragCoord.x / canvasSize.x, 2.f * smoothstep(1.f - r, 1.f + r, abs(1.f - 2.f * gl_FragCoord.x / canvasSize.x)));

    vec3 x = texture(tex0, uv).xyz;
//  vec3 x = texture(tex0, uv).xyz;
    x = pow(x, vec3(2.2f));
//  x = pow(x, vec3(2.2f));

    float t = dot(x, vec3(2, -1, 0));
//  float t = dot(x, vec3(2, -1, 0));

    fragColor = vec4(mix(Color001 * .6f, Color002, step(a, t)), 1);
//  fragColor = vec4(mix(Color001 * .6f, Color002, step(a, t)), 1);
}
