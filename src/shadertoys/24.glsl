#version 300 es
precision  lowp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;

//    Define@ @@@@@@@@ the @@@ luminance weights
// vec3 W = vec3(0.2125,
//               0.7154,
//               0.0721);

uniform vec3 W ; // 0.2125 , 0.7154 , 0.0721

//    Checker function for the pattern@@ @@@@@@@
float checker(vec2 uv, float scale, float angle)
{
    float  s = sin(angle),
           c = cos(angle);
    vec2 uv2 = vec2(c * uv.x - s * uv.y
             ,      s * uv.x + c * uv.y)
             * scale  ;
    return sin(uv2.x) *
           sin(uv2.y) ;
}

//    Process @@@@@@@@ @@@ @@@ luminance with pattern influence
float processLum(vec2 uv, float lum)
{
    float  angle = 001.0;
    float  scale = 350.0;

    float    dots = checker(uv, scale, angle);
    float intens1 = 5.0;
    float intens2 = (intens1 -    1.0) *  0.5;
    return    lum *  intens1 - intens2 * (1.0 - dots);
}

void main()
{
    // Normalized pixel@@ coordinates (from 0 to 1) @@@@@@@ @@@@@
    vec2 uv = vTexCoord;

    // Choose@@@@ between test@@@@@@@ color @ or @@ texture color
#ifdef TEST
    vec3 col =
    vec3(uv.x);
#else
    vec3 col = texture(tex0, uv).xyz;
#endif

    // Compute luminance @@@@@@@@@@
    float   lum =
            dot(col, W);

    // Apply@@ luminance processing
    float color = processLum(uv, lum);

    // Add a blueish ink-like style
                                                color = clamp   (
                                                color , 0.0, 1.0);
    vec3 outputColor = mix(vec3(0.0, 0.2, 0.3),
                           vec3(1.0, 1.0, 1.0), color);

    // Additional test condition to overwrite the color if uv.y > .7
#ifdef TEST
    if ( uv.y > 0.7 )
         outputColor = col;        
#endif

    // Set@@@@@@@ the@ final@@@@ @@ fragment@ @@@ color @@ @@@@ @ @@
    fragColor = vec4(outputColor, 1.0);
}




// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/fdf3zM
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@









