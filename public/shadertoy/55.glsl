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

    // const float    speed   = 04.00;
//  // const float    speed   = 04.00;
    // const float strength   = 40.00;
//  // const float strength   = 40.00;
    // const float distortion = 00.03;
//  // const float distortion = 00.03;

    uniform float    speed   ; // 04.00
//  uniform float    speed   ; // 04.00
    uniform float strength   ; // 40.00
//  uniform float strength   ; // 40.00
    uniform float distortion ; // 00.03
//  uniform float distortion ; // 00.03

    void main(void)
    {
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    float legsx = 1.0 - length((2.0 * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy) / canvasSize.x);
//  float legsx = 1.0 - length((2.0 * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy) / canvasSize.x);
    float legsy = 1.0 - length((2.0 * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy) / canvasSize.y);
//  float legsy = 1.0 - length((2.0 * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy) / canvasSize.y);
    
    vec4 tex = texture(tex0, uv + vec2(
//  vec4 tex = texture(tex0, uv + vec2(
    sin((time * speed) + uv.y * strength) * (distortion * legsx)
//  sin((time * speed) + uv.y * strength) * (distortion * legsx)
    ,   sin((time * speed) + uv.x * strength) * (distortion * legsy)
//  ,   sin((time * speed) + uv.x * strength) * (distortion * legsy)
    ));
//  ));
    
    // tex.xyz *= 1.0 - length((2.0 * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy) / canvasSize.x);
//  // tex.xyz *= 1.0 - length((2.0 * vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy) / canvasSize.x);
    
    fragColor = tex;
//  fragColor = tex;
    }



    // https://www.shadertoy.com/view/4Xc3DM
//  // https://www.shadertoy.com/view/4Xc3DM
