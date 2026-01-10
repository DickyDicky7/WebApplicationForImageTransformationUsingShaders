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

    //  #define THRESHOLD .5 // @@edge@@ threshold
//  //  #define THRESHOLD .5 // @@edge@@ threshold
    //  #define LEVELS    10 // @number@ @@@of@@@@ posterization levels
//  //  #define LEVELS    10 // @number@ @@@of@@@@ posterization levels
    //  #define RADIUS     5 // kuwahara @@@window
//  //  #define RADIUS     5 // kuwahara @@@window

    uniform float THRESHOLD ; // 0.5
//  uniform float THRESHOLD ; // 0.5
    uniform int   LEVELS    ; // 10
//  uniform int   LEVELS    ; // 10
    uniform int   RADIUS    ; // 05
//  uniform int   RADIUS    ; // 05

    /*
//  /*
    * Posterization is the result of reducing the number of colors
//  * Posterization is the result of reducing the number of colors
    * Posterization is the result of reducing the number of colors
//  * Posterization is the result of reducing the number of colors
    * in an image. I.e., if you try to view a 24-bit color image in
//  * in an image. I.e., if you try to view a 24-bit color image in
    * in an image. I.e., if you try to view a 24-bit color image in
//  * in an image. I.e., if you try to view a 24-bit color image in
    * and old 16 color CRT monitor the screen will render a
//  * and old 16 color CRT monitor the screen will render a
    * and old 16 color CRT monitor the screen will render a
//  * and old 16 color CRT monitor the screen will render a
    * "posterized" version of the image
//  * "posterized" version of the image
    * "posterized" version of the image
//  * "posterized" version of the image
    * http://www.cs.umb.edu/~jreyes/csit114-fall-2007/project4/filters.html#posterize
//  * http://www.cs.umb.edu/~jreyes/csit114-fall-2007/project4/filters.html#posterize
    * http://www.cs.umb.edu/~jreyes/csit114-fall-2007/project4/filters.html#posterize
//  * http://www.cs.umb.edu/~jreyes/csit114-fall-2007/project4/filters.html#posterize
    */
//  */
    // vec3 posterize(vec3 c)
//  // vec3 posterize(vec3 c)
    // {
//  // {
    //     // Split up each of the color channels into ranges
//  //     // Split up each of the color channels into ranges
    //     // Split up each of the color channels into ranges
//  //     // Split up each of the color channels into ranges
    //     float range = 1. /float(LEVELS);
//  //     float range = 1. /float(LEVELS);
    //     float            colors[LEVELS];
//  //     float            colors[LEVELS];
    
    //     // Assign each range to a specified value
//  //     // Assign each range to a specified value
    //     // Assign each range to a specified value
//  //     // Assign each range to a specified value
    //     // For now set it to the mean
//  //     // For now set it to the mean
    //     // For now set it to the mean
//  //     // For now set it to the mean
    //     for (int   i  = 0; i < LEVELS; i++) {
//  //     for (int   i  = 0; i < LEVELS; i++) {
    //         colors[i] = ((float(i    ) * range)
//  //         colors[i] = ((float(i    ) * range)
    //                   +  (float(i + 1) * range)) / 2.;
//  //                   +  (float(i + 1) * range)) / 2.;
    //     }
//  //     }
    
    //     ivec3 v = ivec3(int(floor(c.r / range)),
//  //     ivec3 v = ivec3(int(floor(c.r / range)),
    //                     int(floor(c.g / range)),
//  //                     int(floor(c.g / range)),
    //                     int(floor(c.b / range)));
//  //                     int(floor(c.b / range)));
    
    
    //     c.r = colors[v.x];
//  //     c.r = colors[v.x];
    //     c.g = colors[v.y];
//  //     c.g = colors[v.y];
    //     c.b = colors[v.z];
//  //     c.b = colors[v.z];
    
    //     c   = floor(c * float(LEVELS)) / float(LEVELS);;
//  //     c   = floor(c * float(LEVELS)) / float(LEVELS);;
  
    //     return c;
//  //     return c;
    // }
