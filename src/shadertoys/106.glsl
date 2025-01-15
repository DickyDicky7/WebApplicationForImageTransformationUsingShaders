#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/lXGcWR

// Simple Kuwahara filter. Doesn't feature any of the later improvements, as I'm still learning.

// Quick way to toggle filter using the preprocessor. Just set to 0 to disable or anything else to enable.
#define FILTERED 1
// Define how large the entire Kuwahara kernel is. Don't set these to 0! Odd values work best.
#define KERNEL_WIDTH 5
#define KERNEL_HEIGHT 5

// Need to initialize quadrants here, since float arrays need constants
#define QUADRANT_WIDTH int(ceil(float(KERNEL_WIDTH) / 2.0))
#define QUADRANT_HEIGHT int(ceil(float(KERNEL_HEIGHT) / 2.0))

// Helper struct to store info about each of the quadrants
struct quadrantInfo
{
    float standardDeviation;
    vec4 averageColor;
};

// Calculate the standard deviation and average pixel color of a given quadrant.
quadrantInfo processQuadrant(vec2 uv, vec2 quadrantOffset, float[QUADRANT_WIDTH * QUADRANT_HEIGHT] kernel)
{
    quadrantInfo result;
    
    // Convert quadrant extents to floats
    float quadrantWidth = float(QUADRANT_WIDTH);
    float quadrantHeight = float(QUADRANT_HEIGHT);
    float quadrantSize = quadrantWidth * quadrantHeight;
    
    // Calculate step size to sample adjacent pixels
    float stepSize = 1.0;
    float stepX = stepSize / iResolution.x;
    float stepY = stepSize / iResolution.y;
    
    // Initialize samples array and mean (will be used for standard deviation calculation after loop)
    float mean = 0.0;
    float[QUADRANT_WIDTH * QUADRANT_HEIGHT] samples;
    
    // Accumulate the final pixel color sample by sample
    for(float y = 0.0; y < quadrantHeight; y++)
    {
        for(float x = 0.0; x < quadrantWidth; x++)
        {
            // Calculate sample offset for both X and Y coordinates.
            vec2 sampleOffset = vec2(0);
            sampleOffset.x = stepX * (x + quadrantOffset.x * quadrantWidth);
            sampleOffset.y = stepY * (y + quadrantOffset.y * quadrantHeight);
            vec4 currentSample = texture(iChannel0, uv + sampleOffset);
            
            // Traverse the kernel from bottom right to top left, flipping it.
            // Flipping the kernel is part of the convolution operation.
            int kernelIndex = int((quadrantSize - 1.0) - (quadrantWidth * y + x));
            result.averageColor += kernel[kernelIndex] * currentSample;
            
            // Add to mean and calculate HSV sample
            mean += max(currentSample.r, max(currentSample.g, currentSample.b));
            samples[kernelIndex] = max(currentSample.r, max(currentSample.g, currentSample.b));
        }
    }
    
    // Calculate mean first
    mean /= quadrantSize;
    
    // Calculate the variance for standard deviation (using the mean)
    float variance = 0.0;
    for(int i = 0; i < QUADRANT_WIDTH * QUADRANT_HEIGHT; i++)
    {
        variance += pow(samples[i] - mean, 2.0);
    }
    variance /= quadrantSize;
    result.standardDeviation = sqrt(variance);
    
    return result;
}

// Return index of quadrant with smallest standard deviation
int getMinStDev(quadrantInfo[4] q)
{
    /*
    This is problematic if two sectors have the same standard deviation, 
    but that's an issue with the algorithm rather than my implementation
    */
    float minStDev = min(q[0].standardDeviation, min(q[1].standardDeviation, min(q[2].standardDeviation, q[3].standardDeviation)));
    
    if(q[0].standardDeviation == minStDev) return 0;
    if(q[1].standardDeviation == minStDev) return 1;
    if(q[2].standardDeviation == minStDev) return 2;
    return 3;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    // Get V (of HSV) from RGB to use for filtering (instead of using R,G,B individually)
    vec4 col = texture(iChannel0, uv);
    float value = max(col.b, max(col.r, col.g));
    
    // Initialize kernel that will be used for each quadrant
    float[QUADRANT_WIDTH * QUADRANT_HEIGHT] kernel;
    for(int i = 0; i < QUADRANT_WIDTH * QUADRANT_HEIGHT; i++)
    {
        kernel[i] = 1.0 / float(QUADRANT_WIDTH * QUADRANT_HEIGHT);
    }
    
    // Process each quadrant to get standard deviation and average pixel color
    quadrantInfo[4] quadrants;
    // X gets larger to the right, Y to the **TOP**
    vec2[] quadrantOffsets = vec2[](vec2(-1, -1), vec2(0, -1), vec2(-1, 0), vec2(0, 0));
    for(int i = 0; i < 4; i++)
    {
        quadrants[i] = processQuadrant(uv, quadrantOffsets[i], kernel);
    }
    
    // Get index of quadrant with smallest standard deviation
    int smallest = getMinStDev(quadrants);
    
    // Output the desired result to screen
    #if FILTERED != 0
    fragColor = quadrants[smallest].averageColor;
    #else
    fragColor = texture(iChannel0, uv);
    #endif
}