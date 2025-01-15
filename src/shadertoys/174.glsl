#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/XcKBRW


    float easeInOutQuad(float t) { return t < 0.5f ? 2.0f * t * t : -1.0f + (4.0f - 2.0f * t) * t; }
//  float easeInOutQuad(float t) { return t < 0.5f ? 2.0f * t * t : -1.0f + (4.0f - 2.0f * t) * t; }

    // Cubic Easing
//  // Cubic Easing
    float easeInCubic(float t) { return t * t * t; }
//  float easeInCubic(float t) { return t * t * t; }

    float easeOutCubic(float t) { float f = t - 1.0f; return f * f * f + 1.0f; }
//  float easeOutCubic(float t) { float f = t - 1.0f; return f * f * f + 1.0f; }

    float easeInOutCubic(float t) { return t < 0.5f ? 4.0f * t * t * t : (t - 1.0f) * (2.0f * t - 2.0f) * (2.0f * t - 2.0f) + 1.0f; }
//  float easeInOutCubic(float t) { return t < 0.5f ? 4.0f * t * t * t : (t - 1.0f) * (2.0f * t - 2.0f) * (2.0f * t - 2.0f) + 1.0f; }

    // Quartic Easing
//  // Quartic Easing
    float easeInQuart(float t) { return t * t * t * t; }
//  float easeInQuart(float t) { return t * t * t * t; }

    float easeOutQuart(float t) { float f = t - 1.0f; return 1.0f - f * f * f * f; }
//  float easeOutQuart(float t) { float f = t - 1.0f; return 1.0f - f * f * f * f; }

    float easeInOutQuart(float t) { return t < 0.5f ? 8.0f * t * t * t * t : 1.0f - 8.0f * (t - 1.0f) * (t - 1.0f) * (t - 1.0f) * (t - 1.0f); }
//  float easeInOutQuart(float t) { return t < 0.5f ? 8.0f * t * t * t * t : 1.0f - 8.0f * (t - 1.0f) * (t - 1.0f) * (t - 1.0f) * (t - 1.0f); }

    // Sine Easing
//  // Sine Easing
    float easeInSine(float t) { return 1.0f - cos((t * 3.141592653589793f) / 2.0f); }
//  float easeInSine(float t) { return 1.0f - cos((t * 3.141592653589793f) / 2.0f); }

    float easeOutSine(float t) { return sin((t * 3.141592653589793f) / 2.0f); }
//  float easeOutSine(float t) { return sin((t * 3.141592653589793f) / 2.0f); }

    float easeInOutSine(float t) { return -0.5f * (cos(3.141592653589793f * t) - 1.0f); }
//  float easeInOutSine(float t) { return -0.5f * (cos(3.141592653589793f * t) - 1.0f); }

    // Exponential Easing
//  // Exponential Easing
    float easeInExpo(float t) { return t == 0.0f ? 0.0f : pow(2.0f, 10.0f * (t - 1.0f)); }
//  float easeInExpo(float t) { return t == 0.0f ? 0.0f : pow(2.0f, 10.0f * (t - 1.0f)); }

    float easeOutExpo(float t) { return t == 1.0f ? 1.0f : 1.0f - pow(2.0f, -10.0f * t); }
//  float easeOutExpo(float t) { return t == 1.0f ? 1.0f : 1.0f - pow(2.0f, -10.0f * t); }

    float easeInOutExpo(float t) { if (t == 0.0f) return 0.0f; if (t == 1.0f) return 1.0f; return t < 0.5f ? 0.5f * pow(2.0f, 20.0f * t - 10.0f) : 1.0f - 0.5f * pow(2.0f, -20.0f * t + 10.0f); }
//  float easeInOutExpo(float t) { if (t == 0.0f) return 0.0f; if (t == 1.0f) return 1.0f; return t < 0.5f ? 0.5f * pow(2.0f, 20.0f * t - 10.0f) : 1.0f - 0.5f * pow(2.0f, -20.0f * t + 10.0f); }

    // Back Easing
//  // Back Easing
    float easeInBack(float t) { const float c1 = 1.70158f; return (c1 + 1.0f) * t * t * t - c1 * t * t; }
//  float easeInBack(float t) { const float c1 = 1.70158f; return (c1 + 1.0f) * t * t * t - c1 * t * t; }

    float easeOutBack(float t) { const float c1 = 1.70158f; float f = t - 1.0f; return 1.0f + (c1 + 1.0f) * f * f * f + c1 * f * f; }
//  float easeOutBack(float t) { const float c1 = 1.70158f; float f = t - 1.0f; return 1.0f + (c1 + 1.0f) * f * f * f + c1 * f * f; }

    float easeInOutBack(float t) { const float c1 = 1.70158f; const float c2 = c1 * 1.525f; return t < 0.5f ? (pow(2.0f * t, 2.0f) * ((c2 + 1.0f) * 2.0f * t - c2)) / 2.0f : (pow(2.0f * t - 2.0f, 2.0f) * ((c2 + 1.0f) * (t * 2.0f - 2.0f) + c2) + 2.0f) / 2.0f; }
