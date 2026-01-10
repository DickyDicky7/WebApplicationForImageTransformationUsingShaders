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

    // Mask type
//  // Mask type
    // Mask type
//  // Mask type
    //  0 = Very compressed TV style shadow mask
//  //  0 = Very compressed TV style shadow mask
    //  0 = Very compressed TV style shadow mask
//  //  0 = Very compressed TV style shadow mask
    //  1 = Stretched VGA style shadow mask (same as prior shaders)
//  //  1 = Stretched VGA style shadow mask (same as prior shaders)
    //  1 = Stretched VGA style shadow mask (same as prior shaders)
//  //  1 = Stretched VGA style shadow mask (same as prior shaders)
    //  2 = VGA style shadow mask
//  //  2 = VGA style shadow mask
    //  2 = VGA style shadow mask
//  //  2 = VGA style shadow mask
    //const int  mask_type =    0;
//  //const int  mask_type =    0;
    uniform int  mask_type ; // 0
//  uniform int  mask_type ; // 0

    // Bloom Type
//  // Bloom Type
    // Bloom Type
//  // Bloom Type
    //  0 = Normalized exposure
//  //  0 = Normalized exposure
    //  0 = Normalized exposure
//  //  0 = Normalized exposure
    //  1 = Aditive bloom
//  //  1 = Aditive bloom
    //  1 = Aditive bloom
//  //  1 = Aditive bloom
    //  2 = No Bloom
//  //  2 = No Bloom
    //  2 = No Bloom
//  //  2 = No Bloom
    //const int bloom_type =    1;
//  //const int bloom_type =    1;
    uniform int bloom_type ; // 1
//  uniform int bloom_type ; // 1

    // Hardness of scanline.
//  // Hardness of scanline.
    // Hardness of scanline.
//  // Hardness of scanline.
    //  -8.0 = soft
//  //  -8.0 = soft
    //  -8.0 = soft
//  //  -8.0 = soft
    // -16.0 = medium
//  // -16.0 = medium
    // -16.0 = medium
//  // -16.0 = medium
    //const float hardScan =    -8.0;
//  //const float hardScan =    -8.0;
    uniform float hardScan ; // -8.0
//  uniform float hardScan ; // -8.0

    // Hardness of pixels in scanline.
//  // Hardness of pixels in scanline.
    // Hardness of pixels in scanline.
//  // Hardness of pixels in scanline.
    // -2.0 = soft
//  // -2.0 = soft
    // -2.0 = soft
//  // -2.0 = soft
    // -4.0 = hard
//  // -4.0 = hard
    // -4.0 = hard
//  // -4.0 = hard
    //const float hardPix  =    -2.0;
//  //const float hardPix  =    -2.0;
    uniform float hardPix  ; // -2.0
//  uniform float hardPix  ; // -2.0

    // Hardness of short vertical bloom.
//  // Hardness of short vertical bloom.
    // Hardness of short vertical bloom.
//  // Hardness of short vertical bloom.
    //  -1.0 = wide to the point of clipping (bad)
//  //  -1.0 = wide to the point of clipping (bad)
    //  -1.0 = wide to the point of clipping (bad)
//  //  -1.0 = wide to the point of clipping (bad)
    //  -1.5 = wide
//  //  -1.5 = wide
    //  -1.5 = wide
//  //  -1.5 = wide
    //  -4.0 = not very wide at all
//  //  -4.0 = not very wide at all
    //  -4.0 = not very wide at all
//  //  -4.0 = not very wide at all
    //const float hardBloomScan =    -2.0;
//  //const float hardBloomScan =    -2.0;
    uniform float hardBloomScan ; // -2.0
//  uniform float hardBloomScan ; // -2.0

    // Hardness of short horizontal bloom.
//  // Hardness of short horizontal bloom.
    // Hardness of short horizontal bloom.
//  // Hardness of short horizontal bloom.
    //  -0.5 = wide to the point of clipping (bad)
