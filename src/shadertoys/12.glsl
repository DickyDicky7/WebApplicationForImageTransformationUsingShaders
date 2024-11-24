#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4       glslFragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;

vec3     darkest  = vec3(0.0588235, 0.219608, 0.0588235); 
float lumDarkest  = 0.13921568627450980;
vec3     darker   = vec3(0.1882350, 0.384314, 0.1882350); 
float lumDarker   = 0.28627450980392155;
vec3     lighter  = vec3(0.5450980, 0.674510, 0.0588235); 
float lumLighter  = 0.36666666666666670;
vec3     lightest = vec3(0.6078430, 0.737255, 0.0588235); 
float lumLightest = 0.39803921568627454;

float CalculateHue(vec4 color, float minCol, float maxCol)
{
    float hue = 00.0;  
    hue = hue * 60.0;
    
    if (hue < 0.0)
    {
        hue += 360.0;
    }
    
    if (abs(maxCol - color.r) < 0.000001)
    {
        hue =       (color.g - color.b) / (maxCol - minCol);
    }
    else
    if (abs(maxCol - color.g) < 0.000001)
    {
        hue = 2.0 + (color.b - color.r) / (maxCol - minCol);
    }
    else
    {
        hue = 4.0 + (color.r - color.g) / (maxCol - minCol);
    }
    
    return hue;
}

void main() 
{
    vec2 uv = vTexCoord;
    uv *= 100.00;
    uv = vec2(floor(uv.x), floor(uv.y));
    uv *= 000.01;   
    
    vec4 fragColor = texture(tex0, uv);
    float maxCol = max(max(fragColor.r, fragColor.g), fragColor.b);
    float minCol = min(min(fragColor.r, fragColor.g), fragColor.b);
    float lum = (minCol + maxCol) / 2.0 ;
    
    float  darkestDist = abs(lumDarkest  - lum);
    float   darkerDist = abs(lumDarker   - lum);
    float  lighterDist = abs(lumLighter  - lum);
    float lightestDist = abs(lumLightest - lum);
    
    float minDist = min(min(min(darkestDist, darkerDist), lighterDist), lightestDist);
    
    if (abs(minDist - darkestDist) < 0.000001)
    {
        fragColor = vec4(darkest , 1.0);
    }
    else
    if (abs(minDist -  darkerDist) < 0.000001)
    {
        fragColor = vec4(darker  , 1.0);
    }
    else
    if (abs(minDist - lighterDist) < 0.000001)
    {
        fragColor = vec4(lighter , 1.0);
    }
    else
    {
        fragColor = vec4(lightest, 1.0);
    }
    
    glslFragColor = fragColor;
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/ltV3Wc
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
