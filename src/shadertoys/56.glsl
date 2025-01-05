#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

//const float VINGETTE =    0.2;
uniform float VINGETTE ; // 0.2

void main(void)
{
    float RES = 300.0;
    vec2  res = vec2(RES, RES * (canvasSize.y  / canvasSize.x));
    vec2  uv  =                gl_FragCoord.xy / canvasSize.xy ;
    
    // Simulate lo-res by adjusting UV coordinates
    // Simulate lo-res by adjusting UV coordinates
    uv -= mod(uv, 1.0 / res);

    //--------------------------------------------
    //--------------------------------------------
    vec3 color = texture(tex0, uv).xyz;
    
    // Apply vignette effect (darkening around the edges)
    // Apply vignette effect (darkening around the edges)
    float    vignette = 1.0 - VINGETTE * length(2.0 * uv - 1.0);
    color *= vignette                                          ;
    
    // Reduce color depth
    // Reduce color depth
        color -= mod (color, 1.0 / 4.0);

    // Output to screen
    // Output to screen
    fragColor  = vec4(color, 1.0      );
}



// https://www.shadertoy.com/view/lfXSDs
