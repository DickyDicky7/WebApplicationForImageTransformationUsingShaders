#version 300 es
// #version 300 es
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

    // https://www.shadertoy.com/view/43tyzH
//  // https://www.shadertoy.com/view/43tyzH

    // conf!
//  // conf!
    // conf!
//  // conf!
#define  COLOR_MODE 0
// #define  COLOR_MODE 0
#define   MOVE_MODE 1
// #define   MOVE_MODE 1
#define  PULSE_MODE 0
// #define  PULSE_MODE 0

#define INVERT_RATE 3.5
// #define INVERT_RATE 3.5

    // const
//  // const
    // const
//  // const
#define PI (3.14159)
// #define PI (3.14159)

    // code!
//  // code!
    // code!
//  // code!
    vec4 mainImage2(in vec2 uv, float angleMul, float angleOff, float dotCount, float dotSize, float nGroups, float gID) {
//  vec4 mainImage2(in vec2 uv, float angleMul, float angleOff, float dotCount, float dotSize, float nGroups, float gID) {
    // Scale uv by dotCount to get a denser or sparser grid:
//  // Scale uv by dotCount to get a denser or sparser grid:
    // Scale uv by dotCount to get a denser or sparser grid:
//  // Scale uv by dotCount to get a denser or sparser grid:
    vec2 scaledUV = uv * dotCount;
//  vec2 scaledUV = uv * dotCount;

    // Find the nearest integer lattice point:
//  // Find the nearest integer lattice point:
    // Find the nearest integer lattice point:
//  // Find the nearest integer lattice point:
    vec2 cell = floor(scaledUV + 0.5);
//  vec2 cell = floor(scaledUV + 0.5);
    // Convert cell back to world coordinates for the dot position:
//  // Convert cell back to world coordinates for the dot position:
    // Convert cell back to world coordinates for the dot position:
//  // Convert cell back to world coordinates for the dot position:
    vec2 dotPos = (cell / dotCount);
//  vec2 dotPos = (cell / dotCount);

    // If desired, use grouping logic to show/hide certain dots.
//  // If desired, use grouping logic to show/hide certain dots.
    // If desired, use grouping logic to show/hide certain dots.
//  // If desired, use grouping logic to show/hide certain dots.
    // For example, only draw a dot if (cell.x + cell.y) mod nGroups == gID.
//  // For example, only draw a dot if (cell.x + cell.y) mod nGroups == gID.
    // For example, only draw a dot if (cell.x + cell.y) mod nGroups == gID.
//  // For example, only draw a dot if (cell.x + cell.y) mod nGroups == gID.
    float cellIndex  = mod((cell.x + cell.y), nGroups);
//  float cellIndex  = mod((cell.x + cell.y), nGroups);
    if  ( cellIndex != gID) return vec4(0.0);
//  if  ( cellIndex != gID) return vec4(0.0);

    // Compute the distance from the current pixel to the dot center:
//  // Compute the distance from the current pixel to the dot center:
    // Compute the distance from the current pixel to the dot center:
//  // Compute the distance from the current pixel to the dot center:
    float dist = length(uv - dotPos);
//  float dist = length(uv - dotPos);
    
    vec2 unuv = vec2(uv.x / (canvasSize.x / canvasSize.y), uv.y);
//  vec2 unuv = vec2(uv.x / (canvasSize.x / canvasSize.y), uv.y);
    unuv =   (
//  unuv =   (
    unuv + 1.) / 2.;
//  unuv + 1.) / 2.;
    // undo resolution scaling
//  // undo resolution scaling
    // undo resolution scaling
//  // undo resolution scaling
    vec3 texC =  texture(      tex0, unuv).rgb;
//  vec3 texC =  texture(      tex0, unuv).rgb;
    texC += texture(uploadTex0, unuv).rgb;
//  texC += texture(uploadTex0, unuv).rgb;
    texC /= 2.;
//  texC /= 2.;

    // Use smoothstep to create a soft-edged dot:
//  // Use smoothstep to create a soft-edged dot:
    // Use smoothstep to create a soft-edged dot:
//  // Use smoothstep to create a soft-edged dot:
#if COLOR_MODE
// #if COLOR_MODE
    float            intensity  = smoothstep(dotSize, dotSize * 0.8, dist);
//  float            intensity  = smoothstep(dotSize, dotSize * 0.8, dist);
    return vec4(vec3(intensity) * texC, 1.0 );
//  return vec4(vec3(intensity) * texC, 1.0 );
#else
// #else
    dotSize *=   dot(texC.rgb, vec3(1. / 3.));
//  dotSize *=   dot(texC.rgb, vec3(1. / 3.));
    float            intensity = smoothstep(dotSize, dotSize * 0.8, dist);
//  float            intensity = smoothstep(dotSize, dotSize * 0.8, dist);
    return vec4(vec3(intensity)       , 1.0 );
//  return vec4(vec3(intensity)       , 1.0 );
#endif
// #endif
    }