//  //  -0.5 = wide to the point of clipping (bad)
    //  -0.5 = wide to the point of clipping (bad)
//  //  -0.5 = wide to the point of clipping (bad)
    //  -1.0 = wide
//  //  -1.0 = wide
    //  -1.0 = wide
//  //  -1.0 = wide
    //  -2.0 = not very wide at all
//  //  -2.0 = not very wide at all
    //  -2.0 = not very wide at all
//  //  -2.0 = not very wide at all
    //const float hardBloomPix  =    -1.5;
//  //const float hardBloomPix  =    -1.5;
    uniform float hardBloomPix  ; // -1.5
//  uniform float hardBloomPix  ; // -1.5

    // Amount of small bloom effect.
//  // Amount of small bloom effect.
    // Amount of small bloom effect.
//  // Amount of small bloom effect.
    //  1.0/1.0 = only bloom
//  //  1.0/1.0 = only bloom
    //  1.0/1.0 = only bloom
//  //  1.0/1.0 = only bloom
    //  1.0/16.0 = what I think is a good amount of small bloom
//  //  1.0/16.0 = what I think is a good amount of small bloom
    //  1.0/16.0 = what I think is a good amount of small bloom
//  //  1.0/16.0 = what I think is a good amount of small bloom
    //  0.0     = no bloom
//  //  0.0     = no bloom
    //  0.0     = no bloom
//  //  0.0     = no bloom
    //const float bloomAmount  =    16.0;
//  //const float bloomAmount  =    16.0;
    uniform float bloomAmount  ; // 16.0
//  uniform float bloomAmount  ; // 16.0

    // Display warp.
//  // Display warp.
    // Display warp.
//  // Display warp.
    // 0.0 = none
//  // 0.0 = none
    // 0.0 = none
//  // 0.0 = none
    // 1.0/8.0 = extreme
//  // 1.0/8.0 = extreme
    // 1.0/8.0 = extreme
//  // 1.0/8.0 = extreme
    //const vec2 warp =    vec2(64.0, 24.0);
//  //const vec2 warp =    vec2(64.0, 24.0);
    uniform vec2 warp ; //      64.0, 24.0
//  uniform vec2 warp ; //      64.0, 24.0

    // Amount of shadow mask.
//  // Amount of shadow mask.
    // Amount of shadow mask.
//  // Amount of shadow mask.
    //const float maskDarkk =    0.5;
//  //const float maskDarkk =    0.5;
    //const float maskLight =    1.5;
//  //const float maskLight =    1.5;
    uniform float maskDarkk ; // 0.5
//  uniform float maskDarkk ; // 0.5
    uniform float maskLight ; // 1.5
//  uniform float maskLight ; // 1.5


    //------------------------------------------------------------------------
//  //------------------------------------------------------------------------

    // @sRGB@ to Linear.
//  // @sRGB@ to Linear.
    // @sRGB@ to Linear.
//  // @sRGB@ to Linear.
    // Assuing using sRGB typed textures this should not be needed.
//  // Assuing using sRGB typed textures this should not be needed.
    // Assuing using sRGB typed textures this should not be needed.
//  // Assuing using sRGB typed textures this should not be needed.
    float ToLinear1(float c) { return (c <= 0.04045) ?
//  float ToLinear1(float c) { return (c <= 0.04045) ?
    c / 12.920    :
//  c / 12.920    :
    pow((c + 00.055) / 1.055, 2.4); }
//  pow((c + 00.055) / 1.055, 2.4); }
    vec3  ToLinear(
//  vec3  ToLinear(
    vec3 c        ) { return vec3(ToLinear1(c.r),
//  vec3 c        ) { return vec3(ToLinear1(c.r),
    ToLinear1(c.g),
//  ToLinear1(c.g),
    ToLinear1(c.b)); }
//  ToLinear1(c.b)); }

    // Linear to @sRGB@.
