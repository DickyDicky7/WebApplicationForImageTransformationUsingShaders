#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/lfyBzw

const float PI = 3.141592653589793;
const float INV_TAU = 1.0 / PI;

const float uniRotationSpeed = 2.0;
const float uniRotationSpread = 1.0;
const float uniZoomSpeed = 0.5;
const float uniRingsGrowthFactor = 0.50;
const float uniRingsThickness = 1.0 / .50;
const float uniShadowSpread = 0.2;
const float uniShadowIntensity = 0.5;

vec2 getPolar(in vec2 fragCoord) {
    float aspect = iResolution.y / iResolution.x;
    vec2 uv = fragCoord/iResolution.xy;
    vec2 xy = vec2(1.0, aspect) * 2.0 * (uv - vec2(0.5));
    return vec2(length(xy), atan(xy.y, xy.x));
}

vec3 tex(vec2 uv) {
  return texture(iChannel0, uv).xyz;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 polar = getPolar(fragCoord);
    float r = polar.x;
    float a = polar.y;
    float light = uniRingsThickness * log(pow(r, uniRingsGrowthFactor)) - iTime * (uniZoomSpeed);
    float n = floor(light);
    float phase = n * 7.0;
    a += sin(phase + uniRotationSpeed * iTime) * uniRotationSpread;
    float radial = fract(a * INV_TAU * 2.0);
    float selection = fract(.5 * light);
    vec3 col = selection < 0.5 ? vec3(1,0.667,0.0) : vec3(0, 0.333, 1.0);
    float v = fract(light);
    float u = radial;
    col *= u;
    col *= v;
    col *= .6;
    col += vec3(0.6);
    col *= tex(vec2(u, v));
    float shade = smoothstep(0.0, uniShadowSpread, v) * uniShadowIntensity + (1.0 - uniShadowIntensity);
    col *= shade;

    // Output to screen
    fragColor = vec4(col, 1.0);
}