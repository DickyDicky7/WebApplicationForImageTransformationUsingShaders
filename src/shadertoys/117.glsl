#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/43tyzH

// conf
#define COLOR_MODE 0
#define MOVE_MODE 1
#define PULSE_MODE 0

#define INVERT_RATE 3.5

// const
#define PI (3.14159)

// code
vec4 mainImage2(in vec2 uv, float angleMul, float angleOff, float dotCount, float dotSize, float nGroups, float gID) {
    // Scale uv by dotCount to get a denser or sparser grid:
    vec2 scaledUV = uv * dotCount;

    // Find the nearest integer lattice point:
    vec2 cell = floor(scaledUV + 0.5); 
    // Convert cell back to world coordinates for the dot position:
    vec2 dotPos = (cell / dotCount);

    // If desired, use grouping logic to show/hide certain dots.
    // For example, only draw a dot if (cell.x + cell.y) mod nGroups == gID.
    float cellIndex = mod((cell.x + cell.y), nGroups);
    if (cellIndex != gID) return vec4(0.0);

    // Compute the distance from the current pixel to the dot center:
    float dist = length(uv - dotPos);
    
    vec2 unuv = vec2(uv.x/(iResolution.x/iResolution.y), uv.y);
    unuv = (unuv+1.)/2.; // undo resolution scaling
    vec3 texC = texture(iChannel0, unuv).rgb;
    texC += texture(iChannel1, unuv).rgb;
    texC /= 2.;

    // Use smoothstep to create a soft-edged dot:
#if COLOR_MODE
    float intensity = smoothstep(dotSize, dotSize * 0.8, dist);
    return vec4(vec3(intensity)*texC, 1.0);
#else
    dotSize *= dot(texC.rgb, vec3(1./3.));
    float intensity = smoothstep(dotSize, dotSize * 0.8, dist);
    return vec4(vec3(intensity), 1.0);
#endif
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;  // Adjust for aspect ratio
    
    float time = iTime;
    float moveSpeed = 3.;
    float moveDist = 0.1;

    vec2 off;
#if MOVE_MODE
    off = vec2(sin(time*moveSpeed), cos(time*moveSpeed))*moveDist;
    //if (fract(time/INVERT_RATE*2.)<0.1) off = vec2(0.);
#endif
    vec2 m = (iMouse.z>0.) ? (iMouse.xy / iResolution.xy) * 2.0 - 1.0 : off;

    // Instead of spinning circles, we now get a grid of dots.
    // The parameters can be tweaked:
    // angleMul, angleOff now don't have a direct effect, but we keep them in the call for compatibility.
    // dotCount, radius, dotSize define the look of the grid.
    // nGroups, gID allow for patterned distribution of the dots.

    float dotCount = 20.;
    float dotSize = 0.025;
#if PULSE_MODE
    dotSize = mix(0.01,.025, (sin(time/2.)+1.)/2.);
#endif
    float nGroups = 4.;
    vec3 col = vec3(0.0);
    col += mainImage2(uv + m,               -1.5, 0.0, dotCount, dotSize, nGroups, 0.0).rgb;
    col += mainImage2(uv + m * vec2(1.0,-1.0), 1.0,  0.0, dotCount, dotSize, nGroups, 1.0).rgb;
    col += mainImage2(uv + m * vec2(-1.0,1.0), -1.0, 0.0, dotCount, dotSize, nGroups, 2.0).rgb;
    col += mainImage2(uv + m * vec2(-1.0,-1.0),1.5,  0.0, dotCount, dotSize, nGroups, 3.0).rgb;

    if (mod(time, INVERT_RATE*2.) > INVERT_RATE) col = 1.-col;
    fragColor = vec4(col,1.0);
}