//  // Linear to @sRGB@.
    // Linear to @sRGB@.
//  // Linear to @sRGB@.
    // Assuing using sRGB typed textures this should not be needed.
//  // Assuing using sRGB typed textures this should not be needed.
    // Assuing using sRGB typed textures this should not be needed.
//  // Assuing using sRGB typed textures this should not be needed.
    float ToSrgb1(float c) { return (c < 0.0031308 ? c * 12.92 : 1.055 * pow(c, 0.41666) - 0.055); }
//  float ToSrgb1(float c) { return (c < 0.0031308 ? c * 12.92 : 1.055 * pow(c, 0.41666) - 0.055); }
    vec3  ToSrgb ( vec3 c) { return vec3(ToSrgb1(c.r),
//  vec3  ToSrgb ( vec3 c) { return vec3(ToSrgb1(c.r),
    ToSrgb1(c.g),
//  ToSrgb1(c.g),
    ToSrgb1(c.b)); }
//  ToSrgb1(c.b)); }

    // Nearest emulated sample given floating point position and texel offset.
//  // Nearest emulated sample given floating point position and texel offset.
    // Nearest emulated sample given floating point position and texel offset.
//  // Nearest emulated sample given floating point position and texel offset.
    // Also zero's off screen.
//  // Also zero's off screen.
    // Also zero's off screen.
//  // Also zero's off screen.
    vec3 Fetch(vec2 pos, vec2 off, sampler2D iChannel0) {
//  vec3 Fetch(vec2 pos, vec2 off, sampler2D iChannel0) {
    pos = floor(pos  * canvasSize
//  pos = floor(pos  * canvasSize
    +       off) / canvasSize;
//  +       off) / canvasSize;
    
    if(max(abs(pos.x - 0.5),
//  if(max(abs(pos.x - 0.5),
    abs(pos.y - 0.5)) > 0.5) {
//  abs(pos.y - 0.5)) > 0.5) {
    return vec3(0.0,
//  return vec3(0.0,
    0.0,
//  0.0,
    0.0);
//  0.0);
    }
//  }
    
    return ToLinear(texture(iChannel0 , pos.xy , -16.0).rgb);
//  return ToLinear(texture(iChannel0 , pos.xy , -16.0).rgb);
    }
//  }

    // Distance in emulated pixels to nearest texel.
//  // Distance in emulated pixels to nearest texel.
    // Distance in emulated pixels to nearest texel.
//  // Distance in emulated pixels to nearest texel.
    vec2 Dist(vec2 pos) {
//  vec2 Dist(vec2 pos) {
    pos =       pos   * canvasSize;
//  pos =       pos   * canvasSize;
    return - ((pos - floor(pos)) - vec2(0.5));
//  return - ((pos - floor(pos)) - vec2(0.5));
    }
//  }
    
    // 1D Gaussian.
//  // 1D Gaussian.
    // 1D Gaussian.
//  // 1D Gaussian.
    float Gaus(float pos, float scale) { return exp2(scale * pos * pos); }
//  float Gaus(float pos, float scale) { return exp2(scale * pos * pos); }

    // 3-tap Gaussian filter along horz line.
//  // 3-tap Gaussian filter along horz line.
    // 3-tap Gaussian filter along horz line.
