#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const vec4  fog_color = vec4(1.0);
const float resolution_downsampling = 8.0;
const float bit_depth = 64.0;
const mat4  bayer_matrix_4x4 = mat4(
    vec4( -0.5000,  0.0000, -0.3750,  0.1250 ),
    vec4(  0.2500, -0.2500,  0.3750, -0.1250 ),
    vec4( -0.3125,  0.1875, -0.4375,  0.0625 ),
    vec4(  0.4375, -0.0625,  0.3125, -0.1875 )
);
const int bayer_n = 4;
void vertex() {
	// Called for every vertex the material is visible on.
}

float   get(int y,
            int x) {
	for (int r  = 0;
	         r <= 3;
			 r++   )
	for (int c  = 0;
	         c <= 3;
			 c++   )
		if (y == r
		&&  x == c) return bayer_matrix_4x4[r][c];
}

// float round(float value) {
//   return floor(value + 0.5);
// }

// vec2 round(vec2 v) {
//   return vec2(floor(v.x + 0.5), floor(v.y + 0.5));
// }

// vec3 round(vec3 v) {
//   return vec3(floor(v.x + 0.5), floor(v.y + 0.5), floor(v.z + 0.5));
// }

// vec4 round(vec4 v) {
//   return vec4(floor(v.x + 0.5), floor(v.y + 0.5), floor(v.z + 0.5), floor(v.w + 0.5));
// }

void main() {
	vec2 UV_new = vTexCoord -  mod(vTexCoord, (1.0 / canvasSize) * resolution_downsampling);
	vec3 tex = texture(tex0, UV_new).rgb;
	//float screen_resize = SCREEN_PIXEL_SIZE.x
	vec2 pix_id = vec2(vTexCoord.x / ((1.0 / canvasSize).x * resolution_downsampling),
	                   vTexCoord.y / ((1.0 / canvasSize).y * resolution_downsampling));
//	float bayer_shift = bayer_matrix_4x4[int(mod( pix_id.x, 4.0))][int(mod(pix_id.y, 4.0))];
	float bayer_shift = get(int(mod(pix_id.x, 4.0)) ,
	                        int(mod(pix_id.y, 4.0)));
	tex += vec3(bayer_shift / bit_depth);
	tex.r = round(tex.r * bit_depth-1.0) / (bit_depth-1.0);
	tex.g = round(tex.g * bit_depth-1.0) / (bit_depth-1.0);
	tex.b = round(tex.b * bit_depth-1.0) / (bit_depth-1.0);
	fragColor.rgb = tex.rgb;
	fragColor.a = 1.0;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}



// https://godotshaders.com/shader/simple-ordered-dithering-and-screen-pixelation/