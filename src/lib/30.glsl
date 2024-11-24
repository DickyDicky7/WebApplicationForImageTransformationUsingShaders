#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float speedScale   = 16.0;
const float clipPosition = 00.2;

// float round(float x) {
//     return floor(x + 0.5);
// }

// vec2 round(vec2 v) {
//     return vec2(round(v.x), round(v.y));
// }

// vec3 round(vec3 v) {
//     return vec3(round(v.x), round(v.y), round(v.z));
// }

// vec4 round(vec4 v) {
//     return vec4(round(v.x), round(v.y), round(v.z), round(v.w));
// }


float random (vec2 uv) {
    return     fract(sin(dot(uv.xy, vec2(12.9898,78.2330))) * 43758.5453123);
}

void main() {
	fragColor.a = 0.0;
	
	vec2  pos   = vTexCoord  - vec2(0.5);
	float theta = round(64.0 * atan(pos.y, pos.x));
	float  dist = sqrt(pow(pos.x, 2.0)
	            +      pow(pos.y, 2.0) );
	
	float distValue = round(dist * 4.0 + time * -speedScale + 8.0 * random(vec2(theta)));
	if (dist > clipPosition + random(vec2(theta           )) * 0.30
	&&                        random(vec2(theta, distValue)) < 0.02) {
		fragColor.a   =      1.0 ;
		fragColor.rgb = vec3(1.0);
	}

	fragColor = max(fragColor, (1.0 - fragColor) * texture(tex0, vTexCoord));
}

// https://godotshaders.com/shader/motion-lines/