//  // 3-tap Gaussian filter along horz line.
    vec3 Horz3(vec2 pos, float off, sampler2D iChannel0) {
//  vec3 Horz3(vec2 pos, float off, sampler2D iChannel0) {
    vec3 b = Fetch(pos, vec2(-1.0, off), iChannel0);
//  vec3 b = Fetch(pos, vec2(-1.0, off), iChannel0);
    vec3 c = Fetch(pos, vec2( 0.0, off), iChannel0);
//  vec3 c = Fetch(pos, vec2( 0.0, off), iChannel0);
    vec3 d = Fetch(pos, vec2( 1.0, off), iChannel0);
//  vec3 d = Fetch(pos, vec2( 1.0, off), iChannel0);
    float dst = Dist(pos).x;
//  float dst = Dist(pos).x;
    
    // Convert distance to weight.
//  // Convert distance to weight.
    // Convert distance to weight.
//  // Convert distance to weight.
    float scale = hardPix;
//  float scale = hardPix;
    float wb = Gaus(dst - 1.0, scale);
//  float wb = Gaus(dst - 1.0, scale);
    float wc = Gaus(dst + 0.0, scale);
//  float wc = Gaus(dst + 0.0, scale);
    float wd = Gaus(dst + 1.0, scale);
//  float wd = Gaus(dst + 1.0, scale);
    
    // Return filtered sample.
//  // Return filtered sample.
    // Return filtered sample.
//  // Return filtered sample.
    return (b * wb + c * wc + d * wd) / (wb + wc + wd);
//  return (b * wb + c * wc + d * wd) / (wb + wc + wd);
    }
//  }
    // 5-tap Gaussian filter along horz line.
//  // 5-tap Gaussian filter along horz line.
    // 5-tap Gaussian filter along horz line.
//  // 5-tap Gaussian filter along horz line.
    vec3 Horz5(vec2 pos, float off, sampler2D iChannel0) {
//  vec3 Horz5(vec2 pos, float off, sampler2D iChannel0) {
    vec3 a = Fetch(pos, vec2(-2.0, off), iChannel0);
//  vec3 a = Fetch(pos, vec2(-2.0, off), iChannel0);
    vec3 b = Fetch(pos, vec2(-1.0, off), iChannel0);
//  vec3 b = Fetch(pos, vec2(-1.0, off), iChannel0);
    vec3 c = Fetch(pos, vec2( 0.0, off), iChannel0);
//  vec3 c = Fetch(pos, vec2( 0.0, off), iChannel0);
    vec3 d = Fetch(pos, vec2( 1.0, off), iChannel0);
//  vec3 d = Fetch(pos, vec2( 1.0, off), iChannel0);
    vec3 e = Fetch(pos, vec2( 2.0, off), iChannel0);
//  vec3 e = Fetch(pos, vec2( 2.0, off), iChannel0);
    float dst = Dist(pos).x;
//  float dst = Dist(pos).x;
    
    // Convert distance to weight.
//  // Convert distance to weight.
    // Convert distance to weight.
//  // Convert distance to weight.
    float scale = hardPix;
//  float scale = hardPix;
    float wa = Gaus(dst - 2.0, scale);
//  float wa = Gaus(dst - 2.0, scale);
    float wb = Gaus(dst - 1.0, scale);
//  float wb = Gaus(dst - 1.0, scale);
    float wc = Gaus(dst + 0.0, scale);
//  float wc = Gaus(dst + 0.0, scale);
    float wd = Gaus(dst + 1.0, scale);
//  float wd = Gaus(dst + 1.0, scale);
    float we = Gaus(dst + 2.0, scale);
//  float we = Gaus(dst + 2.0, scale);
    
    // Return filtered sample.
//  // Return filtered sample.
    // Return filtered sample.
//  // Return filtered sample.
    return (a * wa + b * wb + c * wc + d * wd + e * we) / (wa + wb + wc + wd + we);
//  return (a * wa + b * wb + c * wc + d * wd + e * we) / (wa + wb + wc + wd + we);
    }
//  }
    // 7-tap Gaussian filter along horz line.
//  // 7-tap Gaussian filter along horz line.
    // 7-tap Gaussian filter along horz line.