//  // }

    /*
//  /*
    * Sobel operator:
//  * Sobel operator:
    * Sobel operator:
//  * Sobel operator:
    * Convolve image with horizontal and vertical filters
//  * Convolve image with horizontal and vertical filters
    * Convolve image with horizontal and vertical filters
//  * Convolve image with horizontal and vertical filters
    * that calculates the image gradient (directional change in the
//  * that calculates the image gradient (directional change in the
    * that calculates the image gradient (directional change in the
//  * that calculates the image gradient (directional change in the
    * intensity or color) thereby detecting an edge
//  * intensity or color) thereby detecting an edge
    * intensity or color) thereby detecting an edge
//  * intensity or color) thereby detecting an edge
    */
//  */
    vec3 edge(vec2 uv, vec2 s)
//  vec3 edge(vec2 uv, vec2 s)
    {
//  {
    // Sobel convolution kernels in the horizational
//  // Sobel convolution kernels in the horizational
    // Sobel convolution kernels in the horizational
//  // Sobel convolution kernels in the horizational
    // and vertical directions
//  // and vertical directions
    // and vertical directions
//  // and vertical directions
    mat3 h = mat3(-1 , -2 , -1 , // first col h[0]
//  mat3 h = mat3(-1 , -2 , -1 , // first col h[0]
    0 ,  0 ,  0 ,
//  0 ,  0 ,  0 ,
    1 ,  2 ,  1  );
//  1 ,  2 ,  1  );
     
    mat3 v = mat3( 1 ,  0 , -1 ,
//  mat3 v = mat3( 1 ,  0 , -1 ,
    2 ,  0 , -2 ,
//  2 ,  0 , -2 ,
    1 ,  0 , -1  );
//  1 ,  0 , -1  );
    
    // populate neighboring pixel box with neighboring pixels
//  // populate neighboring pixel box with neighboring pixels
    // populate neighboring pixel box with neighboring pixels
//  // populate neighboring pixel box with neighboring pixels
    mat3 b;
//  mat3 b;
    for     (float i = 0.; i < 3.; i++) {
//  for     (float i = 0.; i < 3.; i++) {
    for (float j = 0.; j < 3.; j++) {
//  for (float j = 0.; j < 3.; j++) {
    vec4 t = texture(tex0, uv+
//  vec4 t = texture(tex0, uv+
    vec2((i  - 1.) * s.x
//  vec2((i  - 1.) * s.x
    ,              (1. - j ) * s.y));
//  ,              (1. - j ) * s.y));
    b[int(i)]
//  b[int(i)]
    [int(j)] = length(t);
//  [int(j)] = length(t);
    }
//  }
    }
//  }

    // Convolve
//  // Convolve
    // Convolve
//  // Convolve
    // Process can be described as "sliding the kernel over the input image"
//  // Process can be described as "sliding the kernel over the input image"
    // Process can be described as "sliding the kernel over the input image"
//  // Process can be described as "sliding the kernel over the input image"
    //   For each position of the kernel, we multiply the overlapping values
//  //   For each position of the kernel, we multiply the overlapping values
    //   For each position of the kernel, we multiply the overlapping values
//  //   For each position of the kernel, we multiply the overlapping values
    //   of the kernel and image together, and add up the results.
//  //   of the kernel and image together, and add up the results.
    //   of the kernel and image together, and add up the results.
//  //   of the kernel and image together, and add up the results.
    //   This sum of products will be the value of the output image at the
//  //   This sum of products will be the value of the output image at the
    //   This sum of products will be the value of the output image at the
//  //   This sum of products will be the value of the output image at the
    //   point in the input image where the kernel is centered
//  //   point in the input image where the kernel is centered
    //   point in the input image where the kernel is centered
//  //   point in the input image where the kernel is centered
    float gx = dot(h[0], b[0]) + dot(h[1], b[1]) + dot(h[2], b[2]);
//  float gx = dot(h[0], b[0]) + dot(h[1], b[1]) + dot(h[2], b[2]);
    float gy = dot(v[0], b[0]) + dot(v[1], b[1]) + dot(v[2], b[2]);
//  float gy = dot(v[0], b[0]) + dot(v[1], b[1]) + dot(v[2], b[2]);

    // magnitude of gradient
//  // magnitude of gradient
    float magnitude  = clamp(sqrt((gx * gx) + (gy * gy)), 0., .9);
//  float magnitude  = clamp(sqrt((gx * gx) + (gy * gy)), 0., .9);
    
    if (  magnitude >= THRESHOLD  )
//  if (  magnitude >= THRESHOLD  )
    return vec3(0, 0, 0);
//  return vec3(0, 0, 0);
    else
//  else
    return vec3(1, 1, 1);
//  return vec3(1, 1, 1);
    }
