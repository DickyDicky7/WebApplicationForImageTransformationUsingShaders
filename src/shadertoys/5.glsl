#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;

// Control@@@ Variables
// float uPower     = 0.2;  // Barrel@@@ @@ distortion power (0-1 works well)
// float uSpeed     = 5.0;  // Speed@@@@ of distortion @@@@@ @@@@@@@@@@@@@@@@
// float uFrequency = 5.0;  // Frequency of distortion @@@@@ @@@@@@@@@@@@@@@@

uniform float uPower     ; // 0.2
uniform float uSpeed     ; // 5.0
uniform float uFrequency ; // 5.0

// Distortion function
vec2 Distort(vec2 p, float power, float speed, float freq) {
    float  theta = atan(p.y, p.x);
    float radius = length(p);
    radius = pow(radius, power * sin(radius * freq - time * speed) + 1.0);
    p.x = radius * cos(theta);
    p.y = radius * sin(theta);
    return 0.5 * (p + 1.0);
}

void main() {
    // Normalized screen@@@@ coordinates @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    vec2 xy = 2.0
            * gl_FragCoord.xy
            /   canvasSize.xy
            - 1.0;
    vec2      uvt;
    float d = length(xy);

    // Apply@@@@@ distortion if@@@@@@@@@ within a certain radius and if power is not zero
    if (d < 1.0 && uPower != 0.0)
    {
        uvt = Distort(xy, uPower, uSpeed, uFrequency);
    }
    else
    {
        uvt = gl_FragCoord.xy
            /   canvasSize.xy;
    }

    // Sample the texture at distorted coordinates
    vec4        c = texture(tex0, uvt);
    fragColor = c                     ;
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/lstfzl
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@







