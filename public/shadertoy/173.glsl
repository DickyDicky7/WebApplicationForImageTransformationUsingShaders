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

    // https://www.shadertoy.com/view/lfyBzw
//  // https://www.shadertoy.com/view/lfyBzw

    const float      PI = 3.141592653589793;
//  const float      PI = 3.141592653589793;
    const float INV_TAU = 1.0
//  const float INV_TAU = 1.0
    / PI                    ;
//  / PI                    ;

    //const float uniRotationSpeed     =    2.00;
//  //const float uniRotationSpeed     =    2.00;
    uniform float uniRotationSpeed     ; // 2.00
//  uniform float uniRotationSpeed     ; // 2.00
    //const float uniRotationSpread    =    1.00;
//  //const float uniRotationSpread    =    1.00;
    uniform float uniRotationSpread    ; // 1.00
//  uniform float uniRotationSpread    ; // 1.00
    //const float uniZoomSpeed         =    0.50;
//  //const float uniZoomSpeed         =    0.50;
    uniform float uniZoomSpeed         ; // 0.50
//  uniform float uniZoomSpeed         ; // 0.50
    //const float uniRingsGrowthFactor =    0.50;
//  //const float uniRingsGrowthFactor =    0.50;
    uniform float uniRingsGrowthFactor ; // 0.50
//  uniform float uniRingsGrowthFactor ; // 0.50
    //const float uniRingsThickness    =    1.00 / .50;
//  //const float uniRingsThickness    =    1.00 / .50;
    uniform float uniRingsThickness    ; // 2.00
//  uniform float uniRingsThickness    ; // 2.00
    //const float uniShadowSpread      =    0.20;
//  //const float uniShadowSpread      =    0.20;
    uniform float uniShadowSpread      ; // 0.20
//  uniform float uniShadowSpread      ; // 0.20
    //const float uniShadowIntensity   =    0.50;
//  //const float uniShadowIntensity   =    0.50;
    uniform float uniShadowIntensity   ; // 0.50
//  uniform float uniShadowIntensity   ; // 0.50

    vec2 getPolar(in vec2 fragCoord) {
//  vec2 getPolar(in vec2 fragCoord) {
    float aspect = canvasSize.y / canvasSize.x; vec2 uv = fragCoord / canvasSize.xy; vec2 xy = vec2(1.0, aspect) * 2.0 * (uv - vec2(0.5)); return vec2(length(xy), atan(xy.y, xy.x));
//  float aspect = canvasSize.y / canvasSize.x; vec2 uv = fragCoord / canvasSize.xy; vec2 xy = vec2(1.0, aspect) * 2.0 * (uv - vec2(0.5)); return vec2(length(xy), atan(xy.y, xy.x));
    }
//  }

    vec3 tex(vec2 uv) {
//  vec3 tex(vec2 uv) {
    return texture(tex0, uv).xyz;
//  return texture(tex0, uv).xyz;
    }
//  }

    void main()
    {
    vec2 polar = getPolar(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy); float r = polar.x; float a = polar.y; float light = uniRingsThickness * log(pow(r, uniRingsGrowthFactor)) - time * (uniZoomSpeed); float n = floor(light); float phase = n * 7.0; a += sin(phase + uniRotationSpeed * time) * uniRotationSpread; float radial = fract(a * INV_TAU * 2.0); float selection = fract(.5 * light); vec3 col = selection < 0.5 ? vec3(1,0.667,0.0) : vec3(0, 0.333, 1.0); float v = fract(light); float u = radial; col *= u; col *= v; col *= .6; col += vec3(0.6); col *= tex(vec2(u, v)); float shade = smoothstep(0.0, uniShadowSpread, v) * uniShadowIntensity + (1.0 - uniShadowIntensity); col *= shade;
//  vec2 polar = getPolar(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy); float r = polar.x; float a = polar.y; float light = uniRingsThickness * log(pow(r, uniRingsGrowthFactor)) - time * (uniZoomSpeed); float n = floor(light); float phase = n * 7.0; a += sin(phase + uniRotationSpeed * time) * uniRotationSpread; float radial = fract(a * INV_TAU * 2.0); float selection = fract(.5 * light); vec3 col = selection < 0.5 ? vec3(1,0.667,0.0) : vec3(0, 0.333, 1.0); float v = fract(light); float u = radial; col *= u; col *= v; col *= .6; col += vec3(0.6); col *= tex(vec2(u, v)); float shade = smoothstep(0.0, uniShadowSpread, v) * uniShadowIntensity + (1.0 - uniShadowIntensity); col *= shade;
    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }








