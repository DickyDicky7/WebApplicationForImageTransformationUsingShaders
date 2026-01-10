    #version 300 es
//  #version 300 es
    precision lowp float;
//  precision lowp float;

    in vec2 vTexCoord; out vec4 o; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  in vec2 vTexCoord; out vec4 o; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

    void main() { vec2 u = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy; vec3 c = vec3(canvasSize, 0.0f); float t = 0.05f * time; u = 0.4f * (u + u - c.xy) / c.y + t; vec4 color = vec4(0.0f); float i = 0.0f; for(; ++i < 14.0f; color = sqrt(color * color + 0.7f) * 0.99f) { u *= -0.1f * mat2(5, 11, -11, 5); u += cos(u.yx / 0.1f + 0.4f * i * color.xz) * 0.003f * i + t / i; c = cos(3.0f * t + vec3(cos(u * 1e2f), 1.0f) / 8.0f + color.x * i / 9.0f + u.x * 0.4f * i + sin(u.y * i)); color.rgb += c * pow(c * c, vec3(0.0f, 1.5f, 4.0f)) / pow(i, i / 43.0f); u += sin(u.yx) * color.z * 0.03f; } color.rgb = 1.0f - exp(-0.018f * color.rgb * color.rgb * color.r); o = color; }
//  void main() { vec2 u = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy; vec3 c = vec3(canvasSize, 0.0f); float t = 0.05f * time; u = 0.4f * (u + u - c.xy) / c.y + t; vec4 color = vec4(0.0f); float i = 0.0f; for(; ++i < 14.0f; color = sqrt(color * color + 0.7f) * 0.99f) { u *= -0.1f * mat2(5, 11, -11, 5); u += cos(u.yx / 0.1f + 0.4f * i * color.xz) * 0.003f * i + t / i; c = cos(3.0f * t + vec3(cos(u * 1e2f), 1.0f) / 8.0f + color.x * i / 9.0f + u.x * 0.4f * i + sin(u.y * i)); color.rgb += c * pow(c * c, vec3(0.0f, 1.5f, 4.0f)) / pow(i, i / 43.0f); u += sin(u.yx) * color.z * 0.03f; } color.rgb = 1.0f - exp(-0.018f * color.rgb * color.rgb * color.r); o = color; }

    // https://www.shadertoy.com/view/43yBWD
//  // https://www.shadertoy.com/view/43yBWD
