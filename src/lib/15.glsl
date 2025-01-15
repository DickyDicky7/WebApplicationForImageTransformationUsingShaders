#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
uniform         sampler2D        noise0; // null
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// // group_uniiforms Image;
// // group_uniiforms Image;
// const float curvature     = 2.;
// const float          skip = 1.;
// const float image_flicker = 1.;

// // group_uniiforms Vignette;
// // group_uniiforms Vignette;
// const float vignette_flicker_speed = 1.;
// const float vignette_strength      = 1.;

// // group_uniiforms Scanlines;
// // group_uniiforms Scanlines;
// const float small_scanlines_speed     = 1. ;
// const float small_scanlines_proximity = 1. ;
// const float small_scanlines_opacity   = 1. ;
// const float       scanlines_opacity   = 1. ;
// const float       scanlines_speed     = 1. ;
// const float       scanlines_thickness = 0.5;
// const float       scanlines_spacing   = 1. ;

// // group_uniiforms Noise;
// // group_uniiforms Noise;
// // const sampler2D noise_texture: filter_linear_mipmap, repeat_enable;
// // const sampler2D noise_texture: filter_linear_mipmap, repeat_enable;


// group_uniiforms Image;
// group_uniiforms Image;
uniform float curvature     ; // 2.0
uniform float          skip ; // 1.0
uniform float image_flicker ; // 1.0

// group_uniiforms Vignette;
// group_uniiforms Vignette;
uniform float vignette_flicker_speed ; // 1.0
uniform float vignette_strength      ; // 1.0

// group_uniiforms Scanlines;
// group_uniiforms Scanlines;
uniform float small_scanlines_speed     ; // 1.0
uniform float small_scanlines_proximity ; // 1.0
uniform float small_scanlines_opacity   ; // 1.0
uniform float       scanlines_opacity   ; // 1.0
uniform float       scanlines_speed     ; // 1.0
uniform float       scanlines_thickness ; // 0.5
uniform float       scanlines_spacing   ; // 1.0

// group_uniiforms Noise;
// group_uniiforms Noise;
// const sampler2D noise_texture: filter_linear_mipmap, repeat_enable;
// const sampler2D noise_texture: filter_linear_mipmap, repeat_enable;

float noise(vec2 p, vec2 uv)
{
    float  s  = texture(noise0, vec2(1. * time, 2. * time) * 8. + p * 1.).x;
           s *= s;
    return s     ;
}

//---------------------------------------------------------------------------------------------
float onOff(float a, float b    , float c  ) { return step(c, sin(time + a * cos(time * b))); }
//---------------------------------------------------------------------------------------------
float ramp (float y, float start, float end)
{
    float      inside = step(start, y)
                      - step(end  , y);
    float        fact = (y  -start)
                      / (end-start) * inside;
    return (1. - fact)              * inside;
}

float stripes(vec2 uv)
{
    float noi = noise(uv * vec2(0.5, 1.)
                         + vec2(1.0, 3.)
              ,       uv)  *      scanlines_opacity;
    return ramp(mod(  uv.y * 4. * scanlines_spacing  +     time * scanlines_speed     / (2.00 
                                * scanlines_spacing) + sin(time * scanlines_speed
                                                     + sin(time * scanlines_speed     *  0.63
                                * scanlines_spacing)), 1.),       scanlines_thickness ,  0.60) * noi;
}

vec3 getVideo(vec2 uv)
{
    vec2    look = uv;
    float window = 1. / (1. + 20. * (look.y - mod(time / 4., 1.))
                                  * (look.y - mod(time / 4., 1.))) * image_flicker;
    look.x =
    look.x + sin(look.y * 10. + time) / 50.0 * onOff(4., 4., .3) * (1.        + cos(time * 80.)) * window;
    float vShift =                      00.4 * onOff(2., 3., .9) * (sin(time) * sin(time * 20.)  +(0.5 + 0.1 * sin(time * 200.) * cos(time))) * skip;
    look.y = mod(look.y
        + vShift ,  1.);
    vec3   video = texture(tex0, look).xyz;
    return video                          ;
}

vec2 screenDistort(vec2 uv)
{
    uv -= vec2(.5, .5);
    uv  =  uv * 1.2 * (1. / 1.2 + curvature * uv.x * uv.x * uv.y * uv.y);
    uv += vec2(.5, .5);
    return uv;
}

void main()
{
    vec2    uv = vTexCoord;
            uv = screenDistort(uv);
    vec3 video =      getVideo(uv);
    float vigAmt  = 3. + .3 * sin(time *      vignette_flicker_speed + 1. + 5.
                            * cos(time * 5. * vignette_flicker_speed + 1.  ));
          vigAmt *= vignette_strength;
    float           vignette = (1. - vigAmt * (uv.y - .5) * (uv.y - .5))
                             * (1. - vigAmt * (uv.x - .5) * (uv.x - .5));

    video += stripes(uv         )     ;
    video +=   noise(uv * 2., uv) / 2.;
    video *=        vignette;
    video *= (12. / small_scanlines_opacity + mod(uv.y * 30. * small_scanlines_proximity + time * small_scanlines_speed, 1.)) / 13. * small_scanlines_opacity;

    fragColor = vec4(video, 1.0);
}

// https://godotshaders.com/shader/vcr-analog-distortions/

/* License CC BY-NC-SA 4.0 Deed */
/* License CC BY-NC-SA 4.0 Deed */
/* https://creativecommons.org/licenses/by-nc-sa/4.0/ */
/* https://creativecommons.org/licenses/by-nc-sa/4.0/ */
/* Fork of Ryk's VCR distortion shader */
/* Fork of Ryk's VCR distortion shader */
/* https://www.shadertoy.com/view/ldjGzV */
/* https://www.shadertoy.com/view/ldjGzV */
