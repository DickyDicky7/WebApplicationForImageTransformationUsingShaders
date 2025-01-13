#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// const float wave_speed = 03.0; //wave @@@@@@@@ loop speed
// const float wave_freq  = 10.0; //wave vertical freq @@@@@
// const float wave_width = 01.0; //wave @@@@@@@@ @@@@ width 

uniform float wave_speed ; // 03.0
uniform float wave_freq  ; // 10.0
uniform float wave_width ; // 01.0

void main()
{
    vec2 scale_UV = vTexCoord;
    vec2
    wave_uv_offset;
    wave_uv_offset.x = cos((time * wave_speed) + vTexCoord.x + vTexCoord.y * wave_freq * 2.0) * wave_width * 0.01;
//  fragColor =    vec4(                 wave_uv_offset, 0.0, 1.0);
    fragColor = texture(tex0, scale_UV + wave_uv_offset          );
}


// https://godotshaders.com/shader/2d-water-effect/