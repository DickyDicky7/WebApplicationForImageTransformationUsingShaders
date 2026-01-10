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

    // https://www.shadertoy.com/view/DtlXW8
//  // https://www.shadertoy.com/view/DtlXW8

#define pi 3.14159265359
// #define pi 3.14159265359

    float random2d(vec2 n) { return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453); }
//  float random2d(vec2 n) { return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453); }

    float randomRange(vec2 seed, float _min, float _max) { return _min + random2d(seed) * (_max - _min); }
//  float randomRange(vec2 seed, float _min, float _max) { return _min + random2d(seed) * (_max - _min); }


    uniform float speed                  ; // 10.00
//  uniform float speed                  ; // 10.00
    uniform float x_density              ; // 20.00
//  uniform float x_density              ; // 20.00
    uniform float y_density              ; // 25.00
//  uniform float y_density              ; // 25.00
    uniform float x_randomness           ; // 04.00
//  uniform float x_randomness           ; // 04.00
    uniform float y_randomness           ; // 04.00
//  uniform float y_randomness           ; // 04.00
    uniform float x_in_between_thickness ; // 00.00
//  uniform float x_in_between_thickness ; // 00.00
    uniform float y_in_between_thickness ; // 00.00
//  uniform float y_in_between_thickness ; // 00.00
    // 0.01;
//  // 0.01;
    // 0.02;
//  // 0.02;
    uniform float x_shift_power          ; // 00.02
//  uniform float x_shift_power          ; // 00.02
    uniform float y_shift_power          ; // 00.05
//  uniform float y_shift_power          ; // 00.05
    uniform float col_shift_x_power      ; // 00.02
//  uniform float col_shift_x_power      ; // 00.02
    uniform float col_shift_y_power      ; // 00.02
//  uniform float col_shift_y_power      ; // 00.02


    void main()
    {
    float     remapTime = floor(time * speed);
//  float     remapTime = floor(time * speed);
    vec2 uv = vTexCoord                      ;
//  vec2 uv = vTexCoord                      ;
    
    float x_coef_1 = randomRange(vec2(remapTime, 32.34    ), 5.0, 10.0);
//  float x_coef_1 = randomRange(vec2(remapTime, 32.34    ), 5.0, 10.0);
    float y_coef_1 = randomRange(vec2(remapTime, 98.45    ), 5.0, 10.0);
//  float y_coef_1 = randomRange(vec2(remapTime, 98.45    ), 5.0, 10.0);
    float x_coef_2 = random2d   (vec2(15.43    , remapTime)           );
//  float x_coef_2 = random2d   (vec2(15.43    , remapTime)           );
    float y_coef_2 = random2d   (vec2(45.34    , remapTime)           );
//  float y_coef_2 = random2d   (vec2(45.34    , remapTime)           );
    
    float x = x_coef_1 * (uv.x + x_coef_2);
//  float x = x_coef_1 * (uv.x + x_coef_2);
    float y = y_coef_1 * (uv.y + y_coef_2);
//  float y = y_coef_1 * (uv.y + y_coef_2);
    
    float x_coef_3 = x_randomness * sin(4.0 * x);
//  float x_coef_3 = x_randomness * sin(4.0 * x);
    float y_coef_3 = y_randomness * sin(4.0 * y);
//  float y_coef_3 = y_randomness * sin(4.0 * y);
    
    float final_x = sin(x_density * x + x_coef_3);
//  float final_x = sin(x_density * x + x_coef_3);
    float final_y = sin(y_density * y + y_coef_3);
//  float final_y = sin(y_density * y + y_coef_3);
    
    float x_threshold = 1.0 - step(1.0 - x_in_between_thickness      , final_x);
//  float x_threshold = 1.0 - step(1.0 - x_in_between_thickness      , final_x);
    float y_threshold =       step(      y_in_between_thickness - 1.0, final_y);
//  float y_threshold =       step(      y_in_between_thickness - 1.0, final_y);
    
    final_x = floor((x_density * x + x_coef_3 - 0.5 * pi) / (2.0 * pi));
//  final_x = floor((x_density * x + x_coef_3 - 0.5 * pi) / (2.0 * pi));
    final_y = floor((y_density * y + y_coef_3 + 0.5 * pi) / (2.0 * pi));
//  final_y = floor((y_density * y + y_coef_3 + 0.5 * pi) / (2.0 * pi));
    
    float x_shift = randomRange(vec2(remapTime, final_x), -x_shift_power, x_shift_power);
//  float x_shift = randomRange(vec2(remapTime, final_x), -x_shift_power, x_shift_power);
    float y_shift = randomRange(vec2(remapTime, final_y), -y_shift_power, y_shift_power);
//  float y_shift = randomRange(vec2(remapTime, final_y), -y_shift_power, y_shift_power);
    
    uv.y += x_threshold * x_shift;
//  uv.y += x_threshold * x_shift;
    uv.x += y_threshold * y_shift;
//  uv.x += y_threshold * y_shift;
    
    vec3 col = texture(tex0, uv).rgb;
//  vec3 col = texture(tex0, uv).rgb;
    
    /////////////////////
//  /////////////////////
    //   Color shift   //
//  //   Color shift   //
    /////////////////////
//  /////////////////////
    float rnd          =           random2d   (vec2(remapTime , 95.45)                                       );
//  float rnd          =           random2d   (vec2(remapTime , 95.45)                                       );
    vec2  col_shift_uv = uv + vec2(randomRange(vec2(remapTime , 48.64), -col_shift_x_power, col_shift_x_power)
//  vec2  col_shift_uv = uv + vec2(randomRange(vec2(remapTime , 48.64), -col_shift_x_power, col_shift_x_power)
    ,           randomRange(vec2(remapTime , 25.63), -col_shift_y_power, col_shift_y_power)
//  ,           randomRange(vec2(remapTime , 25.63), -col_shift_y_power, col_shift_y_power)
    );
//  );
    if (rnd < 0.33)
//  if (rnd < 0.33)
    col.r = texture(tex0, col_shift_uv).r;
//  col.r = texture(tex0, col_shift_uv).r;
    else
//  else
    if (rnd < 0.66)
//  if (rnd < 0.66)
    col.g = texture(tex0, col_shift_uv).g;
//  col.g = texture(tex0, col_shift_uv).g;
    else
//  else
    col.b = texture(tex0, col_shift_uv).b;
//  col.b = texture(tex0, col_shift_uv).b;
    
    ///////////////////////////////////////////////
//  ///////////////////////////////////////////////
    ///////////////////////////////////////////////
//  ///////////////////////////////////////////////
    
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }



















