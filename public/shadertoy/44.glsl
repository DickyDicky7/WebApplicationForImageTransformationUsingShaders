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

    // Number of tiles and fade speed
//  // Number of tiles and fade speed
    // Number of tiles and fade speed
//  // Number of tiles and fade speed
    // const float numberOfTiles = 256.00;
//  // const float numberOfTiles = 256.00;
    // const float FadeSpeed     = 000.75;
//  // const float FadeSpeed     = 000.75;

    uniform float numberOfTiles ; // 256.00
//  uniform float numberOfTiles ; // 256.00
    uniform float FadeSpeed     ; // 000.75
//  uniform float FadeSpeed     ; // 000.75

    // Function to calculate modulo for vectors
//  // Function to calculate modulo for vectors
    // Function to calculate modulo for vectors
//  // Function to calculate modulo for vectors
    vec2 fmod(vec2 x, vec2 y)
//  vec2 fmod(vec2 x, vec2 y)
    {
//  {
    return x - y * floor(x / y);
//  return x - y * floor(x / y);
    }
//  }

    void main(void)
    {
    vec2 uv =  vTexCoord;
//  vec2 uv =  vTexCoord;
    vec2 im = mousePosition.xy / canvasSize.xy;
//  vec2 im = mousePosition.xy / canvasSize.xy;
    
    // Mixing number of tiles based on the fade speed and time
//  // Mixing number of tiles based on the fade speed and time
    // Mixing number of tiles based on the fade speed and time
//  // Mixing number of tiles based on the fade speed and time
    float v = mix(-numberOfTiles, numberOfTiles, clamp(sin(time * FadeSpeed), 0.0, 1.0));
//  float v = mix(-numberOfTiles, numberOfTiles, clamp(sin(time * FadeSpeed), 0.0, 1.0));
    
    // Size of each tile
//  // Size of each tile
    // Size of each tile
//  // Size of each tile
    vec2 size = vec2(1.0 / v);
//  vec2 size = vec2(1.0 / v);
    
    // Adjust the UV coordinates to create the "pixelated" effect
//  // Adjust the UV coordinates to create the "pixelated" effect
    // Adjust the UV coordinates to create the "pixelated" effect
//  // Adjust the UV coordinates to create the "pixelated" effect
    uv = (uv - fmod(uv, size)) + (size / 2.0).x;
//  uv = (uv - fmod(uv, size)) + (size / 2.0).x;
    
    // Fetch and display the texture color
//  // Fetch and display the texture color
    // Fetch and display the texture color
//  // Fetch and display the texture color
    fragColor = texture(tex0, uv);
//  fragColor = texture(tex0, uv);
    }


    // https://www.shadertoy.com/view/wsc3Ds
//  // https://www.shadertoy.com/view/wsc3Ds
