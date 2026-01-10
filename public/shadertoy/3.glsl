    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    uniform         sampler2D        noise1; // null
//  uniform         sampler2D        noise1; // null
    uniform         sampler2D        noise2; // null
//  uniform         sampler2D        noise2; // null
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4          fragColor;
//  out             vec4          fragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    // Constants
//  // Constants
    // Constants
//  // Constants
    #define pi 3.1415926
//  #define pi 3.1415926

    // Uniiforms
//  // Uniiforms
    // Uniiforms
//  // Uniiforms


    // Color channel splitting function
//  // Color channel splitting function
    // Color channel splitting function
//  // Color channel splitting function
    vec3       colorSplit(vec2 uv, vec2 s) {
//  vec3       colorSplit(vec2 uv, vec2 s) {
    vec3       color;
//  vec3       color;
    color.r = texture(tex0, uv - s).r;
//  color.r = texture(tex0, uv - s).r;
    color.g = texture(tex0, uv    ).g;
//  color.g = texture(tex0, uv    ).g;
    color.b = texture(tex0, uv + s).b;
//  color.b = texture(tex0, uv + s).b;
    return color;
//  return color;
    }
//  }

    // Interlace effect
//  // Interlace effect
    // Interlace effect
//  // Interlace effect
    vec2 interlace(vec2 uv, float s) {
//  vec2 interlace(vec2 uv, float s) {
    uv.x += s * (4.0 * fract((uv.y * canvasSize.y) / 2.0) - 1.0);
//  uv.x += s * (4.0 * fract((uv.y * canvasSize.y) / 2.0) - 1.0);
    return uv                                                   ;
//  return uv                                                   ;
    }
//  }

    // Fault effect (horizontal glitch)
//  // Fault effect (horizontal glitch)
    // Fault effect (horizontal glitch)
//  // Fault effect (horizontal glitch)
    vec2 fault(vec2 uv, float s) {
//  vec2 fault(vec2 uv, float s) {
    float          v  = pow(0.5 - 0.5 * cos(2.0 * pi * uv.y), 100.0)
//  float          v  = pow(0.5 - 0.5 * cos(2.0 * pi * uv.y), 100.0)
    * sin(2.0 * pi * uv.y);
//  * sin(2.0 * pi * uv.y);
    uv.x += v * s;
//  uv.x += v * s;
    return      uv           ;
//  return      uv           ;
    }
//  }

    // Random distortion effect
//  // Random distortion effect
    // Random distortion effect
//  // Random distortion effect
    vec2 rnd(vec2 uv, float s) {
//  vec2 rnd(vec2 uv, float s) {
    uv.x += s * (2.0 * texture(noise1, uv * 0.05).x - 1.0);
//  uv.x += s * (2.0 * texture(noise1, uv * 0.05).x - 1.0);
    return uv                                             ;
//  return uv                                             ;
    }
//  }

    void main() {
    // Time variable for animation
//  // Time variable for animation
    // Time variable for animation
//  // Time variable for animation
    float t = time / 10.0;
//  float t = time / 10.0;

    // Normalize fragment coordinates
//  // Normalize fragment coordinates
    // Normalize fragment coordinates
//  // Normalize fragment coordinates
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;

    // Create a smooth interlacing effect
//  // Create a smooth interlacing effect
    // Create a smooth interlacing effect
//  // Create a smooth interlacing effect
    float s = texture(noise1, vec2(t * 0.2, 0.5)).r;
//  float s = texture(noise1, vec2(t * 0.2, 0.5)).r;

    uv = interlace(uv, s * 0.005);
//  uv = interlace(uv, s * 0.005);
    
    // Fault effect with time-based horizontal glitch
//  // Fault effect with time-based horizontal glitch
    // Fault effect with time-based horizontal glitch
//  // Fault effect with time-based horizontal glitch
    float r = texture(noise2, vec2 (t , 0.0)).x;
//  float r = texture(noise2, vec2 (t , 0.0)).x;
    uv = fault(uv + vec2(0.0, fract(t * 2.0)), 5.0 * sign(r) * pow(abs(r), 5.0))
//  uv = fault(uv + vec2(0.0, fract(t * 2.0)), 5.0 * sign(r) * pow(abs(r), 5.0))
    - vec2(0.0, fract(t * 2.0));
//  - vec2(0.0, fract(t * 2.0));

    // Random horizontal noise
//  // Random horizontal noise
    // Random horizontal noise
//  // Random horizontal noise
    uv = rnd(uv, s * 0.02);
//  uv = rnd(uv, s * 0.02);

    // Color split effect for simulating RGB offset
//  // Color split effect for simulating RGB offset
    // Color split effect for simulating RGB offset
//  // Color split effect for simulating RGB offset
    vec3 color = colorSplit(uv, vec2(s * 0.02, 0.0));
//  vec3 color = colorSplit(uv, vec2(s * 0.02, 0.0));

    // Mix with background noise texture
//  // Mix with background noise texture
    // Mix with background noise texture
//  // Mix with background noise texture
    color = mix(color, texture(noise1, 0.5 * uv + t * 100.0).rgb, 0.25);
//  color = mix(color, texture(noise1, 0.5 * uv + t * 100.0).rgb, 0.25);

    // Output the final color
//  // Output the final color
    // Output the final color
//  // Output the final color
    fragColor = vec4(color, 1.0);
//  fragColor = vec4(color, 1.0);
    }


    // https://www.shadertoy.com/view/ltSSWV
//  // https://www.shadertoy.com/view/ltSSWV
