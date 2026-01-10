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

    // const bool   keep_luminance = false;
//  // const bool   keep_luminance = false;
    // const vec4  color_start     = vec4(0.0, 0.0, 0.0, 1.0);
//  // const vec4  color_start     = vec4(0.0, 0.0, 0.0, 1.0);
    // const float       start_pos = 0.000;
//  // const float       start_pos = 0.000;
    // const vec4  color_mid       = vec4(0.5, 0.5, 0.5, 1.0);
//  // const vec4  color_mid       = vec4(0.5, 0.5, 0.5, 1.0);
    // const float       mid_pos   = 0.500;
//  // const float       mid_pos   = 0.500;
    // const vec4  color_end       = vec4(1.0, 1.0, 1.0, 1.0);
//  // const vec4  color_end       = vec4(1.0, 1.0, 1.0, 1.0);
    // const float       end_pos   = 0.990;
//  // const float       end_pos   = 0.990;
    // const bool  midpos_enabled  = false;
//  // const bool  midpos_enabled  = false;
    // const float effect_filling  = 1.000;
//  // const float effect_filling  = 1.000;

    uniform bool   keep_luminance ; // false
//  uniform bool   keep_luminance ; // false
    uniform vec4  color_start     ; // 0.0, 0.0, 0.0, 1.0
//  uniform vec4  color_start     ; // 0.0, 0.0, 0.0, 1.0
    uniform float       start_pos ; // 0.000
//  uniform float       start_pos ; // 0.000
    uniform vec4  color_mid       ; // 0.5, 0.5, 0.5, 1.0
//  uniform vec4  color_mid       ; // 0.5, 0.5, 0.5, 1.0
    uniform float       mid_pos   ; // 0.500
//  uniform float       mid_pos   ; // 0.500
    uniform vec4  color_end       ; // 1.0, 1.0, 1.0, 1.0
//  uniform vec4  color_end       ; // 1.0, 1.0, 1.0, 1.0
    uniform float       end_pos   ; // 0.990
//  uniform float       end_pos   ; // 0.990
    uniform bool  midpos_enabled  ; // false
//  uniform bool  midpos_enabled  ; // false
    uniform float effect_filling  ; // 1.000
//  uniform float effect_filling  ; // 1.000

    vec3 rgb2hsv(vec3 c)
