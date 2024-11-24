#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const vec4 u_bgColor = vec4(1.0, 1.0, 1.0, 1.0);
const float u_bgColorFactor = 0.4;
const vec4 u_patternColor = vec4(0.0, 0.0, 0.0, 1.0);

const float u_threshold1 = 0.75;
const float u_threshold2 = 0.50;
const float u_threshold3 = 0.25;
const float u_threshold4 = 0.05;

const vec2 u_bgTiling = vec2(1.0, 1.0);
const vec2 u_patternTiling = vec2(1.0, 1.0);

uniform sampler2D u_bgTexture;
uniform sampler2D u_patternTexture;

const float C2_SQRT2 = 0.707106781;
const mat2 ROT_45 = mat2(vec2(C2_SQRT2, -C2_SQRT2), vec2(C2_SQRT2, C2_SQRT2));
const vec4 COLOR_WHITE = vec4(1.0, 1.0, 1.0, 1.0);

float getIntensity(vec3 color)
{
	return 0.299*color.r + 0.587*color.g + 0.114*color.b;
}

vec4 getPatternColor(vec2 uv, float intensity)
{
	vec2 patternUV1 = vec2(-uv.x, uv.y) * u_patternTiling;
	vec2 patternUV2 = uv * u_patternTiling;
	vec2 patternUV3 = ROT_45*(uv + vec2(0.2358, 0.9123)) * u_patternTiling;
	vec2 patternUV4 = (vec2(uv.x, -uv.y) + vec2(0.4123, 0.7218)) * u_patternTiling;
	vec4 pCol1 = texture(u_patternTexture, patternUV1);
	vec4 pCol2 = texture(u_patternTexture, patternUV2);
	vec4 pCol3 = texture(u_patternTexture, patternUV3);
	vec4 pCol4 = texture(u_patternTexture, patternUV4);
	
	if(intensity > u_threshold1)
		return vec4(1.0, 1.0, 1.0, 1.0);
	if(intensity > u_threshold2)
		return mix(pCol1, COLOR_WHITE, 0.5);
	if(intensity > u_threshold3)
		return mix(pCol1*pCol2, COLOR_WHITE, 0.3);
	if(intensity > u_threshold4)
		return mix(pCol1*pCol2*pCol3, COLOR_WHITE, 0.1);
	return pCol1*pCol2*pCol3*pCol4*0.8;
}

void main()
{
	vec4 origColor = texture(tex0, vTexCoord);
	float intensity = getIntensity(origColor.rgb);
	vec4 bgColor = mix(texture(u_patternTexture, vTexCoord*u_bgTiling), u_bgColor, u_bgColorFactor);
	vec4 patternColor = getPatternColor(vTexCoord, intensity);
	vec4 color = mix(u_patternColor, bgColor, getIntensity(patternColor.rgb));
	fragColor = color;
}


// https://godotshaders.com/shader/pencil-screen-space-shader/