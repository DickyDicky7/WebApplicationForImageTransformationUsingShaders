#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

#define PI 3.14159265359

// const   int  samples = 4;
// const   bool colorOn    ;

uniform int  samples ; // 4
uniform bool colorOn ; // false


float aux ;
float aux2;
float tightness;
vec2     aspect;
vec2  texAspect;

mat2 spin(float angle) {
    return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

vec4 samplePixel(vec2 uv) {
    float separation = 0.1;
    vec2 rCenter = (vec2(separation, 0.0) * spin(-time * 0.1)) / aspect + vec2(0.5);
    vec2 gCenter = (vec2(separation, 0.0) * spin(2.0 * PI / 3.0) * spin(-time * 0.1)) / aspect + vec2(0.5);
    vec2 bCenter = (vec2(separation, 0.0) * spin(4.0 * PI / 3.0) * spin(-time * 0.1)) / aspect + vec2(0.5);

    vec2 rPoint = (uv - rCenter) * aspect;
    vec2 gPoint = (uv - gCenter) * aspect;
    vec2 bPoint = (uv - bCenter) * aspect;

    rPoint = rPoint * spin(-time * 10.0) * spin(length(rPoint) * tightness);
    gPoint = gPoint * spin(-time * 10.0) * spin(length(gPoint) * tightness);
    bPoint = bPoint * spin(-time * 10.0) * spin(length(bPoint) * tightness);

    vec3 image = colorOn  ? texture(tex0, uv * aspect * texAspect).rgb
                          : texture(tex0, uv * aspect * texAspect).ggg; // Grayscale input looks cooler. Change to .rgb for color
         image = pow(image, vec3(mix(0.5, 4.0, aux)));

    vec3 imageThreshold = mix(vec3(1.0), vec3(-1.0), image) * vec3(length(rPoint) , length(gPoint) , length(bPoint)  );
         imageThreshold =                step(imageThreshold, vec3(       rPoint.x,        gPoint.x,        bPoint.x));

    return vec4(imageThreshold, 1.0);
}

vec4 superSamplePixel(vec2 pos) {
    vec2 off = 1.0 / float(samples) / canvasSize.xy;
    vec4 sum = vec4(0.0);
    for     (int x = 0; x < samples; x++) {
        for (int y = 0; y < samples; y++) {
            sum += samplePixel(pos + vec2(off.x * float(x)
                                   ,      off.y * float(y)));
        }
    }
    return sum / float(samples * samples);
}

void main() {
    aux  = max(0.1, mousePosition.x / canvasSize.x);
    aux2 = max(0.2, mousePosition.y / canvasSize.y);
    tightness = aux2 * 3000.0;
       aspect = vec2(1.0, canvasSize.y / canvasSize.x);
    texAspect = vec2(1.0, canvasSize.x / canvasSize.y);

    vec2 uv = gl_FragCoord.xy /       canvasSize.xy ;
                 fragColor    = superSamplePixel(uv);
}


//                          https://www.shadertoy.com/view/4l33D4
// Spiral math adapted from https://www.shadertoy.com/view/XsfXR2
