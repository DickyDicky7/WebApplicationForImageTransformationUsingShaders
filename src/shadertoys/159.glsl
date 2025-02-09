#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/tsKcRV

#define pi 3.14159265359

void main()
{
    vec2 uv = vTexCoord; 
//  vec2 uv = vTexCoord; 
    vec4 base = texture(tex0, uv);
//  vec4 base = texture(tex0, uv);
    
    vec2 new_pos;
//  vec2 new_pos;
    vec2 shift = vec2(15.0 / canvasSize.x, 0.0);
//  vec2 shift = vec2(15.0 / canvasSize.x, 0.0);
    
    ///////////////////////////
    ///////////////////////////
    
    if (uv.x < 0.5) {
//      new_pos = vec2( uv.x              / 2.0, uv.y);
        new_pos = vec2((uv.x + 0.5 + 1.0) / 2.0, uv.y);
    } else {
//      new_pos  = vec2((uv.x + 1.0) / 2.0, uv.y);        
        shift   *= -1.0;
        new_pos  = vec2((uv.x - 0.5) / 2.0, uv.y);
    }
    vec4 overlay = vec4(
        texture(tex0, new_pos              ).r,
        texture(tex0, new_pos +       shift).g,
        texture(tex0, new_pos + 2.0 * shift).b,
        1.0
    );    
    fragColor = mix(base, overlay, pow(2.0 * abs(uv.x - 0.5), 2.0));
//  fragColor = mix(base, overlay, pow(2.0 * abs(uv.x - 0.5), 2.0));
    
    ///////////////////////////
    ///////////////////////////
    
    shift = vec2(0.0, 15.0 / canvasSize.y);
//  shift = vec2(0.0, 15.0 / canvasSize.y);
    if (uv.y < 0.5) {
//      new_pos = vec2(uv.x / 2.0,  uv.y                   );
        new_pos = vec2(uv.x      , (uv.y + 0.5 + 1.0) / 2.0);
    } else {
//      new_pos  = vec2(      (uv.x + 1.0) / 2.0, uv.y);        
         shift  *= -1.0;
        new_pos  = vec2(uv.x, (uv.y - 0.5) / 2.0      );
    }
    overlay = vec4(
        texture(tex0, new_pos              ).r,
        texture(tex0, new_pos +       shift).g,
        texture(tex0, new_pos + 2.0 * shift).b,
        1.0
    );    
    fragColor = mix(fragColor, overlay, pow(2.0 * abs(uv.y - 0.5), 2.0));
//  fragColor = mix(fragColor, overlay, pow(2.0 * abs(uv.y - 0.5), 2.0));
}










