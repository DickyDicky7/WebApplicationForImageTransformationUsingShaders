#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float scanline_count = 50.0;

vec2 uv_curve(vec2 uv)
{
    uv  = (uv - 0.5) * 2.0;
    uv.x *= 1.0 + pow(abs(uv.y) / 3.0, 2.0);
    uv.y *= 1.0 + pow(abs(uv.x) / 3.0, 2.0);
    uv /= 1.2;
    uv  = (uv / 2.0) + 0.5;
    return uv;
}


void main()
{	
    float PI = 3.14159;
    
    float r = texture(tex0, uv_curve(vTexCoord) + vec2((1.0 / canvasSize).x *  0.0), 0.0).r;
    float g = texture(tex0, uv_curve(vTexCoord) + vec2((1.0 / canvasSize).x *  3.0), 0.0).g;
    float b = texture(tex0, uv_curve(vTexCoord) + vec2((1.0 / canvasSize).x * -3.0), 0.0).b;
    
    
    float s = sin(uv_curve(vTexCoord).y * scanline_count * PI * 2.0);
          s = (s * 0.5 + 0.5) * 0.9 + 0.10;
    vec4 scan_line = vec4(vec3(pow(s, 0.25)), 1.0);
    
    
    fragColor = vec4(r, g, b, 1.0) * scan_line;
}




// https://godotshaders.com/shader/retro-tv-shader/