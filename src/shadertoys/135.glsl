#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/XcVfDG

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    // Calculate step size to sample adjacent pixels
    float step = 1.0;
    float stepX = step / iResolution.x;
    float stepY = step / iResolution.y;
    
    // Sample adjacent pixels (center one isn't needed)
    vec4 topLeft = texture(iChannel0, uv + vec2(-stepX, stepY));
    vec4 topCenter = texture(iChannel0, uv + vec2(0, stepY));
    vec4 topRight = texture(iChannel0, uv + vec2(stepX, stepY));
    
    vec4 centerLeft = texture(iChannel0, uv + vec2(-stepX, 0));
    vec4 centerRight = texture(iChannel0, uv + vec2(stepX, 0));
    
    vec4 bottomLeft = texture(iChannel0, uv + vec2(-stepX, -stepY));
    vec4 bottomCenter = texture(iChannel0, uv + vec2(0, -stepY));
    vec4 bottomRight = texture(iChannel0, uv + vec2(stepX, -stepY));
    
    // Calculate gradients for horizontal and vertical edges using convolution and Sobel kernels
    // Not sure if I have the rotate the Sobel masks 180°, it seems to work without it, too...
    vec4 gradX = topLeft - topRight + 2.0 * centerLeft - 2.0 * centerRight + bottomLeft - bottomRight;
    vec4 gradY = topLeft + 2.0 * topCenter + topRight - bottomLeft - 2.0 * bottomCenter - bottomRight;
    
    // Calculate final pixel color by combining gradients and using their luma value
    vec4 grad = sqrt(gradX * gradX + gradY * gradY);
    float luma = sqrt(grad.x * grad.x + grad.y * grad.y + grad.z * grad.z);
    
    // Output to screen
    fragColor.rgb = vec3(luma);
}