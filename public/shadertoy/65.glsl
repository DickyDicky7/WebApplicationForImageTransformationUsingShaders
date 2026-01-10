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

    // const float GAMMA      = 0.65;
//  // const float GAMMA      = 0.65;
    // const float REGIONS    = 5.00;
//  // const float REGIONS    = 5.00;
    // const float LINES      = 0.50;
//  // const float LINES      = 0.50;
    // const float BASE       = 2.50;
//  // const float BASE       = 2.50;
    // const float GREEN_BIAS = 0.90;
//  // const float GREEN_BIAS = 0.90;


    uniform float GAMMA      ; // 0.65
//  uniform float GAMMA      ; // 0.65
    uniform float REGIONS    ; // 5.00
//  uniform float REGIONS    ; // 5.00
    uniform float LINES      ; // 0.50
//  uniform float LINES      ; // 0.50
    uniform float BASE       ; // 2.50
//  uniform float BASE       ; // 2.50
    uniform float GREEN_BIAS ; // 0.90
//  uniform float GREEN_BIAS ; // 0.90


    // Hash function for noise generation
//  // Hash function for noise generation
    // Hash function for noise generation
//  // Hash function for noise generation
    float hash(float n) {
//  float hash(float n) {
    return fract(sin(n) * 43758.5453);
//  return fract(sin(n) * 43758.5453);
    }
//  }

    // 3D noise function
//  // 3D noise function
    // 3D noise function
//  // 3D noise function
    float noise(in vec3 x) {
//  float noise(in vec3 x) {
    vec3 p = floor(x);
//  vec3 p = floor(x);
    vec3 f = fract(x);
//  vec3 f = fract(x);
    f = f * f * (3.0 - 2.0 * f);
//  f = f * f * (3.0 - 2.0 * f);

    float n = p.x + p.y * 57.0 + 113.0 * p.z;
//  float n = p.x + p.y * 57.0 + 113.0 * p.z;

    float  res = mix(mix(mix(hash(n + 000.0), hash(n + 001.0), f.x),
//  float  res = mix(mix(mix(hash(n + 000.0), hash(n + 001.0), f.x),
    mix(hash(n + 057.0), hash(n + 058.0), f.x), f.y),
//  mix(hash(n + 057.0), hash(n + 058.0), f.x), f.y),
    mix(mix(hash(n + 113.0), hash(n + 114.0), f.x),
//  mix(mix(hash(n + 113.0), hash(n + 114.0), f.x),
    mix(hash(n + 170.0), hash(n + 171.0), f.x), f.y), f.z);
//  mix(hash(n + 170.0), hash(n + 171.0), f.x), f.y), f.z);
    return res;
//  return res;
    }
//  }

    // Outline function for edges in the scene
//  // Outline function for edges in the scene
    // Outline function for edges in the scene
