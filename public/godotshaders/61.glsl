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

    uniform sampler2D   bayer0; // null
//  uniform sampler2D   bayer0; // null
    uniform sampler2D palette0; // null
//  uniform sampler2D palette0; // null
    /*
//  /*
    const vec2        bayer0Size;
//  const vec2        bayer0Size;
    const vec2      palette0Size;
//  const vec2      palette0Size;
    */
//  */

    // const int   u_bitttt_depth = 32;
//  // const int   u_bitttt_depth = 32;
    // const float u_contrast = 1.0;
//  // const float u_contrast = 1.0;
    // const float u_offsettt = 0.0;
//  // const float u_offsettt = 0.0;
    // const int   u_dither_sizee = 02;
//  // const int   u_dither_sizee = 02;
    // const bool  u_repeat_off   = false;
//  // const bool  u_repeat_off   = false;
    // const float u_repeat_value = 10.00;
//  // const float u_repeat_value = 10.00;

    uniform int   u_bitttt_depth ; // 32
//  uniform int   u_bitttt_depth ; // 32
    uniform float u_contrast ; // 1.0
//  uniform float u_contrast ; // 1.0
    uniform float u_offsettt ; // 0.0
//  uniform float u_offsettt ; // 0.0
    uniform int   u_dither_sizee ; // 02
//  uniform int   u_dither_sizee ; // 02
    uniform bool  u_repeat_off   ; // false
//  uniform bool  u_repeat_off   ; // false
    uniform float u_repeat_value ; // 10.00
