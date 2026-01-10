    #version 300 es
//  #version 300 es
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

    // const float PI = 3.14;
//  // const float PI = 3.14;
    // const float    scan_line_amount    =   1.0 ;
//  // const float    scan_line_amount    =   1.0 ;
    // const float         warp_amount    =   0.1 ;
//  // const float         warp_amount    =   0.1 ;
    // const float        noise_amount    =   0.03;
//  // const float        noise_amount    =   0.03;
    // const float interference_amount    =   0.2 ;
//  // const float interference_amount    =   0.2 ;
    // const float       grille_amount    =   0.1 ;
//  // const float       grille_amount    =   0.1 ;
    // const float       grille_size      =   1.0 ;
//  // const float       grille_size      =   1.0 ;
    // const float     vignette_amount    =   0.6 ;
//  // const float     vignette_amount    =   0.6 ;
    // const float     vignette_intensity =   0.4 ;
//  // const float     vignette_intensity =   0.4 ;
    // const float    aberation_amount    =   0.5 ;
//  // const float    aberation_amount    =   0.5 ;
    // const float    roll_line_amount    =   0.3 ;
//  // const float    roll_line_amount    =   0.3 ;
    // const float    roll_speed          =   1.0 ;
//  // const float    roll_speed          =   1.0 ;
    // const float    scan_line_strength  = - 8.0 ;
//  // const float    scan_line_strength  = - 8.0 ;
    // const float        pixel_strength  = - 2.0 ;
//  // const float        pixel_strength  = - 2.0 ;

    const float PI = 3.14;
//  const float PI = 3.14;
    uniform float    scan_line_amount    ; //   1.0
//  uniform float    scan_line_amount    ; //   1.0
    uniform float         warp_amount    ; //   0.1
//  uniform float         warp_amount    ; //   0.1
    uniform float        noise_amount    ; //   0.03
//  uniform float        noise_amount    ; //   0.03
    uniform float interference_amount    ; //   0.2
//  uniform float interference_amount    ; //   0.2
    uniform float       grille_amount    ; //   0.1
//  uniform float       grille_amount    ; //   0.1
    uniform float       grille_size      ; //   1.0
//  uniform float       grille_size      ; //   1.0
    uniform float     vignette_amount    ; //   0.6
//  uniform float     vignette_amount    ; //   0.6
    uniform float     vignette_intensity ; //   0.4
//  uniform float     vignette_intensity ; //   0.4
    uniform float    aberation_amount    ; //   0.5
//  uniform float    aberation_amount    ; //   0.5
    uniform float    roll_line_amount    ; //   0.3
//  uniform float    roll_line_amount    ; //   0.3
    uniform float    roll_speed          ; //   1.0
//  uniform float    roll_speed          ; //   1.0
    uniform float    scan_line_strength  ; // - 8.0
//  uniform float    scan_line_strength  ; // - 8.0
    uniform float        pixel_strength  ; // - 2.0
//  uniform float        pixel_strength  ; // - 2.0

    float random(vec2 uv) {
//  float random(vec2 uv) {
    return fract(cos(uv.x * 83.4827
//  return fract(cos(uv.x * 83.4827
    + uv.y * 92.2842) * 43758.5453123);
//  + uv.y * 92.2842) * 43758.5453123);
    }
