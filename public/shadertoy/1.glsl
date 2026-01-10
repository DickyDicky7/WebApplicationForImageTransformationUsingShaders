#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    uniform         sampler2D        noise0; // null
//  uniform         sampler2D        noise0; // null
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

    const float PI    = 3.1415926536;
//  const float PI    = 3.1415926536;
    const float PI2   = PI   *   2.0;
//  const float PI2   = PI   *   2.0;
    const int   mSize =               9;
//  const int   mSize =               9;
    const int   kSize = (mSize - 1) / 2;
//  const int   kSize = (mSize - 1) / 2;
    const float sigma = 3.0000000000;
//  const float sigma = 3.0000000000;

    // Gaussian PDF function
//  // Gaussian PDF function
    // Gaussian PDF function
//  // Gaussian PDF function
    float normpdf(float x, float sigma) {
//  float normpdf(float x, float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
//  return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
    }
//  }

    // Color dodge blend function
//  // Color dodge blend function
    // Color dodge blend function
//  // Color dodge blend function
    vec3 colorDodge(vec3 src, vec3 dst) {
//  vec3 colorDodge(vec3 src, vec3 dst) {
    return step(0.0, dst) * mix(min(vec3(1.0), dst / (1.0 - src)), vec3(1.0), step(1.0, src));
//  return step(0.0, dst) * mix(min(vec3(1.0), dst / (1.0 - src)), vec3(1.0), step(1.0, src));
    }
//  }

    // Convert to greyscale
//  // Convert to greyscale
    // Convert to greyscale
//  // Convert to greyscale
    float greyScale(vec3 col) {
//  float greyScale(vec3 col) {
    return dot(col, vec3(0.30, 0.59, 0.11));
//  return dot(col, vec3(0.30, 0.59, 0.11));
    }
//  }

    // Generate pseudo-random value
//  // Generate pseudo-random value
    // Generate pseudo-random value
//  // Generate pseudo-random value
    vec2 random(vec2 p) {
//  vec2 random(vec2 p) {
    p  =   fract( p    * vec2(314.159, 314.265));
//  p  =   fract( p    * vec2(314.159, 314.265));
    p +=     dot( p    , p.yx  + 17.17);
//  p +=     dot( p    , p.yx  + 17.17);
    return fract((p.xx + p.yx) *  p.xy);
//  return fract((p.xx + p.yx) *  p.xy);
    }
//  }

    // Set up input channels
//  // Set up input channels
    // Set up input channels
//  // Set up input channels


    void main() {
    vec2   q = vTexCoord;
//  vec2   q = vTexCoord;
    vec3 col = texture(tex0, q).rgb;
//  vec3 col = texture(tex0, q).rgb;

    // Random pattern for stippling
//  // Random pattern for stippling
    // Random pattern for stippling
//  // Random pattern for stippling
    vec2 r    = random(q);
//  vec2 r    = random(q);
    r.x *=      PI2 ;
//  r.x *=      PI2 ;
    vec2  cr  = vec2(sin(r.x), cos(r.x)) * sqrt(r.y);
//  vec2  cr  = vec2(sin(r.x), cos(r.x)) * sqrt(r.y);

    // Blurred version of the image
//  // Blurred version of the image
    // Blurred version of the image
//  // Blurred version of the image
    vec3 blurred = texture(tex0, q + cr * (vec2(mSize) / canvasSize.xy)).rgb;
//  vec3 blurred = texture(tex0, q + cr * (vec2(mSize) / canvasSize.xy)).rgb;

    // Conditional Gaussian blur kernel setup if mouse is pressed
//  // Conditional Gaussian blur kernel setup if mouse is pressed
    // Conditional Gaussian blur kernel setup if mouse is pressed
//  // Conditional Gaussian blur kernel setup if mouse is pressed
    if (mousePosition.z > 0.5) {
//  if (mousePosition.z > 0.5) {
    blurred = vec3(0.0);
//  blurred = vec3(0.0);
    float kernel[  9  ];
//  float kernel[  9  ];
    float Z =      0.0 ;
//  float Z =      0.0 ;

    for (int j = 0; j <= kSize; ++j) {
//  for (int j = 0; j <= kSize; ++j) {
    kernel[kSize + j] =
//  kernel[kSize + j] =
    kernel[kSize - j] = normpdf(float(j), sigma);
//  kernel[kSize - j] = normpdf(float(j), sigma);
    }
//  }
    for (int j = 0; j <  mSize; ++j) {
//  for (int j = 0; j <  mSize; ++j) {
    Z += kernel[j];
//  Z += kernel[j];
    }
//  }

    // Apply Gaussian blur
//  // Apply Gaussian blur
    // Apply Gaussian blur
//  // Apply Gaussian blur
    for     (int i = -kSize; i <= kSize; ++i) {
//  for     (int i = -kSize; i <= kSize; ++i) {
    for (int j = -kSize; j <= kSize; ++j) {
//  for (int j = -kSize; j <= kSize; ++j) {
    vec2 offset = vec2(float(i), float(j)) / canvasSize.xy;
//  vec2 offset = vec2(float(i), float(j)) / canvasSize.xy;
    blurred += kernel[kSize + j]
//  blurred += kernel[kSize + j]
    *  kernel[kSize + i]
//  *  kernel[kSize + i]
    *  texture(tex0, q + offset).rgb;
//  *  texture(tex0, q + offset).rgb;
    }
//  }
    }
//  }
    blurred = blurred / (Z * Z);
//  blurred = blurred / (Z * Z);
    }
//  }

    // Invert blurred color and apply color dodge
//  // Invert blurred color and apply color dodge
    // Invert blurred color and apply color dodge
//  // Invert blurred color and apply color dodge
    vec3 inv     = vec3(1.0) - blurred ;
//  vec3 inv     = vec3(1.0) - blurred ;
    vec3 lighten = colorDodge(col, inv);
//  vec3 lighten = colorDodge(col, inv);

    // Convert to greyscale and add contrast
//  // Convert to greyscale and add contrast
    // Convert to greyscale and add contrast
//  // Convert to greyscale and add contrast
    vec3 res = vec3(greyScale(lighten     ));
//  vec3 res = vec3(greyScale(lighten     ));
    res = vec3(pow      (res.x  , 3.0));
//  res = vec3(pow      (res.x  , 3.0));

    // Apply edge effect if mouse is pressed
//  // Apply edge effect if mouse is pressed
    // Apply edge effect if mouse is pressed
//  // Apply edge effect if mouse is pressed
    if (mousePosition.z > 0.5) {
//  if (mousePosition.z > 0.5) {
    res *= 0.25
//  res *= 0.25
    +  0.75
//  +  0.75
    *  pow(16.0
//  *  pow(16.0
    *       q.x
//  *       q.x
    *       q.y
//  *       q.y
    *      (1.0 - q.x)
//  *      (1.0 - q.x)
    *      (1.0 - q.y), 0.15);
//  *      (1.0 - q.y), 0.15);
    }
//  }

    // Output the final color
//  // Output the final color
    // Output the final color
//  // Output the final color
    fragColor = vec4(res, 1.0);
//  fragColor = vec4(res, 1.0);
    }

    // https://www.shadertoy.com/view/ldSyzV
//  // https://www.shadertoy.com/view/ldSyzV
