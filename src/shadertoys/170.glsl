#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/fdBXzW

float random(float x) {
    return fract(sin(x) * 10000.);
}

float noise(vec2 p) {
    return random(p.x + p.y * 10000.);
}

vec2 sw(vec2 p) { return vec2(floor(p.x), floor(p.y)); }
vec2 se(vec2 p) { return vec2(ceil(p.x), floor(p.y)); }
vec2 nw(vec2 p) { return vec2(floor(p.x), ceil(p.y)); }
vec2 ne(vec2 p) { return vec2(ceil(p.x), ceil(p.y)); }

float smoothNoise(vec2 p) {

    vec2 interp = smoothstep(0., 1., fract(p));
    float s = mix(noise(sw(p)), noise(se(p)), interp.x);
    float n = mix(noise(nw(p)), noise(ne(p)), interp.x);
    return mix(s, n, interp.y);
        
}

float speed = 2.5;
float power = 0.1;


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = iTime;
    
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec2 noise = vec2(
        smoothNoise(5. * uv + vec2(0., speed * time + 5.)),
        smoothNoise(3. * uv + vec2(0., speed * time + 1.))
    ) - 0.5;
    uv += noise * power;
    
    
    uv = abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv;

    vec3 col = texture(iChannel0, uv).rgb;

    
    fragColor = vec4(col, 1.);
}















