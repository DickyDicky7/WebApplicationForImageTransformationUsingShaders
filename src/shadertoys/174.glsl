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


float easeInOutQuad(float t) {
    return t < 0.5 ? 2.0 * t * t : -1.0 + (4.0 - 2.0 * t) * t;
}

// Cubic Easing
float easeInCubic(float t) {
    return t * t * t;
}

float easeOutCubic(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

float easeInOutCubic(float t) {
    return t < 0.5 ? 4.0 * t * t * t : (t - 1.0) * (2.0 * t - 2.0) * (2.0 * t - 2.0) + 1.0;
}

// Quartic Easing
float easeInQuart(float t) {
    return t * t * t * t;
}

float easeOutQuart(float t) {
    float f = t - 1.0;
    return 1.0 - f * f * f * f;
}

float easeInOutQuart(float t) {
    return t < 0.5 ? 8.0 * t * t * t * t : 1.0 - 8.0 * (t - 1.0) * (t - 1.0) * (t - 1.0) * (t - 1.0);
}

// Sine Easing
float easeInSine(float t) {
    return 1.0 - cos((t * 3.141592653589793) / 2.0);
}

float easeOutSine(float t) {
    return sin((t * 3.141592653589793) / 2.0);
}

float easeInOutSine(float t) {
    return -0.5 * (cos(3.141592653589793 * t) - 1.0);
}

// Exponential Easing
float easeInExpo(float t) {
    return t == 0.0 ? 0.0 : pow(2.0, 10.0 * (t - 1.0));
}

float easeOutExpo(float t) {
    return t == 1.0 ? 1.0 : 1.0 - pow(2.0, -10.0 * t);
}

float easeInOutExpo(float t) {
    if (t == 0.0) return 0.0;
    if (t == 1.0) return 1.0;
    return t < 0.5 ? 0.5 * pow(2.0, 20.0 * t - 10.0) : 1.0 - 0.5 * pow(2.0, -20.0 * t + 10.0);
}

// Back Easing
float easeInBack(float t) {
    const float c1 = 1.70158;
    return (c1 + 1.0) * t * t * t - c1 * t * t;
}

float easeOutBack(float t) {
    const float c1 = 1.70158;
    float f = t - 1.0;
    return 1.0 + (c1 + 1.0) * f * f * f + c1 * f * f;
}

float easeInOutBack(float t) {
    const float c1 = 1.70158;
    const float c2 = c1 * 1.525;
    return t < 0.5
        ? (pow(2.0 * t, 2.0) * ((c2 + 1.0) * 2.0 * t - c2)) / 2.0
        : (pow(2.0 * t - 2.0, 2.0) * ((c2 + 1.0) * (t * 2.0 - 2.0) + c2) + 2.0) / 2.0;
}


//use to scale the window
vec2 scaleUV(vec2 uv, vec2 scale)
{
  // Put texture coordinate origin to center of window.
  uv = uv * 2.0 - 1.0;

  //scale
  uv /= mix(vec2(1.0,1.0), vec2(0.0,0.0), scale);

  // scale from center
  uv = uv * 0.5 + 0.5;

  return uv;
}

vec3 offsetHue(vec3 color, float hueOffset) {
    // Convert RGB to HSV
    float maxC = max(max(color.r, color.g), color.b);
    float minC = min(min(color.r, color.g), color.b);
    float delta = maxC - minC;

    float hue = 0.0;
    if (delta > 0.0) {
        if (maxC == color.r) {
            hue = mod((color.g - color.b) / delta, 6.0);
        } else if (maxC == color.g) {
            hue = (color.b - color.r) / delta + 2.0;
        } else {
            hue = (color.r - color.g) / delta + 4.0;
        }
    }
    hue /= 6.0;

    float saturation = (maxC > 0.0) ? (delta / maxC) : 0.0;
    float value = maxC;

    // Offset the hue
    hue = mod(hue + hueOffset, 1.0);

    // Convert HSV back to RGB
    float c = value * saturation;
    float x = c * (1.0 - abs(mod(hue * 6.0, 2.0) - 1.0));
    float m = value - c;

    vec3 rgb;
    if (hue < 1.0 / 6.0) {
        rgb = vec3(c, x, 0.0);
    } else if (hue < 2.0 / 6.0) {
        rgb = vec3(x, c, 0.0);
    } else if (hue < 3.0 / 6.0) {
        rgb = vec3(0.0, c, x);
    } else if (hue < 4.0 / 6.0) {
        rgb = vec3(0.0, x, c);
    } else if (hue < 5.0 / 6.0) {
        rgb = vec3(x, 0.0, c);
    } else {
        rgb = vec3(c, 0.0, x);
    }

    return rgb + m;
}



vec4 blur(vec2 uv, float radius, float samples) {
  vec4 color = vec4(0.0);

  const float tau        = 6.28318530718;
  const float directions = 15.0;

  for (float d = 0.0; d < tau; d += tau / directions) {
    for (float s = 0.0; s < 1.0; s += 1.0 / samples) {
      vec2 offset = vec2(cos(d), sin(d)) * radius * (1.0 - s) / iResolution.xy;
      //color += getInputColor(uv + offset);
      color += texture(iChannel0, uv + offset);
    }
  }

  return color / samples / directions;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{

    float T_MAX = 1.50;
    float time = mod(iTime, T_MAX);
    float t = time/ T_MAX;
    t = 1.0 - t;
    
    float progress = t;
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    uv = scaleUV(uv, vec2(progress));
    //vec4 oColor = texture(iChannel0, uv);
    vec4 oColor = blur(uv,progress * 500.0,3.0);
    
    vec4 tint = vec4(1.0,0.0,0.0,1.0);
    tint.rgb = offsetHue(tint.rgb, progress * 1.0);
    tint = mix(vec4(1.0),tint*5.0,progress);
    
    oColor *= tint;

    // Output to screen
    fragColor = oColor;
}