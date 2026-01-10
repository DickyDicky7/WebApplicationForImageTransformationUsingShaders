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

    // const float max_blend       = 0.5;
//  // const float max_blend       = 0.5;
    // const float rotation_offset = 0.0;
//  // const float rotation_offset = 0.0;
    // const float intensity       = 0.5;
//  // const float intensity       = 0.5;
    // const bool           invert = false;
//  // const bool           invert = false;
    // const vec2  rel_rect_size   = vec2(1024, 600);
//  // const vec2  rel_rect_size   = vec2(1024, 600);

    uniform float max_blend       ; // 0.5
//  uniform float max_blend       ; // 0.5
    uniform float rotation_offset ; // 0.0
//  uniform float rotation_offset ; // 0.0
    uniform float intensity       ; // 0.5
//  uniform float intensity       ; // 0.5
    uniform bool           invert ; // false
//  uniform bool           invert ; // false
    uniform vec2  rel_rect_size   ; // 1024, 600
//  uniform vec2  rel_rect_size   ; // 1024, 600

    float      distFromCen(vec2 p) {
//  float      distFromCen(vec2 p) {
    return distance   (     p,vec2(0.5));
//  return distance   (     p,vec2(0.5));
    }
//  }
    //rotates by angle radians
//  //rotates by angle radians
    //rotates by angle radians
//  //rotates by angle radians
    vec2 rotate(vec2 p, float angle) {
//  vec2 rotate(vec2 p, float angle) {
    return  vec2(cos(angle) * p.x -
//  return  vec2(cos(angle) * p.x -
    sin(angle) * p.y ,
//  sin(angle) * p.y ,
    sin(angle) * p.x +
//  sin(angle) * p.x +
    cos(angle) * p.y);
//  cos(angle) * p.y);
    }
//  }

    void main() {
    vec4 c = fragColor;
//  vec4 c = fragColor;
    
    float distMod = invert ?       distFromCen(vTexCoord)
//  float distMod = invert ?       distFromCen(vTexCoord)
    : 0.5 - distFromCen(vTexCoord);
//  : 0.5 - distFromCen(vTexCoord);
    float angle =         intensity  * distMod       *               6.28318 + rotation_offset;
//  float angle =         intensity  * distMod       *               6.28318 + rotation_offset;
    vec2 newp   =  rotate(vTexCoord  -     vec2(0.5) , angle) + vec2(0.5);
//  vec2 newp   =  rotate(vTexCoord  -     vec2(0.5) , angle) + vec2(0.5);
    vec2 disp   = (newp - vTexCoord) * rel_rect_size * (1.0 / canvasSize);
//  vec2 disp   = (newp - vTexCoord) * rel_rect_size * (1.0 / canvasSize);
    disp.y = // for some reason UV and SCEEN_UV are inveresed
//  disp.y = // for some reason UV and SCEEN_UV are inveresed
    - disp.y ; // for some reason UV and SCEEN_UV are inveresed
//  - disp.y ; // for some reason UV and SCEEN_UV are inveresed
    fragColor = mix(texture(tex0, vTexCoord + disp), c, max_blend  * 2.0 * (0.5
//  fragColor = mix(texture(tex0, vTexCoord + disp), c, max_blend  * 2.0 * (0.5
    - distFromCen(      vTexCoord       )                        ));
//  - distFromCen(      vTexCoord       )                        ));
    //COLOR = c;
//  //COLOR = c;
    //COLOR = c;
//  //COLOR = c;
    //Doesn'[t apply effect outside of circle]
//  //Doesn'[t apply effect outside of circle]
    //Doesn'[t apply effect outside of circle]
//  //Doesn'[t apply effect outside of circle]
    if (        distFromCen(      vTexCoord       ) > 0.5) {
//  if (        distFromCen(      vTexCoord       ) > 0.5) {
    fragColor =     texture(tex0, vTexCoord       );
//  fragColor =     texture(tex0, vTexCoord       );
    }
//  }
    }



    // https://godotshaders.com/shader/vortex-overlay/
//  // https://godotshaders.com/shader/vortex-overlay/






