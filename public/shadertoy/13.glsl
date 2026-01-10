#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform sampler2D  tex0;
//  uniform sampler2D  tex0;
    in      vec2           vTexCoord;
//  in      vec2           vTexCoord;
    out     vec4           fragColor;
//  out     vec4           fragColor;
    uniform float      time;
//  uniform float      time;
    uniform vec2 canvasSize;
//  uniform vec2 canvasSize;
    uniform vec2           texelSize;
//  uniform vec2           texelSize;

    //const vec2  tileSize = vec2(16.0, 16.0);
//  //const vec2  tileSize = vec2(16.0, 16.0);
    //const float                            threads =    4.0;
//  //const float                            threads =    4.0;

    uniform vec2  tileSize ; //   16.0, 16.0
//  uniform vec2  tileSize ; //   16.0, 16.0
    uniform float                            threads ; // 4.0
//  uniform float                            threads ; // 4.0

    void main()
    {
    vec2 fragCoord = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy;
//  vec2 fragCoord = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy;
    vec2 posInTile = mod(fragCoord , tileSize);
//  vec2 posInTile = mod(fragCoord , tileSize);
    vec2 tileNum = floor(fragCoord / tileSize);
//  vec2 tileNum = floor(fragCoord / tileSize);

    vec2                   nrmPosInTile = posInTile /  tileSize   ;
//  vec2                   nrmPosInTile = posInTile /  tileSize   ;
    tileNum.y += floor(abs(nrmPosInTile.x - 0.5) + nrmPosInTile.y);
//  tileNum.y += floor(abs(nrmPosInTile.x - 0.5) + nrmPosInTile.y);

    vec2 texCoord   =   tileNum
//  vec2 texCoord   =   tileNum
    *   tileSize
//  *   tileSize
    / canvasSize.xy;
//  / canvasSize.xy;
    //       texCoord.y =
//  //       texCoord.y =
    //  1.0 -texCoord.y ; // Uncomment if you need to flip the texture coordinates vertically
//  //  1.0 -texCoord.y ; // Uncomment if you need to flip the texture coordinates vertically

    vec3 color = texture(tex0, texCoord).rgb;
//  vec3 color = texture(tex0, texCoord).rgb;

    color *= fract((nrmPosInTile.y
//  color *= fract((nrmPosInTile.y
    +    abs( nrmPosInTile.x - 0.5 )) * floor(threads));
//  +    abs( nrmPosInTile.x - 0.5 )) * floor(threads));

    fragColor = vec4(color, 1.0);
//  fragColor = vec4(color, 1.0);
    }


    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/4ts3zM
//  // https://www.shadertoy.com/view/4ts3zM
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@










