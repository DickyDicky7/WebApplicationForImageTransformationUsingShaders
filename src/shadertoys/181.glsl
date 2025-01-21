#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4XjfDG

uniform float NUMBERSS ; // 100.00
uniform float DISTANCE ; // 000.01

const float pi = 3.14159265358;

void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
    
    vec3    col = vec3(0.0);
    float
    place       =      0.0 ;
    
    for (float i = 1.0; i <= NUMBERSS; i++) { place = ((2.0 * pi) / (NUMBERSS / i)) + (pi / 2.0); col += texture(tex0, uv + DISTANCE * vec2(cos(place) * (canvasSize.y / canvasSize.x), sin(place))).rgb;
    }
    
    col /= NUMBERSS;
//  col /= NUMBERSS;
    
    // Output to screen
    // Output to screen
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
}





