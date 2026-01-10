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

    // https://www.shadertoy.com/view/3scBzH
//  // https://www.shadertoy.com/view/3scBzH

    #define pi 3.14159265359
//  #define pi 3.14159265359

    uniform float          speed ; //  3.00
//  uniform float          speed ; //  3.00
    uniform float     side       ; //  0.19
//  uniform float     side       ; //  0.19
    uniform vec2      move       ; // -0.12, 0.1
//  uniform vec2      move       ; // -0.12, 0.1
    uniform float rotation_count ; //  1.00
//  uniform float rotation_count ; //  1.00
    uniform float     zoom_ratio ; //  2.00
//  uniform float     zoom_ratio ; //  2.00

    void main() {
    float remapTime = mod(speed * time, 2.f * pi) - pi; remapTime *= step(0.f, remapTime);
//  float remapTime = mod(speed * time, 2.f * pi) - pi; remapTime *= step(0.f, remapTime);

    ////////////////////////
//  ////////////////////////
    ///   Zoom formula   ///
//  ///   Zoom formula   ///
    ////////////////////////
//  ////////////////////////
    float zoom = zoom_ratio * sign(remapTime - pi / 2.f) * (1.f - abs(cos(remapTime)));
//  float zoom = zoom_ratio * sign(remapTime - pi / 2.f) * (1.f - abs(cos(remapTime)));

    //////////////////////////////
//  //////////////////////////////
    ///   Getting the center   ///
//  ///   Getting the center   ///
    //////////////////////////////
//  //////////////////////////////
    vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x; vec2 center = side * round((uv + move) / side); center -= move; center.y = center.y * canvasSize.x / canvasSize.y; uv = vTexCoord;
//  vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.x; vec2 center = side * round((uv + move) / side); center -= move; center.y = center.y * canvasSize.x / canvasSize.y; uv = vTexCoord;

    /////////////////////////////
//  /////////////////////////////
    ///   Applying the zoom   ///
//  ///   Applying the zoom   ///
    /////////////////////////////
//  /////////////////////////////
    uv -= zoom * (center - vec2(0.5f, 0.5f));
//  uv -= zoom * (center - vec2(0.5f, 0.5f));

    //////////////////
//  //////////////////
    ///   Mirror   ///
//  ///   Mirror   ///
    //////////////////
//  //////////////////
    uv = abs(uv); uv = step(1.f, uv) * 2.f + sign(1.f - uv) * uv;
//  uv = abs(uv); uv = step(1.f, uv) * 2.f + sign(1.f - uv) * uv;

    ////////////////////////
//  ////////////////////////
    ///   Scene change   ///
//  ///   Scene change   ///
    ////////////////////////
//  ////////////////////////
    bool change_scene = int((speed * time + pi / 2.f) / (2.f * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; fragColor = vec4(col, 1.0f);
//  bool change_scene = int((speed * time + pi / 2.f) / (2.f * pi)) % 2 == 0; vec3 col = (change_scene) ? texture(tex0, uv).rgb : texture(uploadTex0, uv).rgb; fragColor = vec4(col, 1.0f);
    }



