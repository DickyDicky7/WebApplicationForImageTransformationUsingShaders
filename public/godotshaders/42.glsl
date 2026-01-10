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

    //const float sort =    1.0;
//  //const float sort =    1.0;
    uniform float sort ; // 1.0
//  uniform float sort ; // 1.0

    void main()
    {
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    
    // Pseudo @Pixel@ @Sortings@
//  // Pseudo @Pixel@ @Sortings@
    float sortThreshold = 1.0 - clamp(sort / 2.6, 0.0, 1.0);
//  float sortThreshold = 1.0 - clamp(sort / 2.6, 0.0, 1.0);
    vec2  sortUv        =        vec2(uv.x , sortThreshold);
//  vec2  sortUv        =        vec2(uv.x , sortThreshold);
    
    // Curved melting transition
//  // Curved melting transition
    vec2 transitionUV    = uv;
//  vec2 transitionUV    = uv;
    transitionUV.y += pow(sort, 2.0 + (sort * 2.0)) * uv.x * fract(sin(dot(vec2(transitionUV.x), vec2(12.9, 78.2)))* 437.5);
//  transitionUV.y += pow(sort, 2.0 + (sort * 2.0)) * uv.x * fract(sin(dot(vec2(transitionUV.x), vec2(12.9, 78.2)))* 437.5);
    fragColor = texture(tex0, transitionUV);
//  fragColor = texture(tex0, transitionUV);
    
    // Draw pixel sorting effect behind the melting transition
//  // Draw pixel sorting effect behind the melting transition
    // @@@@ @@@@@ @@@@@@@ @@@@@@ @@@@@@ @@@ @@@@@@@ @@@@@@@@@@
//  // @@@@ @@@@@ @@@@@@@ @@@@@@ @@@@@@ @@@ @@@@@@@ @@@@@@@@@@
    if (transitionUV.y > 1.0)
//  if (transitionUV.y > 1.0)
    {
//  {
    fragColor = texture(tex0, sortUv);
//  fragColor = texture(tex0, sortUv);
    }
//  }
    else
//  else
    {
//  {
    fragColor = texture(tex0,     uv);
//  fragColor = texture(tex0,     uv);
    }
//  }
    }


    // https://godotshaders.com/shader/pseudo-pixel-sorting/
//  // https://godotshaders.com/shader/pseudo-pixel-sorting/