//  // 7-tap Gaussian filter along horz line.
    vec3 Horz7(vec2 pos, float off, sampler2D iChannel0) {
//  vec3 Horz7(vec2 pos, float off, sampler2D iChannel0) {
    vec3 a = Fetch(pos, vec2(-3.0, off), iChannel0);
//  vec3 a = Fetch(pos, vec2(-3.0, off), iChannel0);
    vec3 b = Fetch(pos, vec2(-2.0, off), iChannel0);
//  vec3 b = Fetch(pos, vec2(-2.0, off), iChannel0);
    vec3 c = Fetch(pos, vec2( 1.0, off), iChannel0);
//  vec3 c = Fetch(pos, vec2( 1.0, off), iChannel0);
    vec3 d = Fetch(pos, vec2( 0.0, off), iChannel0);
//  vec3 d = Fetch(pos, vec2( 0.0, off), iChannel0);
    vec3 e = Fetch(pos, vec2( 1.0, off), iChannel0);
//  vec3 e = Fetch(pos, vec2( 1.0, off), iChannel0);
    vec3 f = Fetch(pos, vec2( 2.0, off), iChannel0);
//  vec3 f = Fetch(pos, vec2( 2.0, off), iChannel0);
    vec3 g = Fetch(pos, vec2( 3.0, off), iChannel0);
//  vec3 g = Fetch(pos, vec2( 3.0, off), iChannel0);
    float dst = Dist(pos).x;
//  float dst = Dist(pos).x;
    
    // Convert distance to weight.
//  // Convert distance to weight.
    // Convert distance to weight.
//  // Convert distance to weight.
    float scale = hardBloomPix;
//  float scale = hardBloomPix;
    float wa = Gaus(dst - 3.0, scale);
//  float wa = Gaus(dst - 3.0, scale);
    float wb = Gaus(dst - 2.0, scale);
//  float wb = Gaus(dst - 2.0, scale);
    float wc = Gaus(dst - 1.0, scale);
//  float wc = Gaus(dst - 1.0, scale);
    float wd = Gaus(dst + 0.0, scale);
//  float wd = Gaus(dst + 0.0, scale);
    float we = Gaus(dst + 1.0, scale);
//  float we = Gaus(dst + 1.0, scale);
    float wf = Gaus(dst + 2.0, scale);
//  float wf = Gaus(dst + 2.0, scale);
    float wg = Gaus(dst + 3.0, scale);
//  float wg = Gaus(dst + 3.0, scale);
    
    // Return filtered sample.
//  // Return filtered sample.
    // Return filtered sample.
//  // Return filtered sample.
    return (a * wa + b * wb + c * wc + d * wd + e * we + f * wf + g * wg) / (wa + wb + wc + wd + we + wf + wg);
//  return (a * wa + b * wb + c * wc + d * wd + e * we + f * wf + g * wg) / (wa + wb + wc + wd + we + wf + wg);
    }
//  }

    // Return scanline weight.
//  // Return scanline weight.
    // Return scanline weight.
//  // Return scanline weight.
    float Scan(vec2 pos, float off) {
//  float Scan(vec2 pos, float off) {
    float       dst = Dist(pos).y   ;
//  float       dst = Dist(pos).y   ;
    return Gaus(dst + off, hardScan);
//  return Gaus(dst + off, hardScan);
    }
//  }

    // Return scanline weight for bloom.
//  // Return scanline weight for bloom.
    // Return scanline weight for bloom.
//  // Return scanline weight for bloom.
    float BloomScan(vec2  pos, float off) {
//  float BloomScan(vec2  pos, float off) {
    float       dst = Dist(pos).y        ;
//  float       dst = Dist(pos).y        ;
    return Gaus(dst + off, hardBloomScan);
//  return Gaus(dst + off, hardBloomScan);
    }
//  }

    // Allow nearest three lines to effect pixel.
//  // Allow nearest three lines to effect pixel.
    // Allow nearest three lines to effect pixel.
