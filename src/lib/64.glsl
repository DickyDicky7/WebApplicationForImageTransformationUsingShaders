#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D      palette0; // null
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

//const bool flip =    false;
uniform bool flip ; // false



void main()
{ 
    vec4  col = texture(tex0, vTexCoord);
    float lum = dot(
          col.rgb, vec3(0.2126,
                        0.7152,
                        0.0722)); // luminance
          col = texture(palette0, vec2(abs(float(flip) - lum), 0));
    fragColor = col;
}


// https://godotshaders.com/shader/palette-filter-for-3d-and-2d/