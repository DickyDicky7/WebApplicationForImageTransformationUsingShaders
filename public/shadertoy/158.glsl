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

    // https://www.shadertoy.com/view/WsKcz1
//  // https://www.shadertoy.com/view/WsKcz1

#define pi 3.14159265359
// #define pi 3.14159265359

    vec4 blend_with_center(vec2 center, vec2 uv, vec2 diff) { vec2 centered_uv = uv - center; float shift = 0.03f; vec3 col = vec3(texture(tex0, centered_uv).r, texture(tex0, vec2(centered_uv.x, centered_uv.y + shift)).g, texture(tex0, vec2(centered_uv.x, centered_uv.y + 2.f * shift)).b); float alpha = 1.f - smoothstep(0.f, 0.3f, length(centered_uv - diff)); return vec4(col, alpha); }
//  vec4 blend_with_center(vec2 center, vec2 uv, vec2 diff) { vec2 centered_uv = uv - center; float shift = 0.03f; vec3 col = vec3(texture(tex0, centered_uv).r, texture(tex0, vec2(centered_uv.x, centered_uv.y + shift)).g, texture(tex0, vec2(centered_uv.x, centered_uv.y + 2.f * shift)).b); float alpha = 1.f - smoothstep(0.f, 0.3f, length(centered_uv - diff)); return vec4(col, alpha); }

    // Position of each reflection
//  // Position of each reflection
    // Position of each reflection
//  // Position of each reflection
    /*
//  /*
    vec2 centers[8] = vec2[](
//  vec2 centers[8] = vec2[](
    vec2( 0.40, 0.00), vec2(-0.40,  0.00),
//  vec2( 0.40, 0.00), vec2(-0.40,  0.00),
    vec2( 0.00, 0.50), vec2( 0.00, -0.50),
//  vec2( 0.00, 0.50), vec2( 0.00, -0.50),
    vec2( 0.25, 0.30), vec2( 0.25, -0.30),
//  vec2( 0.25, 0.30), vec2( 0.25, -0.30),
    vec2(-0.25, 0.30), vec2(-0.25, -0.30)
//  vec2(-0.25, 0.30), vec2(-0.25, -0.30)
    );
//  );
    */
//  */

    // Center of each reflection
//  // Center of each reflection
    // Center of each reflection
//  // Center of each reflection
    // something around vec2(0.5, 0.5)
//  // something around vec2(0.5, 0.5)
    // something around vec2(0.5, 0.5)
//  // something around vec2(0.5, 0.5)

    vec2 diff[8] = vec2[](
//  vec2 diff[8] = vec2[](
    vec2( 0.55,  0.60), vec2( 0.50,  0.40),
//  vec2( 0.55,  0.60), vec2( 0.50,  0.40),
    vec2( 0.40,  0.55), vec2( 0.60,  0.60),
//  vec2( 0.40,  0.55), vec2( 0.60,  0.60),
    vec2( 0.50,  0.50), vec2( 0.55,  0.45),
//  vec2( 0.50,  0.50), vec2( 0.55,  0.45),
    vec2( 0.40,  0.60), vec2( 0.50,  0.40)
//  vec2( 0.40,  0.60), vec2( 0.50,  0.40)
    );
