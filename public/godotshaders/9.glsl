    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform sampler2D  tex0;
//  uniform sampler2D  tex0;
    in      vec2           vTexCoord;
//  in      vec2           vTexCoord;
    out     vec4           fragColor;
//  out     vec4           fragColor;
    uniform float      time;
//  uniform float      time;
    uniform vec2 canvasSize;
//  uniform vec2 canvasSize;
    uniform vec2           texelSize;
//  uniform vec2           texelSize;


    // const float threshold = 0.5;
//  // const float threshold = 0.5;
    // const float delta     = 0.2;
//  // const float delta     = 0.2;

    uniform float threshold ; // 0.5
//  uniform float threshold ; // 0.5
    uniform float delta     ; // 0.2
//  uniform float delta     ; // 0.2

    void main() {
    vec4 screen_color = texture(tex0, vTexCoord); // Get the color from the screen texture
//  vec4 screen_color = texture(tex0, vTexCoord); // Get the color from the screen texture

    float avg = (screen_color.r + screen_color.g + screen_color.b) / 3.0;
//  float avg = (screen_color.r + screen_color.g + screen_color.b) / 3.0;

    if(avg < threshold) {
//  if(avg < threshold) {
    fragColor.rgb = vec3(screen_color.r - delta, screen_color.r - delta, screen_color.r - delta);
//  fragColor.rgb = vec3(screen_color.r - delta, screen_color.r - delta, screen_color.r - delta);
    } else {
//  } else {
    fragColor.rgb = vec3(screen_color.r + delta, screen_color.r + delta, screen_color.r + delta);
//  fragColor.rgb = vec3(screen_color.r + delta, screen_color.r + delta, screen_color.r + delta);
    }
//  }
    }

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://godotshaders.com/shader/grey-threshold/
//  // https://godotshaders.com/shader/grey-threshold/
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