//  float easeInOutBack(float t) { const float c1 = 1.70158f; const float c2 = c1 * 1.525f; return t < 0.5f ? (pow(2.0f * t, 2.0f) * ((c2 + 1.0f) * 2.0f * t - c2)) / 2.0f : (pow(2.0f * t - 2.0f, 2.0f) * ((c2 + 1.0f) * (t * 2.0f - 2.0f) + c2) + 2.0f) / 2.0f; }

//use to scale the window
//use to scale the window
vec2 scaleUV(vec2 uv, vec2 scale) {
    // Put texture coordinate origin to center of window.
    // Put texture coordinate origin to center of window.
    uv = uv * 2.0f - 1.0f;

    //scale
    uv /= mix(vec2(1.0f, 1.0f)
       ,      vec2(0.0f, 0.0f)
       ,scale);

    // scale from center
    // scale from center
    uv = uv * 0.5f + 0.5f;

    return uv;
}

vec3 offsetHue(vec3 color, float hueOffset) {
    // Convert RGB to HSV
    // Convert RGB to HSV
    float maxC  = max(max(color.r, color.g), color.b);
    float minC  = min(min(color.r, color.g), color.b);
    float delta = maxC - minC;

    float hue = 0.0f;
    if (delta > 0.0f) {
        if (maxC == color.r)
        {
            hue = mod((color.g - color.b) / delta, 6.0f);
        }
        else
        if (maxC == color.g)
        {
            hue =     (color.b - color.r) / delta + 2.0f;
        }
        else
        {
            hue =     (color.r - color.g) / delta + 4.0f;
        }
    }
    hue /= 6.0f;

    float saturation = (maxC > 0.0f) ? (delta / maxC) : 0.0f;
    float                               value = maxC        ;

    // Offset the hue
    // Offset the hue
    hue = mod(hue + hueOffset, 1.0f);
//  hue = mod(hue + hueOffset, 1.0f);

    // Convert HSV back to RGB
    // Convert HSV back to RGB
    float c = value * saturation; float x = c * (1.0f - abs(mod(hue * 6.0f, 2.0f) - 1.0f)); float m = value - c;
//  float c = value * saturation; float x = c * (1.0f - abs(mod(hue * 6.0f, 2.0f) - 1.0f)); float m = value - c;

          vec3 rgb;
           if (hue < 1.0f / 6.0f) { rgb = vec3(c   , x   , 0.0f);
    } else if (hue < 2.0f / 6.0f) { rgb = vec3(x   , c   , 0.0f);
    } else if (hue < 3.0f / 6.0f) { rgb = vec3(0.0f, c   , x   );
    } else if (hue < 4.0f / 6.0f) { rgb = vec3(0.0f, x   , c   );
    } else if (hue < 5.0f / 6.0f) { rgb = vec3(x   , 0.0f, c   );
    } else                        { rgb = vec3(c   , 0.0f, x   );
    }

    return rgb + m;
}

    vec4 blur(vec2 uv, float radius, float samples) { vec4 color = vec4(0.0f); const float tau = 6.28318530718f; const float directions = 15.0f; for(float d = 0.0f; d < tau; d += tau / directions) { for(float s = 0.0f; s < 1.0f; s += 1.0f / samples) { vec2 offset = vec2(cos(d), sin(d)) * radius * (1.0f - s) / canvasSize.xy; /* color += getInputColor(uv + offset); */ color += texture(tex0, uv + offset); } } return color / samples / directions; }
//  vec4 blur(vec2 uv, float radius, float samples) { vec4 color = vec4(0.0f); const float tau = 6.28318530718f; const float directions = 15.0f; for(float d = 0.0f; d < tau; d += tau / directions) { for(float s = 0.0f; s < 1.0f; s += 1.0f / samples) { vec2 offset = vec2(cos(d), sin(d)) * radius * (1.0f - s) / canvasSize.xy; /* color += getInputColor(uv + offset); */ color += texture(tex0, uv + offset); } } return color / samples / directions; }

void main() {

    float T_MAX = 1.50f; float rtime = mod(time, T_MAX); float t = rtime / T_MAX; t = 1.0f - t; float progress = t;
//  float T_MAX = 1.50f; float rtime = mod(time, T_MAX); float t = rtime / T_MAX; t = 1.0f - t; float progress = t;

    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;

    // Time varying pixel color
//  // Time varying pixel color
    uv = scaleUV(uv, vec2(progress));
//  uv = scaleUV(uv, vec2(progress));
    // vec4 oColor = texture(tex0, uv);
//  // vec4 oColor = texture(tex0, uv);
    vec4 oColor = blur(uv, progress * 500.0f, 3.0f);
//  vec4 oColor = blur(uv, progress * 500.0f, 3.0f);

    vec4 tint = vec4(1.0f, 0.0f, 0.0f, 1.0f); tint.rgb = offsetHue(tint.rgb, progress * 1.0f); tint = mix(vec4(1.0f), tint * 5.0f, progress); oColor *= tint;
//  vec4 tint = vec4(1.0f, 0.0f, 0.0f, 1.0f); tint.rgb = offsetHue(tint.rgb, progress * 1.0f); tint = mix(vec4(1.0f), tint * 5.0f, progress); oColor *= tint;

    // Output to screen
//  // Output to screen
    fragColor = oColor;
//  fragColor = oColor;
}



