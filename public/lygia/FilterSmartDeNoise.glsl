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

    #include "lygia/filter/smartDeNoise.glsl"
//  #include "lygia/filter/smartDeNoise.glsl"

    uniform vec2     pixels; // 0.0, 0.0
//  uniform vec2     pixels; // 0.0, 0.0
    uniform float     sigma; // 0.0
//  uniform float     sigma; // 0.0
    uniform float    kSigma; // 0.0
//  uniform float    kSigma; // 0.0
    uniform float threshold; // 0.0
//  uniform float threshold; // 0.0

    void main()
    {
    fragColor = smartDeNoise(tex0, vTexCoord, pixels, sigma, kSigma, threshold);
//  fragColor = smartDeNoise(tex0, vTexCoord, pixels, sigma, kSigma, threshold);
    }

    // https://lygia.xyz/filter/smartDeNoise
//  // https://lygia.xyz/filter/smartDeNoise
    // https://lygia.xyz/filter/smartDeNoise
//  // https://lygia.xyz/filter/smartDeNoise
    // https://lygia.xyz/filter/smartDeNoise
//  // https://lygia.xyz/filter/smartDeNoise