//  }

    // helper func to find min std dev
//  // helper func to find min std dev
    // helper func to find min std dev
//  // helper func to find min std dev
    void findMin(float s, inout float min_sigma, vec4 m, out vec4 c)
//  void findMin(float s, inout float min_sigma, vec4 m, out vec4 c)
    {
//  {
    if (s < min_sigma) {
//  if (s < min_sigma) {
    min_sigma = s;
//  min_sigma = s;
    c = vec4(m)      ;
//  c = vec4(m)      ;
    }
//  }
    }
//  }

    /*
//  /*
    * Inspired by non-photorealistic techniques,
//  * Inspired by non-photorealistic techniques,
    * Inspired by non-photorealistic techniques,
//  * Inspired by non-photorealistic techniques,
    * I originally wanted to implement a
//  * I originally wanted to implement a
    * I originally wanted to implement a
//  * I originally wanted to implement a
    * watercolor/brush-stroke shader...
//  * watercolor/brush-stroke shader...
    * watercolor/brush-stroke shader...
//  * watercolor/brush-stroke shader...
    * Read some things decided I maybe didn't have time
//  * Read some things decided I maybe didn't have time
    * Read some things decided I maybe didn't have time
//  * Read some things decided I maybe didn't have time
    * for that -- I found a cool kuwahara filter implementation
//  * for that -- I found a cool kuwahara filter implementation
    * for that -- I found a cool kuwahara filter implementation
//  * for that -- I found a cool kuwahara filter implementation
    * https://www.shadertoy.com/view/MsXSz4
//  * https://www.shadertoy.com/view/MsXSz4
    * https://www.shadertoy.com/view/MsXSz4
//  * https://www.shadertoy.com/view/MsXSz4
    *  who is the source of this...not me :)
//  *  who is the source of this...not me :)
    *  who is the source of this...not me :)
//  *  who is the source of this...not me :)
    * https://en.wikipedia.org/wiki/Kuwahara_filter
//  * https://en.wikipedia.org/wiki/Kuwahara_filter
    * https://en.wikipedia.org/wiki/Kuwahara_filter
//  * https://en.wikipedia.org/wiki/Kuwahara_filter
    */
//  */
    vec4 kuwahara(vec2 uv, vec2 s)
