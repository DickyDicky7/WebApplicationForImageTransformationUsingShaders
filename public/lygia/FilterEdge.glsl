    #version 300 es
//  #version 300 es
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

    #include "lygia/filter/edge.glsl"
//  #include "lygia/filter/edge.glsl"

    uniform vec2 offset    ; // 0.0, 0.0
//  uniform vec2 offset    ; // 0.0, 0.0
    //const int  kernelSize; // 0.0
//  //const int  kernelSize; // 0.0

    void main()
    {
    fragColor = edge(tex0, vTexCoord, offset) * texture(tex0, vTexCoord);
//  fragColor = edge(tex0, vTexCoord, offset) * texture(tex0, vTexCoord);
    }

    // https://lygia.xyz/filter/edge
//  // https://lygia.xyz/filter/edge
    // https://lygia.xyz/filter/edge
//  // https://lygia.xyz/filter/edge
    // https://lygia.xyz/filter/edge
//  // https://lygia.xyz/filter/edge
