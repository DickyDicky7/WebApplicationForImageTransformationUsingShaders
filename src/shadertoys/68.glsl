#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#define t time
#define r canvasSize.xy

void main(  ){
	vec3 c;
	float l,z=t;
	for(int i=0;i<3;i++) {
		vec2 uv,p=gl_FragCoord.xy/r;
		uv=p;
		p-=.5;
		p.x*=r.x/r.y;
		z+=.07;
		l=length(p);
		uv+=p/l*(sin(z)+1.)*abs(sin(l*9.-z-z));
		c[i]=.01/length(mod(uv,1.)-.5);
	}
	fragColor=vec4(c/l,t);
    fragColor=max(fragColor,(1.0-fragColor)*texture(tex0, vTexCoord));
}


// https://www.shadertoy.com/view/XsXXDn

// http://www.pouet.net/prod.php?which=57245
// If you intend to reuse this shader, please add credits to 'Danilo Guanabara'
