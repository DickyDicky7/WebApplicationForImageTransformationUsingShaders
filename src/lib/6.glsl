#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const vec3  color = vec3(1.0, 1.0, 1.0);
const float speed = 1.0;
const float density = 300.0;
const float compression = 001.0;
const float trail_size  = 100.0;
const float brightness  = 100.0;
const float PI = 3.14;

void main() {
    vec2     uv =   -vTexCoord;
    float timee = time * speed;
             uv.x *= density;
    vec2  duv = vec2(floor( uv.x), uv.y) * compression;
    float offset =     sin(duv.x       );
    float   fall =     cos(duv.x * 30.0);
    float  trail =     mix(100.0 , trail_size , fall);
    float   drop =   fract(duv.y + timee      * fall + offset) * trail;
    drop = 1.0 / drop;
    drop = smoothstep(0.0, 1.0, drop * drop);
    drop =          sin(        drop * PI  )  * fall *
           brightness;
    float   shape = sin(fract(uv.x)  * PI  );
    drop *= shape
         *  shape    ;
    fragColor = vec4(    color *        drop       ,         1.00            );
    fragColor = max (fragColor , (1.0 - fragColor) * texture(tex0, vTexCoord));
}


// https://godotshaders.com/shader/vertical-drops/