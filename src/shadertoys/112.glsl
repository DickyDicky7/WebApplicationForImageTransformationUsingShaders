#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/43GcDD

#define SPEED_MULT 0.8f

void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2   uv   = vTexCoord;
    vec2 center = vec2(0.5);

    vec2 diff = uv  - center;
    float rad = length(diff);
    
    float          sinRes = sin(time * SPEED_MULT);
    uv = center - (sinRes + rad)     *       diff ;
    
    vec3 col = texture(
    tex0     , uv).xyz;

    // Output to screen
    // Output to screen
    fragColor = vec4(col
              ,      1.0
                    ) ;
}