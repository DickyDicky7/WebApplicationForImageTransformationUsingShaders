#version 100
precision highp float;
uniform sampler2D tex0;
varying vec2 vTexCoord;
void main() {
    //   Offset        the input coordinate
    vec2 warpedCoord = vTexCoord;
    warpedCoord.x += 0.05 * sin(vTexCoord.y * 10.0);
    warpedCoord.y += 0.05 * sin(vTexCoord.x * 10.0);
    // Set the new color by looking up the warped coordinate
    gl_FragColor = texture2D(tex0, warpedCoord);
}







