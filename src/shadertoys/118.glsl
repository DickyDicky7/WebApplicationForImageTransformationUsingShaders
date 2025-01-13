#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/XXtczH

// conf
#define COLOR_MODE 2
#define MOVE_MODE 1
#define PULSE_MODE 1

#define INVERT_RATE (3.5)
#define COLORSHIFT_INTENSITY (0.5/15.)

// const
#define PI (3.14159)

// code
vec4 mainImage2(in vec2 uv, float dotCount, float dotSize, float nGroups, float gID) {
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
#if COLOR_MODE==2
    dotSize *= dot(texC.rgb, vec3(1./3.));
    float intensity = smoothstep(dotSize, dotSize * 0.8, dist);

    if (gID==0.) return vec4(1.*intensity,0.,0.,1.);
    if (gID==1.) return vec4(0.,1.*intensity,0.,1.);
    if (gID==2.) return vec4(0.,0.,1.*intensity,1.);
    if (gID==3.) return vec4(1.*intensity,0.,0.,1.);

#endif
#if COLOR_MODE==1
    float intensity = smoothstep(dotSize, dotSize * 0.8, dist);
    return vec4(vec3(intensity)*texC, 1.0);
#endif
#if COLOR_MODE==0
    dotSize *= dot(texC.rgb, vec3(1./3.));
    float intensity = smoothstep(dotSize, dotSize * 0.8, dist);
    return vec4(vec3(intensity), 1.0);
#endif
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord.xy / iResolution.xy) * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;  // Adjust for aspect ratio

    vec3 col_ = vec3(0.0);

    if (distance(uv,vec2(0.)) < 0.025) col_.r = 1.;

// RGB delay
for (float i=0.; i<3.; i++) {
    float time = iTime+(i*COLORSHIFT_INTENSITY);
    float moveSpeed = 3.;
    float moveDist = 0.2;

    vec2 off;
#if MOVE_MODE
    off = vec2(sin(time*moveSpeed), cos(time*moveSpeed))*moveDist;
    //if (fract(time/INVERT_RATE*2.)<0.1) off = vec2(0.);
#endif
    vec2 m = (iMouse.z>0.) ? (iMouse.xy / iResolution.xy) * 2.0 - 1.0 : off;

    // The parameters can be tweaked:
    // dotCount, radius, dotSize define the look of the grid.
    // nGroups, gID allow for patterned distribution of the dots.

    float dotCount = 30.;
    float dotRadius = 0.055;
#if PULSE_MODE
    dotRadius = mix(0.02,.055, (sin(time/2.)+1.)/2.);
#endif
    float nGroups = 4.;
    vec3 col = vec3(0.0);
    col += mainImage2(uv + m,                   dotCount, dotRadius, nGroups, 0.0).rgb;
    col += mainImage2(uv + m * vec2(1.0,-1.0),  dotCount, dotRadius, nGroups, 1.0).rgb;
    col += mainImage2(uv + m * vec2(-1.0,1.0),  dotCount, dotRadius, nGroups, 2.0).rgb;
    col += mainImage2(uv + m * vec2(-1.0,-1.0), dotCount, dotRadius, nGroups, 3.0).rgb;

    if (mod(time, INVERT_RATE*2.) > INVERT_RATE) col = 1.-col;
    if (i==0.) col_.r += col.r;
    if (i==1.) col_.g += col.g;
    if (i==2.) col_.b += col.b;
    //col_ += col/3.;
}

    fragColor = vec4(col_,1.0);
}
