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

    // https://www.shadertoy.com/view/Wdtyzj
//  // https://www.shadertoy.com/view/Wdtyzj

    #define pi 3.14159265359
//  #define pi 3.14159265359


    float rand(vec2 co) { return fract(sin(dot(co.xy, vec2(12.9898f, 78.233f))) * 43758.5453f); }
//  float rand(vec2 co) { return fract(sin(dot(co.xy, vec2(12.9898f, 78.233f))) * 43758.5453f); }

    float distortion(float x) { float y = (sin(5.f * x) + sin(6.f * x) * sin(7.f * x) + sin(10.f * x)); return (y >= 0.5f) ? y : 0.f; }
//  float distortion(float x) { float y = (sin(5.f * x) + sin(6.f * x) * sin(7.f * x) + sin(10.f * x)); return (y >= 0.5f) ? y : 0.f; }

    void main() {
    vec2 uv = vTexCoord; vec3 col = texture(tex0, uv).rgb;
//  vec2 uv = vTexCoord; vec3 col = texture(tex0, uv).rgb;

    /////////////////
//  /////////////////
    // Color shift //
//  // Color shift //
    /////////////////
//  /////////////////

    float distortion_power = 5.f * abs(sin(time)); // 0.0 -> 5.0
//  float distortion_power = 5.f * abs(sin(time)); // 0.0 -> 5.0

    float shift_count = 5.f;
//  float shift_count = 5.f;
    float shift_power = distortion_power / 500.f;
//  float shift_power = distortion_power / 500.f;
    float       speed = 3.f;
//  float       speed = 3.f;

    float shift = (vec4(vTexCoord * canvasSize, 0.0, 1.0).x + distortion_power * distortion((uv.y + speed * time) * shift_count)) / canvasSize.x;
//  float shift = (vec4(vTexCoord * canvasSize, 0.0, 1.0).x + distortion_power * distortion((uv.y + speed * time) * shift_count)) / canvasSize.x;
    col = vec3(texture(tex0, vec2(shift                    , uv.y)).r
//  col = vec3(texture(tex0, vec2(shift                    , uv.y)).r
    ,      texture(tex0, vec2(shift + shift_power      , uv.y)).g
//  ,      texture(tex0, vec2(shift + shift_power      , uv.y)).g
    ,      texture(tex0, vec2(shift + shift_power * 2.f, uv.y)).b);
//  ,      texture(tex0, vec2(shift + shift_power * 2.f, uv.y)).b);

    /////////////////
//  /////////////////
    // Noise No. 1 //
//  // Noise No. 1 //
    /////////////////
//  /////////////////
    float  noise_ratio = distortion_power * 0.1f ;
//  float  noise_ratio = distortion_power * 0.1f ;
    col += noise_ratio * (rand(time * uv) - 0.5f);
//  col += noise_ratio * (rand(time * uv) - 0.5f);
    col *= 1.5f;
//  col *= 1.5f;

    fragColor = vec4(col, 1.0f);
//  fragColor = vec4(col, 1.0f);
    }







