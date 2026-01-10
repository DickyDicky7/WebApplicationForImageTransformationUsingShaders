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

    // https://www.shadertoy.com/view/3dcfDH
//  // https://www.shadertoy.com/view/3dcfDH

    #define pi 3.14159265359
//  #define pi 3.14159265359


    float planeIntersection(vec3 N, vec3 V,vec3 pos) { float distToPlane = -dot(pos, N); float rayDotPlane = -dot(V, N); if (rayDotPlane > 0. && distToPlane > 0.) return distToPlane / rayDotPlane; else return 0.; }
//  float planeIntersection(vec3 N, vec3 V,vec3 pos) { float distToPlane = -dot(pos, N); float rayDotPlane = -dot(V, N); if (rayDotPlane > 0. && distToPlane > 0.) return distToPlane / rayDotPlane; else return 0.; }

    vec2 getUV(vec3 perpX, vec3 perpY, vec3 pos) { return vec2(dot(perpX, pos), dot(perpY, pos)); }
//  vec2 getUV(vec3 perpX, vec3 perpY, vec3 pos) { return vec2(dot(perpX, pos), dot(perpY, pos)); }

    vec3 planeColor(vec2 uv, bool change_scene) { float aspect = canvasSize.x / canvasSize.y; uv = (0.5 / aspect) * uv + vec2(0.5, 0.5 / aspect); uv.y *= canvasSize.x / canvasSize.y; return (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; }
//  vec3 planeColor(vec2 uv, bool change_scene) { float aspect = canvasSize.x / canvasSize.y; uv = (0.5 / aspect) * uv + vec2(0.5, 0.5 / aspect); uv.y *= canvasSize.x / canvasSize.y; return (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; }

    vec4 boxColor(vec3 viewingNormal,
//  vec4 boxColor(vec3 viewingNormal,
    vec3        boxPos,
//  vec3        boxPos,
    vec3        planeX,
//  vec3        planeX,
    vec3        planeY,
//  vec3        planeY,
    vec3        planeZ,
//  vec3        planeZ,
    bool change_scene) { for (int i = 0; i < 2; ++i) {
//  bool change_scene) { for (int i = 0; i < 2; ++i) {
    vec3 planePos = boxPos + planeZ; float t = planeIntersection(planeZ, viewingNormal, planePos); vec2 uv; if (t > 0.) { vec3 pos = t * viewingNormal; uv = getUV(planeX, planeY, pos - planePos); if (uv.x < length(planeX) && uv.x > -length(planeX) && uv.y < length(planeY) && uv.y > -length(planeY)) { return vec4(planeColor(uv, change_scene), t); } }
//  vec3 planePos = boxPos + planeZ; float t = planeIntersection(planeZ, viewingNormal, planePos); vec2 uv; if (t > 0.) { vec3 pos = t * viewingNormal; uv = getUV(planeX, planeY, pos - planePos); if (uv.x < length(planeX) && uv.x > -length(planeX) && uv.y < length(planeY) && uv.y > -length(planeY)) { return vec4(planeColor(uv, change_scene), t); } }
    planePos = boxPos + planeX;       t = planeIntersection(planeX, viewingNormal, planePos);          if (t > 0.) { vec3 pos = t * viewingNormal; uv = getUV(planeZ, planeY, pos - planePos); if (uv.x < length(planeZ) && uv.x > -length(planeZ) && uv.y < length(planeY) && uv.y > -length(planeY)) { return vec4(planeColor(uv, change_scene), t); } }
//  planePos = boxPos + planeX;       t = planeIntersection(planeX, viewingNormal, planePos);          if (t > 0.) { vec3 pos = t * viewingNormal; uv = getUV(planeZ, planeY, pos - planePos); if (uv.x < length(planeZ) && uv.x > -length(planeZ) && uv.y < length(planeY) && uv.y > -length(planeY)) { return vec4(planeColor(uv, change_scene), t); } }
    planePos = boxPos + planeY;       t = planeIntersection(planeY, viewingNormal, planePos);          if (t > 0.) { vec3 pos = t * viewingNormal; uv = getUV(planeX, planeZ, pos - planePos); if (uv.x < length(planeZ) && uv.x > -length(planeZ) && uv.y < length(planeX) && uv.y > -length(planeX)) { return vec4(planeColor(uv, change_scene), t); } }
//  planePos = boxPos + planeY;       t = planeIntersection(planeY, viewingNormal, planePos);          if (t > 0.) { vec3 pos = t * viewingNormal; uv = getUV(planeX, planeZ, pos - planePos); if (uv.x < length(planeZ) && uv.x > -length(planeZ) && uv.y < length(planeX) && uv.y > -length(planeX)) { return vec4(planeColor(uv, change_scene), t); } }

    planeX *= -1.;
//  planeX *= -1.;
    planeY *= -1.;
//  planeY *= -1.;
    planeZ *= -1.;
//  planeZ *= -1.;
    }
//  }
    return vec4(0);
//  return vec4(0);
    }
//  }


    uniform float          speed ; // 00.7
//  uniform float          speed ; // 00.7
    uniform float   farthest_pos ; // 25.0
//  uniform float   farthest_pos ; // 25.0
    uniform float    closest_pos ; // 05.0
//  uniform float    closest_pos ; // 05.0
    uniform float rotation_speed ; // 03.0
//  uniform float rotation_speed ; // 03.0
    uniform float    speed_power ; // 03.0
//  uniform float    speed_power ; // 03.0


    void main()
    {
    ///////////////////////////////
//  ///////////////////////////////
    ///   Scene change params   ///
//  ///   Scene change params   ///
    ///////////////////////////////
//  ///////////////////////////////
    bool change_scene = int((speed * time + 0.5) / 2.) % 2 == 0; float ratio = mod(speed * time, 2.) - 1.; ratio *= step(0., ratio);
//  bool change_scene = int((speed * time + 0.5) / 2.) % 2 == 0; float ratio = mod(speed * time, 2.) - 1.; ratio *= step(0., ratio);
    
    
    ////////////////////////////
//  ////////////////////////////
    ///   Background color   ///
//  ///   Background color   ///
    ////////////////////////////
//  ////////////////////////////
    vec2 uv = vTexCoord; vec3 col = (change_scene) ? texture(tex0, uv).rgb  : texture(uploadTex0, uv).rgb; fragColor = vec4(col, 1); if (ratio <= 0.) { return; }
//  vec2 uv = vTexCoord; vec3 col = (change_scene) ? texture(tex0, uv).rgb  : texture(uploadTex0, uv).rgb; fragColor = vec4(col, 1); if (ratio <= 0.) { return; }
    
    ///////////////////////
//  ///////////////////////
    ///   Cube params   ///
//  ///   Cube params   ///
    ///////////////////////
//  ///////////////////////
    uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x; float aspect = canvasSize.x / canvasSize.y; vec3 viewingNormal = normalize(vec3(uv - vec2(0.5, 0.5 / aspect), 1)); vec3 boxPos = vec3(0, 0, mix(closest_pos, farthest_pos, pow((ratio - 0.5) * 2., speed_power)));
//  uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x; float aspect = canvasSize.x / canvasSize.y; vec3 viewingNormal = normalize(vec3(uv - vec2(0.5, 0.5 / aspect), 1)); vec3 boxPos = vec3(0, 0, mix(closest_pos, farthest_pos, pow((ratio - 0.5) * 2., speed_power)));
    
    
    ///////////////////////////
//  ///////////////////////////
    ///   Rotation params   ///
//  ///   Rotation params   ///
    ///////////////////////////
//  ///////////////////////////
    vec3 planeZ = normalize( vec3 (
//  vec3 planeZ = normalize( vec3 (
    sin(rotation_speed * time),
//  sin(rotation_speed * time),
    sin(rotation_speed * time),
//  sin(rotation_speed * time),
    cos(rotation_speed * time)
//  cos(rotation_speed * time)
    ));
//  ));
    vec3 planeX = normalize(cross(planeZ, vec3(1,0,0)));
//  vec3 planeX = normalize(cross(planeZ, vec3(1,0,0)));
    vec3 planeY = normalize(cross(planeZ
//  vec3 planeY = normalize(cross(planeZ
    ,                 planeX             ));
//  ,                 planeX             ));
    
    
    ////////////////////////////////
//  ////////////////////////////////
    ///   Actual cube function   ///
//  ///   Actual cube function   ///
    ////////////////////////////////
//  ////////////////////////////////
    vec4 boxCol = boxColor(viewingNormal
//  vec4 boxCol = boxColor(viewingNormal
    ,                 boxPos
//  ,                 boxPos
    ,                 planeX
//  ,                 planeX
    ,                 planeY
//  ,                 planeY
    ,                 planeZ
//  ,                 planeZ
    ,          change_scene);
//  ,          change_scene);
    
    
    //////////////////////////////////////
//  //////////////////////////////////////
    ///   Mixing with the background   ///
//  ///   Mixing with the background   ///
    //////////////////////////////////////
//  //////////////////////////////////////
    col = mix(col, boxCol.rgb, step(0.5, boxCol.a)); fragColor = vec4(col, 1);
//  col = mix(col, boxCol.rgb, step(0.5, boxCol.a)); fragColor = vec4(col, 1);
    }
















