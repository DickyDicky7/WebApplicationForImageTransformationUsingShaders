#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

float triWave( float  x ) {
    return( abs( mod( x - 10.0, 20.0 ) - 10.0 ) + 1.0 );
}

void main(void) {
    vec2  uv    = gl_FragCoord .xy / canvasSize.xy;
          uv    =               uv                * 02.0 - 1.0;
    float mouse = mousePosition.x  / canvasSize.x * 10.0 + 1.0;
    
    vec2 uvR;
    vec2 uvG;
    vec2 uvB;
    
    if (mousePosition.z > 0.0) {
        uvR = uv * (1.0 - length(uv) / mouse);
        uvG = uv * (1.0 - length(uv) / mouse + 0.005);
        uvB = uv * (1.0 - length(uv) / mouse + 0.010);
    }   else                   {
        uvR = uv * (1.0 - length(uv) / triWave(time * 5.0));
        uvG = uv * (1.0 - length(uv) / triWave(time * 5.0 + 0.1));
        uvB = uv * (1.0 - length(uv) / triWave(time * 5.0 + 0.2));
    }
    
    uvR = uvR / 2.0 + 0.5;
    uvG = uvG / 2.0 + 0.5;
    uvB = uvB / 2.0 + 0.5;
    
    float R = texture(tex0, uvR).r;
    float G = texture(tex0, uvG).g;
    float B = texture(tex0, uvB).b;
    
    fragColor = vec4(R, G, B, 1.0);
}



// https://www.shadertoy.com/view/3dtcRf
