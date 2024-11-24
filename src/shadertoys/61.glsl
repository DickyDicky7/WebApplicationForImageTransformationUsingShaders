#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

void main(  )
{
    float inc = 2.0*mousePosition.x;
    // Normalized pixel coordinates (from 0 to 1)
    if (inc<.001) inc = (sin(time)*.5+.5)*canvasSize.x;
    vec2 uv = 2.0*((mod(gl_FragCoord.xy,inc)+(ceil(gl_FragCoord.xy / inc)*inc/2.0)))/canvasSize.xy;

    // Time varying pixel color
    vec3 col = texture(tex0,uv).rgb;

    // Output to screen
    fragColor = vec4(col,1.0);
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/lXsGzr
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
