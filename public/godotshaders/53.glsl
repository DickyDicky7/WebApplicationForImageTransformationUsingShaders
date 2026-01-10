#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    uniform         sampler2D      palette0; // null
//  uniform         sampler2D      palette0; // null
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

    // const float screen_height = 640.0;
//  // const float screen_height = 640.0;
    // const float amplitude = 00.075;
//  // const float amplitude = 00.075;
    // const float frequency = 10.000;
//  // const float frequency = 10.000;
    // const float     speed = 02.000;
//  // const float     speed = 02.000;
    // const float amplitude_vertical = 0.0;
//  // const float amplitude_vertical = 0.0;
    // const float frequency_vertical = 0.0;
//  // const float frequency_vertical = 0.0;
    // const float     speed_vertical = 0.0;
//  // const float     speed_vertical = 0.0;
    // const vec2  scrolling_direction= vec2(0.0, 0.0);
//  // const vec2  scrolling_direction= vec2(0.0, 0.0);
    // const float scrolling_speed    = 0.08;
//  // const float scrolling_speed    = 0.08;
    // const bool     enable_palette_cycling = false;
//  // const bool     enable_palette_cycling = false;
    // const float           palette_speed   = 00.10;
//  // const float           palette_speed   = 00.10;

    uniform float screen_height ; // 640.0
//  uniform float screen_height ; // 640.0
    uniform float amplitude ; // 00.075
//  uniform float amplitude ; // 00.075
    uniform float frequency ; // 10.000
//  uniform float frequency ; // 10.000
    uniform float     speed ; // 02.000
//  uniform float     speed ; // 02.000
    uniform float amplitude_vertical ; // 0.0
//  uniform float amplitude_vertical ; // 0.0
    uniform float frequency_vertical ; // 0.0
//  uniform float frequency_vertical ; // 0.0
    uniform float     speed_vertical ; // 0.0
//  uniform float     speed_vertical ; // 0.0
    uniform vec2  scrolling_direction; // 0.0, 0.0
//  uniform vec2  scrolling_direction; // 0.0, 0.0
    uniform float scrolling_speed    ; // 0.08
//  uniform float scrolling_speed    ; // 0.08
    uniform bool     enable_palette_cycling ; // false
//  uniform bool     enable_palette_cycling ; // false
    uniform float           palette_speed   ; // 00.10
//  uniform float           palette_speed   ; // 00.10

    void main()
    {
    float diff_x = amplitude          * sin((frequency          * vTexCoord.y) + (speed          * time));
//  float diff_x = amplitude          * sin((frequency          * vTexCoord.y) + (speed          * time));
    float diff_y = amplitude_vertical * sin((frequency_vertical * vTexCoord.y) + (speed_vertical * time));
//  float diff_y = amplitude_vertical * sin((frequency_vertical * vTexCoord.y) + (speed_vertical * time));
    vec2  scroll =                                                                                        scrolling_direction * time * scrolling_speed;
//  vec2  scroll =                                                                                        scrolling_direction * time * scrolling_speed;
    vec4           tex = texture(tex0, vec2(vTexCoord.x + diff_x  ,
//  vec4           tex = texture(tex0, vec2(vTexCoord.x + diff_x  ,
    vTexCoord.y + diff_y) + scroll);
//  vTexCoord.y + diff_y) + scroll);
    float palette_swap =
//  float palette_swap =
    mod(  tex.r  -time *
//  mod(  tex.r  -time *
    palette_speed
//  palette_speed
    ,  001.0
//  ,  001.0
    );
//  );
    
    if (enable_palette_cycling)
//  if (enable_palette_cycling)
    {
//  {
    fragColor = vec4(texture(palette0, vec2(palette_swap, 0)).rgb, tex.a);
//  fragColor = vec4(texture(palette0, vec2(palette_swap, 0)).rgb, tex.a);
    }
//  }
    else
//  else
    {
//  {
    fragColor = tex;
//  fragColor = tex;
    }
//  }
        
    fragColor = mix(  vec4(  0.0  )
//  fragColor = mix(  vec4(  0.0  )
    ,   fragColor , mod((vTexCoord.y * screen_height) , 2.0));
//  ,   fragColor , mod((vTexCoord.y * screen_height) , 2.0));
    }



    // https://godotshaders.com/shader/earthbound-like-battle-background-shader-w-scroll-effect-and-palette-cycling/
//  // https://godotshaders.com/shader/earthbound-like-battle-background-shader-w-scroll-effect-and-palette-cycling/