//  // Allow nearest three lines to effect pixel.
    vec3 Tri(vec2 pos, sampler2D iChannel0) {
//  vec3 Tri(vec2 pos, sampler2D iChannel0) {
    vec3 a = Horz3(pos,-1.0, iChannel0);
//  vec3 a = Horz3(pos,-1.0, iChannel0);
    vec3 b = Horz5(pos, 0.0, iChannel0);
//  vec3 b = Horz5(pos, 0.0, iChannel0);
    vec3 c = Horz3(pos, 1.0, iChannel0);
//  vec3 c = Horz3(pos, 1.0, iChannel0);
    
    float wa = Scan(pos,-1.0);
//  float wa = Scan(pos,-1.0);
    float wb = Scan(pos, 0.0);
//  float wb = Scan(pos, 0.0);
    float wc = Scan(pos, 1.0);
//  float wc = Scan(pos, 1.0);
    
    return a * wa + b * wb + c * wc;
//  return a * wa + b * wb + c * wc;
    }
//  }

    // Small bloom.
//  // Small bloom.
    // Small bloom.
//  // Small bloom.
    vec3 Bloom(vec2 pos, sampler2D iChannel0) {
//  vec3 Bloom(vec2 pos, sampler2D iChannel0) {
    vec3 a = Horz5(pos,-2.0, iChannel0);
//  vec3 a = Horz5(pos,-2.0, iChannel0);
    vec3 b = Horz7(pos,-1.0, iChannel0);
//  vec3 b = Horz7(pos,-1.0, iChannel0);
    vec3 c = Horz7(pos, 0.0, iChannel0);
//  vec3 c = Horz7(pos, 0.0, iChannel0);
    vec3 d = Horz7(pos, 1.0, iChannel0);
//  vec3 d = Horz7(pos, 1.0, iChannel0);
    vec3 e = Horz5(pos, 2.0, iChannel0);
//  vec3 e = Horz5(pos, 2.0, iChannel0);
    
    float wa = BloomScan(pos,-2.0);
//  float wa = BloomScan(pos,-2.0);
    float wb = BloomScan(pos,-1.0);
//  float wb = BloomScan(pos,-1.0);
    float wc = BloomScan(pos, 0.0);
//  float wc = BloomScan(pos, 0.0);
    float wd = BloomScan(pos, 1.0);
//  float wd = BloomScan(pos, 1.0);
    float we = BloomScan(pos, 2.0);
//  float we = BloomScan(pos, 2.0);
    
    return a * wa + b * wb + c * wc + d * wd + e * we;
//  return a * wa + b * wb + c * wc + d * wd + e * we;
    }
//  }

    // Distortion of scanlines, and end of screen alpha.
//  // Distortion of scanlines, and end of screen alpha.
    // Distortion of scanlines, and end of screen alpha.
//  // Distortion of scanlines, and end of screen alpha.
    vec2 Warp(vec2 pos) {
//  vec2 Warp(vec2 pos) {
    pos  =             pos   * 2.0    - 1.0;
//  pos  =             pos   * 2.0    - 1.0;
    pos *= vec2(1.0 + (pos.y * pos.y) * 1.0 / warp.x
//  pos *= vec2(1.0 + (pos.y * pos.y) * 1.0 / warp.x
    ,       1.0 + (pos.x * pos.x) * 1.0 / warp.y);
//  ,       1.0 + (pos.x * pos.x) * 1.0 / warp.y);
    
    return             pos   * 0.5    + 0.5;
//  return             pos   * 0.5    + 0.5;
    }
