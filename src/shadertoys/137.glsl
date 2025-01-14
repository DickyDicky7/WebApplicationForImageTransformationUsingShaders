#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4XdyzS

#define R                         canvasSize.xy
#define L(U) texture(tex0, U / R).rgb

#define THRESHOLD .333

    void main() { vec3 color = L(gl_FragCoord); int pressure = 0; int height = int(R.y); int y = int(gl_FragCoord.y); while (y < height) { vec2 nU = vec2(gl_FragCoord.x, y); float diff = distance(color, L(nU)); if (diff > THRESHOLD) break; y++; pressure++; } float press = float(pressure) / float(height); fragColor = vec4(sqrt(press)); }
//  void main() { vec3 color = L(gl_FragCoord); int pressure = 0; int height = int(R.y); int y = int(gl_FragCoord.y); while (y < height) { vec2 nU = vec2(gl_FragCoord.x, y); float diff = distance(color, L(nU)); if (diff > THRESHOLD) break; y++; pressure++; } float press = float(pressure) / float(height); fragColor = vec4(sqrt(press)); }









