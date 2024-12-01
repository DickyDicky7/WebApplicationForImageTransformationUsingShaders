#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// Convert RGB color to CMYK
// Convert RGB color to CMYK
vec4 cmyk(vec3 c) {
    float k = 1.0 - max(c.r, max(c.g, c.b));
    return vec4(
        (1.0 - c.r - k) / (1.0 - k),
        (1.0 - c.g - k) / (1.0 - k),
        (1.0 - c.b - k) / (1.0 - k),
        k
    );
}

// Grid pattern rotated by 'a' radians with the density 'dens'
// Grid pattern rotated by 'a' radians with the density 'dens'
vec2 grid(vec2 uv, float a, float dens) {
    vec2 aspect = canvasSize.xy / canvasSize.y;
    return vec2(
        mod(((uv.x * aspect.x) * cos(a) - uv.y * sin(a)) * dens, 1.0), 
        mod(((uv.x * aspect.x) * sin(a) + uv.y * cos(a)) * dens, 1.0)
    );
}

void main(void)
{
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2         uv = gl_FragCoord.xy / canvasSize.xy;

    vec3      col   = texture(tex0, uv).rgb;
    
    // Color of the image, converted to CMYK
    // Color of the image, converted to CMYK
    vec4  cmykColor = cmyk(col);
    
    // Density of the dots
    // Density of the dots
    float dens      = 100.0    ;
    
    // Rotation angles for different ink colors
    // Rotation angles for different ink colors
    // http://the-print-guide.blogspot.com/2009/05/halftone-screen-angles.html
    // http://the-print-guide.blogspot.com/2009/05/halftone-screen-angles.html
    float ca = 0.261;
    float ma = 1.309;
    float ya = 0.000;
    float ka = 0.785;
    
    vec2  cgrid = grid(uv, ca, dens);
    
    float cb = cmykColor.x * 0.8 / length(cgrid - vec2(0.5));
          cb =  pow(    cb       , 5.0);
          cb =  max(min(cb , 1.0), 0.0);
    vec3  cv = vec3(    cb , 0.0 , 0.0);
    
    vec2  mgrid = grid(uv, ma, dens);
    
    float mb = cmykColor.y * 0.9 / length(mgrid - vec2(0.5));
          mb =  pow(    mb       , 5.0);
          mb =  max(min(mb , 1.0), 0.0);
    vec3  mv = vec3(0.0    , mb  , 0.0);
    
    vec2  ygrid = grid(uv, ya, dens);
    
    float yb = cmykColor.z * 0.8 / length(ygrid - vec2(0.5));
          yb =  pow(    yb ,       5.0);
          yb =  max(min(yb , 1.0), 0.0);
    vec3  yv = vec3(0.0    , 0.0 , yb );
    
    vec2  kgrid = grid(uv, ka, dens);
    
    float kb = cmykColor.w * 0.6 / length(kgrid - vec2(0.5));
          kb =  pow(    kb , 5.0      );
          kb =  max(min(kb , 1.0), 0.0);
    vec3  kv = vec3(    kb            );

    // Output to screen
    // Output to screen
    fragColor = vec4(vec3(1.0) - cv - mv - yv - kv, 1.0);
}


// https://www.shadertoy.com/view/Ds2fRD
