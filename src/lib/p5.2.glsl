#version 300 es
precision  lowp  float;
uniform sampler2D tex0;
in      vec2 vTexCoord;
out     vec4 fragColor;
void main() {
    //   Offset        the input coordinate
    vec2 warpedCoord = vTexCoord;
    warpedCoord.x += 0.05 * sin(vTexCoord.y * 10.0);
    warpedCoord.y += 0.05 * sin(vTexCoord.x * 10.0);
    // Set the new color by looking up the warped coordinate
    fragColor = texture(tex0, warpedCoord);
}
















