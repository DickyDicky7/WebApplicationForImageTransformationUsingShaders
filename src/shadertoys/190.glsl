#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/McGyzd

const float Line_Smoothness = 0.045; // range from 0 to 0.1
const float Line_Width = 0.09; // range from 0 to 0.2
const float Brightness = 3.0;
const float Rotation_deg = 30.; // range from -90 to 90
const float Distortion = 1.8; // range from 1 to 2
const float Speed = 0.7;
const float Position = 0.; // range from 0 to 1
const float Position_Min = 0.25;
const float Position_Max = 0.5;
const float Alpha = 1.; // range from 0 to 1
const vec3 Glow_Color = vec3(0.6, 0.7, 0.9);

vec2 rotate_uv(vec2 uv, vec2 center, float rotation, bool use_degrees){
		float _angle = rotation;
		if(use_degrees){
			_angle = rotation * (3.1415926/180.0);
		}
		mat2 _rotation = mat2(
			vec2(cos(_angle), -sin(_angle)),
			vec2(sin(_angle), cos(_angle))
		);
		vec2 _delta = uv - center;
		_delta = _rotation * _delta;
		return _delta + center;
	}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = fragCoord/iResolution.xy;
    uv.y = 1.0 - uv.y;
	vec2 center_uv = uv - vec2(0.5, 0.5);
	float gradient_to_edge = max(abs(center_uv.x), abs(center_uv.y));
	gradient_to_edge = gradient_to_edge * Distortion;
	gradient_to_edge = 1.0 - gradient_to_edge;
	vec2 rotaded_uv = rotate_uv(uv, vec2(0.5, 0.5), Rotation_deg, true);
	
	float remapped_position;
	{
		float output_range = Position_Max - Position_Min;
		remapped_position = Position_Min + output_range * Position;
	}
	
	float remapped_time = iTime * Speed + remapped_position;
	remapped_time = fract(remapped_time);
	{
		float output_range = 2.0 - (-2.0);
		remapped_time = -2.0 + output_range * remapped_time;
	}
	
	vec2 offset_uv = vec2(rotaded_uv.xy) + vec2(remapped_time, 0.0);
	float line = vec3(offset_uv, 0.0).x;
	line = abs(line);
	line = gradient_to_edge * line;
	line = sqrt(line);
	
	float line_smoothness = clamp(Line_Smoothness, 0.001, 1.0);
	float offset_plus = Line_Width + line_smoothness;
	float offset_minus = Line_Width - line_smoothness;
	
	float remapped_line;
	{
		float input_range = offset_minus - offset_plus;
		remapped_line = (line - offset_plus) / input_range;
	}
	remapped_line = remapped_line * Brightness;
	remapped_line = min(remapped_line, Alpha);
	remapped_line = clamp(remapped_line, -0.2, 1.0);

	// Sample the original texture
	vec4 original_color = texture(iChannel0, uv);
	
	// Apply the effect as an additive blend
	fragColor = original_color + vec4(vec3(remapped_line) * Glow_Color, 0.0);
	fragColor.a = original_color.a;
}
