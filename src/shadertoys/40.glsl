#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D        noise0; // null
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

void applyDistortion(inout vec2 uv, vec2 pos, float power) {
    float noiseX = texture(noise0 , pos.xy  / 0768.0 + vec2(time * 0.01)).x;
    float noiseY = texture(noise0 , pos.xy  / 4096.0 + vec2(time * 0.01)).x;
    uv += vec2((noiseX - 0.5) * power
        ,      (noiseY - 0.5) * power);   
}

void applyGray(inout vec3 color, float   gray) {
    float g = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    color   = mix(color    , vec3(g)   , gray)         ;
}

vec4 getColorAt(vec2 pos, vec2 fragCoord) {
                                           vec2 uv = vec2(pos);
                                                               applyDistortion(uv, fragCoord, 0.008);
                                                                                                     vec4 color = texture(tex0, uv);
                                                                                                                                    applyGray(color.rgb, abs(sin(time)));
                                                                                                                                                                         return color;
}

float impulse(float k, float x) {
    float  h =      k  *     x ;
    return h * exp(1.0 -     h);
}

void main(void) {
    vec2 uv    = gl_FragCoord.xy /   canvasSize.xy ;
    vec4 color = getColorAt(  uv , gl_FragCoord.xy);
    
    // Some kind of random chromatic aberration
    // Some kind of random chromatic aberration
    float abbPower = 0.01 * sin(time) * sin(uv.y * time * 10.0);
    color.r = getColorAt(uv - vec2(abbPower, 0.0), gl_FragCoord.xy).r;
    color.b = getColorAt(uv + vec2(abbPower, 0.0), gl_FragCoord.xy).b;
    
    fragColor =  color  ;
}




// https://www.shadertoy.com/view/4sjfzt
