#version 300 es
precision highp float;

uniform         sampler2D          tex0; //texture
uniform         sampler2D          tex1; //noise
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#define GAMMA 0.65
#define REGIONS 5.0
#define LINES 0.5
#define BASE 2.5
#define GREEN_BIAS 0.9

// Hash function for noise generation
float hash(float n) {
    return fract(sin(n) * 43758.5453);
}

// 3D noise function
float noise(in vec3 x) {
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f * f * (3.0 - 2.0 * f);

    float n = p.x + p.y * 57.0 + 113.0 * p.z;

    float res = mix(mix(mix(hash(n + 0.0), hash(n + 1.0), f.x),
                        mix(hash(n + 57.0), hash(n + 58.0), f.x), f.y),
                    mix(mix(hash(n + 113.0), hash(n + 114.0), f.x),
                        mix(hash(n + 170.0), hash(n + 171.0), f.x), f.y), f.z);
    return res;
}

// Outline function for edges in the scene
vec3 OutlineWhyCantIPassASampler(vec2 fragCoord) {
    vec2 uv = fragCoord.xy / canvasSize.xy;
    uv.y = 1.0 - uv.y;
    vec4 lines = vec4(0.30, 0.59, 0.11, 1.0);

    lines.rgb = lines.rgb * LINES * 1.5;

    float s11 = dot(texture(tex1, uv + vec2(-1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // LEFT
    float s12 = dot(texture(tex1, uv + vec2(0.0, -1.0 / canvasSize.y)), lines); // MIDDLE
    float s13 = dot(texture(tex1, uv + vec2(1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // RIGHT

    float s21 = dot(texture(tex1, uv + vec2(-1.0 / canvasSize.x, 0.0)), lines); // LEFT
    float s23 = dot(texture(tex1, uv + vec2(1.0 / canvasSize.x, 0.0)), lines); // RIGHT

    float s31 = dot(texture(tex1, uv + vec2(-1.0 / canvasSize.x, 1.0 / canvasSize.y)), lines); // LEFT
    float s32 = dot(texture(tex1, uv + vec2(0.0, 1.0 / canvasSize.y)), lines); // MIDDLE
    float s33 = dot(texture(tex1, uv + vec2(1.0 / canvasSize.x, 1.0 / canvasSize.y)), lines); // RIGHT

    float t1 = s13 + s33 + (2.0 * s23) - s11 - (2.0 * s21) - s31;
    float t2 = s31 + (2.0 * s32) + s33 - s11 - (2.0 * s12) - s13;

    vec3 col;

    if (((t1 * t1) + (t2 * t2)) > 0.04) {
        col = vec3(-1.0, -1.0, -1.0);
    } else {
        col = vec3(0.0, 0.0, 0.0);
    }

    return col;
}

// Recolor the foreground colors
vec3 RecolorForeground(vec3 color) {
    if (color.g > (color.r + color.b) * GREEN_BIAS) {
        color.rgb = vec3(0.0, 0.0, 0.0);
    }

    color.rgb = 0.2126 * color.rrr + 0.7152 * color.ggg + 0.0722 * color.bbb;

    if (color.r > 0.75) {
        color.r *= 0.9;
    } else if (color.r > 0.5) {
        color.r *= 0.7;
        color.g *= 0.9;
    } else if (color.r > 0.25) {
        color.r *= 0.5;
        color.g *= 0.75;
    } else {
        color.r *= 0.25;
        color.g *= 0.5;
    }

    return color;
}

// Posterization effect
vec3 Posterize(vec3 color) {
    color = pow(color, vec3(GAMMA, GAMMA, GAMMA));
    color = floor(color * REGIONS) / REGIONS;
    color = pow(color, vec3(1.0 / GAMMA));
    return color.rgb;
}

// Replace background color
vec3 ReplaceBackground(vec3 color, vec2 uv, vec2 fragCoord) {
    color.r = texture(tex1, vec2(uv.x, 1.0 - uv.y)).r - 0.6;
    color.r = (0.5 - 0.5 * uv.x + uv.y) * 0.75 + color.r;
    color = Posterize(color.rrr);
    color.b = 0.0;
    color.g = 0.0;
    color += OutlineWhyCantIPassASampler(fragCoord) / 40.0;
    return color;
}

// Outline function for final drawing
vec3 Outline(vec2 uv) {
    vec4 lines = vec4(0.30, 0.59, 0.11, 1.0);
    lines.rgb = lines.rgb * LINES;

    if (canvasSize.x < 300.0) {
        lines /= 4.0; // improves thumbnail look
    } else if (canvasSize.x > 1000.0) {
        lines *= 1.5;
    }

    float s11 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // LEFT
    float s12 = dot(texture(tex0, uv + vec2(0.0, -1.0 / canvasSize.y)), lines); // MIDDLE
    float s13 = dot(texture(tex0, uv + vec2(1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // RIGHT

    float s21 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x, 0.0)), lines); // LEFT
    float s23 = dot(texture(tex0, uv + vec2(1.0 / canvasSize.x, 0.0)), lines); // RIGHT

    float s31 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x, 1.0 / canvasSize.y)), lines); // LEFT
    float s32 = dot(texture(tex0, uv + vec2(0.0, 1.0 / canvasSize.y)), lines); // MIDDLE
    float s33 = dot(texture(tex0, uv + vec2(1.0 / canvasSize.x, 1.0 / canvasSize.y)), lines); // RIGHT

    float t1 = s13 + s33 + (2.0 * s23) - s11 - (2.0 * s21) - s31;
    float t2 = s31 + (2.0 * s32) + s33 - s11 - (2.0 * s12) - s13;

    vec3 col;

    if (((t1 * t1) + (t2 * t2)) > 0.04) {
        col = vec3(-1.0, -1.0, -1.0);
    } else {
        col = vec3(0.0, 0.0, 0.0);
    }

    return col;
}

void main() {
    vec2 uv = vTexCoord;
    vec3 color = normalize(texture(tex0, uv)).rgb * BASE;
    color = Posterize(color);
    vec3 background = ReplaceBackground(color, uv, gl_FragCoord.xy);
    color.rgb += Outline(uv);
    color = RecolorForeground(color) + background;

    fragColor = vec4(color, 1.0);
}


// https://www.shadertoy.com/view/MfscWl

