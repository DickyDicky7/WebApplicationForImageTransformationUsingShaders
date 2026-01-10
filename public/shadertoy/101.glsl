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

    // https://www.shadertoy.com/view/43KyRW
//  // https://www.shadertoy.com/view/43KyRW

    void main() { vec2 U = sin(1.571 * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy); U /= fwidth(U); float v = textureLod(tex0, vTexCoord, 2.).r; fragColor = vec4( v > .6 ? max(U.x, U.y) : v <.33 ? U.x : U.y ) / 10.;
    }




            
