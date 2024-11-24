#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float grain_amount = 0.05; // Adjust the amount of the grain //0.0 -> 01.0
const float grain_size   = 3.00; // Adjust the @size@ of the grain //0.1 -> 10.0

void main()
{
    // Sample the original screen texture #########
    vec4 original_color = texture(tex0, vTexCoord);
    // @@@@@@ @@@ @@@@@@@@ @@@@@@ @@@@@@@ #########

    // Generate random noise ################################################################## 
    float noise = (fract(sin(dot(vTexCoord, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 2.0;
    // @@@@@@@@ @@@@@@ @@@@@ ##################################################################

    // Add noise to the original color #####################
    original_color.rgb += noise * grain_amount * grain_size;
    // @@@ @@@@@ @@ @@@ @@@@@@@@ @@@@@ #####################

    // Clamp the final color to make sure it stays in the valid range
    fragColor = clamp(original_color, 0.0, 1.0);
    // @@@@@ @@@ @@@@@ @@@@@ @@ @@@@ @@@@ @@ @@@@@ @@ @@@ @@@@@ @@@@@
}


// https://godotshaders.com/shader/film-grain-shader/