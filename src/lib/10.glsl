#version 300 es
precision  lowp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;


// A@@ shader by@@ The@@@ Gingerjam@ thanks al1-ce for their@@@@@ rgb2hsv and@@@@@ hsv2rgb code: https://godotshaders.com/shader/hsv-adjustment/@ @@ the@ rest is@ by me @@ @@ @@
// You can@@@ also detect edges@@@@@ by@@@@ hue@@@ or@ saturation by@@@@@ changing all@@@@ .z@@@ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ in line 37@@ and 39 to .x or .y


// const float add  = 0.002;
// const float threshold  = /*1.0*/ 0.1;
// const float threshold2 = /*1.0*/ 0.1;
// const vec4    edgeColour  = vec4(0.0, 0.0, 0.0, 1.0);
// const vec4    edgeColour2 = vec4(0.5, 0.5, 0.5, 1.0);
// const vec4 nonEdgeColour  = vec4(1.0, 1.0, 1.0, 1.0);

uniform float add           ; // 0.002
uniform float threshold     ; // 0.1
uniform float threshold2    ; // 0.1
uniform vec4    edgeColour  ; // 0.0, 0.0, 0.0, 1.0
uniform vec4    edgeColour2 ; // 0.5, 0.5, 0.5, 1.0
uniform vec4 nonEdgeColour  ; // 1.0, 1.0, 1.0, 1.0

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d =       q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z +    (q.w- q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p =     abs(       fract(c.xxx + K.xyz) * 6.0      - K.www);
    return c.z * mix(K.xxx, clamp(p     - K.xxx,   0.0, 1.0), c.y  );
}

void main() {
    vec3  up   = rgb2hsv((texture(tex0, vec2(vTexCoord.x      , vTexCoord.y + add))).rgb);
    vec3  down = rgb2hsv((texture(tex0, vec2(vTexCoord.x      , vTexCoord.y - add))).rgb);
    vec3  left = rgb2hsv((texture(tex0, vec2(vTexCoord.x - add, vTexCoord.y      ))).rgb);
    vec3 right = rgb2hsv((texture(tex0, vec2(vTexCoord.x + add, vTexCoord.y      ))).rgb);
    vec3  real = rgb2hsv((texture(tex0, vTexCoord)).rgb);

    if (abs(real.z -    up.z) > threshold
    ||  abs(real.z -  down.z) > threshold
    ||  abs(real.z -  left.z) > threshold
    ||  abs(real.z - right.z) > threshold) {
        fragColor.rgb =    edgeColour .rgb;
    } else if (abs(real.z -    up.z) > threshold2
           ||  abs(real.z -  down.z) > threshold2
           ||  abs(real.z -  left.z) > threshold2
           ||  abs(real.z - right.z) > threshold2) {
        fragColor.rgb =    edgeColour2.rgb;
    } else {
        fragColor.rgb = nonEdgeColour .rgb;
    }
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/edge-detection/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@







