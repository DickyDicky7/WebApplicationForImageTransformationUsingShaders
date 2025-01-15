#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

void main(void)
{
    vec2 uv = gl_FragCoord.xy / canvasSize.xy; // Normalized pixel coordinates (from 0 to 1)
    
    int RADIUS = 5;
    vec2 pos;
    vec3 col;

    vec3 mean [4];
    vec3 sigma[4];
    
    for (int i = 0; i < 4; i++) {
        mean [i] = vec3(0.0);
        sigma[i] = vec3(0.0);
    }

    vec2 offsets[4];
    offsets[0] = vec2( -5,  -5);
    offsets[1] = vec2( -5, 0.0);
    offsets[2] = vec2(0.0,  -5);
    offsets[3] = vec2(0.0, 0.0);

    for         (int i = 0; i <  4; i++) {
        for     (int j = 0; j <= 5; j++) {
            for (int k = 0; k <= 5; k++) {
                                                 pos = vec2(j, k) + offsets[i];
                              vec2  uvpos = uv + pos / canvasSize . xy        ;
                col = texture(tex0, uvpos).xyz;

                mean [i] += col      ;
                sigma[i] += col * col;
            }
        }
    }

    float       n = float(5 + 1) * float(5 + 1);
    float sigma_f                              ;
    float min     = 1.0                        ;

    for (int i = 0; i < 4; i++) {
        mean [i] /= n;
        sigma[i]  = abs(sigma[i] / n - mean[i] * mean[i]);
        sigma_f   = sigma[i].r
                  + sigma[i].g
                  + sigma[i].b;

        if (sigma_f < min) {
            min = sigma_f;
            col = mean[i];
        }
    }

    float offset = ( sin(time) + 1.0) / 2.0;
    float side   = floor(uv.r  +
          offset);
    col = mix(texture(tex0, uv).xyz, col, side);

    fragColor = vec4(col, 1.0); // Output to screen
}


// https://www.shadertoy.com/view/csVXzz
