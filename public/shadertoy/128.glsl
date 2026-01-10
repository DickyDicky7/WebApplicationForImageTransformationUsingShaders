#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform         sampler2D          tex0;
//  uniform         sampler2D          tex0;
    in              vec2          vTexCoord;
//  in              vec2          vTexCoord;
    out             vec4          fragColor;
//  out             vec4          fragColor;
    uniform         float              time;
//  uniform         float              time;
    uniform         vec2         canvasSize;
//  uniform         vec2         canvasSize;
    uniform         vec2          texelSize;
//  uniform         vec2          texelSize;
    uniform         vec4      mousePosition;
//  uniform         vec4      mousePosition;

    // https://www.shadertoy.com/view/tsdyWf
//  // https://www.shadertoy.com/view/tsdyWf

    ////////////////////////////
//  ////////////////////////////
    ////////////////////////////
//  ////////////////////////////

    uniform float   SAMPLES ; // 10.00
//  uniform float   SAMPLES ; // 10.00

    uniform float   decay   ; // 00.97
//  uniform float   decay   ; // 00.97
    uniform float   density ; // 00.15
//  uniform float   density ; // 00.15

    uniform float threshold ; // 00.70
//  uniform float threshold ; // 00.70

    ////////////////////////////
//  ////////////////////////////
    ////////////////////////////
//  ////////////////////////////


    float hash( vec2 p ) { return fract(sin(dot(p, vec2(41, 289))) * 45758.5453); }
//  float hash( vec2 p ) { return fract(sin(dot(p, vec2(41, 289))) * 45758.5453); }
    vec3  lOff(        ) { return vec3(0., 0., 0.); }
//  vec3  lOff(        ) { return vec3(0., 0., 0.); }
    

    vec3  rainbow_1(float x) {
//  vec3  rainbow_1(float x) {
    return vec3(
//  return vec3(
    (tanh(-10. * x + 2.) + 1.) * 0.5 + (tanh(10. * x - 7.) + 1.) * 0.5,
//  (tanh(-10. * x + 2.) + 1.) * 0.5 + (tanh(10. * x - 7.) + 1.) * 0.5,
    (tanh(-10. * x + 3.) + 1.) * 0.5,
//  (tanh(-10. * x + 3.) + 1.) * 0.5,
    (tanh(-10. * x + 6.) + 1.) * 0.5
//  (tanh(-10. * x + 6.) + 1.) * 0.5
    );
//  );
    }
//  }
    vec3  rainbow_2(float x) {
//  vec3  rainbow_2(float x) {
    return vec3(
//  return vec3(
    1.,
//  1.,
    (tanh(-10. * x + 6.) + 1.) * 0.5,
//  (tanh(-10. * x + 6.) + 1.) * 0.5,
    (tanh(-10. * x + 3.) + 1.) * 0.5
//  (tanh(-10. * x + 3.) + 1.) * 0.5
    );
//  );
    }
//  }
    vec3  rainbow_3(float x) {
//  vec3  rainbow_3(float x) {
    return vec3(
//  return vec3(
    (tanh(-10. * x + 3.) + 1.) * 0.5,
//  (tanh(-10. * x + 3.) + 1.) * 0.5,
    (tanh(-10. * x + 6.) + 1.) * 0.5,
//  (tanh(-10. * x + 6.) + 1.) * 0.5,
    1.
//  1.
    );
//  );
    }
//  }



    vec3 shine(vec2 original_uv     ,
//  vec3 shine(vec2 original_uv     ,
    vec2         tuv
//  vec2         tuv
    )
//  )
    {
//  {
    vec2 dTuv  =  tuv * density / SAMPLES; vec4 currentColor; vec3 result = vec3(0.f); float weight = 0.05f; vec2 uv = original_uv; uv += dTuv * (hash(uv.xy) * 2.f - 1.f); for (float i = 0.f; i < SAMPLES; i++) { uv -= dTuv; currentColor = texture(tex0, uv); result += (step(threshold, length(currentColor.rgb) / sqrt(3.f)) * currentColor.rgb * rainbow_2(i / SAMPLES) * weight); weight *= decay; }
//  vec2 dTuv  =  tuv * density / SAMPLES; vec4 currentColor; vec3 result = vec3(0.f); float weight = 0.05f; vec2 uv = original_uv; uv += dTuv * (hash(uv.xy) * 2.f - 1.f); for (float i = 0.f; i < SAMPLES; i++) { uv -= dTuv; currentColor = texture(tex0, uv); result += (step(threshold, length(currentColor.rgb) / sqrt(3.f)) * currentColor.rgb * rainbow_2(i / SAMPLES) * weight); weight *= decay; }
    ////////////////////////////////
//  ////////////////////////////////
    ////////////////////////////////
//  ////////////////////////////////
    dTuv *= -1.f                    ;                                                   weight = 0.05f;      uv = original_uv; uv += dTuv * (hash(uv.xy) * 2.f - 1.f); for (float i = 0.f; i < SAMPLES; i++) { uv -= dTuv; currentColor = texture(tex0, uv); result += (step(threshold, length(currentColor.rgb) / sqrt(3.f)) * currentColor.rgb * rainbow_3(i / SAMPLES) * weight); weight *= decay; }
//  dTuv *= -1.f                    ;                                                   weight = 0.05f;      uv = original_uv; uv += dTuv * (hash(uv.xy) * 2.f - 1.f); for (float i = 0.f; i < SAMPLES; i++) { uv -= dTuv; currentColor = texture(tex0, uv); result += (step(threshold, length(currentColor.rgb) / sqrt(3.f)) * currentColor.rgb * rainbow_3(i / SAMPLES) * weight); weight *= decay; }

    return result;
//  return result;
    }
//  }


    void main() {
    vec2 uv = vTexCoord; vec2 tuv; vec4 col = texture(tex0, uv.xy) * 0.8;
//  vec2 uv = vTexCoord; vec2 tuv; vec4 col = texture(tex0, uv.xy) * 0.8;
    float x = 0.5;
//  float x = 0.5;
    float y = 0.5;
//  float y = 0.5;
    tuv = vec2(x,  y); col.rgb += shine(uv, tuv);
//  tuv = vec2(x,  y); col.rgb += shine(uv, tuv);
    tuv = vec2(x, -y); col.rgb += shine(uv, tuv);
//  tuv = vec2(x, -y); col.rgb += shine(uv, tuv);
    fragColor = sqrt(smoothstep(0., 1., col));
//  fragColor = sqrt(smoothstep(0., 1., col));
    }










