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

    // https://www.shadertoy.com/view/tddfRX
//  // https://www.shadertoy.com/view/tddfRX

#define pi 3.14159265359
// #define pi 3.14159265359


    float planeIntersection(vec3 N, vec3 V, vec3 pos) { float distToPlane = -dot(pos, N); float rayDotPlane = -dot(V, N); if (rayDotPlane > 0. && distToPlane > 0.) return distToPlane / rayDotPlane; else return 0.; }
//  float planeIntersection(vec3 N, vec3 V, vec3 pos) { float distToPlane = -dot(pos, N); float rayDotPlane = -dot(V, N); if (rayDotPlane > 0. && distToPlane > 0.) return distToPlane / rayDotPlane; else return 0.; }

    vec2 getUV(vec3 perpX, vec3 perpY, vec3 pos) { return vec2(dot(perpX, pos), dot(perpY, pos)); }
//  vec2 getUV(vec3 perpX, vec3 perpY, vec3 pos) { return vec2(dot(perpX, pos), dot(perpY, pos)); }

    vec3 planeColor(vec2 uv, bool reverse, bool change_scene) { float aspect = canvasSize.x / canvasSize.y; uv = (0.5f / aspect) * uv + vec2(0.5f, 0.5f / aspect); uv.y *= canvasSize.x / canvasSize.y; if(reverse) uv.y = 1.f - uv.y; return (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; }
//  vec3 planeColor(vec2 uv, bool reverse, bool change_scene) { float aspect = canvasSize.x / canvasSize.y; uv = (0.5f / aspect) * uv + vec2(0.5f, 0.5f / aspect); uv.y *= canvasSize.x / canvasSize.y; if(reverse) uv.y = 1.f - uv.y; return (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; }

    float sdfStar5(in vec2 p) { /* repeat domain 5x */ const vec2 k1 = vec2(0.809016994375f, -0.587785252292f); /* pi/5 */ const vec2 k2 = vec2(-k1.x, k1.y); p.x = abs(p.x); p -= 2.0f * max(dot(k1, p), 0.0f) * k1; p -= 2.0f * max(dot(k2, p), 0.0f) * k2; /* draw triangle */ const vec2 k3 = vec2(0.951056516295f, 0.309016994375f); /* pi/10 */ return dot(vec2(abs(p.x) - 0.3f, p.y), k3); }
//  float sdfStar5(in vec2 p) { /* repeat domain 5x */ const vec2 k1 = vec2(0.809016994375f, -0.587785252292f); /* pi/5 */ const vec2 k2 = vec2(-k1.x, k1.y); p.x = abs(p.x); p -= 2.0f * max(dot(k1, p), 0.0f) * k1; p -= 2.0f * max(dot(k2, p), 0.0f) * k2; /* draw triangle */ const vec2 k3 = vec2(0.951056516295f, 0.309016994375f); /* pi/10 */ return dot(vec2(abs(p.x) - 0.3f, p.y), k3); }

    bool check_if_inside(vec2 uv, float one, float _sign) { uv *= _sign; float limit = one - sdfStar5(uv); return limit > one; }
//  bool check_if_inside(vec2 uv, float one, float _sign) { uv *= _sign; float limit = one - sdfStar5(uv); return limit > one; }

    vec4 boxColor(vec3 viewingNormal, vec3 boxPos, vec3 planeX, vec3 planeY, vec3 planeZ, bool change_scene) {
//  vec4 boxColor(vec3 viewingNormal, vec3 boxPos, vec3 planeX, vec3 planeY, vec3 planeZ, bool change_scene) {

    float star_width = 0.2f; bool reverse = true; float one = length(planeX); bool colored = false;
//  float star_width = 0.2f; bool reverse = true; float one = length(planeX); bool colored = false;
    
    ////////////////////////////////////
//  ////////////////////////////////////
    ///         MAIN Plane 1         ///
//  ///         MAIN Plane 1         ///
    ////////////////////////////////////
//  ////////////////////////////////////
    vec4 col_1 = vec4(0.f); vec3 planePos = boxPos + star_width * planeZ; float t1 = planeIntersection(planeZ, viewingNormal, planePos); vec2 uv; if(t1 > 0.f) { vec3 pos = t1 * viewingNormal; uv = getUV(planeX, planeY, pos - planePos); if(check_if_inside(uv, one, -1.f) && uv.y < length(planeX) && uv.y > -length(planeX)) col_1 = (colored) ? vec4(1, 0, 0, 1) : vec4(planeColor(uv, reverse, change_scene), 1.f); else t1 = 1000.f; } else t1 = 1000.f;
//  vec4 col_1 = vec4(0.f); vec3 planePos = boxPos + star_width * planeZ; float t1 = planeIntersection(planeZ, viewingNormal, planePos); vec2 uv; if(t1 > 0.f) { vec3 pos = t1 * viewingNormal; uv = getUV(planeX, planeY, pos - planePos); if(check_if_inside(uv, one, -1.f) && uv.y < length(planeX) && uv.y > -length(planeX)) col_1 = (colored) ? vec4(1, 0, 0, 1) : vec4(planeColor(uv, reverse, change_scene), 1.f); else t1 = 1000.f; } else t1 = 1000.f;
    
    
    /////////////////////////////////
//  /////////////////////////////////
    
    planeX *= -1.;
//  planeX *= -1.;
    planeY *= -1.;
//  planeY *= -1.;
    planeZ *= -1.;
//  planeZ *= -1.;
    
    reverse = !reverse;
//  reverse = !reverse;
    
    /////////////////////////////////
//  /////////////////////////////////
    
    
    ////////////////////////////////////
//  ////////////////////////////////////
    ///         MAIN Plane 2         ///
//  ///         MAIN Plane 2         ///
    ////////////////////////////////////
//  ////////////////////////////////////
    vec4 col_2 = vec4(0.f); planePos = boxPos + star_width * planeZ; float t2 = planeIntersection(planeZ, viewingNormal, planePos); if(t2 > 0.f) { vec3 pos = t2 * viewingNormal; uv = getUV(planeX, planeY, pos - planePos); if(check_if_inside(uv, one, 1.f) && uv.y < one && uv.y > -one) col_2 = (colored) ? vec4(0, 0, 1, 1) : col_2 = vec4(planeColor(uv, reverse, change_scene), 1.f); else t2 = 1000.f; } else t2 = 1000.f;
//  vec4 col_2 = vec4(0.f); planePos = boxPos + star_width * planeZ; float t2 = planeIntersection(planeZ, viewingNormal, planePos); if(t2 > 0.f) { vec3 pos = t2 * viewingNormal; uv = getUV(planeX, planeY, pos - planePos); if(check_if_inside(uv, one, 1.f) && uv.y < one && uv.y > -one) col_2 = (colored) ? vec4(0, 0, 1, 1) : col_2 = vec4(planeColor(uv, reverse, change_scene), 1.f); else t2 = 1000.f; } else t2 = 1000.f;
    
    
    ///////////////////////////////
//  ///////////////////////////////
    ///         Plane 3         ///
//  ///         Plane 3         ///
    ///////////////////////////////
//  ///////////////////////////////
    vec3 rot = planeY; float rot_ratio = 0.245f; float move_ratio = 0.285f; vec4 col_3 = vec4(0, 0.5f, 0, 1); vec3 _planeX = normalize(mix(planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t3 = planeIntersection(_planeX, viewingNormal, planePos); if(t3 > 0.f) { vec3 pos = t3 * viewingNormal; uv = getUV(planeZ, planeY, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.84f && uv.y > -one * 0.84f) col_3 = (colored) ? vec4(0, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t3); else t3 = 1000.f; } else t3 = 1000.f;
//  vec3 rot = planeY; float rot_ratio = 0.245f; float move_ratio = 0.285f; vec4 col_3 = vec4(0, 0.5f, 0, 1); vec3 _planeX = normalize(mix(planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t3 = planeIntersection(_planeX, viewingNormal, planePos); if(t3 > 0.f) { vec3 pos = t3 * viewingNormal; uv = getUV(planeZ, planeY, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.84f && uv.y > -one * 0.84f) col_3 = (colored) ? vec4(0, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t3); else t3 = 1000.f; } else t3 = 1000.f;
    
    
    ///////////////////////////////
//  ///////////////////////////////
    ///         Plane 4         ///
//  ///         Plane 4         ///
    ///////////////////////////////
//  ///////////////////////////////
    vec4 col_4 = vec4(0, 0.5f, 0, 1); _planeX = normalize(mix(-planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t4 = planeIntersection(_planeX, viewingNormal, planePos); if(t4 > 0.f) { vec3 pos = t4 * viewingNormal; uv = getUV(planeZ, planeY, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.84f && uv.y > -one * 0.84f) col_4 = (colored) ? vec4(0.f, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t4); else t4 = 1000.f; } else t4 = 1000.f;
//  vec4 col_4 = vec4(0, 0.5f, 0, 1); _planeX = normalize(mix(-planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t4 = planeIntersection(_planeX, viewingNormal, planePos); if(t4 > 0.f) { vec3 pos = t4 * viewingNormal; uv = getUV(planeZ, planeY, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.84f && uv.y > -one * 0.84f) col_4 = (colored) ? vec4(0.f, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t4); else t4 = 1000.f; } else t4 = 1000.f;
    
    
    ///////////////////////////////
//  ///////////////////////////////
    ///         Plane 5         ///
//  ///         Plane 5         ///
    ///////////////////////////////
//  ///////////////////////////////
    rot = planeY; rot_ratio = 1.f; move_ratio = 0.285f; vec4 col_5 = vec4(0, 0.5f, 0, 1); _planeX = planeY; /* normalize(mix(planeX, rot, rot_ratio)); */ _planeX *= move_ratio; planePos = boxPos + _planeX; float t5 = planeIntersection(_planeX, viewingNormal, planePos); if(t5 > 0.f) { vec3 pos = t5 * viewingNormal; uv = getUV(planeZ, planeX, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.87f && uv.y > -one * 0.87f) col_5 = (colored) ? vec4(0, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t5); else t5 = 1000.f; } else t5 = 1000.f;
//  rot = planeY; rot_ratio = 1.f; move_ratio = 0.285f; vec4 col_5 = vec4(0, 0.5f, 0, 1); _planeX = planeY; /* normalize(mix(planeX, rot, rot_ratio)); */ _planeX *= move_ratio; planePos = boxPos + _planeX; float t5 = planeIntersection(_planeX, viewingNormal, planePos); if(t5 > 0.f) { vec3 pos = t5 * viewingNormal; uv = getUV(planeZ, planeX, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.87f && uv.y > -one * 0.87f) col_5 = (colored) ? vec4(0, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t5); else t5 = 1000.f; } else t5 = 1000.f;
    
    
    ///////////////////////////////
//  ///////////////////////////////
    ///         Plane 6         ///
//  ///         Plane 6         ///
    ///////////////////////////////
//  ///////////////////////////////
    rot = planeY; rot_ratio = 0.58f; move_ratio = -0.287f; vec4 col_6 = vec4(0, 0.5f, 0, 1); _planeX = normalize(mix(planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t6 = planeIntersection(_planeX, viewingNormal, planePos); if(t6 > 0.f) { vec3 pos = t6 * viewingNormal; uv = getUV(planeZ, planeX, pos - planePos); uv.y *= -1.f; if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.71f && uv.y > -one * 0.71f) col_6 = (colored) ? vec4(0, 0.5f, 0.5f, 1.f) : vec4(planeColor(uv, reverse, change_scene), t6); else t6 = 1000.f; } else t6 = 1000.f;
//  rot = planeY; rot_ratio = 0.58f; move_ratio = -0.287f; vec4 col_6 = vec4(0, 0.5f, 0, 1); _planeX = normalize(mix(planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t6 = planeIntersection(_planeX, viewingNormal, planePos); if(t6 > 0.f) { vec3 pos = t6 * viewingNormal; uv = getUV(planeZ, planeX, pos - planePos); uv.y *= -1.f; if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.71f && uv.y > -one * 0.71f) col_6 = (colored) ? vec4(0, 0.5f, 0.5f, 1.f) : vec4(planeColor(uv, reverse, change_scene), t6); else t6 = 1000.f; } else t6 = 1000.f;
    
    
    ///////////////////////////////
//  ///////////////////////////////
    ///         Plane 7         ///
//  ///         Plane 7         ///
    ///////////////////////////////
//  ///////////////////////////////
    rot = -planeY; rot_ratio = 0.58f; move_ratio = 0.287f; vec4 col_7 = vec4(0, 0.5f, 0, 1); _planeX = normalize(mix(planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t7 = planeIntersection(_planeX, viewingNormal, planePos); if(t7 > 0.f) { vec3 pos = t7 * viewingNormal; uv = getUV(planeZ, planeX, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.71f && uv.y > -one * 0.71f) col_7 = (colored) ? vec4(0, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t7); else t7 = 1000.f; } else t7 = 1000.f;
//  rot = -planeY; rot_ratio = 0.58f; move_ratio = 0.287f; vec4 col_7 = vec4(0, 0.5f, 0, 1); _planeX = normalize(mix(planeX, rot, rot_ratio)); _planeX *= move_ratio; planePos = boxPos + _planeX; float t7 = planeIntersection(_planeX, viewingNormal, planePos); if(t7 > 0.f) { vec3 pos = t7 * viewingNormal; uv = getUV(planeZ, planeX, pos - planePos); if(uv.x < one * star_width && uv.x > -one * star_width && uv.y < one * 0.71f && uv.y > -one * 0.71f) col_7 = (colored) ? vec4(0, 0.5f, 0.5f, 1) : vec4(planeColor(uv, reverse, change_scene), t7); else t7 = 1000.f; } else t7 = 1000.f;
    
    
    
    /////////////////////////////////////////////////////////////
//  /////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////
//  /////////////////////////////////////////////////////////////
    
    float _min_ = min(min(min(min(min(min(t1, t2), t3), t4), t5), t6), t7);
//  float _min_ = min(min(min(min(min(min(t1, t2), t3), t4), t5), t6), t7);
    
    if (_min_ == t1) return col_1;
//  if (_min_ == t1) return col_1;
    if (_min_ == t2) return col_2;
//  if (_min_ == t2) return col_2;
    if (_min_ == t3) return col_3;
//  if (_min_ == t3) return col_3;
    if (_min_ == t4) return col_4;
//  if (_min_ == t4) return col_4;
    if (_min_ == t5) return col_5;
//  if (_min_ == t5) return col_5;
    if (_min_ == t6) return col_6;
//  if (_min_ == t6) return col_6;
    if (_min_ == t7) return col_7;
//  if (_min_ == t7) return col_7;
    
    }
//  }




    uniform float    speed       ; // 00.7
//  uniform float    speed       ; // 00.7
    uniform float farthest_pos   ; // 15.0
//  uniform float farthest_pos   ; // 15.0
    uniform float  closest_pos   ; // 02.0
//  uniform float  closest_pos   ; // 02.0
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
    vec2 uv = vTexCoord; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; fragColor = vec4(col, 1); if (ratio <= 0.) { return; }
//  vec2 uv = vTexCoord; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; fragColor = vec4(col, 1); if (ratio <= 0.) { return; }
    
    ///////////////////////
//  ///////////////////////
    ///   Cube params   ///
//  ///   Cube params   ///
    ///////////////////////
//  ///////////////////////
    uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x; float aspect = canvasSize.x / canvasSize.y; vec3 viewingNormal = normalize(vec3(uv - vec2(0.5f, 0.5f / aspect), 1)); vec3 boxPos = vec3(0, 0, mix(closest_pos, farthest_pos, pow((ratio - 0.5f) * 2.f, speed_power)));
//  uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x; float aspect = canvasSize.x / canvasSize.y; vec3 viewingNormal = normalize(vec3(uv - vec2(0.5f, 0.5f / aspect), 1)); vec3 boxPos = vec3(0, 0, mix(closest_pos, farthest_pos, pow((ratio - 0.5f) * 2.f, speed_power)));

    ///////////////////////////
//  ///////////////////////////
    ///   Rotation params   ///
//  ///   Rotation params   ///
    ///////////////////////////
//  ///////////////////////////
    vec3 planeZ = normalize(vec3(sin(rotation_speed * time), 0, cos(rotation_speed * time))); vec3 planeX = normalize(cross(planeZ, vec3(0, 1, 0))); vec3 planeY = normalize(cross(planeZ, planeX));
//  vec3 planeZ = normalize(vec3(sin(rotation_speed * time), 0, cos(rotation_speed * time))); vec3 planeX = normalize(cross(planeZ, vec3(0, 1, 0))); vec3 planeY = normalize(cross(planeZ, planeX));

    ////////////////////////////////
//  ////////////////////////////////
    ///   Actual cube function   ///
//  ///   Actual cube function   ///
    ////////////////////////////////
//  ////////////////////////////////
    vec4 boxCol = boxColor(viewingNormal, boxPos, planeX, planeY, planeZ, change_scene);
//  vec4 boxCol = boxColor(viewingNormal, boxPos, planeX, planeY, planeZ, change_scene);

    //////////////////////////////////////
//  //////////////////////////////////////
    ///   Mixing with the background   ///
//  ///   Mixing with the background   ///
    //////////////////////////////////////
//  //////////////////////////////////////
    col = mix(col, boxCol.rgb, step(0.5f, boxCol.a)); fragColor = vec4(col, 1);
//  col = mix(col, boxCol.rgb, step(0.5f, boxCol.a)); fragColor = vec4(col, 1);
    }







