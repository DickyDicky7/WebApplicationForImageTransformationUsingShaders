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

    // const float aspect     = 1.00;
//  // const float aspect     = 1.00;
    // const float distortion = 1.00;
//  // const float distortion = 1.00;
    // const float radius     = 1.07;
//  // const float radius     = 1.07;
    // const float      alpha = 1.00;
//  // const float      alpha = 1.00;
    // const float crop            = 0.943;
//  // const float crop            = 0.943;
    // const vec4  crop_color      = vec4(0,0,0,1);
//  // const vec4  crop_color      = vec4(0,0,0,1);
    // const float crop_feathering = 0.100;
//  // const float crop_feathering = 0.100;

    // const float base_distortion                             = 0.990;
//  // const float base_distortion                             = 0.990;
    // const float                channel_offset               = 0.005;
//  // const float                channel_offset               = 0.005;
    // const float                              noise_strength = 5.000;
//  // const float                              noise_strength = 5.000;

    uniform float aspect     ; // 1.00
//  uniform float aspect     ; // 1.00
    uniform float distortion ; // 1.00
//  uniform float distortion ; // 1.00
    uniform float radius     ; // 1.07
//  uniform float radius     ; // 1.07
    uniform float      alpha ; // 1.00
//  uniform float      alpha ; // 1.00
    uniform float crop            ; // 0.943
//  uniform float crop            ; // 0.943
    uniform vec4  crop_color      ; // 0,0,0,1
//  uniform vec4  crop_color      ; // 0,0,0,1
    uniform float crop_feathering ; // 0.100
//  uniform float crop_feathering ; // 0.100

    uniform float base_distortion                             ; // 0.990
//  uniform float base_distortion                             ; // 0.990
    uniform float                channel_offset               ; // 0.005
//  uniform float                channel_offset               ; // 0.005
    uniform float                              noise_strength ; // 5.000
//  uniform float                              noise_strength ; // 5.000

    vec2 distort(vec2 p)
//  vec2 distort(vec2 p)
    {
//  {
    float   d = length(p);
//  float   d = length(p);
    float   z = sqrt(distortion + d * d * -distortion);
//  float   z = sqrt(distortion + d * d * -distortion);
    float   r = atan(d  , z  )      /   03.1415926535 ;
//  float   r = atan(d  , z  )      /   03.1415926535 ;
    float phi = atan(p.y, p.x);
//  float phi = atan(p.y, p.x);
    return vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);
//  return vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);
    }
//  }

    void main()
    {
    vec2 xy = (vTexCoord * 2.0 - 1.0);
//  vec2 xy = (vTexCoord * 2.0 - 1.0);
    xy =              vec2(xy.x *aspect , xy.y);
//  xy =              vec2(xy.x *aspect , xy.y);
    float d =            length(xy);
//  float d =            length(xy);
    vec4 tex;
//  vec4 tex;
    if (d < radius)
//  if (d < radius)
    {
//  {
    vec2 distorted_uv_r = distort(xy * (base_distortion + 0.0 * channel_offset));
//  vec2 distorted_uv_r = distort(xy * (base_distortion + 0.0 * channel_offset));
    vec2 distorted_uv_g = distort(xy * (base_distortion + 1.0 * channel_offset));
//  vec2 distorted_uv_g = distort(xy * (base_distortion + 1.0 * channel_offset));
    vec2 distorted_uv_b = distort(xy * (base_distortion + 2.0 * channel_offset));
//  vec2 distorted_uv_b = distort(xy * (base_distortion + 2.0 * channel_offset));
        
    tex.r = texture(tex0, distorted_uv_r).r;
//  tex.r = texture(tex0, distorted_uv_r).r;
    tex.g = texture(tex0, distorted_uv_g).g;
//  tex.g = texture(tex0, distorted_uv_g).g;
    tex.b = texture(tex0, distorted_uv_b).b;
//  tex.b = texture(tex0, distorted_uv_b).b;
    float x = (vTexCoord.x + 4.0 )
//  float x = (vTexCoord.x + 4.0 )
    * (vTexCoord.y + 4.0 )
//  * (vTexCoord.y + 4.0 )
    * (time * 10.0);
//  * (time * 10.0);
    tex         =  tex + vec4(mod(( mod(x, 013.0) ) * ( mod(x, 123.0) ), 0.01) - 0.005) * noise_strength;
//  tex         =  tex + vec4(mod(( mod(x, 013.0) ) * ( mod(x, 123.0) ), 0.01) - 0.005) * noise_strength;
    fragColor   =  tex ;
//  fragColor   =  tex ;
    fragColor.a = alpha;
//  fragColor.a = alpha;
    }
//  }

    if (d > crop)
//  if (d > crop)
    {
//  {
    float softness = smoothstep(crop, crop + crop_feathering, d       );
//  float softness = smoothstep(crop, crop + crop_feathering, d       );
    fragColor      =        mix(tex ,        crop_color     , softness);
//  fragColor      =        mix(tex ,        crop_color     , softness);
    fragColor.a    = alpha;
//  fragColor.a    = alpha;
    }
//  }
    }

    // https://godotshaders.com/shader/bodycam/
//  // https://godotshaders.com/shader/bodycam/