//  }

    vec3 Mask(vec2 pos) {
//  vec3 Mask(vec2 pos) {
    if (mask_type == 0) {
//  if (mask_type == 0) {

    float line = maskLight;
//  float line = maskLight;
    float  odd = 0.0      ;
//  float  odd = 0.0      ;
        
    if (fract( pos.x / 6.0) < 0.5)   odd       = 1.0      ;
//  if (fract( pos.x / 6.0) < 0.5)   odd       = 1.0      ;
    if (fract((pos.y + odd) / 2.0) < 0.5) line = maskDarkk;
//  if (fract((pos.y + odd) / 2.0) < 0.5) line = maskDarkk;
    pos.x =
//  pos.x =
    fract( pos.x / 3.0);
//  fract( pos.x / 3.0);
        
    vec3 mask = vec3(maskDarkk, maskDarkk, maskDarkk);
//  vec3 mask = vec3(maskDarkk, maskDarkk, maskDarkk);
    if (pos.x < 0.333) mask.r = maskLight;
//  if (pos.x < 0.333) mask.r = maskLight;
    else if (pos.x < 0.666) mask.g = maskLight;
//  else if (pos.x < 0.666) mask.g = maskLight;
    else                    mask.b = maskLight; mask *= line;
//  else                    mask.b = maskLight; mask *= line;
    return mask;
//  return mask;

    } else if (mask_type == 1) {
//  } else if (mask_type == 1) {

    pos.x +=       pos.y * 3.0 ;
//  pos.x +=       pos.y * 3.0 ;
    vec3 mask = vec3(maskDarkk, maskDarkk, maskDarkk);
//  vec3 mask = vec3(maskDarkk, maskDarkk, maskDarkk);
    pos.x  = fract(pos.x / 6.0);
//  pos.x  = fract(pos.x / 6.0);
    if (pos.x < 0.333) mask.r = maskLight;
//  if (pos.x < 0.333) mask.r = maskLight;
    else if (pos.x < 0.666) mask.g = maskLight;
//  else if (pos.x < 0.666) mask.g = maskLight;
    else                    mask.b = maskLight;
//  else                    mask.b = maskLight;
        
    return mask;
//  return mask;

    } else if (mask_type == 2) {
//  } else if (mask_type == 2) {

    pos.xy = floor(pos.xy * vec2(1.0, 0.5));
//  pos.xy = floor(pos.xy * vec2(1.0, 0.5));
    pos.x +=       pos.y  * 3.0 ;
//  pos.x +=       pos.y  * 3.0 ;
    vec3 mask = vec3(maskDarkk, maskDarkk, maskDarkk);
//  vec3 mask = vec3(maskDarkk, maskDarkk, maskDarkk);
    pos.x  = fract(pos.x  / 6.0);
//  pos.x  = fract(pos.x  / 6.0);
    if (pos.x < 0.333) mask.r = maskLight;
//  if (pos.x < 0.333) mask.r = maskLight;
    else if (pos.x < 0.666) mask.g = maskLight;
//  else if (pos.x < 0.666) mask.g = maskLight;
    else                    mask.b = maskLight;
//  else                    mask.b = maskLight;
    
    return mask;
//  return mask;
    }
//  }
    }
//  }

    // Draw dividing bars.
//  // Draw dividing bars.
    // Draw dividing bars.
//  // Draw dividing bars.
    float Bar(float pos, float bar) { pos -= bar; return pos * pos < 4.0 ? 0.0 : 1.0; }
//  float Bar(float pos, float bar) { pos -= bar; return pos * pos < 4.0 ? 0.0 : 1.0; }

    // Entry.
//  // Entry.
    // Entry.
//  // Entry.
    void main() {
    vec2 pos = Warp(vTexCoord);
//  vec2 pos = Warp(vTexCoord);
    
    fragColor.rgb = Tri(pos, tex0) * Mask(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy);
//  fragColor.rgb = Tri(pos, tex0) * Mask(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy);
    if (bloom_type == 0) { fragColor.rgb  = mix(fragColor.rgb , Bloom(pos, tex0) , 1.0 / bloomAmount); }
//  if (bloom_type == 0) { fragColor.rgb  = mix(fragColor.rgb , Bloom(pos, tex0) , 1.0 / bloomAmount); }
    else if (bloom_type == 1) { fragColor.rgb +=                     Bloom(pos, tex0) * 1.0 / bloomAmount ; }
//  else if (bloom_type == 1) { fragColor.rgb +=                     Bloom(pos, tex0) * 1.0 / bloomAmount ; }
    
    fragColor.a   =                  1.0 ;
//  fragColor.a   =                  1.0 ;
    fragColor.rgb = ToSrgb(fragColor.rgb);
//  fragColor.rgb = ToSrgb(fragColor.rgb);
    }

    //SHADER ORIGINALY CREADED BY "TimothyLottes" FROM SHADERTOY
