#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/M3KyRc

vec4 BlurColor (in vec2 Coord, in sampler2D Tex, in float MipBias)
{
    vec2 TexelSize =                                      MipBias
       /canvasSize ;
    
    vec4
    Color  = texture(Tex, Coord                                   , MipBias);
    Color += texture(Tex, Coord + vec2( TexelSize.x,          0.0), MipBias);    	
    Color += texture(Tex, Coord + vec2(-TexelSize.x,          0.0), MipBias);    	
    Color += texture(Tex, Coord + vec2(         0.0,  TexelSize.y), MipBias);    	
    Color += texture(Tex, Coord + vec2(         0.0, -TexelSize.y), MipBias);    	
    Color += texture(Tex, Coord + vec2( TexelSize.x,  TexelSize.y), MipBias);    	
    Color += texture(Tex, Coord + vec2(-TexelSize.x,  TexelSize.y), MipBias);    	
    Color += texture(Tex, Coord + vec2( TexelSize.x, -TexelSize.y), MipBias);    	
    Color += texture(Tex, Coord + vec2(-TexelSize.x, -TexelSize.y), MipBias);    

    return Color / 9.0;
}


void main()
{
    float Threshold = 0.0;
    float Intensity = 2.0;
    float BlurSize  = 6.0;

    vec2 uv        =        vTexCoord ;
    vec4     Color = texture(tex0, uv);
    vec4 Highlight = clamp(BlurColor(uv, tex0, BlurSize) - Threshold, 0.0, 1.0) * 1.0 / (1.0 - Threshold);
//  vec4 Highlight = clamp(BlurColor(uv, tex0, BlurSize) - Threshold, 0.0, 1.0) * 1.0 / (1.0 - Threshold);
        
    fragColor = 1.0 - (1.0 - Color) * (1.0 - Highlight * Intensity); //Screen Blend Mode
//  fragColor = 1.0 - (1.0 - Color) * (1.0 - Highlight * Intensity); //Screen Blend Mode
}




