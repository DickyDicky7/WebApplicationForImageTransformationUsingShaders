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

const float PI = 3.1415926536;
const float PI2 = PI * 2.0;
const int mSize = 9;
const int kSize = (mSize - 1) / 2;
const float sigma = 3.0;

// Gaussian PDF function
float normpdf(float x, float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

// Color dodge blend function
vec3 colorDodge(vec3 src, vec3 dst) {
    return step(0.0, dst) * mix(min(vec3(1.0), dst / (1.0 - src)), vec3(1.0), step(1.0, src));
}

// Convert to greyscale
float greyScale(vec3 col) {
    return dot(col, vec3(0.3, 0.59, 0.11));
}

// Generate pseudo-random value
vec2 random(vec2 p) {
    p = fract(p * vec2(314.159, 314.265));
    p += dot(p, p.yx + 17.17);
    return fract((p.xx + p.yx) * p.xy);
}

// Set up input channels


void main() {
    vec2 q = gl_FragCoord.xy / canvasSize.xy;
    vec3 col = texture(tex0, q).rgb;

    // Random pattern for stippling
    vec2 r = random(q);
    r.x *= PI2;
    vec2 cr = vec2(sin(r.x), cos(r.x)) * sqrt(r.y);

    // Blurred version of the image
    vec3 blurred = texture(tex0, q + cr * (vec2(mSize) / canvasSize.xy)).rgb;

    // Conditional Gaussian blur kernel setup if mouse is pressed
    if (mousePosition.z > 0.5) {
        blurred = vec3(0.0);
        float kernel[9];
        float Z = 0.0;

        for (int j = 0; j <= kSize; ++j) {
            kernel[kSize + j] = kernel[kSize - j] = normpdf(float(j), sigma);
        }
        for (int j = 0; j < mSize; ++j) {
            Z += kernel[j];
        }

        // Apply Gaussian blur
        for (int i = -kSize; i <= kSize; ++i) {
            for (int j = -kSize; j <= kSize; ++j) {
                vec2 offset = vec2(float(i), float(j)) / canvasSize.xy;
                blurred += kernel[kSize + j] * kernel[kSize + i] * texture(tex0, q + offset).rgb;
            }
        }
        blurred = blurred / (Z * Z);
    }

    // Invert blurred color and apply color dodge
    vec3 inv = vec3(1.0) - blurred;
    vec3 lighten = colorDodge(col, inv);

    // Convert to greyscale and add contrast
    vec3 res = vec3(greyScale(lighten));
    res = vec3(pow(res.x, 3.0));

    // Apply edge effect if mouse is pressed
    if (mousePosition.z > 0.5) {
        res *= 0.25 + 0.75 * pow(16.0 * q.x * q.y * (1.0 - q.x) * (1.0 - q.y), 0.15);
    }

    // Output the final color
    fragColor = vec4(res, 1.0);
}

// https://www.shadertoy.com/view/ldSyzV