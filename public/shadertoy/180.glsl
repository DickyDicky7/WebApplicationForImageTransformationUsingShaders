    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    uniform         sampler2D    uploadTex0; // null
//  uniform         sampler2D    uploadTex0; // null
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

    // https://www.shadertoy.com/view/4fdBD2
//  // https://www.shadertoy.com/view/4fdBD2

    void main()
    {
    vec2  uv      = vTexCoord;
//  vec2  uv      = vTexCoord;
    vec2    range = vec2(1.25
//  vec2    range = vec2(1.25
    ,      1.75
//  ,      1.75
    )    ;
//  )    ;
    float seed =              float(int(vec4(vTexCoord * canvasSize, 0.0, 1.0).x / 4.0)) * 1938.9231712300;
//  float seed =              float(int(vec4(vTexCoord * canvasSize, 0.0, 1.0).x / 4.0)) * 1938.9231712300;
    float seconds = range.x + fract(sin(   seed              ) * 1937.3781371839)
//  float seconds = range.x + fract(sin(   seed              ) * 1937.3781371839)
    *(range.y -
//  *(range.y -
    range.x
//  range.x
    );
//  );
    
    float t = mod(time,range.y*1.25);
//  float t = mod(time,range.y*1.25);
    
    float                      speed = 1.0 / seconds;
//  float                      speed = 1.0 / seconds;
    float   offset = clamp(t * speed , 0.0 , 1.0   );
//  float   offset = clamp(t * speed , 0.0 , 1.0   );
    uv.y -= offset                                  ;
//  uv.y -= offset                                  ;

    vec3 col = texture(tex0, uv).xyz;
//  vec3 col = texture(tex0, uv).xyz;
    
    if (uv.y < 0.0) {
//  if (uv.y < 0.0) {
        
    uv = vec2(uv.x, mod(uv.y, 1.0));
//  uv = vec2(uv.x, mod(uv.y, 1.0));
       
    if (uv.y <  0.0)  {
//  if (uv.y <  0.0)  {
    uv.y += offset;
//  uv.y += offset;
    }
//  }
       
       
    col = texture(uploadTex0, uv).xyz;
//  col = texture(uploadTex0, uv).xyz;
    }
//  }
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }








