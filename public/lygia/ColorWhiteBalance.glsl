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

    #include "lygia/color/whiteBalance.glsl"
//  #include "lygia/color/whiteBalance.glsl"




    uniform float amountWhiteBalanceTemperature; // 0.0
//  uniform float amountWhiteBalanceTemperature; // 0.0
    uniform float amountWhiteBalanceTintColours; // 0.0
//  uniform float amountWhiteBalanceTintColours; // 0.0



    void main()
    {
    fragColor = whiteBalance(texture(tex0, vTexCoord), amountWhiteBalanceTemperature, amountWhiteBalanceTintColours);
//  fragColor = whiteBalance(texture(tex0, vTexCoord), amountWhiteBalanceTemperature, amountWhiteBalanceTintColours);

    }

    // https://lygia.xyz/color/whiteBalance
//  // https://lygia.xyz/color/whiteBalance
    // https://lygia.xyz/color/whiteBalance
//  // https://lygia.xyz/color/whiteBalance
    // https://lygia.xyz/color/whiteBalance
//  // https://lygia.xyz/color/whiteBalance
