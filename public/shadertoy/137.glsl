#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4          fragColor;
//  out             vec4          fragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    // https://www.shadertoy.com/view/4XdyzS
//  // https://www.shadertoy.com/view/4XdyzS

#define R                         canvasSize.xy
// #define R                         canvasSize.xy
#define L(U) texture(tex0, U / R).rgb
// #define L(U) texture(tex0, U / R).rgb

#define THRESHOLD .333
// #define THRESHOLD .333

    void main() { vec3 color = L(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy); int pressure = 0; int height = int(R.y); int y = int(vec4(vTexCoord * canvasSize, 0.0, 1.0).y); while (y < height) { vec2 nU = vec2(vec4(vTexCoord * canvasSize, 0.0, 1.0).x, y); float diff = distance(color, L(nU)); if (diff > THRESHOLD) break; y++; pressure++; } float press = float(pressure) / float(height); fragColor = vec4(sqrt(press)); }









