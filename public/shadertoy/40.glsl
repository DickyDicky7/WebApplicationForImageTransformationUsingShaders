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

    void applyDistortion(inout vec2 uv, vec2 pos, float power) {
//  void applyDistortion(inout vec2 uv, vec2 pos, float power) {
    float noiseX = texture(noise0 , pos.xy  / 0768.0 + vec2(time * 0.01)).x;
//  float noiseX = texture(noise0 , pos.xy  / 0768.0 + vec2(time * 0.01)).x;
    float noiseY = texture(noise0 , pos.xy  / 4096.0 + vec2(time * 0.01)).x;
//  float noiseY = texture(noise0 , pos.xy  / 4096.0 + vec2(time * 0.01)).x;
    uv += vec2((noiseX - 0.5) * power
//  uv += vec2((noiseX - 0.5) * power
    ,      (noiseY - 0.5) * power);
//  ,      (noiseY - 0.5) * power);
    }
//  }

    void applyGray(inout vec3 color, float   gray) {
//  void applyGray(inout vec3 color, float   gray) {
    float g = dot(color.rgb, vec3(0.299, 0.587, 0.114));
//  float g = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    color   = mix(color    , vec3(g)   , gray)         ;
//  color   = mix(color    , vec3(g)   , gray)         ;
    }
//  }

    vec4 getColorAt(vec2 pos, vec2 fragCoord) {
//  vec4 getColorAt(vec2 pos, vec2 fragCoord) {
    vec2 uv = vec2(pos);
//  vec2 uv = vec2(pos);
    applyDistortion(uv, fragCoord, 0.008);
//  applyDistortion(uv, fragCoord, 0.008);
    vec4 color = texture(tex0, uv);
//  vec4 color = texture(tex0, uv);
    applyGray(color.rgb, abs(sin(time)));
//  applyGray(color.rgb, abs(sin(time)));
    return color;
//  return color;
    }
//  }

    float impulse(float k, float x) {
//  float impulse(float k, float x) {
    float  h =      k  *     x ;
//  float  h =      k  *     x ;
    return h * exp(1.0 -     h);
//  return h * exp(1.0 -     h);
    }
//  }

    void main(void) {
    vec2 uv    = vTexCoord ;
//  vec2 uv    = vTexCoord ;
    vec4 color = getColorAt(  uv , vec4(vTexCoord * canvasSize, 0.0, 1.0).xy);
//  vec4 color = getColorAt(  uv , vec4(vTexCoord * canvasSize, 0.0, 1.0).xy);
    
    // Some kind of random chromatic aberration
//  // Some kind of random chromatic aberration
    // Some kind of random chromatic aberration
//  // Some kind of random chromatic aberration
    float abbPower = 0.01 * sin(time) * sin(uv.y * time * 10.0);
//  float abbPower = 0.01 * sin(time) * sin(uv.y * time * 10.0);
    color.r = getColorAt(uv - vec2(abbPower, 0.0), vec4(vTexCoord * canvasSize, 0.0, 1.0).xy).r;
//  color.r = getColorAt(uv - vec2(abbPower, 0.0), vec4(vTexCoord * canvasSize, 0.0, 1.0).xy).r;
    color.b = getColorAt(uv + vec2(abbPower, 0.0), vec4(vTexCoord * canvasSize, 0.0, 1.0).xy).b;
//  color.b = getColorAt(uv + vec2(abbPower, 0.0), vec4(vTexCoord * canvasSize, 0.0, 1.0).xy).b;
    
    fragColor =  color  ;
//  fragColor =  color  ;
    }




    // https://www.shadertoy.com/view/4sjfzt
//  // https://www.shadertoy.com/view/4sjfzt
