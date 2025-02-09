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

// const float projector_power = 00.5;
// const float vvignette_param = 20.0;

uniform float projector_power ; // 00.5
uniform float vvignette_param ; // 20.0

//vars related to the passing lines


// float round(float x) {
//     return floor(x + 0.5);
// }

// vec2 round(vec2 v) {
//     return vec2(round(v.x), round(v.y));
// }

// vec3 round(vec3 v) {
//     return vec3(round(v.x), round(v.y), round(v.z));
// }

// vec4 round(vec4 v) {
//     return vec4(round(v.x), round(v.y), round(v.z), round(v.w));
// }


//noise for the projector flickering
float noise(vec2 inputt){
    return fract(sin(dot(inputt,vec2(3.1415,8952.37)*12.29))*93.116);
}

void main() {
    //vignette-related:
    float vignette_param2 =  vvignette_param + 0.5 * (noise(vec2(time / 60.0, time / 59.0)));
    float vig             =  -vignette_param2      * ((vTexCoord.x - 0.5)
                                                   *  (vTexCoord.x - 0.5)
                                                   +  (vTexCoord.y - 0.5)
                                                   *  (vTexCoord.y - 0.5));
    vec4  vignette = vec4(vig, vig, vig, 1.0);

    //grayscale-related:
    vec4  pixelcolor = texture(tex0, vTexCoord);
    float brightness = (0.299 * pixelcolor.r
                     +  0.487 * pixelcolor.g
                     +  0.114 * pixelcolor.b  );
    vec4   grayscale = vec4(brightness, brightness, brightness, pixelcolor.a);
    
    //random-fluctuation:
    vec4      random =  texture (
              noise0 , vTexCoord);
    
    //Small speckles:
    float   RTIME1 = round(time * 20.0);
    vec2 position1 = vec2(noise(vec2(RTIME1       , RTIME1      )) ,
                          noise(vec2(RTIME1 / 2.0 , RTIME1 / 2.0)));
    float energy = 1000000.0*(1.0+0.5*noise(vec2(RTIME1 , RTIME1)));
    float xdev1 = (vTexCoord.x-position1.x);
    float ydev1 = (vTexCoord.y-position1.y);
    float spec    = energy*(xdev1*xdev1+0.50000*ydev1*ydev1)+.1*noise(vec2(vTexCoord.x,vTexCoord.y));
    vec4  speckle = vec4(max(0.0,20.0-spec),
                         max(0.0,20.0-spec),
                         max(0.0,20.0-spec),1.0);
    
    //lines:
    float      RTIME2 = round(time*5.0);
    vec2 positionline = vec2(noise(vec2(RTIME2       , RTIME2      )) / 4.0,
                             noise(vec2(RTIME2 / 3.0 , RTIME2 / 3.0))     );
    float xline = (vTexCoord.x-positionline.x);
    float yline = (vTexCoord.y-positionline.y);
    float  lin  =   energy*(xline*xline+0.00001*yline*yline)+.1*noise(vec2(vTexCoord.x,vTexCoord.y));
    vec4   line =   vec4(max(0.0,8.0-lin),
                         max(0.0,8.0-lin),
                         max(0.0,8.0-lin),1.0);
    
    //combining-the parts:
    vec4 dirt       = mix(speckle, line                  , 0.5);
    vec4 grayscale2 = mix( random,     vignette          , 0.7);
    vec4 grayscale3 = mix(dirt   ,             grayscale2, 0.7);
    fragColor = mix(grayscale, grayscale3, projector_power);
}


// https://godotshaders.com/shader/old-movie-shader/