//  vec3 rgb2hsv(vec3 c)
    {
//  {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
//  vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg , K.wz ), vec4(c.gb , K.xy ), step(c.b, c.g));
//  vec4 p = mix(vec4(c.bg , K.wz ), vec4(c.gb , K.xy ), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r  ), vec4(c.r  , p.yzx), step(p.x, c.r));
//  vec4 q = mix(vec4(p.xyw, c.r  ), vec4(c.r  , p.yzx), step(p.x, c.r));

    float d =       q.x - min(q.w , q.y);
//  float d =       q.x - min(q.w , q.y);
    float e =                    1.0e-10;
//  float e =                    1.0e-10;
    return vec3(abs(q.z +    (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
//  return vec3(abs(q.z +    (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
    }
//  }

    // All components are in the range [0…1], including hue.
//  // All components are in the range [0…1], including hue.
    // @@@ @@@@@@@@@@ @@@ @@ @@@ @@@@@ @@@@@@ @@@@@@@@@ @@@@
//  // @@@ @@@@@@@@@@ @@@ @@ @@@ @@@@@ @@@@@@ @@@@@@@@@ @@@@
    vec3 hsv2rgb(vec3 c)
//  vec3 hsv2rgb(vec3 c)
    {
//  {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
//  vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p =     abs(fract( c.xxx   + K.xyz) * 6.0 - K.www      );
//  vec3 p =     abs(fract( c.xxx   + K.xyz) * 6.0 - K.www      );
    return c.z * mix(K.xxx, clamp(p - K.xxx,   0.0,    1.0), c.y);
//  return c.z * mix(K.xxx, clamp(p - K.xxx,   0.0,    1.0), c.y);
    }
//  }

    //function from: https://gamedev.stackexchange.com/a/75928
//  //function from: https://gamedev.stackexchange.com/a/75928
    //@@@@@@@@ @@@@@ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  //@@@@@@@@ @@@@@ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    vec4 to_gray(vec4 tex)
//  vec4 to_gray(vec4 tex)
    {
//  {
    float avg = ( tex.r
//  float avg = ( tex.r
    +   tex.g
//  +   tex.g
    +   tex.b ) / 3.0;
//  +   tex.b ) / 3.0;
    return vec4(vec3(avg), tex.a);
//  return vec4(vec3(avg), tex.a);
    }
//  }

    vec4 to_color(vec4 gray, vec4 col)
//  vec4 to_color(vec4 gray, vec4 col)
    {
//  {
    return gray * col;
//  return gray * col;
    }
//  }

    void main()
    {
    vec4 tex = texture(tex0, vTexCoord);
//  vec4 tex = texture(tex0, vTexCoord);
    vec3 hsv = rgb2hsv(       tex.rgb );
//  vec3 hsv = rgb2hsv(       tex.rgb );
    
    // the .r here represents HUE, .g is SATURATION, .b is LUMINANCE
//  // the .r here represents HUE, .g is SATURATION, .b is LUMINANCE
    // @@@ @@ @@@@ @@@@@@@@@@ @@@@ @@ @@ @@@@@@@@@@@ @@ @@ @@@@@@@@@
//  // @@@ @@ @@@@ @@@@@@@@@@ @@@@ @@ @@ @@@@@@@@@@@ @@ @@ @@@@@@@@@
    vec4 color;
//  vec4 color;
    
    if (hsv.b < start_pos) { color = color_start; }
//  if (hsv.b < start_pos) { color = color_start; }
    if (hsv.b >   end_pos) { color = color_end  ; }
//  if (hsv.b >   end_pos) { color = color_end  ; }
    
    if (hsv.b > start_pos
//  if (hsv.b > start_pos
    &&  hsv.b <   end_pos)
//  &&  hsv.b <   end_pos)
    {
//  {
    if (midpos_enabled
//  if (midpos_enabled
    &&         mid_pos > start_pos
//  &&         mid_pos > start_pos
    &&         mid_pos <   end_pos)
//  &&         mid_pos <   end_pos)
    {
//  {
    if (hsv.b > mid_pos)
//  if (hsv.b > mid_pos)
    {
//  {
    color = mix(color_mid  ,
//  color = mix(color_mid  ,
    color_end  ,
//  color_end  ,
    (hsv.b   - mid_pos)
//  (hsv.b   - mid_pos)
    /     (end_pos - mid_pos));
//  /     (end_pos - mid_pos));
    }
//  }
    else
//  else
    {
//  {
    color = mix(color_start,
//  color = mix(color_start,
    color_mid  ,
//  color_mid  ,
    (hsv.b   - start_pos)
//  (hsv.b   - start_pos)
    /     (mid_pos - start_pos));
//  /     (mid_pos - start_pos));
    }
//  }
    }
//  }
    else
//  else
    {
//  {
    color = mix(color_start,
//  color = mix(color_start,
    color_end  ,
//  color_end  ,
    (hsv.b   - start_pos)
//  (hsv.b   - start_pos)
    /     (end_pos - start_pos));
//  /     (end_pos - start_pos));
    }
//  }
    }
//  }
    
    tex = to_gray(tex);
//  tex = to_gray(tex);
    if (keep_luminance)
//  if (keep_luminance)
    {
//  {
    tex = to_color(tex, color);
//  tex = to_color(tex, color);
    }
//  }
    else
//  else
    {
//  {
    tex = color;
//  tex = color;
    }
//  }
    
    fragColor   = mix( texture(tex0, vTexCoord)  , tex  , effect_filling);
//  fragColor   = mix( texture(tex0, vTexCoord)  , tex  , effect_filling);
    fragColor.a = min( texture(tex0, vTexCoord).a, tex.a                );
//  fragColor.a = min( texture(tex0, vTexCoord).a, tex.a                );
    }


    // https://godotshaders.com/shader/gradient-mapping/
//  // https://godotshaders.com/shader/gradient-mapping/
