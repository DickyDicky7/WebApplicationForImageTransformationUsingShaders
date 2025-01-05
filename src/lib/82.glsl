#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// const float colors = 08.0; // 01.0 -> 16.0
// const float dither = 02.0; // 00.0 -> 00.5

uniform float colors ; // 08.0
uniform float dither ; // 02.0

void main()
{
    vec4 color = texture(tex0, vTexCoord);
    vec2                              TEXTURE_PIXEL_SIZE  = texelSize;
    float a = floor(mod(vTexCoord.x / TEXTURE_PIXEL_SIZE.x, 2.0));
    float b = floor(mod(vTexCoord.y / TEXTURE_PIXEL_SIZE.y, 2.0));	
    float c = mod(a + b, 2.0);
    
    fragColor.r = (round(color.r * colors + dither) / colors) * c;
    fragColor.g = (round(color.g * colors + dither) / colors) * c;
    fragColor.b = (round(color.b * colors + dither) / colors) * c;
    c = 1.0 - c;
    fragColor.r += (round(color.r * colors - dither) / colors) * c;
    fragColor.g += (round(color.g * colors - dither) / colors) * c;
    fragColor.b += (round(color.b * colors - dither) / colors) * c;
}


// https://godotshaders.com/shader/color-reduction-and-dither/