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

    // Loosely based on postprocessing shader by inigo quilez, License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
//  // Loosely based on postprocessing shader by inigo quilez, License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

    vec2 curve(vec2 uv)
//  vec2 curve(vec2 uv)
    {
//  {
    uv    = (uv - 0.5) * 2.0;
//  uv    = (uv - 0.5) * 2.0;
    uv   *= 1.1;
//  uv   *= 1.1;
    uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0);
//  uv.x *= 1.0 + pow((abs(uv.y) / 5.0), 2.0);
    uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0);
//  uv.y *= 1.0 + pow((abs(uv.x) / 4.0), 2.0);
    uv  = (uv / 2.00) + 0.50;
//  uv  = (uv / 2.00) + 0.50;
    uv  =  uv * 0.92  + 0.04;
//  uv  =  uv * 0.92  + 0.04;
    return uv;
//  return uv;
    }
//  }

    void main(  )
    {
    // vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
//  // vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 q  = vTexCoord;
//  vec2 q  = vTexCoord;
    vec2 uv = q;
//  vec2 uv = q;
    uv = curve( uv );
//  uv = curve( uv );
    vec3 oricol = texture( tex0, vec2(q.x,q.y) ).xyz;
//  vec3 oricol = texture( tex0, vec2(q.x,q.y) ).xyz;
    vec3 col;
//  vec3 col;
    float x = sin(0.3     *time+uv.y*21.0)
//  float x = sin(0.3     *time+uv.y*21.0)
    * sin(0.7     *time+uv.y*29.0)
//  * sin(0.7     *time+uv.y*29.0)
    * sin(0.3+0.33*time+uv.y*31.0)
//  * sin(0.3+0.33*time+uv.y*31.0)
    * 0.0017;
//  * 0.0017;

    col.r = texture(tex0,vec2(x+uv.x+0.001,uv.y+0.001)).x+0.05;
//  col.r = texture(tex0,vec2(x+uv.x+0.001,uv.y+0.001)).x+0.05;
    col.g = texture(tex0,vec2(x+uv.x+0.000,uv.y-0.002)).y+0.05;
//  col.g = texture(tex0,vec2(x+uv.x+0.000,uv.y-0.002)).y+0.05;
    col.b = texture(tex0,vec2(x+uv.x-0.002,uv.y+0.000)).z+0.05;
//  col.b = texture(tex0,vec2(x+uv.x-0.002,uv.y+0.000)).z+0.05;
    col.r += 0.08*texture(tex0,0.75*vec2(x+0.025, -0.027)+vec2(uv.x+0.001,uv.y+0.001)).x;
//  col.r += 0.08*texture(tex0,0.75*vec2(x+0.025, -0.027)+vec2(uv.x+0.001,uv.y+0.001)).x;
    col.g += 0.05*texture(tex0,0.75*vec2(x+-0.022, -0.02)+vec2(uv.x+0.000,uv.y-0.002)).y;
//  col.g += 0.05*texture(tex0,0.75*vec2(x+-0.022, -0.02)+vec2(uv.x+0.000,uv.y-0.002)).y;
    col.b += 0.08*texture(tex0,0.75*vec2(x+-0.02, -0.018)+vec2(uv.x-0.002,uv.y+0.000)).z;
//  col.b += 0.08*texture(tex0,0.75*vec2(x+-0.02, -0.018)+vec2(uv.x-0.002,uv.y+0.000)).z;

    col  = clamp(col
//  col  = clamp(col
    *       0.6
//  *       0.6
    +       0.4
//  +       0.4
    *       col
//  *       col
    *       col
//  *       col
    *       1.0
//  *       1.0
    ,       0.0
//  ,       0.0
    ,       1.0);
//  ,       1.0);

    float vig = (0.0
//  float vig = (0.0
    +  1.0
//  +  1.0
    * 16.0
//  * 16.0
    * uv.x
//  * uv.x
    * uv.y
//  * uv.y
    *(1.0-uv.x)
//  *(1.0-uv.x)
    *(1.0-uv.y));
//  *(1.0-uv.y));
    col *= vec3(pow(vig,0.3));
//  col *= vec3(pow(vig,0.3));

    col *= vec3(0.95,
//  col *= vec3(0.95,
    1.05,
//  1.05,
    0.95);
//  0.95);
    col *= 2.8;
//  col *= 2.8;

    float scans = clamp( 0.35+0.35*sin(3.5*time+uv.y*canvasSize.y*1.5), 0.0, 1.0);
//  float scans = clamp( 0.35+0.35*sin(3.5*time+uv.y*canvasSize.y*1.5), 0.0, 1.0);
    
    float s = pow(scans,1.7);
//  float s = pow(scans,1.7);
    col =
//  col =
    col * vec3( 0.4
//  col * vec3( 0.4
    +       0.7
//  +       0.7
    *       s);
//  *       s);

    col *= 1.0+0.01*sin(110.0*time);
//  col *= 1.0+0.01*sin(110.0*time);
    if (uv.x < 0.0 || uv.x > 1.0)
//  if (uv.x < 0.0 || uv.x > 1.0)
    col *= 0.0;
//  col *= 0.0;
    if (uv.y < 0.0 || uv.y > 1.0)
//  if (uv.y < 0.0 || uv.y > 1.0)
    col *= 0.0;
//  col *= 0.0;
    
    col *= 1.0 - 0.65 * vec3(clamp((mod(vec4(vTexCoord * canvasSize, 0.0, 1.0).x, 2.0 ) - 1.0)
//  col *= 1.0 - 0.65 * vec3(clamp((mod(vec4(vTexCoord * canvasSize, 0.0, 1.0).x, 2.0 ) - 1.0)
    * 2.0
//  * 2.0
    , 0.0
//  , 0.0
    , 1.0));
//  , 1.0));
    
    float comp      = smoothstep( 0.1, 0.9, sin(time) );
//  float comp      = smoothstep( 0.1, 0.9, sin(time) );
    fragColor =       vec4( col, 1.0            );
//  fragColor =       vec4( col, 1.0            );
    }

    // https://godotshaders.com/shader/crt-shader-2/
//  // https://godotshaders.com/shader/crt-shader-2/
