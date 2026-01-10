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

    // const vec3  color = vec3(1.0, 1.0, 1.0);
//  // const vec3  color = vec3(1.0, 1.0, 1.0);
    // const float speed = 1.0;
//  // const float speed = 1.0;
    // const float density = 300.0;
//  // const float density = 300.0;
    // const float compression = 001.0;
//  // const float compression = 001.0;
    // const float trail_size  = 100.0;
//  // const float trail_size  = 100.0;
    // const float brightness  = 100.0;
//  // const float brightness  = 100.0;
    // const float PI = 3.14;
//  // const float PI = 3.14;

    uniform vec3  color       ; // 1.0, 1.0, 1.0
//  uniform vec3  color       ; // 1.0, 1.0, 1.0
    uniform float speed       ; // 1.0
//  uniform float speed       ; // 1.0
    uniform float density     ; // 300.0
//  uniform float density     ; // 300.0
    uniform float compression ; // 001.0
//  uniform float compression ; // 001.0
    uniform float trail_size  ; // 100.0
//  uniform float trail_size  ; // 100.0
    uniform float brightness  ; // 100.0
//  uniform float brightness  ; // 100.0
    const   float PI = 3.14;
//  const   float PI = 3.14;

    void main() {
    vec2     uv =   -vTexCoord;
//  vec2     uv =   -vTexCoord;
    float timee = time * speed;
//  float timee = time * speed;
    uv.x *= density;
//  uv.x *= density;
    vec2  duv = vec2(floor( uv.x), uv.y) * compression;
//  vec2  duv = vec2(floor( uv.x), uv.y) * compression;
    float offset =     sin(duv.x       );
//  float offset =     sin(duv.x       );
    float   fall =     cos(duv.x * 30.0);
//  float   fall =     cos(duv.x * 30.0);
    float  trail =     mix(100.0 , trail_size , fall);
//  float  trail =     mix(100.0 , trail_size , fall);
    float   drop =   fract(duv.y + timee      * fall + offset) * trail;
//  float   drop =   fract(duv.y + timee      * fall + offset) * trail;
    drop = 1.0 / drop;
//  drop = 1.0 / drop;
    drop = smoothstep(0.0, 1.0, drop * drop);
//  drop = smoothstep(0.0, 1.0, drop * drop);
    drop =          sin(        drop * PI  )  * fall *
//  drop =          sin(        drop * PI  )  * fall *
    brightness;
//  brightness;
    float   shape = sin(fract(uv.x)  * PI  );
//  float   shape = sin(fract(uv.x)  * PI  );
    drop *= shape
//  drop *= shape
    *  shape    ;
//  *  shape    ;
    fragColor = vec4(    color *        drop       ,         1.00            );
//  fragColor = vec4(    color *        drop       ,         1.00            );
    fragColor = max (fragColor , (1.0 - fragColor) * texture(tex0, vTexCoord));
//  fragColor = max (fragColor , (1.0 - fragColor) * texture(tex0, vTexCoord));
    }


    // https://godotshaders.com/shader/vertical-drops/
//  // https://godotshaders.com/shader/vertical-drops/