//  vec4 kuwahara(vec2 uv, vec2 s)
    {
//  {
    // size of region
//  // size of region
    // size of region
//  // size of region
    float size =     pow(float(RADIUS + 1), 2.);
//  float size =     pow(float(RADIUS + 1), 2.);

    vec4 m0 , m1 , m2 , m3 , s0 , s1 , s2 , s3            ;
//  vec4 m0 , m1 , m2 , m3 , s0 , s1 , s2 , s3            ;
    m0 = m1 = m2 = m3 = s0 = s1 = s2 = s3 = vec4(0.0);
//  m0 = m1 = m2 = m3 = s0 = s1 = s2 = s3 = vec4(0.0);

    vec4 c;
//  vec4 c;

    // 4 square regions with RADIUS pixels
//  // 4 square regions with RADIUS pixels
    // 4 square regions with RADIUS pixels
//  // 4 square regions with RADIUS pixels
    for     (int j = -RADIUS; j <= 0; ++j)  {
//  for     (int j = -RADIUS; j <= 0; ++j)  {
    for (int i = -RADIUS; i <= 0; ++i)  {
//  for (int i = -RADIUS; i <= 0; ++i)  {
    c = texture(tex0, uv + vec2(i, j) * s);
//  c = texture(tex0, uv + vec2(i, j) * s);
    m0 += c    ; // mean @@@
//  m0 += c    ; // mean @@@
    s0 += c * c; // std@ dev
//  s0 += c * c; // std@ dev
    }
//  }
    }
//  }

    for     (int j = -RADIUS; j <= 0     ; ++j)  {
//  for     (int j = -RADIUS; j <= 0     ; ++j)  {
    for (int i = 0      ; i <= RADIUS; ++i)  {
//  for (int i = 0      ; i <= RADIUS; ++i)  {
    c = texture(tex0, uv + vec2(i, j) * s);
//  c = texture(tex0, uv + vec2(i, j) * s);
    m1 += c    ;
//  m1 += c    ;
    s1 += c * c;
//  s1 += c * c;
    }
//  }
    }
//  }

    for     (int j = 0; j <= RADIUS; ++j)  {
//  for     (int j = 0; j <= RADIUS; ++j)  {
    for (int i = 0; i <= RADIUS; ++i)  {
//  for (int i = 0; i <= RADIUS; ++i)  {
    c = texture(tex0, uv + vec2(i, j) * s);
//  c = texture(tex0, uv + vec2(i, j) * s);
    m2 += c    ;
//  m2 += c    ;
    s2 += c * c;
//  s2 += c * c;
    }
//  }
    }
//  }

    for     (int j = 0      ; j <= RADIUS; ++j)  {
//  for     (int j = 0      ; j <= RADIUS; ++j)  {
    for (int i = -RADIUS; i <= 0     ; ++i)  {
//  for (int i = -RADIUS; i <= 0     ; ++i)  {
    c = texture(tex0, uv + vec2(i, j) * s);
//  c = texture(tex0, uv + vec2(i, j) * s);
    m3 += c    ;
//  m3 += c    ;
    s3 += c * c;
//  s3 += c * c;
    }
//  }
    }
//  }
    
    // calculate mean & std dev
//  // calculate mean & std dev
    // calculate mean & std dev
//  // calculate mean & std dev
    m0 /= size;
//  m0 /= size;
    s0  = abs(s0 / size - m0 * m0);
//  s0  = abs(s0 / size - m0 * m0);
    m1 /= size;
//  m1 /= size;
    s1  = abs(s1 / size - m1 * m1);
//  s1  = abs(s1 / size - m1 * m1);
    m2 /= size;
//  m2 /= size;
    s2  = abs(s2 / size - m2 * m2);
//  s2  = abs(s2 / size - m2 * m2);
    m3 /= size;
//  m3 /= size;
    s3  = abs(s3 / size - m3 * m3);
//  s3  = abs(s3 / size - m3 * m3);
    
    // find min std dev
//  // find min std dev
    // find min std dev
//  // find min std dev
    // set output to corresponding mean
//  // set output to corresponding mean
    // set output to corresponding mean
//  // set output to corresponding mean
    float       min_sigma = 1e+2 ;
//  float       min_sigma = 1e+2 ;
    
    float
//  float
    ms = s0.r + s0.g + s0.b;
//  ms = s0.r + s0.g + s0.b;
    findMin(ms, min_sigma, m0, c);
//  findMin(ms, min_sigma, m0, c);
    
    ms = s1.r + s1.g + s1.b;
//  ms = s1.r + s1.g + s1.b;
    findMin(ms, min_sigma, m1, c);
//  findMin(ms, min_sigma, m1, c);
    
    ms = s2.r + s2.g + s2.b;
//  ms = s2.r + s2.g + s2.b;
    findMin(ms, min_sigma, m2, c);
//  findMin(ms, min_sigma, m2, c);
    
    ms = s3.r + s3.g + s3.b;
//  ms = s3.r + s3.g + s3.b;
    findMin(ms, min_sigma, m3, c);
//  findMin(ms, min_sigma, m3, c);
    
    return c;
//  return c;
    }
//  }


    void main(  )
    {
    vec2 uv =      vTexCoord ;
//  vec2 uv =      vTexCoord ;
    vec2 s  = vec2(1.              / canvasSize.x
//  vec2 s  = vec2(1.              / canvasSize.x
    ,      1.              / canvasSize.y );
//  ,      1.              / canvasSize.y );
    vec3 c  =                                       texture(tex0, uv).xyz;
//  vec3 c  =                                       texture(tex0, uv).xyz;

    c  =  kuwahara(uv, s).xyz;
//  c  =  kuwahara(uv, s).xyz;
    //  c  = posterize(c);
//  //  c  = posterize(c);
    c *= edge     (uv, s)    ;
//  c *= edge     (uv, s)    ;
      
    //animate -- comment out to see filters alone
//  //animate -- comment out to see filters alone
    //animate -- comment out to see filters alone
//  //animate -- comment out to see filters alone
    c = mix(texture(tex0, uv).xyz, c, clamp(0.5 + 0.5 * sin(time), 0., 1.));
//  c = mix(texture(tex0, uv).xyz, c, clamp(0.5 + 0.5 * sin(time), 0., 1.));
    
    fragColor = vec4(c, 1.0);
//  fragColor = vec4(c, 1.0);
    }





    // https://www.shadertoy.com/view/4djBDt
//  // https://www.shadertoy.com/view/4djBDt
