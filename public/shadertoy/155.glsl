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

    // https://www.shadertoy.com/view/3dGczK
//  // https://www.shadertoy.com/view/3dGczK

    #define pi 3.14159265359
//  #define pi 3.14159265359

    vec4 blend_with_center(vec2 center, vec2 uv, vec2 diff) {
//  vec4 blend_with_center(vec2 center, vec2 uv, vec2 diff) {
    vec2        centered_uv =
//  vec2        centered_uv =
    uv -
//  uv -
    center;
//  center;
    float      shift = 0.03       ;
//  float      shift = 0.03       ;
    vec3 col = vec3(
//  vec3 col = vec3(
    texture(tex0,      centered_uv                ).r,
//  texture(tex0,      centered_uv                ).r,
    texture(tex0, vec2(centered_uv.x
//  texture(tex0, vec2(centered_uv.x
    ,      centered_uv.y +      shift)).g,
//  ,      centered_uv.y +      shift)).g,
    texture(tex0, vec2(centered_uv.x
//  texture(tex0, vec2(centered_uv.x
    ,      centered_uv.y + 2. * shift)).b
//  ,      centered_uv.y + 2. * shift)).b
    );
//  );
    float            alpha = 1. - smoothstep(0., 0.4, length(centered_uv - diff));
//  float            alpha = 1. - smoothstep(0., 0.4, length(centered_uv - diff));
    return vec4(col, alpha);
//  return vec4(col, alpha);
    }
//  }


    void main()
    {
    ////////////////////
//  ////////////////////
    ///    Clones    ///
//  ///    Clones    ///
    ////////////////////
//  ////////////////////
    
    vec2 uv = vTexCoord; vec4 base = texture(tex0, uv);
//  vec2 uv = vTexCoord; vec4 base = texture(tex0, uv);
    
    vec4 col_1 = blend_with_center(vec2( 0.1, 0.), uv, vec2(0.75, 0.5));
//  vec4 col_1 = blend_with_center(vec2( 0.1, 0.), uv, vec2(0.75, 0.5));
    vec4 col_2 = blend_with_center(vec2(-0.1, 0.), uv, vec2(0.25, 0.5));
//  vec4 col_2 = blend_with_center(vec2(-0.1, 0.), uv, vec2(0.25, 0.5));
    
    float alpha_clone      = col_1.a +         col_2.a        ;
//  float alpha_clone      = col_1.a +         col_2.a        ;
    vec4        clone_col  = col_1.a * col_1 + col_2.a * col_2;
//  vec4        clone_col  = col_1.a * col_1 + col_2.a * col_2;
    clone_col /=
//  clone_col /=
    alpha_clone;
//  alpha_clone;
    if (  alpha_clone == 0.0  )
//  if (  alpha_clone == 0.0  )
    clone_col = vec4(1.);
//  clone_col = vec4(1.);
    alpha_clone =   (
//  alpha_clone =   (
    alpha_clone > 1.) ? 1.:
//  alpha_clone > 1.) ? 1.:
    alpha_clone ;
//  alpha_clone ;
    
    fragColor = mix(base , clone_col , alpha_clone);
//  fragColor = mix(base , clone_col , alpha_clone);
    //  fragColor = max(base , clone_col * alpha_clone);
//  //  fragColor = max(base , clone_col * alpha_clone);
    
    
    ///////////////////////////////////////
//  ///////////////////////////////////////
    ///    Overlaying with "plyonka"    ///
//  ///    Overlaying with "plyonka"    ///
    ///////////////////////////////////////
//  ///////////////////////////////////////
    
    vec2    new_pos                             ;
//  vec2    new_pos                             ;
    vec2    shift = vec2(15. / canvasSize.x, 0.);
//  vec2    shift = vec2(15. / canvasSize.x, 0.);
    
    if (uv.x < 0.5) {
//  if (uv.x < 0.5) {
    new_pos = vec2( uv.x             / 2., uv.y);
//  new_pos = vec2( uv.x             / 2., uv.y);
    //      new_pos = vec2((uv.x + 0.5 + 1.) / 2., uv.y);
//  //      new_pos = vec2((uv.x + 0.5 + 1.) / 2., uv.y);
    } else          {
//  } else          {
    new_pos = vec2((uv.x       + 1.) / 2., uv.y);
//  new_pos = vec2((uv.x       + 1.) / 2., uv.y);
    shift  *= -1.;
//  shift  *= -1.;
    //      new_pos = vec2((uv.x - 0.5     ) / 2., uv.y);
//  //      new_pos = vec2((uv.x - 0.5     ) / 2., uv.y);
    }
//  }
    
    vec4 overlay = vec4(
//  vec4 overlay = vec4(
    texture(tex0, new_pos             ).r,
//  texture(tex0, new_pos             ).r,
    texture(tex0, new_pos +      shift).g,
//  texture(tex0, new_pos +      shift).g,
    texture(tex0, new_pos + 2. * shift).b,
//  texture(tex0, new_pos + 2. * shift).b,
    1.
//  1.
    );
//  );
    
    fragColor = mix(fragColor, overlay, pow(2. * abs(uv.x - 0.5), 2.));
//  fragColor = mix(fragColor, overlay, pow(2. * abs(uv.x - 0.5), 2.));
    }
















