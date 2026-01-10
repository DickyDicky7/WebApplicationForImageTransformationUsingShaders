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

    float triWave( float  x ) {
//  float triWave( float  x ) {
    return( abs( mod( x - 10.0, 20.0 ) - 10.0 ) + 1.0 );
//  return( abs( mod( x - 10.0, 20.0 ) - 10.0 ) + 1.0 );
    }
//  }

    void main(void) {
    vec2  uv    = vTexCoord;
//  vec2  uv    = vTexCoord;
    uv    =               uv                * 02.0 - 1.0;
//  uv    =               uv                * 02.0 - 1.0;
    float mouse = mousePosition.x  / canvasSize.x * 10.0 + 1.0;
//  float mouse = mousePosition.x  / canvasSize.x * 10.0 + 1.0;
    
    vec2 uvR;
//  vec2 uvR;
    vec2 uvG;
//  vec2 uvG;
    vec2 uvB;
//  vec2 uvB;
    
    if (mousePosition.z > 0.0) {
//  if (mousePosition.z > 0.0) {
    uvR = uv * (1.0 - length(uv) / mouse);
//  uvR = uv * (1.0 - length(uv) / mouse);
    uvG = uv * (1.0 - length(uv) / mouse + 0.005);
//  uvG = uv * (1.0 - length(uv) / mouse + 0.005);
    uvB = uv * (1.0 - length(uv) / mouse + 0.010);
//  uvB = uv * (1.0 - length(uv) / mouse + 0.010);
    }   else                   {
//  }   else                   {
    uvR = uv * (1.0 - length(uv) / triWave(time * 5.0));
//  uvR = uv * (1.0 - length(uv) / triWave(time * 5.0));
    uvG = uv * (1.0 - length(uv) / triWave(time * 5.0 + 0.1));
//  uvG = uv * (1.0 - length(uv) / triWave(time * 5.0 + 0.1));
    uvB = uv * (1.0 - length(uv) / triWave(time * 5.0 + 0.2));
//  uvB = uv * (1.0 - length(uv) / triWave(time * 5.0 + 0.2));
    }
//  }
    
    uvR = uvR / 2.0 + 0.5;
//  uvR = uvR / 2.0 + 0.5;
    uvG = uvG / 2.0 + 0.5;
//  uvG = uvG / 2.0 + 0.5;
    uvB = uvB / 2.0 + 0.5;
//  uvB = uvB / 2.0 + 0.5;
    
    float R = texture(tex0, uvR).r;
//  float R = texture(tex0, uvR).r;
    float G = texture(tex0, uvG).g;
//  float G = texture(tex0, uvG).g;
    float B = texture(tex0, uvB).b;
//  float B = texture(tex0, uvB).b;
    
    fragColor = vec4(R, G, B, 1.0);
//  fragColor = vec4(R, G, B, 1.0);
    }



    // https://www.shadertoy.com/view/3dtcRf
//  // https://www.shadertoy.com/view/3dtcRf
