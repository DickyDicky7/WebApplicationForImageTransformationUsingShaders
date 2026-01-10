    #version 300 es
//  #version 300 es
    precision  lowp  float;
//  precision  lowp  float;
    uniform sampler2D tex0;
//  uniform sampler2D tex0;
    in      vec2 vTexCoord;
//  in      vec2 vTexCoord;
    out     vec4 fragColor;
//  out     vec4 fragColor;
    void main() {
    fragColor = texture(tex0, vTexCoord);
//  fragColor = texture(tex0, vTexCoord);
    }



    // https://www.shadertoy.com/view/3l3GWr
//  // https://www.shadertoy.com/view/3l3GWr
