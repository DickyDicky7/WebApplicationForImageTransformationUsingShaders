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

void main() {
    vec2 fragCoord =
      gl_FragCoord.xy;
    vec2                                             displacementSampleUV = vec2(fragCoord.x  +       time * 75.0
                                                                          ,      fragCoord.y) / canvasSize . xy  ;
    float displacement          = texture(noise0  ,  displacementSampleUV).x                                     ;
    vec2  displacementDirection = vec2(cos(displacement * 6.28318530718)
                                ,      sin(displacement * 6.28318530718)                                        );
    vec2 displacedUV = (fragCoord + displacementDirection
                                  * displacement  *  20.0)                                    / canvasSize . xy  ;
    float            shade = texture(tex0, displacedUV).x                                                        ;
    fragColor = vec4(shade ,
                     shade ,
                     shade ,
                     01.00);
}


// https://www.shadertoy.com/view/WstcRH
