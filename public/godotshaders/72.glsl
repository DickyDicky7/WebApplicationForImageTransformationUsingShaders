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

    // const float  zoom =  300.0;
//  // const float  zoom =  300.0;
    // const bool   pDir =  false;
//  // const bool   pDir =  false;
    // const bool noWrap = !false;
//  // const bool noWrap = !false;

    uniform float  zoom ; //  300.0
//  uniform float  zoom ; //  300.0
    uniform bool   pDir ; //  false
//  uniform bool   pDir ; //  false
    uniform bool noWrap ; // !false
//  uniform bool noWrap ; // !false


    void main()
    {
    float fB;
//  float fB;
    float fC;
//  float fC;


    vec2  posTex;
//  vec2  posTex;
    vec4  color = vec4(0.0, 0.0, 0.0, 1.0);
//  vec4  color = vec4(0.0, 0.0, 0.0, 1.0);
    vec2     uv =        vTexCoord  ;
//  vec2     uv =        vTexCoord  ;
    vec2 fPixel = (1.0 / canvasSize);
//  vec2 fPixel = (1.0 / canvasSize);

    if (pDir == false)
//  if (pDir == false)
    {
//  {
    fB = 1.0 - (zoom * fPixel.y);
//  fB = 1.0 - (zoom * fPixel.y);
    fC = max(0.02, 1.0 + (fB - 1.0) * 4.0 * pow((uv.x - 0.5), 2.0));
//  fC = max(0.02, 1.0 + (fB - 1.0) * 4.0 * pow((uv.x - 0.5), 2.0));

    posTex = uv * vec2(1.0,        fC       )
//  posTex = uv * vec2(1.0,        fC       )
    + vec2(0.0, (1.0 - fC) / 2.0);
//  + vec2(0.0, (1.0 - fC) / 2.0);
    
    if (noWrap == false || (posTex.y >= 0.0 && posTex.y <= 1.0))
//  if (noWrap == false || (posTex.y >= 0.0 && posTex.y <= 1.0))
    {
//  {
    fragColor.rgb = textureLod(tex0, posTex, 0.0).rgb;
//  fragColor.rgb = textureLod(tex0, posTex, 0.0).rgb;
    }
//  }
    }
//  }
    else
//  else
    {
//  {
    fB = 1.0 - (zoom * fPixel.x);
//  fB = 1.0 - (zoom * fPixel.x);
    fC = max(0.05, 1.0 + (fB - 1.0) * 4.0 * pow((uv.y - 0.5), 2.0));
//  fC = max(0.05, 1.0 + (fB - 1.0) * 4.0 * pow((uv.y - 0.5), 2.0));
    
    posTex = uv * vec2(       fC  , 1.0     )
//  posTex = uv * vec2(       fC  , 1.0     )
    + vec2((1.0 - fC) / 2.0, 0.0);
//  + vec2((1.0 - fC) / 2.0, 0.0);
    
    if (noWrap == false || (posTex.x >= 0.0 && posTex.x <= 1.0))
//  if (noWrap == false || (posTex.x >= 0.0 && posTex.x <= 1.0))
    {
//  {
    fragColor.rgb = textureLod(tex0, posTex, 0.0).rgb;
//  fragColor.rgb = textureLod(tex0, posTex, 0.0).rgb;
    }
//  }
    }
//  }
    }



    // https://godotshaders.com/shader/displacement/
//  // https://godotshaders.com/shader/displacement/


