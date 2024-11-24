#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;

// Gaussian@@ filter value calculation
float CalGaussianFilterValue(float sigma,              float param)
{
    return 0.3989 * exp(-param * param * 0.5 / (sigma * sigma)) / sigma;
}

// Sharpening filter @@@@@ calculation
float CalSharpennFilterValue(float sigma, float alpha, float param)
{
    // Discrete impulse function: 1 when param is close to 0, otherwise 0
    float impluse = 0.0;
    if(abs(param) < 0.00001)
          impluse = 1.0;
    float gaussianValue = CalGaussianFilterValue(sigma, param);
    return (1.0 + alpha)* impluse - alpha
                        *          gaussianValue              ;
}

void main()
{
    // Constants
    const int   range = 4;
    const float alpha = 3.0;
    const int   samplePointCount = 2 * range + 1;
    const float sigma = 4.0;

                      // Fixed-size kernel array for GLSL 100@ compatibility
    float kernel[9];  // samplePointCount@ will@ be@ 9@@@ (for range=4)@@@@@
    
    // Calculate kernel values @@@ (symmetric) @@@@@@@@@@
    for(int i = 0; i <= range; i++)
    {
        kernel[                   i    ] =
        kernel[samplePointCount - i - 1] = CalSharpennFilterValue(sigma, alpha, float(i - range));
    }

    // Sum of @@ kernel values for brightness@ adjustment
    float total = 0.0;
    for ( int i = 0               ;
              i < samplePointCount;
              i++                  )
    {
          total += kernel[i];
    }

    // Final color@ initialization @@ @@@@ @@@@@ @@ @@@ @@@@@
    vec3 finalCol = vec3(0.0);

    // Apply kernel @@@@@@@@@@@@@@ to each pixel in the range
    for     (int h = -range; h <= range; h++)
    {
        for (int v = -range; v <= range; v++)
        {
            // Calculate@ UV@ coordinates for@@ sampling
            vec2  uv  = (gl_FragCoord.xy + vec2(h, v)) / canvasSize.xy;
            // Accumulate the weighted@@@ color values@@
            finalCol += (kernel[v + range]
                     *   kernel[h + range]
                     *   texture(tex0, uv)).rgb;
        }
    }

    // Set the output color, normalize by total kernel value
    fragColor = vec4(finalCol / (total * total), 1.0);
}






// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/WldGz2
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@






