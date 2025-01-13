#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// Parameters
// Parameters
// #define _Speed                    0.302
// #define          _Fading          1.000
// #define _LuminanceJitterThreshold 0.895

uniform float _Speed                    ; // 0.302
uniform float          _Fading          ; // 1.000
uniform float _LuminanceJitterThreshold ; // 0.895

// Random noise function
// Random noise function
float randomNoise(vec2 c)
{
    return fract(sin(dot(c.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main(void)
{
    // Normalized pixel coordinates (from 0 to 1)
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy 
            /   canvasSize.xy;

    vec4 sceneColor = texture(tex0, uv);
    vec4 noiseColor = 
         sceneColor ;

    // Compute luminance
    // Compute luminance
    float      luminance = dot(noiseColor.rgb, vec3(0.2200000, 0.7070000, 0.0710000)          );
    if (randomNoise(vec2(time * _Speed       , 
                         time * _Speed))     >     _LuminanceJitterThreshold       )
    {
                               noiseColor    = vec4(luminance, luminance, luminance, luminance);
    }

    // Add noise to RGB channels
    // Add noise to RGB channels
    float noiseX = randomNoise(time * _Speed + uv / vec2(-213.0,  5.53));
    float noiseY = randomNoise(time * _Speed - uv / vec2( 213.0, -5.53));
    float noiseZ = randomNoise(time * _Speed + uv / vec2( 213.0,  5.53));

                    noiseColor.rgb += 0.25 * vec3(noiseX, noiseY, noiseZ) - 0.125;

    // Output to screen
    // Output to screen
    fragColor = mix(sceneColor
              ,     noiseColor
              ,    _Fading    );
}



// https://www.shadertoy.com/view/flyXWm