//  uniform float u_repeat_value ; // 10.00

    void main()
    {
    // sample the@ screen@@@@@ texture@ at the desired@@ output resolution (according to u_dither_size)
//  // sample the@ screen@@@@@ texture@ at the desired@@ output resolution (according to u_dither_size)
    // this@@ will effectively pixelate @@ the resulting output @@@@@@@@@@ @@@@@@@@@@ @@ @@@@@@@@@@@@@@
//  // this@@ will effectively pixelate @@ the resulting output @@@@@@@@@@ @@@@@@@@@@ @@ @@@@@@@@@@@@@@
    vec2 screen_size      = canvasSize / float(u_dither_sizee);
//  vec2 screen_size      = canvasSize / float(u_dither_sizee);
    vec2 screen_sample_uv =              floor(vTexCoord * screen_size)
//  vec2 screen_sample_uv =              floor(vTexCoord * screen_size)
    / screen_size;
//  / screen_size;
    vec3 screen_col       = texture(tex0, screen_sample_uv).rgb;
//  vec3 screen_col       = texture(tex0, screen_sample_uv).rgb;
    
    // calculate pixel luminosity (https://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color)
//  // calculate pixel luminosity (https://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color)
    float lum = (screen_col.r * 0.299)
//  float lum = (screen_col.r * 0.299)
    + (screen_col.g * 0.587)
//  + (screen_col.g * 0.587)
    + (screen_col.b * 0.114);
//  + (screen_col.b * 0.114);
    
    // adjust with@@@@@@ contrast and offset parameters @@@@ @ @@@@ @@@@@@ @@@@@@ @@ @@@@@@@
//  // adjust with@@@@@@ contrast and offset parameters @@@@ @ @@@@ @@@@@@ @@@@@@ @@ @@@@@@@
    float contrast = u_contrast;
//  float contrast = u_contrast;
    lum =      (lum - 0.5 + u_offsettt) * contrast + 0.5;
//  lum =      (lum - 0.5 + u_offsettt) * contrast + 0.5;
    lum = clamp(lum , 0.0 , 1.0       );
//  lum = clamp(lum , 0.0 , 1.0       );
    
    // reduce luminosity bit@@@@@ @@@ depth@ to@@@@@@@@ give a more banded visual if desired
//  // reduce luminosity bit@@@@@ @@@ depth@ to@@@@@@@@ give a more banded visual if desired
    float bits = float(u_bitttt_depth);
//  float bits = float(u_bitttt_depth);
    lum        = floor(
//  lum        = floor(
    lum * bits) / bits;
//  lum * bits) / bits;
    
    // to@@@ support multicolour palettes@ we@@@ want@@@ to@@@@@@@ dither@@@@@@ between the@@@ two@@@@ colours@@ on@@ @@@@@@ the palette
//  // to@@@ support multicolour palettes@ we@@@ want@@@ to@@@@@@@ dither@@@@@@ between the@@@ two@@@@ colours@@ on@@ @@@@@@ the palette
    // which are@@@@ adjacent@@@ to@@@@@@@ the@@ current pixel@@@@ luminosity@@
//  // which are@@@@ adjacent@@@ to@@@@@@@ the@@ current pixel@@@@ luminosity@@
    // to@@@ do@@@@@ this@@@@@@@ we@@@@@@@ need@ to@@@@@ determine which 'band' lum@@@@ falls@ into@@@ calculate @@@@ @@@@@@ the upper@@ and lower
//  // to@@@ do@@@@@ this@@@@@@@ we@@@@@@@ need@ to@@@@@ determine which 'band' lum@@@@ falls@ into@@@ calculate @@@@ @@@@@@ the upper@@ and lower
    // bound of@@@@@ that@ band@ then@@@@@ later we@@@@@ will@@@@@ use@@@@@@@@@ the@@@@ dither texture to@@@@@@@ pick either the upper@@ or@ @@@@@
//  // bound of@@@@@ that@ band@ then@@@@@ later we@@@@@ will@@@@@ use@@@@@@@@@ the@@@@ dither texture to@@@@@@@ pick either the upper@@ or@ @@@@@
    // lower colour@
//  // lower colour@
    
    // get the palette texture size mapped so it is 1px high (so the x value however many colour bands there are)
//  // get the palette texture size mapped so it is 1px high (so the x value however many colour bands there are)
    vec2 col_size  = vec2(textureSize(palette0
//  vec2 col_size  = vec2(textureSize(palette0
    ,                         0)) /* palette0Size */;
//  ,                         0)) /* palette0Size */;
    col_size /=
//  col_size /=
    col_size.y;
//  col_size.y;
    
    float col_x          = float(col_size.x) - 1.0; // colour boundaries is 1@@ less@@ than@@@@ the number of colour bands
//  float col_x          = float(col_size.x) - 1.0; // colour boundaries is 1@@ less@@ than@@@@ the number of colour bands
    float col_texel_size = 1.0 / col_x            ; // the@@@ size@@@@@@ of one colour boundary @@@ @@@@@@ @@ @@@@@@ @@@@@
//  float col_texel_size = 1.0 / col_x            ; // the@@@ size@@@@@@ of one colour boundary @@@ @@@@@@ @@ @@@@@@ @@@@@
    
    lum = max(lum - 0.00001, 0.0);                       // makes@@@@@ sure@ our floor calculation below behaves when lum@@ == 1.0@@
//  lum = max(lum - 0.00001, 0.0);                       // makes@@@@@ sure@ our floor calculation below behaves when lum@@ == 1.0@@
    float lum_lower  =  floor(lum * col_x)        * col_texel_size;
//  float lum_lower  =  floor(lum * col_x)        * col_texel_size;
    float lum_upper  = (floor(lum * col_x) + 1.0) * col_texel_size;
//  float lum_upper  = (floor(lum * col_x) + 1.0) * col_texel_size;
    float lum_scaled = lum * col_x - floor(lum * col_x); // calculates where lum lies@ between@@@@ the@@ upper@@ and@ lower @@ bound
//  float lum_scaled = lum * col_x - floor(lum * col_x); // calculates where lum lies@ between@@@@ the@@ upper@@ and@ lower @@ bound
    
    // @map@@@@ the@@@@ dither texture onto@ the@@@ screen@ there are@@ better ways of@ @doing@ this that@ makes@ the@@@@ dither pattern 'stick' @@
//  // @map@@@@ the@@@@ dither texture onto@ the@@@ screen@ there are@@ better ways of@ @doing@ this that@ makes@ the@@@@ dither pattern 'stick' @@
    // with@@@@ objects in@@@@ the@@@@ 3D@@@ world@ instead of@@@ being mapped onto the screen@ see@ lucas pope's details posts@ on@@@@@ @@how@@ he
//  // with@@@@ objects in@@@@ the@@@@ 3D@@@ world@ instead of@@@ being mapped onto the screen@ see@ lucas pope's details posts@ on@@@@@ @@how@@ he
    // achieved this@@@ in@@@@ Obra@@@ Dinn: https://forums.tigsource.com/index.php?topic=40832.msg1363742#msg1363742
//  // achieved this@@@ in@@@@ Obra@@@ Dinn: https://forums.tigsource.com/index.php?topic=40832.msg1363742#msg1363742
    vec2     noise_size = vec2(textureSize(bayer0
//  vec2     noise_size = vec2(textureSize(bayer0
    ,                       0)) /* bayer0Size */;
//  ,                       0)) /* bayer0Size */;
    vec2 inv_noise_size = vec2(1.0 / float(noise_size.x),
//  vec2 inv_noise_size = vec2(1.0 / float(noise_size.x),
    1.0 / float(noise_size.y));
//  1.0 / float(noise_size.y));
    vec2     noise_uv   = vTexCoord  * inv_noise_size * vec2(float(screen_size.x),
//  vec2     noise_uv   = vTexCoord  * inv_noise_size * vec2(float(screen_size.x),
    float(screen_size.y));
//  float(screen_size.y));
    float    threshold  =                                                         texture(bayer0, float(u_repeat_off) * noise_uv + (1.0 - float(u_repeat_off)) * fract(noise_uv * u_repeat_value)).r;
//  float    threshold  =                                                         texture(bayer0, float(u_repeat_off) * noise_uv + (1.0 - float(u_repeat_off)) * fract(noise_uv * u_repeat_value)).r;
    
    // adjust@@@ the dither@@ slightly so@@@@ min@ and max@@ aren't quite@ @@@@@@@@ at @@@ 0.0 and 1.0
//  // adjust@@@ the dither@@ slightly so@@@@ min@ and max@@ aren't quite@ @@@@@@@@ at @@@ 0.0 and 1.0
    // otherwise we@ wouldn't get@@@@@ fullly dark and fully light@ dither patterns at lum 0.0 and 1.0
//  // otherwise we@ wouldn't get@@@@@ fullly dark and fully light@ dither patterns at lum 0.0 and 1.0
    threshold = threshold * 0.99 + 0.005;
//  threshold = threshold * 0.99 + 0.005;
    
    // the lower@@@@@ lum_scaled is@ the fewer pixels will be below the dither threshold@ and thus will use the lower bound colour@
//  // the lower@@@@@ lum_scaled is@ the fewer pixels will be below the dither threshold@ and thus will use the lower bound colour@
    // and vice-versa @@@@@@@@@@ @@@ @@@ @@@@@ @@@@@@ @@@@ @@ @@@@@ @@@ @@@@@@ @@@@@@@@@@ @@@ @@@@ @@@@ @@@ @@@ @@@@@ @@@@@ @@@@@@@
//  // and vice-versa @@@@@@@@@@ @@@ @@@ @@@@@ @@@@@@ @@@@ @@ @@@@@ @@@ @@@@@@ @@@@@@@@@@ @@@ @@@@ @@@@ @@@ @@@ @@@@@ @@@@@ @@@@@@@
    float ramp_val ;
//  float ramp_val ;
    if (lum_scaled < threshold)
//  if (lum_scaled < threshold)
    {
//  {
    ramp_val = 0.0;
//  ramp_val = 0.0;
    }
//  }
    else
//  else
    {
//  {
    ramp_val = 1.0;
//  ramp_val = 1.0;
    }
//  }
    // sample at the lower bound colour if ramp_val is 0.0 @@ upper bound colour if 1.0
//  // sample at the lower bound colour if ramp_val is 0.0 @@ upper bound colour if 1.0
    // @@@@@@ @@ @@@ @@@@@ @@@@@ @@@@@@ @@ @@@@@@@@ @@ @@@ @@ @@@@@ @@@@@ @@@@@@ @@ @@@
//  // @@@@@@ @@ @@@ @@@@@ @@@@@ @@@@@@ @@ @@@@@@@@ @@ @@@ @@ @@@@@ @@@@@ @@@@@@ @@ @@@
    float col_sample = mix( lum_lower,
//  float col_sample = mix( lum_lower,
    lum_upper,
//  lum_upper,
    ramp_val          );
//  ramp_val          );
    vec3            final_col = texture(palette0, vec2(col_sample, 0.5)).rgb;
//  vec3            final_col = texture(palette0, vec2(col_sample, 0.5)).rgb;
    
    // return the final colour!
//  // return the final colour!
    fragColor.rgb = final_col ;
//  fragColor.rgb = final_col ;
    }



    // https://godotshaders.com/shader/dither-gradient-shader/
//  // https://godotshaders.com/shader/dither-gradient-shader/