//  //SHADER ORIGINALY CREADED BY "TimothyLottes" FROM SHADERTOY
    //SHADER ORIGINALY CREADED BY "TimothyLottes" FROM SHADERTOY
//  //SHADER ORIGINALY CREADED BY "TimothyLottes" FROM SHADERTOY
    //PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//  //PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
    //PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//  //PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
    //LICENSE : CC0
//  //LICENSE : CC0
    //LICENSE : CC0
//  //LICENSE : CC0
    //COMATIBLE WITH : GLES2, GLES3, WEBGL
//  //COMATIBLE WITH : GLES2, GLES3, WEBGL
    //COMATIBLE WITH : GLES2, GLES3, WEBGL
//  //COMATIBLE WITH : GLES2, GLES3, WEBGL
    //SHADERTOY LINK : https://www.shadertoy.com/view/MsjXzh
//  //SHADERTOY LINK : https://www.shadertoy.com/view/MsjXzh
    //SHADERTOY LINK : https://www.shadertoy.com/view/MsjXzh
//  //SHADERTOY LINK : https://www.shadertoy.com/view/MsjXzh
    //
//  //
    // PUBLIC DOMAIN CRT STYLED SCAN-LINE SHADER
//  // PUBLIC DOMAIN CRT STYLED SCAN-LINE SHADER
    // PUBLIC DOMAIN CRT STYLED SCAN-LINE SHADER
//  // PUBLIC DOMAIN CRT STYLED SCAN-LINE SHADER
    //
//  //
    //   by Timothy Lottes
//  //   by Timothy Lottes
    //   by Timothy Lottes
//  //   by Timothy Lottes
    //
//  //
    // This is more along the style of a really good CGA arcade monitor.
//  // This is more along the style of a really good CGA arcade monitor.
    // This is more along the style of a really good CGA arcade monitor.
//  // This is more along the style of a really good CGA arcade monitor.
    // With RGB inputs instead of NTSC.
//  // With RGB inputs instead of NTSC.
    // With RGB inputs instead of NTSC.
//  // With RGB inputs instead of NTSC.
    // The shadow mask example has the mask rotated 90 degrees for less chromatic aberration.
//  // The shadow mask example has the mask rotated 90 degrees for less chromatic aberration.
    // The shadow mask example has the mask rotated 90 degrees for less chromatic aberration.
//  // The shadow mask example has the mask rotated 90 degrees for less chromatic aberration.
    //
//  //
    // Left it unoptimized to show the theory behind the algorithm.
//  // Left it unoptimized to show the theory behind the algorithm.
    // Left it unoptimized to show the theory behind the algorithm.
//  // Left it unoptimized to show the theory behind the algorithm.
    //
//  //
    // It is an example what I personally would want as a display option for pixel art games.
//  // It is an example what I personally would want as a display option for pixel art games.
    // It is an example what I personally would want as a display option for pixel art games.
//  // It is an example what I personally would want as a display option for pixel art games.
    // Please take and use, change, or whatever.
//  // Please take and use, change, or whatever.
    // Please take and use, change, or whatever.
//  // Please take and use, change, or whatever.

    //#-------------------------------------------------------------------#
//  //#-------------------------------------------------------------------#
    // https://godotshaders.com/shader/crt-shader-with-realistic-blurring/
//  // https://godotshaders.com/shader/crt-shader-with-realistic-blurring/
    //#-------------------------------------------------------------------#
//  //#-------------------------------------------------------------------#
