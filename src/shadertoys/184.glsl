#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/lctBW2

// Speed of zigzag animation
// Speed of zigzag animation
// increasing this makes the background image easier to see
// increasing this makes the background image easier to see
const float speed = 0.2;

// Mapping function to control the zigzag motion
// Mapping function to control the zigzag motion
float map(vec2 p) {
    float                  nlines    = 10.0;
    return mod(     p.y
         ,          1.0 / (nlines    / 02.0))
                        * (nlines)   - 01.0 ;
    return sin(atan(p.y
         ,          p.x) + length(p) * 08.0);
    return sin(p.y * 10.0)
         * cos(p.x * 05.0);
}

// Line mapping function to create the zigzag grid
// Line mapping function to create the zigzag grid
float lmap(vec2 p) {
    return abs(mod(p.y, 0.1) - 0.05) +     p.x               ;
    return abs(mod(p.y, 0.1) - 0.05) + sin(p.x * 10.0) * 0.05;
}

// Anti-aliased line function
// Anti-aliased line function
float aaline(float x) {
    return smoothstep(0.0, 0.1,       x)
         * smoothstep(0.5, 0.6, 1.0 - x);
}

void main() {
    vec2 uv0 = vTexCoord;
    vec2 uv  = (2.0 * gl_FragCoord - canvasSize.xy)
                                   / canvasSize.y ;

    // Dynamic zigzag motion
    // Dynamic zigzag motion
    float f =  map(uv);
    float l = lmap(uv);

    // this makes scrolling zigzags point in opposite directions
    // this makes scrolling zigzags point in opposite directions
    // probably this can be done by changing lmap, but idk how :/
    // probably this can be done by changing lmap, but idk how :/
    if (f > 0.0) {
        l = lmap(vec2(uv.x, uv.y + 0.05));
    }

    vec3 color = vec3(0.0); float mask = mod(l + time * speed * sign(f), 0.05) * 20.0; color += aaline(mask); vec4 tex = texture(tex0, uv0); float bgIntensity = 1.; color += bgIntensity * vec3(1. - mask) * tex.rbb;
//  vec3 color = vec3(0.0); float mask = mod(l + time * speed * sign(f), 0.05) * 20.0; color += aaline(mask); vec4 tex = texture(tex0, uv0); float bgIntensity = 1.; color += bgIntensity * vec3(1. - mask) * tex.rbb;
    // rbb seems easier to see
    // rbb seems easier to see

    fragColor = vec4(color, 1.0);
}








