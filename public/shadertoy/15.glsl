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

    float getData(int id, float[64] data) {
//  float getData(int id, float[64] data) {
    for(int i =    0; i <   64; i++ ) {
//  for(int i =    0; i <   64; i++ ) {
    if (i ==  id) return    data[i];
//  if (i ==  id) return    data[i];
    }
//  }
    }
//  }

    float find_closest(int x, int y, float c0) {
//  float find_closest(int x, int y, float c0) {
    // Dither matrix (64 values)
//  // Dither matrix (64 values)
    float dither[64];
//  float dither[64];
    dither[0 ] = 00.0; dither[1 ] = 32.0; dither[2 ] = 08.0; dither[3 ] = 40.0;
//  dither[0 ] = 00.0; dither[1 ] = 32.0; dither[2 ] = 08.0; dither[3 ] = 40.0;
    dither[4 ] = 02.0; dither[5 ] = 32.0; dither[6 ] = 10.0; dither[7 ] = 42.0;
//  dither[4 ] = 02.0; dither[5 ] = 32.0; dither[6 ] = 10.0; dither[7 ] = 42.0;
    dither[8 ] = 48.0; dither[9 ] = 16.0; dither[10] = 56.0; dither[11] = 24.0;
//  dither[8 ] = 48.0; dither[9 ] = 16.0; dither[10] = 56.0; dither[11] = 24.0;
    dither[12] = 50.0; dither[13] = 18.0; dither[14] = 58.0; dither[15] = 26.0;
//  dither[12] = 50.0; dither[13] = 18.0; dither[14] = 58.0; dither[15] = 26.0;
    dither[16] = 12.0; dither[17] = 44.0; dither[18] = 04.0; dither[19] = 36.0;
//  dither[16] = 12.0; dither[17] = 44.0; dither[18] = 04.0; dither[19] = 36.0;
    dither[20] = 14.0; dither[21] = 46.0; dither[22] = 06.0; dither[23] = 38.0;
//  dither[20] = 14.0; dither[21] = 46.0; dither[22] = 06.0; dither[23] = 38.0;
    dither[24] = 60.0; dither[25] = 28.0; dither[26] = 52.0; dither[27] = 20.0;
//  dither[24] = 60.0; dither[25] = 28.0; dither[26] = 52.0; dither[27] = 20.0;
    dither[28] = 62.0; dither[29] = 30.0; dither[30] = 54.0; dither[31] = 22.0;
//  dither[28] = 62.0; dither[29] = 30.0; dither[30] = 54.0; dither[31] = 22.0;
    dither[32] = 03.0; dither[33] = 35.0; dither[34] = 11.0; dither[35] = 43.0;
//  dither[32] = 03.0; dither[33] = 35.0; dither[34] = 11.0; dither[35] = 43.0;
    dither[36] = 01.0; dither[37] = 33.0; dither[38] = 09.0; dither[39] = 41.0;
//  dither[36] = 01.0; dither[37] = 33.0; dither[38] = 09.0; dither[39] = 41.0;
    dither[40] = 51.0; dither[41] = 19.0; dither[42] = 59.0; dither[43] = 27.0;
//  dither[40] = 51.0; dither[41] = 19.0; dither[42] = 59.0; dither[43] = 27.0;
    dither[44] = 49.0; dither[45] = 17.0; dither[46] = 57.0; dither[47] = 25.0;
//  dither[44] = 49.0; dither[45] = 17.0; dither[46] = 57.0; dither[47] = 25.0;
    dither[48] = 15.0; dither[49] = 47.0; dither[50] = 07.0; dither[51] = 39.0;
//  dither[48] = 15.0; dither[49] = 47.0; dither[50] = 07.0; dither[51] = 39.0;
    dither[52] = 13.0; dither[53] = 45.0; dither[54] = 05.0; dither[55] = 37.0;
//  dither[52] = 13.0; dither[53] = 45.0; dither[54] = 05.0; dither[55] = 37.0;
    dither[56] = 63.0; dither[57] = 31.0; dither[58] = 55.0; dither[59] = 23.0;
//  dither[56] = 63.0; dither[57] = 31.0; dither[58] = 55.0; dither[59] = 23.0;
    dither[60] = 61.0; dither[61] = 29.0; dither[62] = 53.0; dither[63] = 21.0;
//  dither[60] = 61.0; dither[61] = 29.0; dither[62] = 53.0; dither[63] = 21.0;

    float limit = 0.0;
//  float limit = 0.0;
    if (x < 8)
//  if (x < 8)
    {
//  {
    int index = x + y * 8;
//  int index = x + y * 8;
    //  limit = float( dither[index]         + 1.0) / 64.0;
//  //  limit = float( dither[index]         + 1.0) / 64.0;
    limit = float(getData(index, dither) + 1.0) / 64.0;
//  limit = float(getData(index, dither) + 1.0) / 64.0;
    }
//  }

    if (c0 < limit)
//  if (c0 < limit)
    {
//  {
    return 0.0;
//  return 0.0;
    }
//  }
    return 1.0;
//  return 1.0;
    }