//  }

    void main() {
    vec2 uv    = vTexCoord * 2.0 - 1.0;
//  vec2 uv    = vTexCoord * 2.0 - 1.0;
    uv.x *= canvasSize.x
//  uv.x *= canvasSize.x
    /  canvasSize.y         ; // Adjust for aspect ratio
//  /  canvasSize.y         ; // Adjust for aspect ratio
    
    float time = time; float moveSpeed = 3.; float moveDist = 0.1;
//  float time = time; float moveSpeed = 3.; float moveDist = 0.1;

    vec2 off;
//  vec2 off;
#if MOVE_MODE
// #if MOVE_MODE
    off = vec2(sin(time * moveSpeed)
//  off = vec2(sin(time * moveSpeed)
    ,      cos(time * moveSpeed))
//  ,      cos(time * moveSpeed))
    * moveDist;
//  * moveDist;
    //if (fract(time/INVERT_RATE*2.)<0.1) off = vec2(0.);
//  //if (fract(time/INVERT_RATE*2.)<0.1) off = vec2(0.);
    //if (fract(time/INVERT_RATE*2.)<0.1) off = vec2(0.);
//  //if (fract(time/INVERT_RATE*2.)<0.1) off = vec2(0.);
#endif
// #endif
    vec2 m = (mousePosition.z > 0.) ? (mousePosition.xy / canvasSize.xy) * 2.0 - 1.0 : off;
//  vec2 m = (mousePosition.z > 0.) ? (mousePosition.xy / canvasSize.xy) * 2.0 - 1.0 : off;

    // Instead of spinning circles, we now get a grid of dots.
//  // Instead of spinning circles, we now get a grid of dots.
    // Instead of spinning circles, we now get a grid of dots.
//  // Instead of spinning circles, we now get a grid of dots.
    // The parameters can be tweaked:
//  // The parameters can be tweaked:
    // The parameters can be tweaked:
//  // The parameters can be tweaked:
    // angleMul, angleOff now don't have a direct effect, but we keep them in the call for compatibility.
//  // angleMul, angleOff now don't have a direct effect, but we keep them in the call for compatibility.
    // angleMul, angleOff now don't have a direct effect, but we keep them in the call for compatibility.
//  // angleMul, angleOff now don't have a direct effect, but we keep them in the call for compatibility.
    // dotCount, radius, dotSize define the look of the grid.
//  // dotCount, radius, dotSize define the look of the grid.
    // dotCount, radius, dotSize define the look of the grid.
//  // dotCount, radius, dotSize define the look of the grid.
    // nGroups, gID allow for patterned distribution of the dots.
//  // nGroups, gID allow for patterned distribution of the dots.
    // nGroups, gID allow for patterned distribution of the dots.
//  // nGroups, gID allow for patterned distribution of the dots.

    float dotCount = 20.; float dotSize = 0.025;
//  float dotCount = 20.; float dotSize = 0.025;
#if PULSE_MODE
// #if PULSE_MODE
    dotSize = mix(0.01, .025, (sin(time / 2.) + 1.) / 2.);
//  dotSize = mix(0.01, .025, (sin(time / 2.) + 1.) / 2.);
#endif
// #endif
    float  nGroups = 4.;
//  float  nGroups = 4.;
    vec3
//  vec3
    col  = vec3(0.0)   ;
//  col  = vec3(0.0)   ;
    col += mainImage2(uv + m                   , -1.5, 0.0, dotCount, dotSize, nGroups, 0.0).rgb;
//  col += mainImage2(uv + m                   , -1.5, 0.0, dotCount, dotSize, nGroups, 0.0).rgb;
    col += mainImage2(uv + m * vec2( 1.0, -1.0),  1.0, 0.0, dotCount, dotSize, nGroups, 1.0).rgb;
//  col += mainImage2(uv + m * vec2( 1.0, -1.0),  1.0, 0.0, dotCount, dotSize, nGroups, 1.0).rgb;
    col += mainImage2(uv + m * vec2(-1.0,  1.0), -1.0, 0.0, dotCount, dotSize, nGroups, 2.0).rgb;
//  col += mainImage2(uv + m * vec2(-1.0,  1.0), -1.0, 0.0, dotCount, dotSize, nGroups, 2.0).rgb;
    col += mainImage2(uv + m * vec2(-1.0, -1.0),  1.5, 0.0, dotCount, dotSize, nGroups, 3.0).rgb;
//  col += mainImage2(uv + m * vec2(-1.0, -1.0),  1.5, 0.0, dotCount, dotSize, nGroups, 3.0).rgb;

    if (mod(time, INVERT_RATE * 2.) > INVERT_RATE) col = 1. - col;
//  if (mod(time, INVERT_RATE * 2.) > INVERT_RATE) col = 1. - col;
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }


