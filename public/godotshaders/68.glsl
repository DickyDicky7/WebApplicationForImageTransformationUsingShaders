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

    // const float     aspect = 1.0;
//  // const float     aspect = 1.0;
    // const float distortion = 1.0;
//  // const float distortion = 1.0;
    // const float     radius = 1.0;
//  // const float     radius = 1.0;
    // const float alpha = 1.0;
//  // const float alpha = 1.0;
    // const float  crop = 1.0;
//  // const float  crop = 1.0;
    // const vec4   crop_color = vec4(0.0, 0.0, 0.0, 1.0);
//  // const vec4   crop_color = vec4(0.0, 0.0, 0.0, 1.0);

    uniform float     aspect ; // 1.0
//  uniform float     aspect ; // 1.0
    uniform float distortion ; // 1.0
//  uniform float distortion ; // 1.0
    uniform float     radius ; // 1.0
//  uniform float     radius ; // 1.0
    uniform float alpha ; // 1.0
//  uniform float alpha ; // 1.0
    uniform float  crop ; // 1.0
//  uniform float  crop ; // 1.0
    uniform vec4   crop_color ; // 0.0, 0.0, 0.0, 1.0
//  uniform vec4   crop_color ; // 0.0, 0.0, 0.0, 1.0

    vec2 distort(vec2 p)
//  vec2 distort(vec2 p)
    {
//  {
    float d = length(p);
//  float d = length(p);
    float z = sqrt(distortion + d * d * -distortion);
//  float z = sqrt(distortion + d * d * -distortion);
    float r =   atan(d  , z  ) / 3.1415926535;
//  float r =   atan(d  , z  ) / 3.1415926535;
    float phi = atan(p.y, p.x)               ;
//  float phi = atan(p.y, p.x)               ;
    return vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);
//  return vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);
    }
//  }

    void main()
    {
    vec2 xy = (vTexCoord * 2.0 - 1.0);
//  vec2 xy = (vTexCoord * 2.0 - 1.0);
    xy =
//  xy =
    vec2(xy.x * aspect,
//  vec2(xy.x * aspect,
    xy.y);
//  xy.y);

    float d = length(xy);
//  float d = length(xy);

    vec4 tex;
//  vec4 tex;

    if (d < radius)
//  if (d < radius)
    {
//  {
    xy = distort(xy);
//  xy = distort(xy);
    tex = texture(tex0, xy);
//  tex = texture(tex0, xy);
    fragColor   = tex;
//  fragColor   = tex;
    fragColor.a = alpha;
//  fragColor.a = alpha;
    }
//  }

    // radial crop
//  // radial crop
    if (d > crop)
//  if (d > crop)
    {
//  {
    fragColor = crop_color;
//  fragColor = crop_color;
    }
//  }
    }

    // https://godotshaders.com/shader/2d-radial-distortion-fisheye-barrel/
//  // https://godotshaders.com/shader/2d-radial-distortion-fisheye-barrel/