//  // Outline function for edges in the scene
    vec3 OutlineWhyCantIPassASampler(vec2 fragCoord) {
//  vec3 OutlineWhyCantIPassASampler(vec2 fragCoord) {
    vec2 uv    = fragCoord.xy / canvasSize.xy;
//  vec2 uv    = fragCoord.xy / canvasSize.xy;
    uv.y  = 1.00 - uv.y                 ;
//  uv.y  = 1.00 - uv.y                 ;
    vec4 lines = vec4(0.30, 0.59, 0.11, 1.0) ;
//  vec4 lines = vec4(0.30, 0.59, 0.11, 1.0) ;

    lines.rgb = lines.rgb * LINES * 1.5;
//  lines.rgb = lines.rgb * LINES * 1.5;

    float s11 = dot(texture(noise0, uv + vec2(-1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // @LEFT@
//  float s11 = dot(texture(noise0, uv + vec2(-1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // @LEFT@
    float s12 = dot(texture(noise0, uv + vec2( 0.0               , -1.0 / canvasSize.y)), lines); // MIDDLE
//  float s12 = dot(texture(noise0, uv + vec2( 0.0               , -1.0 / canvasSize.y)), lines); // MIDDLE
    float s13 = dot(texture(noise0, uv + vec2( 1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // RIGHT@
//  float s13 = dot(texture(noise0, uv + vec2( 1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // RIGHT@

    float s21 = dot(texture(noise0, uv + vec2(-1.0 / canvasSize.x,  0.0               )), lines); // @LEFT@
//  float s21 = dot(texture(noise0, uv + vec2(-1.0 / canvasSize.x,  0.0               )), lines); // @LEFT@
    float s23 = dot(texture(noise0, uv + vec2( 1.0 / canvasSize.x,  0.0               )), lines); // RIGHT@
//  float s23 = dot(texture(noise0, uv + vec2( 1.0 / canvasSize.x,  0.0               )), lines); // RIGHT@

    float s31 = dot(texture(noise0, uv + vec2(-1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // @LEFT@
//  float s31 = dot(texture(noise0, uv + vec2(-1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // @LEFT@
    float s32 = dot(texture(noise0, uv + vec2( 0.0               ,  1.0 / canvasSize.y)), lines); // MIDDLE
//  float s32 = dot(texture(noise0, uv + vec2( 0.0               ,  1.0 / canvasSize.y)), lines); // MIDDLE
    float s33 = dot(texture(noise0, uv + vec2( 1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // RIGHT@
//  float s33 = dot(texture(noise0, uv + vec2( 1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // RIGHT@

    float t1 = s13 + s33 + (2.0 * s23) - s11 -       (2.0 * s21) - s31;
//  float t1 = s13 + s33 + (2.0 * s23) - s11 -       (2.0 * s21) - s31;
    float t2 = s31 +       (2.0 * s32) + s33 - s11 - (2.0 * s12) - s13;
//  float t2 = s31 +       (2.0 * s32) + s33 - s11 - (2.0 * s12) - s13;

    vec3 col;
//  vec3 col;

    if (((t1 * t1) + (t2 * t2)) > 0.04) {
//  if (((t1 * t1) + (t2 * t2)) > 0.04) {
    col = vec3(-1.0, -1.0, -1.0);
//  col = vec3(-1.0, -1.0, -1.0);
    } else {
//  } else {
    col = vec3( 0.0,  0.0,  0.0);
//  col = vec3( 0.0,  0.0,  0.0);
    }
//  }

    return col;
//  return col;
    }
//  }

    // Recolor the foreground colors
//  // Recolor the foreground colors
    // Recolor the foreground colors
//  // Recolor the foreground colors
    vec3 RecolorForeground( vec3 color  ) {
//  vec3 RecolorForeground( vec3 color  ) {
    if (color.g > (color.r + color.b) * GREEN_BIAS) {
//  if (color.g > (color.r + color.b) * GREEN_BIAS) {
    color.rgb = vec3(0.0, 0.0, 0.0);
//  color.rgb = vec3(0.0, 0.0, 0.0);
    }
//  }

    color.rgb = 0.2126 * color.rrr
//  color.rgb = 0.2126 * color.rrr
    + 0.7152 * color.ggg
//  + 0.7152 * color.ggg
    + 0.0722 * color.bbb;
//  + 0.0722 * color.bbb;

    if (color.r >  0.75)
//  if (color.r >  0.75)
    {
//  {
    color.r *= 0.90;
//  color.r *= 0.90;
    }
//  }
    else
//  else
    if (color.r >  0.50)
//  if (color.r >  0.50)
    {
//  {
    color.r *= 0.70;
//  color.r *= 0.70;
    color.g *= 0.90;
//  color.g *= 0.90;
    }
//  }
    else
//  else
    if (color.r >  0.25)
//  if (color.r >  0.25)
    {
//  {
    color.r *= 0.50;
//  color.r *= 0.50;
    color.g *= 0.75;
//  color.g *= 0.75;
    }
//  }
    else
//  else
    {
//  {
    color.r *= 0.25;
//  color.r *= 0.25;
    color.g *= 0.50;
//  color.g *= 0.50;
    }
//  }

    return color;
//  return color;
    }
//  }

    // Posterization effect
//  // Posterization effect
    // Posterization effect
//  // Posterization effect
    vec3 Posterize(vec3 color) {
//  vec3 Posterize(vec3 color) {
    color =   pow(color, vec3(GAMMA, GAMMA, GAMMA));
//  color =   pow(color, vec3(GAMMA, GAMMA, GAMMA));
    color = floor(color * REGIONS) / REGIONS       ;
//  color = floor(color * REGIONS) / REGIONS       ;
    color =   pow(color, vec3(1.000/ GAMMA       ));
//  color =   pow(color, vec3(1.000/ GAMMA       ));
    return color.rgb;
//  return color.rgb;
    }
//  }

    // Replace background color
//  // Replace background color
    // Replace background color
//  // Replace background color
    vec3 ReplaceBackground(vec3 color, vec2 uv, vec2 fragCoord) {
//  vec3 ReplaceBackground(vec3 color, vec2 uv, vec2 fragCoord) {
    color.r =  texture(noise0, vec2(uv.x, 1.0 - uv.y)).r - 0.6;
//  color.r =  texture(noise0, vec2(uv.x, 1.0 - uv.y)).r - 0.6;
    color.r = (
//  color.r = (
    0.5
//  0.5
    -  0.5
//  -  0.5
    * uv.x
//  * uv.x
    + uv.y
//  + uv.y
    )
//  )
    *  0.75  +  color.r   ;
//  *  0.75  +  color.r   ;
    color   = Posterize(color.rrr);
//  color   = Posterize(color.rrr);
    color.b =  0.0;
//  color.b =  0.0;
    color.g =  0.0;
//  color.g =  0.0;
    color += OutlineWhyCantIPassASampler(fragCoord) / 40.0;
//  color += OutlineWhyCantIPassASampler(fragCoord) / 40.0;
    return                                   color        ;
//  return                                   color        ;
    }
//  }

    // Outline function for final drawing
//  // Outline function for final drawing
    // Outline function for final drawing
//  // Outline function for final drawing
    vec3 Outline(vec2 uv) {
//  vec3 Outline(vec2 uv) {
    vec4 lines     = vec4(0.30, 0.59, 0.11, 1.0);
//  vec4 lines     = vec4(0.30, 0.59, 0.11, 1.0);
    lines.rgb =
//  lines.rgb =
    lines.rgb * LINES                      ;
//  lines.rgb * LINES                      ;

    if (canvasSize.x < 0300.0)
//  if (canvasSize.x < 0300.0)
    {
//  {
    lines /= 4.0;
//  lines /= 4.0;
    // improves thumbnail look
//  // improves thumbnail look
    // improves thumbnail look
//  // improves thumbnail look
    }
//  }
    else
//  else
    if (canvasSize.x > 1000.0)
//  if (canvasSize.x > 1000.0)
    {
//  {
    lines *= 1.5;
//  lines *= 1.5;
    }
//  }

    float s11 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // @LEFT@
//  float s11 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // @LEFT@
    float s12 = dot(texture(tex0, uv + vec2( 0.0               , -1.0 / canvasSize.y)), lines); // MIDDLE
//  float s12 = dot(texture(tex0, uv + vec2( 0.0               , -1.0 / canvasSize.y)), lines); // MIDDLE
    float s13 = dot(texture(tex0, uv + vec2( 1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // RIGHT@
//  float s13 = dot(texture(tex0, uv + vec2( 1.0 / canvasSize.x, -1.0 / canvasSize.y)), lines); // RIGHT@

    float s21 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x,  0.0               )), lines); // @LEFT@
//  float s21 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x,  0.0               )), lines); // @LEFT@
    float s23 = dot(texture(tex0, uv + vec2( 1.0 / canvasSize.x,  0.0               )), lines); // RIGHT@
//  float s23 = dot(texture(tex0, uv + vec2( 1.0 / canvasSize.x,  0.0               )), lines); // RIGHT@

    float s31 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // @LEFT@
//  float s31 = dot(texture(tex0, uv + vec2(-1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // @LEFT@
    float s32 = dot(texture(tex0, uv + vec2( 0.0               ,  1.0 / canvasSize.y)), lines); // MIDDLE
//  float s32 = dot(texture(tex0, uv + vec2( 0.0               ,  1.0 / canvasSize.y)), lines); // MIDDLE
    float s33 = dot(texture(tex0, uv + vec2( 1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // RIGHT@
//  float s33 = dot(texture(tex0, uv + vec2( 1.0 / canvasSize.x,  1.0 / canvasSize.y)), lines); // RIGHT@

    float t1 = s13 + s33 + (2.0 * s23) - s11 -       (2.0 * s21) - s31;
//  float t1 = s13 + s33 + (2.0 * s23) - s11 -       (2.0 * s21) - s31;
    float t2 = s31 +       (2.0 * s32) + s33 - s11 - (2.0 * s12) - s13;
//  float t2 = s31 +       (2.0 * s32) + s33 - s11 - (2.0 * s12) - s13;

    vec3 col;
//  vec3 col;

    if (((t1 * t1) + (t2 * t2)) > 0.04) {
//  if (((t1 * t1) + (t2 * t2)) > 0.04) {
    col = vec3(-1.0, -1.0, -1.0);
//  col = vec3(-1.0, -1.0, -1.0);
    } else {
//  } else {
    col = vec3( 0.0,  0.0,  0.0);
//  col = vec3( 0.0,  0.0,  0.0);
    }
//  }

    return col;
//  return col;
    }
//  }

    void main() {
    vec2 uv    = vTexCoord;
//  vec2 uv    = vTexCoord;
    vec3 color = normalize(texture(tex0, uv)).rgb * BASE;
//  vec3 color = normalize(texture(tex0, uv)).rgb * BASE;
    color = Posterize(color);
//  color = Posterize(color);
    vec3 background = ReplaceBackground(color, uv, vec4(vTexCoord * canvasSize, 0.0, 1.0).xy)             ;
//  vec3 background = ReplaceBackground(color, uv, vec4(vTexCoord * canvasSize, 0.0, 1.0).xy)             ;
    color.rgb += Outline(uv);
//  color.rgb += Outline(uv);
    color      = RecolorForeground(color                     ) + background;
//  color      = RecolorForeground(color                     ) + background;

    fragColor = vec4(color, 1.0);
//  fragColor = vec4(color, 1.0);
    }


    // https://www.shadertoy.com/view/MfscWl
//  // https://www.shadertoy.com/view/MfscWl

