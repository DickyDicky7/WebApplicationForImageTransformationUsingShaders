#version 300 es
//  precision lowp float;
    precision lowp float;
//  precision lowp float;

//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

/**
 * Fractal Brownian Motion
 * Fractal Brownian Motion
 *
 * Reference: https://thebookofshaders.com/13/
 * Reference: https://thebookofshaders.com/13/
 * 
 * See also: https://iquilezles.org/articles/morenoise
 * See also: https://iquilezles.org/articles/morenoise
 *         : https://iquilezles.org/articles/warp
 *         : https://iquilezles.org/articles/warp
 */

const vec3 mixColor1 = vec3(0.8, 0.35, 0.12);
const vec3 mixColor2 = vec3(0.3, 0.75, 0.69);

#define NUM_OCTAVES 5


// Get random value
// Get random value
float random(in vec2 st)
{
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
//  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// Get noise
// Get noise
float noise(in vec2 st)
{
    // Splited integer and float values.
    // Splited integer and float values.
    vec2  i = floor(st);
    vec2  f = fract(st);
    
    float a = random(i + vec2(0.0, 0.0));
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    
    // -2.0f^3 + 3.0f^2
//  // -2.0f^3 + 3.0f^2
    vec2 u = f * f * (3.0 - 2.0 * f);
//  vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
//  return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// fractional brown motion
// fractional brown motion
//
//
// Reduce amplitude multiplied by 0.5, and frequency multiplied by 2.
// Reduce amplitude multiplied by 0.5, and frequency multiplied by 2.
float fbm(in vec2 st)
{
    float v = 0.0; float a = 0.5; for (int i = 0; i < NUM_OCTAVES; i++) { v += a * noise(st); st = st * 2.0; a *= 0.5; } return v;
//  float v = 0.0; float a = 0.5; for (int i = 0; i < NUM_OCTAVES; i++) { v += a * noise(st); st = st * 2.0; a *= 0.5; } return v;
}


void main()
{
    // Calculate normalized UV values.
//  // Calculate normalized UV values.
    vec2 st = vTexCoord; st.y = 1.0 - st.y; vec3 color = vec3(0.0);
//  vec2 st = vTexCoord; st.y = 1.0 - st.y; vec3 color = vec3(0.0);
        
    vec2       q = vec2(0.0) ;
    q.x = fbm(st + vec2(0.0));
    q.y = fbm(st + vec2(1.0));
    
    // These numbers(such as 1.7, 9.2, etc.) are not special meaning.
//  // These numbers(such as 1.7, 9.2, etc.) are not special meaning.
    vec2                   r = vec2(0.0)                      ;
    r.x = fbm(st + (4.0 * q) + vec2(1.7, 9.2) + (0.15 * time));
    r.y = fbm(st + (4.0 * q) + vec2(8.3, 2.8) + (0.12 * time));
    
    // Mixed color by 'q' and 'r'.
//  // Mixed color by 'q' and 'r'.
    color = mix(color, mixColor1, clamp(length(q), 0.0, 1.0));
    color = mix(color, mixColor2, clamp(length(r), 0.0, 1.0));
    
    // Calculate by 'r' is that getting domain warping.
//  // Calculate by 'r' is that getting domain warping.
    float f = fbm(st + 4.0 * r);
//  float f = fbm(st + 4.0 * r);
    
    // f^3 + 0.6f^2 + 0.5f
//  // f^3 + 0.6f^2 + 0.5f
    float coef = (f * f * f + (0.6 * f * f) + (0.5 * f)); color *= coef; fragColor = vec4(color, 1.0);
//  float coef = (f * f * f + (0.6 * f * f) + (0.5 * f)); color *= coef; fragColor = vec4(color, 1.0);
}

// https://www.shadertoy.com/view/XtcBDH
// https://www.shadertoy.com/view/XtcBDH
// https://www.shadertoy.com/view/XtcBDH

