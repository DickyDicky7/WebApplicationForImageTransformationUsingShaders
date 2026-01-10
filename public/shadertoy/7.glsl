    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform sampler2D  tex0;
//  uniform sampler2D  tex0;
    in      vec2           vTexCoord;
//  in      vec2           vTexCoord;
    out     vec4           fragColor;
//  out     vec4           fragColor;
    uniform float      time;
//  uniform float      time;
    uniform vec2 canvasSize;
//  uniform vec2 canvasSize;
    uniform vec2           texelSize;
//  uniform vec2           texelSize;

    #define COLORED 1
//  #define COLORED 1

    void main() {
    vec2 center = floor(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / 16.0) * 16.0 + 8.0;
//  vec2 center = floor(vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / 16.0) * 16.0 + 8.0;
    vec3    col =                                           texture(tex0, center / canvasSize.xy).rgb;
//  vec3    col =                                           texture(tex0, center / canvasSize.xy).rgb;
    float  l    =                                                                                    max(0.1, dot(col, vec3(0.2125, 0.7154, 0.0721)));
//  float  l    =                                                                                    max(0.1, dot(col, vec3(0.2125, 0.7154, 0.0721)));
    float  dist =                                                                                                                                      distance(center, vec4(vTexCoord * canvasSize, 0.0, 1.0).xy) / 8.0;
//  float  dist =                                                                                                                                      distance(center, vec4(vTexCoord * canvasSize, 0.0, 1.0).xy) / 8.0;
    float alpha =                                                                                                                                                                             smoothstep(1.0, 0.5, dist / l);
//  float alpha =                                                                                                                                                                             smoothstep(1.0, 0.5, dist / l);

    #if defined(COLORED)
//  #if defined(COLORED)
    fragColor.rgb = col * alpha  ;
//  fragColor.rgb = col * alpha  ;
    #else
//  #else
    fragColor.rgb = vec3( alpha );
//  fragColor.rgb = vec3( alpha );
    #endif
//  #endif

    fragColor.a = 1.0;
//  fragColor.a = 1.0;
    }

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/MtcXRB
//  // https://www.shadertoy.com/view/MtcXRB
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



















