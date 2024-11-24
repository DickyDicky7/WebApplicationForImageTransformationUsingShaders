#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// texture to be used as "pixels"// texture to be used as "pixels"
// texture to be used as "pixels"// texture to be used as "pixels"
uniform sampler2D tiledtexture;
// how much of the tiled texture to show (1 recommended) 
// how much of the tiled texture to show (1 recommended) 
const float    opacity = 1.00;
// size of pixelation effect
// size of pixelation effect
const float pixel_size = 0.01;
// whether to greyscale the image or not before applying tiletexture
// whether to greyscale the image or not before applying tiletexture
const bool  greyscale  = true;
// whether to greyscale the image or not before applying tiletexture
// whether to greyscale the image or not before applying tiletexture
const float  contrast  = 1.00;
// grab the camera's view
// grab the camera's view
// uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap; 
// uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap; 
// the overriding color of the tiled texture, white by default
// the overriding color of the tiled texture, white by default
const vec3      pixel_colors = vec3(0.0, 1.0, 0.0);
// the overriding color of the background, black by default
// the overriding color of the background, black by default
const vec3 background_colors = vec3(0.0, 0.0, 0.0);

// Convert to Greyscale using luminosity method if aplicable
// Convert to Greyscale using luminosity method if aplicable
vec4 to_grayscale(vec4 color) {
	float       luminance = 0.21 * color.r
                          + 0.72 * color.g
                          + 0.07 * color.b;
	return vec4(luminance, luminance, luminance, color.a);
}

// Adjust contrast of the greyscale image
// Adjust contrast of the greyscale image
vec4 adjust_contrast(vec4 color) {
	                      color.rgb = (color.rgb - 0.5) * max(contrast, 0.0) + 0.5;
	return                color;
}

// Applies the tiled texture on top of the original texture imitating 
// Applies the tiled texture on top of the original texture imitating 
// photoshop's HARD MIX blending mode
// photoshop's HARD MIX blending mode
vec4 hard_mix(vec4 color1, vec4 color2) {
    vec4 result;
    // The resulting texture
    // The resulting texture
    for (int i = 0; i < 4; i++) {
        // loop through the four channels
        // loop through the four channels
        float value = color1[i] + color2[i];
        // add the values of the two colors
        // add the values of the two colors
        if (  value >= 1.0  )
        {
            // if the value is greater than or equal to 1.0, set it to 1.0
            // if the value is greater than or equal to 1.0, set it to 1.0
            result[i] = 1.0;
        }
        else
        {
            // otherwise, set it to 0.0
            // otherwise, set it to 0.0
            result[i] = 0.0;
        }
    }
    return result; // return the result color
}

vec4 sample_glow_pixel(sampler2D tex, vec2 uv) {
	float                                             hdr_threshold =      0.1  ; // Exagerated, almost everything will glow
	return max(       textureLod(tex,      uv, 2.0) - hdr_threshold , vec4(0.0));
}

// main fragment func
// main fragment func
void main() {
	
	vec2 uv  = vTexCoord;
	vec2 uv2 = vTexCoord;
	
	// apply pixelation on the base texture
    // apply pixelation on the base texture
	uv = floor(uv / pixel_size) 
                  * pixel_size;
	vec4 color1 = sample_glow_pixel(tex0, uv);
	
	// apply greyscale adjustments if applicable
    // apply greyscale adjustments if applicable
	if (greyscale) {
		color1 =     to_grayscale(color1);
		color1 = adjust_contrast (color1);
	}
	
	// apply hard mix blending
    // apply hard mix blending
	vec4 color2 = sample_glow_pixel(tiledtexture, uv2 / pixel_size       );
	vec4 final_result =      mix(color1
                      , hard_mix(color1, color2),                 opacity);
	
	// replace default white with desired color
    // replace default white with desired color
	if (final_result == vec4(1.0, 1.0, 1.0, 1.0)) {
		final_result =  vec4(pixel_colors , 1.0);
		// replace default black background with desired color
        // replace default black background with desired color
	}
    else
    {
		if (final_result == vec4(0.0, 0.0, 0.0    , 1.0)) {
			final_result =  vec4(background_colors, 1.0);
		}
	}
	
	// assign final texture
    // assign final texture
	fragColor = final_result;
}


// https://godotshaders.com/shader/analog-monitor/