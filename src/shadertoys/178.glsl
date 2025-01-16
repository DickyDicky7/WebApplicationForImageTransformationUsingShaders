#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4fcfRj


// Function to rotate coordinates by a specific angle
// Function to rotate coordinates by a specific angle
    vec2 rotate(vec2 coord, float angle) { float rad = radians(angle); float sinAngle = sin(rad); float cosAngle = cos(rad); return vec2( coord.x * cosAngle - coord.y * sinAngle, coord.x * sinAngle + coord.y * cosAngle ); }
//  vec2 rotate(vec2 coord, float angle) { float rad = radians(angle); float sinAngle = sin(rad); float cosAngle = cos(rad); return vec2( coord.x * cosAngle - coord.y * sinAngle, coord.x * sinAngle + coord.y * cosAngle ); }

// Halftone dot function with a density factor (control dot size and spacing)
// Halftone dot function with a density factor (control dot size and spacing)
float halftone(vec2 coord, float intensity, float angle, float density) {
    // Adjust cell size by the density factor (higher value = more dense)
//  // Adjust cell size by the density factor (higher value = more dense)
    float cellSize = 8.0 / density; // Smaller cell size increases the density of dots
//  float cellSize = 8.0 / density; // Smaller cell size increases the density of dots
    
    // Rotate coordinates for proper CMYK angle
//  // Rotate coordinates for proper CMYK angle
    vec2 rotatedCoord = rotate(coord, angle);
//  vec2 rotatedCoord = rotate(coord, angle);

    // Calculate position of the current cell
//  // Calculate position of the current cell
    vec2 cellPos = floor(rotatedCoord / cellSize) * cellSize; // Adjust the cell size here
//  vec2 cellPos = floor(rotatedCoord / cellSize) * cellSize; // Adjust the cell size here
    // Calculate the center of the cell
//  // Calculate the center of the cell
    vec2 cellCenter = cellPos + 0.5 * cellSize;
//  vec2 cellCenter = cellPos + 0.5 * cellSize;
    
    // Distance to center of the cell
//  // Distance to center of the cell
    float distanceToCenter = length(rotatedCoord - cellCenter);
//  float distanceToCenter = length(rotatedCoord - cellCenter);
    
    // Radius of the dot based on intensity (dots become smaller for higher intensity)
//  // Radius of the dot based on intensity (dots become smaller for higher intensity)
    float radius = 0.5 * cellSize * intensity;
//  float radius = 0.5 * cellSize * intensity;
    
    // Return 1.0 (dot) if inside radius, 0.0 (background) otherwise
//  // Return 1.0 (dot) if inside radius, 0.0 (background) otherwise
    return distanceToCenter <= radius ? 1.0 : 0.0;
//  return distanceToCenter <= radius ? 1.0 : 0.0;
}


// ShaderToy version//  // ShaderToy version
void main()
{
    vec2 resolution = canvasSize.xy; resolution.x = resolution.x *0.4; /* vec2 resolution = (297.0, 420.0) */  vec2 screenCoord = gl_FragCoord.xy;
//  vec2 resolution = canvasSize.xy; resolution.x = resolution.x *0.4; /* vec2 resolution = (297.0, 420.0) */  vec2 screenCoord = gl_FragCoord.xy;

    // Get the texture color at the current pixel
//  // Get the texture color at the current pixel
    vec4 texColor = texture(tex0, gl_FragCoord / resolution);
//  vec4 texColor = texture(tex0, gl_FragCoord / resolution);
    
    // CMYK intensities (using inverted RGB)
//  // CMYK intensities (using inverted RGB)
    float c = 1.0 -  texColor.r; //    Cyan
//  float c = 1.0 -  texColor.r; //    Cyan
    float m = 1.0 -  texColor.g; // Magenta
//  float m = 1.0 -  texColor.g; // Magenta
    float y = 1.0 -  texColor.b; // Yellow
//  float y = 1.0 -  texColor.b; // Yellow
    float k = min(c, min(m, y)); //   Black
//  float k = min(c, min(m, y)); //   Black

    // Halftone layers for each CMYK color
//  // Halftone layers for each CMYK color
    float    cyan = halftone(screenCoord, c, 15.0, 4.0); //    Cyan layer at 15° with smaller cell size (density factor)
//  float    cyan = halftone(screenCoord, c, 15.0, 4.0); //    Cyan layer at 15° with smaller cell size (density factor)
    float magenta = halftone(screenCoord, m, 75.0, 4.0); // Magenta layer at 75° with smaller cell size (density factor)
//  float magenta = halftone(screenCoord, m, 75.0, 4.0); // Magenta layer at 75° with smaller cell size (density factor)
    float yellow  = halftone(screenCoord, y, 00.0, 4.0); // Yellow  layer at 00° with smaller cell size (density factor)
//  float yellow  = halftone(screenCoord, y, 00.0, 4.0); // Yellow  layer at 00° with smaller cell size (density factor)
    float   black = halftone(screenCoord, k, 45.0, 4.0); //   Black layer at 45° with smaller cell size (density factor)
//  float   black = halftone(screenCoord, k, 45.0, 4.0); //   Black layer at 45° with smaller cell size (density factor)

    // Composite CMYK layers (subtractive blending)
//  // Composite CMYK layers (subtractive blending)
    vec3 finalColor = vec3(1.0); // Start with white background
//  vec3 finalColor = vec3(1.0); // Start with white background

    // Combine the CMYK channels by subtracting the corresponding color
//  // Combine the CMYK channels by subtracting the corresponding color
    finalColor.r -=    cyan * 1.0  ; // Subtract    Cyan from Red   channel
//  finalColor.r -=    cyan * 1.0  ; // Subtract    Cyan from Red   channel
    finalColor.g -= magenta * 1.0  ; // Subtract Magenta from Green channel
//  finalColor.g -= magenta * 1.0  ; // Subtract Magenta from Green channel
    finalColor.b -= yellow  * 1.0  ; // Subtract Yellow  from Blue  channel
//  finalColor.b -= yellow  * 1.0  ; // Subtract Yellow  from Blue  channel
    finalColor   -= vec3(k) * black; // Subtract   Black from all   channels
//  finalColor   -= vec3(k) * black; // Subtract   Black from all   channels

    // Ensure the final color is clamped between 0 and 1
//  // Ensure the final color is clamped between 0 and 1
    finalColor = clamp(finalColor, 0.0, 1.0);
//  finalColor = clamp(finalColor, 0.0, 1.0);

    // Output the final color
//  // Output the final color
    fragColor = vec4(finalColor, 1.0);
//  fragColor = vec4(finalColor, 1.0);
}


