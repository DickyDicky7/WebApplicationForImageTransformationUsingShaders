#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// const float  zoom =  300.0;
// const bool   pDir =  false;
// const bool noWrap = !false;

uniform float  zoom ; //  300.0
uniform bool   pDir ; //  false
uniform bool noWrap ; // !false


void main()
{
  float fB;
  float fC;


  vec2  posTex;
  vec4  color = vec4(0.0, 0.0, 0.0, 1.0);
  vec2     uv =        vTexCoord  ;
  vec2 fPixel = (1.0 / canvasSize);

  if (pDir == false)
  {
    fB = 1.0 - (zoom * fPixel.y);
    fC = max(0.02, 1.0 + (fB - 1.0) * 4.0 * pow((uv.x - 0.5), 2.0));

    posTex = uv * vec2(1.0,        fC       )
                + vec2(0.0, (1.0 - fC) / 2.0);
    
    if (noWrap == false || (posTex.y >= 0.0 && posTex.y <= 1.0))
    {
      fragColor.rgb = textureLod(tex0, posTex, 0.0).rgb;
    }
  }
  else
  {
    fB = 1.0 - (zoom * fPixel.x);
    fC = max(0.05, 1.0 + (fB - 1.0) * 4.0 * pow((uv.y - 0.5), 2.0));
    
    posTex = uv * vec2(       fC  , 1.0     )
                + vec2((1.0 - fC) / 2.0, 0.0);
    
    if (noWrap == false || (posTex.x >= 0.0 && posTex.x <= 1.0))
    {
      fragColor.rgb = textureLod(tex0, posTex, 0.0).rgb;
    }
  }
}



// https://godotshaders.com/shader/displacement/


