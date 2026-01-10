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

    // const float rain_amount = 200.0;
//  // const float rain_amount = 200.0;
    // const float near_rain_length = 0.2;
//  // const float near_rain_length = 0.2;
    // const float  far_rain_length = 0.1;
//  // const float  far_rain_length = 0.1;
    // const float near_rain_width  = 1.0;
//  // const float near_rain_width  = 1.0;
    // const float  far_rain_width  = 0.5;
//  // const float  far_rain_width  = 0.5;
    // const float near_rain_transparency = 1.0;
//  // const float near_rain_transparency = 1.0;
    // const float  far_rain_transparency = 0.5;
//  // const float  far_rain_transparency = 0.5;
    // // Replace the below reference to source_color with hint_color if you are using a version of Godot before 4.
//  // // Replace the below reference to source_color with hint_color if you are using a version of Godot before 4.
    // const vec4             rain_color = vec4(0.8, 0.8, 0.8, 1.0);
//  // const vec4             rain_color = vec4(0.8, 0.8, 0.8, 1.0);
    // const float       base_rain_speed = 0.5;
//  // const float       base_rain_speed = 0.5;
    // const float additional_rain_speed = 0.5;
//  // const float additional_rain_speed = 0.5;
    // const float slant  = 0.2;
//  // const float slant  = 0.2;

    uniform bool  rain_or_snow                   ; // false
//  uniform bool  rain_or_snow                   ; // false
    uniform float rain_or_snow_amount            ; // 200.0
//  uniform float rain_or_snow_amount            ; // 200.0
    uniform float near_rain_or_snow_length       ; // 0.2
//  uniform float near_rain_or_snow_length       ; // 0.2
    uniform float  far_rain_or_snow_length       ; // 0.1
//  uniform float  far_rain_or_snow_length       ; // 0.1
    uniform float near_rain_or_snow_width        ; // 1.0
//  uniform float near_rain_or_snow_width        ; // 1.0
    uniform float  far_rain_or_snow_width        ; // 0.5
//  uniform float  far_rain_or_snow_width        ; // 0.5
    uniform float near_rain_or_snow_transparency ; // 1.0
//  uniform float near_rain_or_snow_transparency ; // 1.0
    uniform float  far_rain_or_snow_transparency ; // 0.5
//  uniform float  far_rain_or_snow_transparency ; // 0.5
    // Replace the below reference to source_color with hint_color if you are using a version of Godot before 4.
//  // Replace the below reference to source_color with hint_color if you are using a version of Godot before 4.
    uniform vec4             rain_or_snow_color  ; // 0.8, 0.8, 0.8, 1.0
//  uniform vec4             rain_or_snow_color  ; // 0.8, 0.8, 0.8, 1.0
    uniform float       base_rain_or_snow_speed  ; // 0.5
//  uniform float       base_rain_or_snow_speed  ; // 0.5
    uniform float additional_rain_or_snow_speed  ; // 0.5
//  uniform float additional_rain_or_snow_speed  ; // 0.5
    uniform float slant                          ; // 0.2
//  uniform float slant                          ; // 0.2

    void main() {

    float
//  float
    timee     = 10000.0 + time;
//  timee     = 10000.0 + time;

    fragColor = texture(  tex0, vTexCoord  );
//  fragColor = texture(  tex0, vTexCoord  );

    vec2  uv = vec2(0.0);
//  vec2  uv = vec2(0.0);
    float remainder = mod(vTexCoord.x - vTexCoord.y * slant, 1.0 / rain_or_snow_amount )            ;
//  float remainder = mod(vTexCoord.x - vTexCoord.y * slant, 1.0 / rain_or_snow_amount )            ;
    uv.x =         (vTexCoord.x - vTexCoord.y * slant                    ) - remainder;
//  uv.x =         (vTexCoord.x - vTexCoord.y * slant                    ) - remainder;
    float rn   = fract(                                 sin(uv.x * rain_or_snow_amount))            ;
//  float rn   = fract(                                 sin(uv.x * rain_or_snow_amount))            ;
    uv.y = fract(  (vTexCoord.y + rn));
//  uv.y = fract(  (vTexCoord.y + rn));

    if (rain_or_snow)
//  if (rain_or_snow)
    // rain
//  // rain
    fragColor = mix(fragColor, rain_or_snow_color, smoothstep(1.0 - (far_rain_or_snow_length + (near_rain_or_snow_length - far_rain_or_snow_length) * rn), 1.0, fract(uv.y - timee * (base_rain_or_snow_speed + additional_rain_or_snow_speed * rn))) * (far_rain_or_snow_transparency + (near_rain_or_snow_transparency - far_rain_or_snow_transparency) * rn) * step(remainder * rain_or_snow_amount, far_rain_or_snow_width + (near_rain_or_snow_width - far_rain_or_snow_width) * rn));
//  fragColor = mix(fragColor, rain_or_snow_color, smoothstep(1.0 - (far_rain_or_snow_length + (near_rain_or_snow_length - far_rain_or_snow_length) * rn), 1.0, fract(uv.y - timee * (base_rain_or_snow_speed + additional_rain_or_snow_speed * rn))) * (far_rain_or_snow_transparency + (near_rain_or_snow_transparency - far_rain_or_snow_transparency) * rn) * step(remainder * rain_or_snow_amount, far_rain_or_snow_width + (near_rain_or_snow_width - far_rain_or_snow_width) * rn));
    else
//  else
    // snow
//  // snow
    fragColor = mix(fragColor, rain_or_snow_color,       step(1.0 - (far_rain_or_snow_length + (near_rain_or_snow_length - far_rain_or_snow_length) * rn),      fract(uv.y - timee * (base_rain_or_snow_speed + additional_rain_or_snow_speed * rn))) * (far_rain_or_snow_transparency + (near_rain_or_snow_transparency - far_rain_or_snow_transparency) * rn) * step(remainder * rain_or_snow_amount, far_rain_or_snow_width + (near_rain_or_snow_width - far_rain_or_snow_width) * rn));
//  fragColor = mix(fragColor, rain_or_snow_color,       step(1.0 - (far_rain_or_snow_length + (near_rain_or_snow_length - far_rain_or_snow_length) * rn),      fract(uv.y - timee * (base_rain_or_snow_speed + additional_rain_or_snow_speed * rn))) * (far_rain_or_snow_transparency + (near_rain_or_snow_transparency - far_rain_or_snow_transparency) * rn) * step(remainder * rain_or_snow_amount, far_rain_or_snow_width + (near_rain_or_snow_width - far_rain_or_snow_width) * rn));
    }

    // https://godotshaders.com/shader/rain-and-snow-with-parallax-scrolling-effect/
//  // https://godotshaders.com/shader/rain-and-snow-with-parallax-scrolling-effect/

    // Rain and Snow shader by Brian Smith (steampunkdemon.itch.io)
//  // Rain and Snow shader by Brian Smith (steampunkdemon.itch.io)
    // Rain and Snow shader by Brian Smith (steampunkdemon.itch.io)
//  // Rain and Snow shader by Brian Smith (steampunkdemon.itch.io)
    // MIT licence
//  // MIT licence
    // MIT licence
//  // MIT licence










