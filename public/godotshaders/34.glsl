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

    // const float PI = 3.14;
//  // const float PI = 3.14;
    // const int   lines  = 100;
//  // const int   lines  = 100;
    // const vec4  color1 = vec4(0.0, 0.0, 1.0, 1.0);
//  // const vec4  color1 = vec4(0.0, 0.0, 1.0, 1.0);
    // const vec4  color2 = vec4(1.0, 0.0, 0.0, 1.0);
//  // const vec4  color2 = vec4(1.0, 0.0, 0.0, 1.0);
    // const float  speed = 0.4;
//  // const float  speed = 0.4;
    // const float  alpha = 0.5;
//  // const float  alpha = 0.5;
    // const float  noise_amount = 0.05;
//  // const float  noise_amount = 0.05;
    // const float effect_factor = 0.40;
//  // const float effect_factor = 0.40;

    const   float PI = 3.14;
//  const   float PI = 3.14;
    uniform int   lines  ; // 100
//  uniform int   lines  ; // 100
    uniform vec4  color1 ; // 0.0, 0.0, 1.0, 1.0
//  uniform vec4  color1 ; // 0.0, 0.0, 1.0, 1.0
    uniform vec4  color2 ; // 1.0, 0.0, 0.0, 1.0
//  uniform vec4  color2 ; // 1.0, 0.0, 0.0, 1.0
    uniform float  speed ; // 0.4
//  uniform float  speed ; // 0.4
    uniform float  alpha ; // 0.5
//  uniform float  alpha ; // 0.5
    uniform float  noise_amount ; // 0.05
//  uniform float  noise_amount ; // 0.05
    uniform float effect_factor ; // 0.40
//  uniform float effect_factor ; // 0.40


    void noise(in vec2 uv, inout vec4 color) {
//  void noise(in vec2 uv, inout vec4 color) {
    float a = fract(sin(dot(uv, vec2(12.9898, 78.2330) * time)) * 438.5453) * 1.9;
//  float a = fract(sin(dot(uv, vec2(12.9898, 78.2330) * time)) * 438.5453) * 1.9;
    color.rgb = mix(
//  color.rgb = mix(
    color.rgb , vec3(a)
//  color.rgb , vec3(a)
    , noise_amount);
//  , noise_amount);
    }
//  }


    vec4 color_shift(in vec2 uv, in sampler2D image, vec2 shift_vector) { return texture(image, uv - shift_vector); }
//  vec4 color_shift(in vec2 uv, in sampler2D image, vec2 shift_vector) { return texture(image, uv - shift_vector); }

    void main() {
    float        lineN      = floor(  (vTexCoord.y - time * speed) * float(lines) );
//  float        lineN      = floor(  (vTexCoord.y - time * speed) * float(lines) );
    float        line_grade = abs(sin(lineN*PI/4.0));
//  float        line_grade = abs(sin(lineN*PI/4.0));
    float smooth_line_grade = abs(sin((vTexCoord.y - time * speed) * float(lines)));
//  float smooth_line_grade = abs(sin((vTexCoord.y - time * speed) * float(lines)));
    
    vec4 line_color = mix(color1, color2, line_grade);
//  vec4 line_color = mix(color1, color2, line_grade);
    
    // change the "240.0" literal to control line color shifting
//  // change the "240.0" literal to control line color shifting
    // @@@@@@ @@@ @@@@@@@ @@@@@@@ @@ @@@@@@@ @@@@ @@@@@ @@@@@@@@
//  // @@@@@@ @@@ @@@@@@@ @@@@@@@ @@ @@@@@@@ @@@@ @@@@@ @@@@@@@@
    fragColor = color_shift(vTexCoord, tex0, vec2(1.0, 0.0) * smooth_line_grade / 240.0 * effect_factor);
//  fragColor = color_shift(vTexCoord, tex0, vec2(1.0, 0.0) * smooth_line_grade / 240.0 * effect_factor);
    
    //##########################
//  //##########################
    noise(vTexCoord, fragColor);
//  noise(vTexCoord, fragColor);
    //##########################
//  //##########################
    
    fragColor.rgb = mix (   fragColor.rgb, line_color.rgb, effect_factor);
//  fragColor.rgb = mix (   fragColor.rgb, line_color.rgb, effect_factor);
    fragColor.a   = alpha * fragColor.a  * line_color.a                  ;
//  fragColor.a   = alpha * fragColor.a  * line_color.a                  ;
    }


    // https://godotshaders.com/shader/hologram-simple-canvasitem-shader/
//  // https://godotshaders.com/shader/hologram-simple-canvasitem-shader/