//  }

    vec3 fetch_pixel(vec2 uv, vec2 off) {
//  vec3 fetch_pixel(vec2 uv, vec2 off) {
    vec2 pos = floor(uv * canvasSize + off) / canvasSize + vec2(0.5) / canvasSize;
//  vec2 pos = floor(uv * canvasSize + off) / canvasSize + vec2(0.5) / canvasSize;

    float noise        = 0.0;
//  float noise        = 0.0;
    if (  noise_amount > 0.0) {
//  if (  noise_amount > 0.0) {
    noise        = random(pos + fract(time))
//  noise        = random(pos + fract(time))
    *  noise_amount;
//  *  noise_amount;
    }
//  }

    if (max(abs(pos.x - 0.5),
//  if (max(abs(pos.x - 0.5),
    abs(pos.y - 0.5)) > 0.5) {
//  abs(pos.y - 0.5)) > 0.5) {
    return vec3(0.0, 0.0, 0.0);
//  return vec3(0.0, 0.0, 0.0);
    }
//  }

    vec3   clr = texture(tex0, pos, -16.0).rgb + noise;
//  vec3   clr = texture(tex0, pos, -16.0).rgb + noise;
    return clr;
//  return clr;
    }
//  }

    // Distance in emulated pixels to nearest texel @@@@.
//  // Distance in emulated pixels to nearest texel @@@@.
    vec2 Dist(vec2 pos) {
//  vec2 Dist(vec2 pos) {
    pos =       pos   * canvasSize;
//  pos =       pos   * canvasSize;
    return - ((pos - floor(pos)) - vec2(0.5));
//  return - ((pos - floor(pos)) - vec2(0.5));
    }
//  }

    // 1D@@@@@@ @@ Gaussian @@@@@@ @@ @@@@@@@ @@@@@ @@@@.
//  // 1D@@@@@@ @@ Gaussian @@@@@@ @@ @@@@@@@ @@@@@ @@@@.
    float Gaus(float pos, float scale) {
//  float Gaus(float pos, float scale) {
    return
//  return
    exp2(                 scale * pos
//  exp2(                 scale * pos
    * pos);
//  * pos);
    }
//  }

    // 3-tap@@@ @@ Gaussian filter @@ along@@ horz@ line.
//  // 3-tap@@@ @@ Gaussian filter @@ along@@ horz@ line.
    vec3 Horz3(vec2 pos, float off) {
//  vec3 Horz3(vec2 pos, float off) {
    vec3 b = fetch_pixel(pos, vec2(-1.0, off));
//  vec3 b = fetch_pixel(pos, vec2(-1.0, off));
    vec3 c = fetch_pixel(pos, vec2( 0.0, off));
//  vec3 c = fetch_pixel(pos, vec2( 0.0, off));
    vec3 d = fetch_pixel(pos, vec2( 1.0, off));
//  vec3 d = fetch_pixel(pos, vec2( 1.0, off));
    float dst = Dist(pos).x;
//  float dst = Dist(pos).x;

    // Convert distance to weight.
//  // Convert distance to weight.
    float scale = pixel_strength;
//  float scale = pixel_strength;
    float wb = Gaus(dst - 1.0, scale);
//  float wb = Gaus(dst - 1.0, scale);
    float wc = Gaus(dst + 0.0, scale);
//  float wc = Gaus(dst + 0.0, scale);
    float wd = Gaus(dst + 1.0, scale);
//  float wd = Gaus(dst + 1.0, scale);

    // Return@ filtered @@ sample.
//  // Return@ filtered @@ sample.
    return (b * wb + c * wc + d * wd) / (wb + wc + wd);
//  return (b * wb + c * wc + d * wd) / (wb + wc + wd);
    }
//  }

    // Return scanline weight @@@@@ @@ @@@@@@ @@@@@.
//  // Return scanline weight @@@@@ @@ @@@@@@ @@@@@.
    float Scan(vec2 pos, float off) {
//  float Scan(vec2 pos, float off) {
    float       dst = Dist(pos).y;
//  float       dst = Dist(pos).y;

    return Gaus(dst + off, scan_line_strength);
//  return Gaus(dst + off, scan_line_strength);
    }
//  }

    // Allow@ nearest@ three@ lines to effect pixel.
