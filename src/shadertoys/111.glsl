#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/43yyWD

void mainImage( out vec4 fragColour, in vec2 fragCoord )
{
    int i = int(fragCoord.y)&31;

    // reverse bits so order of lines is more pleasing
    i = ((i&1)<<4)+((i&2)<<2)+(i&4)+((i&8)>>2)+((i&16)>>8);

    float a = float(i)/32.;

    vec2 uv = .5+(fragCoord-iResolution.xy*.5)*vec2(iChannelResolution[0].y/iChannelResolution[0].x,1)/iResolution.y;

    // stretch the sides out to fill the frame, but leave the middle the correct aspect ratio
    const float r = .65;
    uv.x = mix( uv.x, fragCoord.x/iResolution.x, 2.*smoothstep(1.-r,1.+r,abs(1.-2.*fragCoord.x/iResolution.x)) );

    vec3 x = texture(iChannel0,uv).xyz;
    x = pow(x,vec3(2.2));
    
    float t = dot(x,vec3(2,-1,0));
    
    fragColour = vec4(mix(vec3(1,0,.7)*.6,vec3(.3,1,.9),step(a,t)),1);
}