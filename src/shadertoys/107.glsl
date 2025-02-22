#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/MXycWR

// Parameters
// Parameters
uniform float radius   ; // 4.0
uniform float strength ; // 4.0
// 1.0 to 5.0
// 0.5 to 8.0
void main()
{

    

    
    // Calculate normalized texture coordinates
    // Calculate normalized texture coordinates
    vec2 tex = vTexCoord;
//  vec2 tex = vTexCoord;
    
    // Sample the texture at the given coordinates
    // Sample the texture at the given coordinates
    vec4 c0 = texture(tex0, tex);
//  vec4 c0 = texture(tex0, tex);
    
    // Convert to YUV
    // Convert to YUV
    vec3  rgb =     c0.rgb;
    float y =  0.299 * rgb.r + 0.587 * rgb.g + 0.114 * rgb.b;
    float u = -0.147 * rgb.r - 0.289 * rgb.g + 0.436 * rgb.b;
    float v =  0.615 * rgb.r - 0.515 * rgb.g - 0.100 * rgb.b;
    
    // YUV color
    // YUV color
    vec3 yuv = vec3(y, u, v);
    
    // Min/Max values initialization
    // Min/Max values initialization
    float min = 999.0;
    float max = 000.0;
    
    // Sampling step sizes
    // Sampling step sizes
    float dx = 1.0 / canvasSize.x;
    float dy = 1.0 / canvasSize.y;
    
    // Loop through the neighboring pixels within the radius
    // Loop through the neighboring pixels within the radius
    for (int y1 = -int(radius); y1 <= int(radius); y1++) {
    for (int x1 = -int(radius); x1 <= int(radius); x1++) {
            if (float(x1 * x1 + y1 * y1)
                                   <=     radius
                                   *      radius) {
                vec2 offset = vec2(float(x1) * dx
                            ,      float(y1) * dy
                                  );
                vec4 neighborColor = texture(tex0, tex + offset);
//              vec4 neighborColor = texture(tex0, tex + offset);

                // Convert the neighboring color to YUV
                // Convert the neighboring color to YUV
                rgb = neighborColor.rgb;
//              rgb = neighborColor.rgb;
                float neighborY = 0.299 * rgb.r
                                + 0.587 * rgb.g
                                + 0.114 * rgb.b;
                
                // Update min and max values
                // Update min and max values
                if (neighborY > max) max = neighborY;
                if (neighborY < min) min = neighborY;
            }
        }
    }
    
    // Adjust Y based on min and max values
    // Adjust Y based on min and max values
    if (abs(max - yuv.r)
    <   abs(min - yuv.r)) {
        yuv.r = (yuv.r + max * strength) / (1.0 + strength);
    } else                {
        yuv.r = (yuv.r + min * strength) / (1.0 + strength);
    }
    
    // Convert YUV back to RGB
    // Convert YUV back to RGB
    float r = yuv.r + 1.402000 * yuv.b                   ;
    float g = yuv.r - 0.344136 * yuv.g - 0.714136 * yuv.b;
    float b = yuv.r + 1.772000 * yuv.g                   ;
    
    // Final color output
    // Final color output
    fragColor = vec4(r, g, b, 1.0);
}





