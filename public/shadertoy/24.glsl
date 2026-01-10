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

    //    Define@ @@@@@@@@ the @@@ luminance weights
//  //    Define@ @@@@@@@@ the @@@ luminance weights
    // vec3 W = vec3(0.2125,
//  // vec3 W = vec3(0.2125,
    //               0.7154,
//  //               0.7154,
    //               0.0721);
//  //               0.0721);

    uniform vec3 W ; // 0.2125 , 0.7154 , 0.0721
//  uniform vec3 W ; // 0.2125 , 0.7154 , 0.0721

    //    Checker function for the pattern@@ @@@@@@@
//  //    Checker function for the pattern@@ @@@@@@@
    float checker(vec2 uv, float scale, float angle)
//  float checker(vec2 uv, float scale, float angle)
    {
//  {
    float  s = sin(angle),
//  float  s = sin(angle),
    c = cos(angle);
//  c = cos(angle);
    vec2 uv2 = vec2(c * uv.x - s * uv.y
//  vec2 uv2 = vec2(c * uv.x - s * uv.y
    ,      s * uv.x + c * uv.y)
//  ,      s * uv.x + c * uv.y)
    * scale  ;
//  * scale  ;
    return sin(uv2.x) *
//  return sin(uv2.x) *
    sin(uv2.y) ;
//  sin(uv2.y) ;
    }
//  }

    //    Process @@@@@@@@ @@@ @@@ luminance with pattern influence
//  //    Process @@@@@@@@ @@@ @@@ luminance with pattern influence
    float processLum(vec2 uv, float lum)
//  float processLum(vec2 uv, float lum)
    {
//  {
    float  angle = 001.0;
//  float  angle = 001.0;
    float  scale = 350.0;
//  float  scale = 350.0;

    float    dots = checker(uv, scale, angle);
//  float    dots = checker(uv, scale, angle);
    float intens1 = 5.0;
//  float intens1 = 5.0;
    float intens2 = (intens1 -    1.0) *  0.5;
//  float intens2 = (intens1 -    1.0) *  0.5;
    return    lum *  intens1 - intens2 * (1.0 - dots);
//  return    lum *  intens1 - intens2 * (1.0 - dots);
    }
//  }

    void main()
    {
    // Normalized pixel@@ coordinates (from 0 to 1) @@@@@@@ @@@@@
//  // Normalized pixel@@ coordinates (from 0 to 1) @@@@@@@ @@@@@
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;

    // Choose@@@@ between test@@@@@@@ color @ or @@ texture color
//  // Choose@@@@ between test@@@@@@@ color @ or @@ texture color
#ifdef TEST
// #ifdef TEST
    vec3 col =
//  vec3 col =
    vec3(uv.x);
//  vec3(uv.x);
#else
// #else
    vec3 col = texture(tex0, uv).xyz;
//  vec3 col = texture(tex0, uv).xyz;
#endif
// #endif

    // Compute luminance @@@@@@@@@@
//  // Compute luminance @@@@@@@@@@
    float   lum =
//  float   lum =
    dot(col, W);
//  dot(col, W);

    // Apply@@ luminance processing
//  // Apply@@ luminance processing
    float color = processLum(uv, lum);
//  float color = processLum(uv, lum);

    // Add a blueish ink-like style
//  // Add a blueish ink-like style
    color = clamp   (
//  color = clamp   (
    color , 0.0, 1.0);
//  color , 0.0, 1.0);
    vec3 outputColor = mix(vec3(0.0, 0.2, 0.3),
//  vec3 outputColor = mix(vec3(0.0, 0.2, 0.3),
    vec3(1.0, 1.0, 1.0), color);
//  vec3(1.0, 1.0, 1.0), color);

    // Additional test condition to overwrite the color if uv.y > .7
//  // Additional test condition to overwrite the color if uv.y > .7
#ifdef TEST
// #ifdef TEST
    if ( uv.y > 0.7 )
//  if ( uv.y > 0.7 )
    outputColor = col;
//  outputColor = col;
#endif
// #endif

    // Set@@@@@@@ the@ final@@@@ @@ fragment@ @@@ color @@ @@@@ @ @@
//  // Set@@@@@@@ the@ final@@@@ @@ fragment@ @@@ color @@ @@@@ @ @@
    fragColor = vec4(outputColor, 1.0);
//  fragColor = vec4(outputColor, 1.0);
    }




    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/fdf3zM
//  // https://www.shadertoy.com/view/fdf3zM
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@