//  // Allow@ nearest@ three@ lines to effect pixel.
    vec3 Tri(vec2 pos) {
//  vec3 Tri(vec2 pos) {
    vec3 clr = fetch_pixel(pos, vec2(0.0));
//  vec3 clr = fetch_pixel(pos, vec2(0.0));
    if (scan_line_amount > 0.0) {
//  if (scan_line_amount > 0.0) {
    vec3 a = Horz3(pos, -1.0);
//  vec3 a = Horz3(pos, -1.0);
    vec3 b = Horz3(pos,  0.0);
//  vec3 b = Horz3(pos,  0.0);
    vec3 c = Horz3(pos,  1.0);
//  vec3 c = Horz3(pos,  1.0);

    float wa = Scan(pos, -1.0);
//  float wa = Scan(pos, -1.0);
    float wb = Scan(pos,  0.0);
//  float wb = Scan(pos,  0.0);
    float wc = Scan(pos,  1.0);
//  float wc = Scan(pos,  1.0);

    vec3 scanlines = a * wa
//  vec3 scanlines = a * wa
    + b * wb
//  + b * wb
    + c * wc                       ;
//  + c * wc                       ;
    clr = mix(clr, scanlines, scan_line_amount);
//  clr = mix(clr, scanlines, scan_line_amount);
    }
//  }
    return clr;
//  return clr;
    }
//  }

    // Takes in the UV and warps the edges, creating the spherized effect
//  // Takes in the UV and warps the edges, creating the spherized effect
    vec2 warp(vec2 uv) {
//  vec2 warp(vec2 uv) {
    vec2  delta = uv - 0.5;
//  vec2  delta = uv - 0.5;
    float delta2 = dot(delta.xy, delta.xy);
//  float delta2 = dot(delta.xy, delta.xy);
    float delta4 =       delta2 *      delta2;
//  float delta4 =       delta2 *      delta2;
    float delta_offset = delta4 * warp_amount;
//  float delta_offset = delta4 * warp_amount;

    vec2    warped = uv + delta *                     delta_offset;
//  vec2    warped = uv + delta *                     delta_offset;
    return (warped - 0.5) / mix(1.0, 1.2, warp_amount / 5.0) + 0.5;
//  return (warped - 0.5) / mix(1.0, 1.2, warp_amount / 5.0) + 0.5;
    }
//  }

    float vignette(vec2 uv) {
//  float vignette(vec2 uv) {
    uv *= 1.0 - uv.xy;
//  uv *= 1.0 - uv.xy;
    float      vignette = uv.x
//  float      vignette = uv.x
    * uv.y
//  * uv.y
    * 15.0;
//  * 15.0;
    return pow(vignette, vignette_intensity * vignette_amount);
//  return pow(vignette, vignette_intensity * vignette_amount);
    }
//  }

    float floating_mod(float a
//  float floating_mod(float a
    ,                  float b) {
//  ,                  float b) {
    return a - b * floor(
//  return a - b * floor(
    a / b        );
//  a / b        );
    }
//  }

    vec3 grille(vec2 uv) {
//  vec3 grille(vec2 uv) {
    float  unit =         PI / 3.0        ;
//  float  unit =         PI / 3.0        ;
    float scale = 2.0 * unit / grille_size;
//  float scale = 2.0 * unit / grille_size;
    float r = smoothstep(0.5, 0.8, cos(uv.x * scale - unit));
//  float r = smoothstep(0.5, 0.8, cos(uv.x * scale - unit));
    float g = smoothstep(0.5, 0.8, cos(uv.x * scale + unit));
//  float g = smoothstep(0.5, 0.8, cos(uv.x * scale + unit));
    float b = smoothstep(0.5, 0.8, cos(uv.x * scale + 3.0 * unit));
//  float b = smoothstep(0.5, 0.8, cos(uv.x * scale + 3.0 * unit));
    return mix(vec3(1.0), vec3(r, g, b), grille_amount);
//  return mix(vec3(1.0), vec3(r, g, b), grille_amount);
    }
