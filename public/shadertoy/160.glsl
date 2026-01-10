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

    // https://www.shadertoy.com/view/wsGczt
//  // https://www.shadertoy.com/view/wsGczt

    uniform float perspective    ; // 0.3
//  uniform float perspective    ; // 0.3
    uniform int   samples        ; // 25
//  uniform int   samples        ; // 25
    uniform float minBlur        ; // 0.0
//  uniform float minBlur        ; // 0.0
    uniform float maxBlur        ; // 0.3
//  uniform float maxBlur        ; // 0.3
    //const float          speed ; // 3.0
//  //const float          speed ; // 3.0
    uniform float          speed ; // 4.0
//  uniform float          speed ; // 4.0
    uniform float rotation_ratio ; // 0.1
//  uniform float rotation_ratio ; // 0.1
    uniform float     zoom_ratio ; // 0.2
//  uniform float     zoom_ratio ; // 0.2

    void main()
    {

    
    /////////////////////////
//  /////////////////////////
    
    float alpha = smoothstep(0.0, 1.0, pow(sin(speed * time) / 2.0, 2.0) * 4.0);
//  float alpha = smoothstep(0.0, 1.0, pow(sin(speed * time) / 2.0, 2.0) * 4.0);
    //  rotation_ratio *= alpha;
//  //  rotation_ratio *= alpha;
    //  rotation_ratio *= alpha;
//  //  rotation_ratio *= alpha;
    
    /////////////////////////
//  /////////////////////////
    
    float timeQ = mix(minBlur, maxBlur, alpha);
//  float timeQ = mix(minBlur, maxBlur, alpha);
        
    float rot = rotation_ratio * sin(speed * time); // pi / 20.0;
//  float rot = rotation_ratio * sin(speed * time); // pi / 20.0;
    mat2 rotation = mat2(
//  mat2 rotation = mat2(
    cos(rot), -sin(rot)
//  cos(rot), -sin(rot)
    ,   sin(rot),  cos(rot)
//  ,   sin(rot),  cos(rot)
    );
//  );
    
    vec2 uv = vTexCoord - 0.5; uv.x = uv.x * canvasSize.x / canvasSize.y; uv = rotation * uv; uv *= 1.0 - alpha * zoom_ratio; uv.x = uv.x / canvasSize.x * canvasSize.y; uv += 0.5;
//  vec2 uv = vTexCoord - 0.5; uv.x = uv.x * canvasSize.x / canvasSize.y; uv = rotation * uv; uv *= 1.0 - alpha * zoom_ratio; uv.x = uv.x / canvasSize.x * canvasSize.y; uv += 0.5;
    
    ////////////////////////
//  ////////////////////////
    ////////////////////////
//  ////////////////////////
    
    
    vec4 result = vec4(0);
//  vec4 result = vec4(0);
    
    for (int i = 0; i <= samples; i++)
//  for (int i = 0; i <= samples; i++)
    {
//  {
    float q = float(i) / float(samples); result += texture(tex0, uv + (vec2(0.5) - uv) * q * timeQ) / float(samples);
//  float q = float(i) / float(samples); result += texture(tex0, uv + (vec2(0.5) - uv) * q * timeQ) / float(samples);
    }
//  }

    if (alpha > 0.75) result = vec4(vec3(1.0 - result.rgb), result.a);
//  if (alpha > 0.75) result = vec4(vec3(1.0 - result.rgb), result.a);
    
    fragColor = result;
//  fragColor = result;
    }












