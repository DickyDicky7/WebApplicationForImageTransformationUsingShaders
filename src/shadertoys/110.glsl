#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/MXyyWD

uniform vec2    tiles; // 128.0, 064.0
uniform vec2 subTiles; // 003.0, 001.0

vec3 colors[3] = vec3[](
    vec3(1.0, 0.0, 0.0),
    vec3(0.0, 1.0, 0.0),
    vec3(0.0, 0.0, 1.0)
);

void main()
{	
    vec2 texUv    = ( floor(vTexCoord * tiles) + 0.5) / tiles;
    vec3 texColor = texture( tex0     , texUv) . xyz         ;
    
    //     pixel uv
    //     pixel uv
    vec2 r  = fract(vTexCoord * tiles);
    // sub-pixel uv
    // sub-pixel uv
         r *=                subTiles ;
    vec3 color = colors[int(r.x)];
    
    // center align
    // center align
    r = fract(r) -      0.5  ;
    // u=u^2, v=v^2
    // u=u^2, v=v^2
    r =   pow(r  , vec2(2.0));
    // dot(r,r) = u^4 + v^4  it's an round-rectangle
    // dot(r,r) = u^4 + v^4  it's an round-rectangle
    float lumin = 1.0 - pow(min(1.0, 20.0 * dot(r, r)), 2.0);
    
    fragColor = vec4(
        color *
     texColor *
        lumin , 1.0 );
}









