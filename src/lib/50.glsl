#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;


const float strength = 2.0;

void main() {
	 vec4       outputt    = texture(tex0, vTexCoord);
	
	float shift = strength * texture(tex0, vTexCoord).r / 100.0;
	outputt.r = texture(tex0, vec2(vTexCoord.x + shift, vTexCoord.y)).r;
	outputt.g = texture(tex0, vTexCoord).g;
	outputt.b = texture(tex0, vec2(vTexCoord.x - shift, vTexCoord.y)).b;
	
	fragColor = outputt;
}

// https://godotshaders.com/shader/chromatic-abberation-with-offset/