//  }

    float roll_line(vec2 uv) {
//  float roll_line(vec2 uv) {
    float x =  uv.y  * 3.0 - time * roll_speed;
//  float x =  uv.y  * 3.0 - time * roll_speed;
    float f = cos(x) * cos(x * 2.35 + 1.1)
//  float f = cos(x) * cos(x * 2.35 + 1.1)
    * cos(x * 4.45 + 2.3);
//  * cos(x * 4.45 + 2.3);
    float  roll_line = smoothstep(0.5, 0.9, f);
//  float  roll_line = smoothstep(0.5, 0.9, f);
    return roll_line *
//  return roll_line *
    roll_line_amount;
//  roll_line_amount;
    }
//  }

    void main() {
    vec2 pix =   vec4(vTexCoord * canvasSize, 0.0, 1.0).xy;
//  vec2 pix =   vec4(vTexCoord * canvasSize, 0.0, 1.0).xy;
    vec2 pos = warp(vTexCoord)  ;
//  vec2 pos = warp(vTexCoord)  ;

    float    line =        0.0  ;
//  float    line =        0.0  ;
    if (roll_line_amount > 0.0) {
//  if (roll_line_amount > 0.0) {
    line =
//  line =
    roll_line(pos);
//  roll_line(pos);
    }
//  }

    vec2 sq_pix = floor(pos * canvasSize) / canvasSize +   vec2(0.5)  / canvasSize  ;
//  vec2 sq_pix = floor(pos * canvasSize) / canvasSize +   vec2(0.5)  / canvasSize  ;
    if (                          interference_amount  + roll_line_amount > 0.0) {
//  if (                          interference_amount  + roll_line_amount > 0.0) {
    float     interference =     random(sq_pix.yy  + fract(time));
//  float     interference =     random(sq_pix.yy  + fract(time));
    pos.x += (interference * (interference_amount  + line * 6.0)) / canvasSize.x;
//  pos.x += (interference * (interference_amount  + line * 6.0)) / canvasSize.x;
    }
//  }

    vec3 clr = Tri(pos);
//  vec3 clr = Tri(pos);
    if (aberation_amount > 0.0) {
//  if (aberation_amount > 0.0) {
    float chromatic   = aberation_amount + line * 2.0;
//  float chromatic   = aberation_amount + line * 2.0;
    vec2  chromatic_x = vec2(     chromatic , 0.0) / canvasSize.x;
//  vec2  chromatic_x = vec2(     chromatic , 0.0) / canvasSize.x;
    vec2  chromatic_y = vec2(0.0, chromatic / 2.0) / canvasSize.y;
//  vec2  chromatic_y = vec2(0.0, chromatic / 2.0) / canvasSize.y;
    float r = Tri(pos - chromatic_x).r;
//  float r = Tri(pos - chromatic_x).r;
    float g = Tri(pos + chromatic_y).g;
//  float g = Tri(pos + chromatic_y).g;
    float b = Tri(pos + chromatic_x).b;
//  float b = Tri(pos + chromatic_x).b;
    clr = vec3(r, g, b);
//  clr = vec3(r, g, b);
    }
//  }

    if (     grille_amount > 0.0    )
//  if (     grille_amount > 0.0    )
    clr *=   grille(pix);
//  clr *=   grille(pix);
    clr *= 1.0 + scan_line_amount * 0.6 + line * 3.0 + grille_amount * 2.0;
//  clr *= 1.0 + scan_line_amount * 0.6 + line * 3.0 + grille_amount * 2.0;
    if(    vignette_amount > 0.0    )
//  if(    vignette_amount > 0.0    )
    clr *= vignette(pos);
//  clr *= vignette(pos);

    fragColor.rgb = clr;
//  fragColor.rgb = clr;
    fragColor.a   = 1.0;
//  fragColor.a   = 1.0;
    }

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://godotshaders.com/shader/realistic-crt-shader/
//  // https://godotshaders.com/shader/realistic-crt-shader/
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


