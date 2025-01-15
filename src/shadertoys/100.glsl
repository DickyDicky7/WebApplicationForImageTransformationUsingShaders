#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/M3tcDl

void main() {
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;

    float count =            80.;
    vec2   roff = vec2(   0,  0);
    vec2   goff = vec2(-.25,.50);
    vec2   boff = vec2( .33,.33);
    
    vec2 uvr=uv*count+roff;
    vec2 uvg=uv*count+goff;
    vec2 uvb=uv*count+boff;
    uvr=vec2(floor(uvr.x)+.5,floor(uvr.y)+.5)/count;
    uvg=vec2(floor(uvg.x)+.5,floor(uvg.y)+.5)/count;
    uvb=vec2(floor(uvb.x)+.5,floor(uvb.y)+.5)/count;
    
    vec3 col = vec3(0);
    col += float(length(uv+roff/count-uvr)<.25/count)*vec3(    texture(tex0,uvr).r,0,0);
    col += float(length(uv+goff/count-uvg)<.25/count)*vec3(0,  texture(tex0,uvg).g,0  );
    col += float(length(uv+boff/count-uvb)<.25/count)*vec3(0,0,texture(tex0,uvb).b    );

    // Output to screen
    // Output to screen
    fragColor = vec4(col,1.0);
}










