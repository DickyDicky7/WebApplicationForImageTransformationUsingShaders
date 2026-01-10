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

    void main(  )
    {
    float inc = 2.0 * mousePosition.x;
//  float inc = 2.0 * mousePosition.x;
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    if (inc < 0.001)
//  if (inc < 0.001)
    inc =       ( sin(time)                 *                         0.5  + 0.5        ) * canvasSize.x ;
//  inc =       ( sin(time)                 *                         0.5  + 0.5        ) * canvasSize.x ;
    vec2 uv = 2.0 * ((mod(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy, inc) + (ceil(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / inc) * inc / 2.0))) / canvasSize.xy;
//  vec2 uv = 2.0 * ((mod(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy, inc) + (ceil(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / inc) * inc / 2.0))) / canvasSize.xy;

    // Time varying pixel color
//  // Time varying pixel color
    // Time varying pixel color
//  // Time varying pixel color
    vec3  col = texture(tex0, uv ).rgb;
//  vec3  col = texture(tex0, uv ).rgb;

    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    fragColor =    vec4(col , 1.0)    ;
//  fragColor =    vec4(col , 1.0)    ;
    }

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/lXsGzr
//  // https://www.shadertoy.com/view/lXsGzr
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