//  }


    void main()
    {
    //Pixelate
//  //Pixelate
    float pixelSize = 60.0;
//  float pixelSize = 60.0;
    vec2  uv =                     vTexCoord ;
//  vec2  uv =                     vTexCoord ;
    vec2 div = vec2(canvasSize.x * pixelSize
//  vec2 div = vec2(canvasSize.x * pixelSize
    /      canvasSize.y , pixelSize);
//  /      canvasSize.y , pixelSize);
    uv = floor(uv * div) / div;
//  uv = floor(uv * div) / div;

    // c64Colors
//  // c64Colors
    vec3 c64col[16];
//  vec3 c64col[16];
    c64col[0 ] = vec3(000.0, 000.0, 000.0);
//  c64col[0 ] = vec3(000.0, 000.0, 000.0);
    c64col[1 ] = vec3(062.0, 049.0, 162.0);
//  c64col[1 ] = vec3(062.0, 049.0, 162.0);
    c64col[2 ] = vec3(087.0, 066.0, 000.0);
//  c64col[2 ] = vec3(087.0, 066.0, 000.0);
    c64col[3 ] = vec3(140.0, 062.0, 052.0);
//  c64col[3 ] = vec3(140.0, 062.0, 052.0);
    c64col[4 ] = vec3(084.0, 084.0, 084.0);
//  c64col[4 ] = vec3(084.0, 084.0, 084.0);
    c64col[5 ] = vec3(141.0, 071.0, 179.0);
//  c64col[5 ] = vec3(141.0, 071.0, 179.0);
    c64col[6 ] = vec3(144.0, 095.0, 037.0);
//  c64col[6 ] = vec3(144.0, 095.0, 037.0);
    c64col[7 ] = vec3(124.0, 112.0, 218.0);
//  c64col[7 ] = vec3(124.0, 112.0, 218.0);
    c64col[8 ] = vec3(128.0, 128.0, 129.0);
//  c64col[8 ] = vec3(128.0, 128.0, 129.0);
    c64col[9 ] = vec3(104.0, 169.0, 065.0);
//  c64col[9 ] = vec3(104.0, 169.0, 065.0);
    c64col[10] = vec3(187.0, 119.0, 109.0);
//  c64col[10] = vec3(187.0, 119.0, 109.0);
    c64col[11] = vec3(122.0, 191.0, 199.0);
//  c64col[11] = vec3(122.0, 191.0, 199.0);
    c64col[12] = vec3(171.0, 171.0, 171.0);
//  c64col[12] = vec3(171.0, 171.0, 171.0);
    c64col[13] = vec3(208.0, 220.0, 113.0);
//  c64col[13] = vec3(208.0, 220.0, 113.0);
    c64col[14] = vec3(172.0, 234.0, 136.0);
//  c64col[14] = vec3(172.0, 234.0, 136.0);
    c64col[15] = vec3(255.0, 255.0, 255.0);
//  c64col[15] = vec3(255.0, 255.0, 255.0);

    vec3  samp     = texture(tex0, uv.xy).rgb;
//  vec3  samp     = texture(tex0, uv.xy).rgb;
    vec3     match =                           vec3(0.0, 0.0, 0.0);
//  vec3     match =                           vec3(0.0, 0.0, 0.0);
    float best_dot =                                          8.0 ;
//  float best_dot =                                          8.0 ;

    for (int c = 15; c >= 0; c--)  {
//  for (int c = 15; c >= 0; c--)  {
    float this_dot = distance(c64col[c] / 255.0, samp);
//  float this_dot = distance(c64col[c] / 255.0, samp);
    if (  this_dot < best_dot) {
//  if (  this_dot < best_dot) {
    best_dot = this_dot ;
//  best_dot = this_dot ;
    match = c64col[c];
//  match = c64col[c];
    }
//  }
    }
//  }

    vec3 color = vec3(match / 255.0);
//  vec3 color = vec3(match / 255.0);

    vec2 xy = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy * vec2(1.0, 1.0);
//  vec2 xy = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy * vec2(1.0, 1.0);
    int x = int(mod(xy.x, 8.0));
//  int x = int(mod(xy.x, 8.0));
    int y = int(mod(xy.y, 8.0));
//  int y = int(mod(xy.y, 8.0));

    vec3 rgb = texture(tex0, uv.xy).rgb;
//  vec3 rgb = texture(tex0, uv.xy).rgb;

    vec3 finalRGB;
//  vec3 finalRGB;
    finalRGB.r = find_closest(x, y, rgb.r);
//  finalRGB.r = find_closest(x, y, rgb.r);
    finalRGB.g = find_closest(x, y, rgb.g);
//  finalRGB.g = find_closest(x, y, rgb.g);
    finalRGB.b = find_closest(x, y, rgb.b);
//  finalRGB.b = find_closest(x, y, rgb.b);

    fragColor = vec4(finalRGB * color, 1.0);
//  fragColor = vec4(finalRGB * color, 1.0);
    }




    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/lls3RH
//  // https://www.shadertoy.com/view/lls3RH
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@






