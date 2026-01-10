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

    // https://www.shadertoy.com/view/Wdyyzd
//  // https://www.shadertoy.com/view/Wdyyzd



    float rand (float n) { return fract(sin(n) * 43758.5453123); }
//  float rand (float n) { return fract(sin(n) * 43758.5453123); }

    float noise(float p) {
//  float noise(float p) {
    float fl = floor(p);
//  float fl = floor(p);
    float fc = fract(p);
//  float fc = fract(p);
    return mix(rand(fl), rand(fl + 1.0), fc);
//  return mix(rand(fl), rand(fl + 1.0), fc);
    }
//  }

    float blockyNoise(vec2 uv, float threshold, float scale, float seed)
//  float blockyNoise(vec2 uv, float threshold, float scale, float seed)
    {
//  {
    float scroll = floor(time + sin(11.0 *  time) + sin(time)) * 0.77; vec2 noiseUV = uv.yy / scale + scroll; float noise2 = texture(noise0, noiseUV).r; float id = floor(noise2 * 20.0); id = noise(id + seed) - 0.5; if (abs(id) > threshold) id = 0.0; return id;
//  float scroll = floor(time + sin(11.0 *  time) + sin(time)) * 0.77; vec2 noiseUV = uv.yy / scale + scroll; float noise2 = texture(noise0, noiseUV).r; float id = floor(noise2 * 20.0); id = noise(id + seed) - 0.5; if (abs(id) > threshold) id = 0.0; return id;
    }
//  }


    void main()
    {
    
    float       rgbIntesnsity = 0.10 + 0.1 *    (sin(time * 3.7)     );
//  float       rgbIntesnsity = 0.10 + 0.1 *    (sin(time * 3.7)     );
    float displacedIntesnsity = 0.20 + 0.3 * pow(sin(time * 1.2), 5.0);
//  float displacedIntesnsity = 0.20 + 0.3 * pow(sin(time * 1.2), 5.0);
    float interlaceIntesnsity = 0.01;
//  float interlaceIntesnsity = 0.01;
    float    dropoutIntensity = 0.10;
//  float    dropoutIntensity = 0.10;

    
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;

    float displace  = blockyNoise(uv    + vec2(uv.y, 00.0), displacedIntesnsity, 025.0, 66.6);
//  float displace  = blockyNoise(uv    + vec2(uv.y, 00.0), displacedIntesnsity, 025.0, 66.6);
    displace *= blockyNoise(uv.yx + vec2(00.0, uv.x), displacedIntesnsity, 111.0, 13.7);
//  displace *= blockyNoise(uv.yx + vec2(00.0, uv.x), displacedIntesnsity, 111.0, 13.7);
    
    uv.x += displace;
//  uv.x += displace;
    
    vec2 offs = 0.1 * vec2(blockyNoise(uv.xy + vec2(uv.y, 0.0), rgbIntesnsity, 65.0, 341.0), 0.0);
//  vec2 offs = 0.1 * vec2(blockyNoise(uv.xy + vec2(uv.y, 0.0), rgbIntesnsity, 65.0, 341.0), 0.0);
    
    float colr = texture(tex0, uv - offs).r;
//  float colr = texture(tex0, uv - offs).r;
    float colg = texture(tex0, uv       ).g;
//  float colg = texture(tex0, uv       ).g;
    float colb = texture(tex0, uv + offs).b;
//  float colb = texture(tex0, uv + offs).b;

    
    float   line = fract(vec4(vTexCoord * canvasSize, 0.0, 1.0).y / 3.0);
//  float   line = fract(vec4(vTexCoord * canvasSize, 0.0, 1.0).y / 3.0);
    vec3    mask = vec3(3.0, 0.0, 0.0);
//  vec3    mask = vec3(3.0, 0.0, 0.0);
    if (line > 0.333)
//  if (line > 0.333)
    mask = vec3(0.0, 3.0, 0.0);
//  mask = vec3(0.0, 3.0, 0.0);
    if (line > 0.666)
//  if (line > 0.666)
    mask = vec3(0.0, 0.0, 3.0);
//  mask = vec3(0.0, 0.0, 3.0);
    
    
    float maskNoise = blockyNoise(uv, interlaceIntesnsity, 90.0, time) * max(displace, offs.x);
//  float maskNoise = blockyNoise(uv, interlaceIntesnsity, 90.0, time) * max(displace, offs.x);
    
    maskNoise = 1.0 - maskNoise; if (maskNoise == 1.0) mask = vec3(1.0);
//  maskNoise = 1.0 - maskNoise; if (maskNoise == 1.0) mask = vec3(1.0);
    
    float dropout = blockyNoise(uv   , dropoutIntensity, 11.0, time)
//  float dropout = blockyNoise(uv   , dropoutIntensity, 11.0, time)
    * blockyNoise(uv.yx, dropoutIntensity, 90.0, time);
//  * blockyNoise(uv.yx, dropoutIntensity, 90.0, time);
    mask *= (1.0 - 5.0 * dropout);
//  mask *= (1.0 - 5.0 * dropout);
    
    
    fragColor = vec4(mask * vec3(colr, colg, colb), 1.0);
//  fragColor = vec4(mask * vec3(colr, colg, colb), 1.0);
    }
