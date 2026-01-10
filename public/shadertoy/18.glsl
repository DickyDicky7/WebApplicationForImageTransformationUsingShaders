#version 300 es
// #version 300 es
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

    vec4 sca(sampler2D tex, vec2 uv, float width)
//  vec4 sca(sampler2D tex, vec2 uv, float width)
    {
//  {
    vec3 acc = vec3(0.0);
//  vec3 acc = vec3(0.0);
    
    const float delta = 0.04;
//  const float delta = 0.04;
    const float range = acos(-1.0);
//  const float range = acos(-1.0);
    const float  spec =           2.0 * range / 3.0;
//  const float  spec =           2.0 * range / 3.0;
    
    for(float i  =  - 1.0;
//  for(float i  =  - 1.0;
    i <=    1.0;
//  i <=    1.0;
    i +=  delta)
//  i +=  delta)
    {
//  {
    vec3   mask = 0.5 + 0.5 * cos(range * i + vec3(-spec, 0.0, spec));
//  vec3   mask = 0.5 + 0.5 * cos(range * i + vec3(-spec, 0.0, spec));
    acc += mask *                                                    texture(tex, uv - vec2(width * i, 0.0)).rgb;
//  acc += mask *                                                    texture(tex, uv - vec2(width * i, 0.0)).rgb;
    }
//  }
    
    return vec4(delta * acc, 0.0);
//  return vec4(delta * acc, 0.0);
    }
//  }

    void main()
    {
    vec2      uv =    vTexCoord                 ;
//  vec2      uv =    vTexCoord                 ;
    fragColor = sca(tex0, uv, 0.1 * uv.x * uv.x);
//  fragColor = sca(tex0, uv, 0.1 * uv.x * uv.x);
    }




    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/ltcyRf
//  // https://www.shadertoy.com/view/ltcyRf
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@









