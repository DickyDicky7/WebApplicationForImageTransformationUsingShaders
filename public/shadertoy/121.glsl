#version 300 es
// #version 300 es
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

    // https://www.shadertoy.com/view/Wd3fzH
//  // https://www.shadertoy.com/view/Wd3fzH

#define pi 3.14159265359
// #define pi 3.14159265359

    mat2 get_rotation_matirx(float rot) {
//  mat2 get_rotation_matirx(float rot) {
    return mat2(
//  return mat2(
    cos(rot), -sin(rot),
//  cos(rot), -sin(rot),
    sin(rot),  cos(rot)
//  sin(rot),  cos(rot)
    );
//  );
    }
//  }

    vec2 rotate_uv(vec2 uv, vec2 iResolution, mat2 rotation) {
//  vec2 rotate_uv(vec2 uv, vec2 iResolution, mat2 rotation) {
    uv -= 0.5;
//  uv -= 0.5;
    uv.x = uv.x * iResolution.x / iResolution.y;
//  uv.x = uv.x * iResolution.x / iResolution.y;
    uv = rotation * uv;
//  uv = rotation * uv;
    uv.x = uv.x / iResolution.x * iResolution.y;
//  uv.x = uv.x / iResolution.x * iResolution.y;
    uv += 0.5;
//  uv += 0.5;
    uv =                               abs(uv);
//  uv =                               abs(uv);
    uv = step(1., uv) * 2. + sign(1.-uv) * uv ;
//  uv = step(1., uv) * 2. + sign(1.-uv) * uv ;
    return uv;
//  return uv;
    }
//  }

    /////////////////////////////////////
//  /////////////////////////////////////
    /////////////////////////////////////
//  /////////////////////////////////////


    uniform float          speed ; //  1.00
//  uniform float          speed ; //  1.00
    uniform float     side       ; //  0.19
//  uniform float     side       ; //  0.19
    uniform vec2      move       ; // -0.12, 0.1
//  uniform vec2      move       ; // -0.12, 0.1

    uniform float rotation_count ; //  1.00
//  uniform float rotation_count ; //  1.00
    uniform float     zoom_ratio ; //  2.00
//  uniform float     zoom_ratio ; //  2.00



    void main()
    {
    float remapTime = mod(speed * time, 2. * pi) - pi; remapTime *= step(0., remapTime);
//  float remapTime = mod(speed * time, 2. * pi) - pi; remapTime *= step(0., remapTime);
    
    ////////////////////////
//  ////////////////////////
    ///   Zoom formula   ///
//  ///   Zoom formula   ///
    ////////////////////////
//  ////////////////////////
    float zoom = zoom_ratio * sign(remapTime - pi / 2.) * ( 1.0 - abs(cos(remapTime)) );
//  float zoom = zoom_ratio * sign(remapTime - pi / 2.) * ( 1.0 - abs(cos(remapTime)) );
    
    //////////////////////////////
//  //////////////////////////////
    ///   Getting the center   ///
//  ///   Getting the center   ///
    //////////////////////////////
//  //////////////////////////////
    vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x ; vec2 center = side * round((uv + move) / side); center -= move; center.y = center.y * canvasSize.x / canvasSize.y;
//  vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x ; vec2 center = side * round((uv + move) / side); center -= move; center.y = center.y * canvasSize.x / canvasSize.y;
    uv = vTexCoord;
//  uv = vTexCoord;
    
    /////////////////////////////
//  /////////////////////////////
    ///   Applying the zoom   ///
//  ///   Applying the zoom   ///
    /////////////////////////////
//  /////////////////////////////
    uv -= zoom * (center - vec2(0.5, 0.5));
//  uv -= zoom * (center - vec2(0.5, 0.5));
    
    //////////////////
//  //////////////////
    ///   Mirror   ///
//  ///   Mirror   ///
    //////////////////
//  //////////////////
    uv =                                 abs(uv);
//  uv =                                 abs(uv);
    uv = step(1., uv) * 2. + sign(1. - uv) * uv ;
//  uv = step(1., uv) * 2. + sign(1. - uv) * uv ;
    
    
    ////////////////////
//  ////////////////////
    ///   Rotation   ///
//  ///   Rotation   ///
    ////////////////////
//  ////////////////////
    float rotation_ratio = 2. * rotation_count * pi; float rot = rotation_ratio * (-(cos(remapTime) - 1.) / 2.); mat2 rotation = get_rotation_matirx(rot); uv = rotate_uv(uv, canvasSize, rotation);
//  float rotation_ratio = 2. * rotation_count * pi; float rot = rotation_ratio * (-(cos(remapTime) - 1.) / 2.); mat2 rotation = get_rotation_matirx(rot); uv = rotate_uv(uv, canvasSize, rotation);
    
    
    ////////////////////////
//  ////////////////////////
    ///   Scene change   ///
//  ///   Scene change   ///
    ////////////////////////
//  ////////////////////////
    bool change_scene = int((speed * time + pi / 2.) / (2. * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb;
//  bool change_scene = int((speed * time + pi / 2.) / (2. * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb;

    
    //////////////////////////
//  //////////////////////////
    ///    Spining blur    ///
//  ///    Spining blur    ///
    //////////////////////////
//  //////////////////////////
    /*
//  /*
    float numSteps = float(int(15. * (-(cos(2. * time) - 1.) / 2.))); float sigma = 0.01; for (float i = 1.; i < numSteps; i++) { rotation = get_rotation_matirx(i * sigma); uv = rotate_uv(uv, canvasSize, rotation); col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.) col /= numSteps;
//  float numSteps = float(int(15. * (-(cos(2. * time) - 1.) / 2.))); float sigma = 0.01; for (float i = 1.; i < numSteps; i++) { rotation = get_rotation_matirx(i * sigma); uv = rotate_uv(uv, canvasSize, rotation); col += (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; } if (numSteps != 0.) col /= numSteps;
    */
//  */
    
    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }









