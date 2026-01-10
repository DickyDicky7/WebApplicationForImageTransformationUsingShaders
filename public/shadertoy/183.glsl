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

    // https://www.shadertoy.com/view/XXSfR3
//  // https://www.shadertoy.com/view/XXSfR3

    // Fork of "bad blur TryroT136" by TryroT136. https://shadertoy.com/view/lX2fRK
//  // Fork of "bad blur TryroT136" by TryroT136. https://shadertoy.com/view/lX2fRK
    // Fork of "bad blur TryroT136" by TryroT136. https://shadertoy.com/view/lX2fRK
//  // Fork of "bad blur TryroT136" by TryroT136. https://shadertoy.com/view/lX2fRK
    // 2024-10-23 23:29:46
//  // 2024-10-23 23:29:46
    // 2024-10-23 23:29:46
//  // 2024-10-23 23:29:46

    void main()
    {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord; vec2 upix =  1.0 / canvasSize.xy; vec3 average = vec3(0.0); float range = 2.0;
//  vec2 uv = vTexCoord; vec2 upix =  1.0 / canvasSize.xy; vec3 average = vec3(0.0); float range = 2.0;
    
    for (float i = -range; i <= range; i++) {
//  for (float i = -range; i <= range; i++) {
    for (float j = -range; j <= range; j++) {
//  for (float j = -range; j <= range; j++) {
    if (j != 0.0
//  if (j != 0.0
    &&  i != 0.0) {
//  &&  i != 0.0) {
    average += texture(tex0, uv + upix * vec2(j, i)).rgb;
//  average += texture(tex0, uv + upix * vec2(j, i)).rgb;
    }
//  }
    }
//  }
    }
//  }
    
    average /= pow(range * 2.0, 2.0) - 1.0; vec3 col = texture(tex0, uv).rgb; col -= average;
//  average /= pow(range * 2.0, 2.0) - 1.0; vec3 col = texture(tex0, uv).rgb; col -= average;
    
    if (col.r >=     (0.0)) {
//  if (col.r >=     (0.0)) {
    col    = vec3(1.0);
//  col    = vec3(1.0);
    } else                  {
//  } else                  {
    col    = vec3(0.0);
//  col    = vec3(0.0);
    }
//  }
    
    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }


