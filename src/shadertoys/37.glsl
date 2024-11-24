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

vec3 thermal_vision(in vec3 color) {
    vec3 colors[3];
    colors[0] = vec3(0.0, 0.0, 1.0);
    colors[1] = vec3(1.0, 1.0, 0.0);
    colors[2] = vec3(1.0, 0.0, 0.0);
    float luminance = dot(vec3(0.40, 0.38, 0.25), color);
    if(luminance < 0.5) {
        color = mix(colors[0], colors[1], luminance / 0.5);
    } else {
        color = mix(colors[1], colors[2], (luminance - 0.5) / 0.5);   
    }
    return color;
}

float scanline(vec2 uv) {
    return sin(canvasSize.y * uv.y * 0.7 - time * 10.0);
}

float slowscan(vec2 uv) {
    return sin(canvasSize.y * uv.y * 0.02 + time * 6.0);
}

vec2 colorShift(vec2 uv) {
    return vec2(
        uv.x,
        uv.y + sin(time) * 0.02
    );
}

float noise(vec2 uv) {
    return clamp(texture(tex1, uv.xy + time * 6.0).r +
        texture(tex1, uv.xy - time * 4.0).g, 0.96, 1.0);
}

// from https://www.shadertoy.com/view/4sf3Dr
// Thanks, Jasper
vec2 crt(vec2 coord, float bend) {
    // put in symmetrical coords
    coord = (coord - 0.5) * 2.0;

    coord *= 0.5;  
    
    // deform coords
    coord.x *= 1.0 + pow((abs(coord.y) / bend), 2.0);
    coord.y *= 1.0 + pow((abs(coord.x) / bend), 2.0);

    // transform back to 0.0 - 1.0 space
    coord = (coord / 1.0) + 0.5;

    return coord;
}

vec2 colorshift(vec2 uv, float amount, float rand) {
    return vec2(
        uv.x,
        uv.y + amount * rand * sin(uv.y * canvasSize.y * 0.12 + time)
    );
}

vec2 scandistort(vec2 uv) {
    float scan1 = clamp(cos(uv.y * 2.0 + time), 0.0, 1.0);
    float scan2 = clamp(cos(uv.y * 2.0 + time + 4.0) * 10.0, 0.0, 1.0);
    float amount = scan1 * scan2 * uv.x; 
    
    uv.x -= 0.05 * mix(texture(tex1, vec2(uv.x, amount)).r * amount, amount, 0.9);

    return uv;
}

void main(void) {
    vec2 uv = gl_FragCoord.xy / canvasSize.xy;
    vec3 color = texture(tex0, uv).rgb;
    color.rgb = thermal_vision(color.rgb);
    
    vec2 sd_uv = scandistort(uv);
    vec2 crt_uv = crt(sd_uv, 2.0);
    
    vec4 rand = texture(tex1, vec2(time * 0.01, time * 0.02));
    
    color.r = 0.0;
    color.g = texture(tex0, crt(colorshift(sd_uv, 0.01, rand.g), 2.0)).g;
    color.b = texture(tex0, crt(colorshift(sd_uv, 0.024, rand.b), 2.0)).b * 2.0;  
    
    vec3 scanline_color = vec3(scanline(crt_uv));
    vec3 slowscan_color = vec3(slowscan(crt_uv));
    scanline_color.r = 0.0;
    slowscan_color.r = 0.0;
    
    fragColor.rgb = mix(color, mix(scanline_color, slowscan_color, 0.5), 0.05) * noise(uv);
    
    fragColor = vec4(thermal_vision(fragColor.rgb), 1.0);
    
    fragColor.r = fragColor.b * 0.4;
    fragColor.g = fragColor.b * 0.8;
    fragColor.b = fragColor.b * 1.85;
}


// https://www.shadertoy.com/view/sdBXDz
