#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/lXKczD

#define GRID_HEIGHT 48.0
#define MIN_RADIUS 0.0
#define MAX_RADIUS 1.2
#define MIN_INTENSITY 0.1
#define MAX_INTENSITY 1.0
#define BACKGROUND 15.0/256.0
#define FOREGROUND vec3(248.0/256.0, 239.0/256.0, 226.0/256.0)

float circle(in vec2 st, in float radius)
{
    float dist = length(st - 0.5);
	return radius == 0.0 ? 0.0 : smoothstep(GRID_HEIGHT / iResolution.y * 1.5, 0.0, dist - radius / 2.0);
}

float intensity(in vec3 col)
{ 
    return 0.299 * col.r + 0.587 * col.g + 0.114 * col.b;
}

float remap(float inMin, float inMax, float outMin, float outMax, float value)
{
    float normalizedValue = clamp((value - inMin) / (inMax - inMin), 0.0, 1.0);
    return mix(outMin, outMax, normalizedValue);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 mc = iMouse.xy / iResolution.y;
    vec2 uv = fragCoord / iResolution.y;
    vec2 gv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    vec2 ouv = gv + 0.5;
    gv = fract(gv * GRID_HEIGHT);
    ouv = floor(ouv * GRID_HEIGHT) / GRID_HEIGHT;
    
    // Mouse
    float blur = 50.0 / iResolution.y;   
    float r = 0.1 + 0.05* sin(iTime);
    vec3 col = 0.9 * vec3(smoothstep( r+blur, r-blur, length( mc - uv ))); 
    //vec3 col = vec3(0.0);
    
    vec3 texCol = texture(iChannel0, ouv).rgb;
    float mask = BACKGROUND;
    // NOTE: Support for MAX_RADIUS exceeding 1.
    for (float y = -1.0; y <= 1.0; y++)
    {
        for (float x = -1.0; x <= 1.0; x++)
        {
            vec2 offset = vec2(x, y);
            texCol = texture(iChannel0, ouv + offset / GRID_HEIGHT).rgb;
            col = max(col, texCol);
            float intensity = intensity(col);
            float radius = remap(MIN_INTENSITY, MAX_INTENSITY, MIN_RADIUS, MAX_RADIUS, intensity * intensity);            
            mask = max(mask, circle(gv - offset, radius));
        }
    }
    
    fragColor = vec4(min(FOREGROUND, vec3(mask)), 1.0);
    //fragColor = vec4(vec3(mask * texCol), 1.0);
    //fragColor = vec4(gv.r, gv.g, 0.0, 1.0);
    //fragColor = vec4(ouv.r, ouv.g, 0.0, 1.0);
    //fragColor = vec4(max(col, texCol), 1.0);
}