//  );


    void main()
    {
    ///////////////////////////
//  ///////////////////////////
    
    float speed  = 1.0           ;
//  float speed  = 1.0           ;
    float alpha  = 2.0 * pi / 8.0;
//  float alpha  = 2.0 * pi / 8.0;
    float radius = 0.4           ;
//  float radius = 0.4           ;
    
    ///////////////////////////
//  ///////////////////////////
    
    vec2 centers[8] = vec2[](
//  vec2 centers[8] = vec2[](
    vec2(radius*cos(0. * alpha+speed*time) ,
//  vec2(radius*cos(0. * alpha+speed*time) ,
    radius*sin(0. * alpha+speed*time)),
//  radius*sin(0. * alpha+speed*time)),
    vec2(radius*cos(1. * alpha+speed*time) ,
//  vec2(radius*cos(1. * alpha+speed*time) ,
    radius*sin(1. * alpha+speed*time)),
//  radius*sin(1. * alpha+speed*time)),
    vec2(radius*cos(2. * alpha+speed*time) ,
//  vec2(radius*cos(2. * alpha+speed*time) ,
    radius*sin(2. * alpha+speed*time)),
//  radius*sin(2. * alpha+speed*time)),
    vec2(radius*cos(3. * alpha+speed*time) ,
//  vec2(radius*cos(3. * alpha+speed*time) ,
    radius*sin(3. * alpha+speed*time)),
//  radius*sin(3. * alpha+speed*time)),
    vec2(radius*cos(4. * alpha+speed*time) ,
//  vec2(radius*cos(4. * alpha+speed*time) ,
    radius*sin(4. * alpha+speed*time)),
//  radius*sin(4. * alpha+speed*time)),
    vec2(radius*cos(5. * alpha+speed*time) ,
//  vec2(radius*cos(5. * alpha+speed*time) ,
    radius*sin(5. * alpha+speed*time)),
//  radius*sin(5. * alpha+speed*time)),
    vec2(radius*cos(6. * alpha+speed*time) ,
//  vec2(radius*cos(6. * alpha+speed*time) ,
    radius*sin(6. * alpha+speed*time)),
//  radius*sin(6. * alpha+speed*time)),
    vec2(radius*cos(7. * alpha+speed*time) ,
//  vec2(radius*cos(7. * alpha+speed*time) ,
    radius*sin(7. * alpha+speed*time))
//  radius*sin(7. * alpha+speed*time))
    );
//  );
    
    
    ////////////////////
//  ////////////////////
    ///    Clones    ///
//  ///    Clones    ///
    ////////////////////
//  ////////////////////
    
    vec2 uv = vTexCoord; vec4 base = texture(tex0, uv);
//  vec2 uv = vTexCoord; vec4 base = texture(tex0, uv);
    
    ////////////////
//  ////////////////
    ////////////////
//  ////////////////
    
    float count = 8.;
//  float count = 8.;
    
    ////////////////
//  ////////////////
    ////////////////
//  ////////////////
    
    vec4 final_col = vec4(0.f); float sum_alpha = 0.f; for (float i = 0.f; i < count; ++i) { vec4 col = blend_with_center(centers[int(i)], uv, diff[int(i)]); final_col += col.a * col; sum_alpha += col.a; } final_col /= sum_alpha; if (sum_alpha == 0.f) final_col = vec4(0.5f); sum_alpha = (sum_alpha > 1.f) ? 1.f : sum_alpha;
//  vec4 final_col = vec4(0.f); float sum_alpha = 0.f; for (float i = 0.f; i < count; ++i) { vec4 col = blend_with_center(centers[int(i)], uv, diff[int(i)]); final_col += col.a * col; sum_alpha += col.a; } final_col /= sum_alpha; if (sum_alpha == 0.f) final_col = vec4(0.5f); sum_alpha = (sum_alpha > 1.f) ? 1.f : sum_alpha;

    fragColor = mix(base, final_col , sum_alpha);
//  fragColor = mix(base, final_col , sum_alpha);
    //  fragColor = max(base, final_col * sum_alpha);
//  //  fragColor = max(base, final_col * sum_alpha);
    
    
    ///////////////////////////////////////
//  ///////////////////////////////////////
    ///    Overlaying with "plyonka"    ///
//  ///    Overlaying with "plyonka"    ///
    ///////////////////////////////////////
//  ///////////////////////////////////////
    
    vec2 new_pos; vec2 shift = vec2(15.f / canvasSize.x, 0.f);
//  vec2 new_pos; vec2 shift = vec2(15.f / canvasSize.x, 0.f);

    if (uv.x < 0.5f) {
//  if (uv.x < 0.5f) {
    new_pos = vec2( uv.x             / 2.f, uv.y);
//  new_pos = vec2( uv.x             / 2.f, uv.y);
    //      new_pos = vec2((uv.x + 0.5 + 1.) / 2.f, uv.y);
//  //      new_pos = vec2((uv.x + 0.5 + 1.) / 2.f, uv.y);
    } else           {
//  } else           {
    new_pos = vec2((uv.x + 1.f     ) / 2.f, uv.y);
//  new_pos = vec2((uv.x + 1.f     ) / 2.f, uv.y);
    shift  *= -1.f;
//  shift  *= -1.f;
    //      new_pos = vec2((uv.x - 0.5     ) / 2.f, uv.y);
//  //      new_pos = vec2((uv.x - 0.5     ) / 2.f, uv.y);
    }
//  }

    vec4 overlay = vec4(texture(tex0, new_pos              ).r
//  vec4 overlay = vec4(texture(tex0, new_pos              ).r
    ,      texture(tex0, new_pos +       shift).g
//  ,      texture(tex0, new_pos +       shift).g
    ,      texture(tex0, new_pos + 2.f * shift).b, 1.f);
//  ,      texture(tex0, new_pos + 2.f * shift).b, 1.f);

    fragColor = mix(fragColor, overlay, pow(2.f * abs(uv.x - 0.5f), 2.f));
//  fragColor = mix(fragColor, overlay, pow(2.f * abs(uv.x - 0.5f), 2.f));
    }












