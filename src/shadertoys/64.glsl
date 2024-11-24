#version 300 es
precision highp float;

uniform         sampler2D          tex0; //texture
uniform         sampler2D          tex1; //noise
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

void main() {
    // vec2 resolution = vec2(640.0, 360.0);
    float stepVal = 4.0;
    float resScale = 0.1;

    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vTexCoord;
    
    // Get the offset value from the second texture channel based on time
    float offset = texture(tex1, vec2(time * 0.1, 0.0)).g;
    offset = floor(offset * 8.0) / 8.0;
    
    // Fetch noise data from the second texture channel
    vec3 noiseBase = texture(tex1, vec2(uv.y * resScale, offset)).rgb;
    
    // Fetch static noise from the second texture channel
    float staticNoise = texture(tex1, uv * 1.3).r;
    
    // Apply quantization to the noise values
    float noiseR = floor(noiseBase.r * stepVal) / stepVal;
    float noiseG = floor(noiseBase.g * stepVal) / stepVal;
    float noiseB = floor(noiseBase.b * stepVal) / stepVal;
    
    // Get time-dependent noise value
    float timeNoise = texture(tex1, vec2(time * 0.1, 0.0)).r * 0.7;
    if (timeNoise < 0.4) {
        timeNoise = 0.0;
    }

    // Fetch the pixel values from the first texture channel with noise displacement
    float r = texture(tex0, uv + vec2(noiseR, 0.0) * 0.07 * timeNoise).r;
    float g = texture(tex0, uv + vec2(noiseG, 0.0) * 0.07 * timeNoise).g;
    float b = texture(tex0, uv + vec2(noiseB, 0.0) * 0.07 * timeNoise).b;
    
    // Get the base color from the first texture channel
    vec3 baseImg = texture(tex0, uv).rgb;
    vec3 color = vec3(r, g, b);

    // Output final color, incorporating static noise and time noise
    fragColor = vec4(color + staticNoise * (timeNoise + 0.2) * 0.2, 1.0);
}


// https://www.shadertoy.com/view/4X2yWw

