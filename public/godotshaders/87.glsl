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

    // const vec4  edge_color = vec4(0.0, 0.0, 0.0, 1.0);
//  // const vec4  edge_color = vec4(0.0, 0.0, 0.0, 1.0);
    // const float thresholds = 0.00;
//  // const float thresholds = 0.00;
    // const float blend      = 0.01;
//  // const float blend      = 0.01;

    uniform vec4  edge_color ; // 0.0, 0.0, 0.0, 1.0
//  uniform vec4  edge_color ; // 0.0, 0.0, 0.0, 1.0
    uniform float thresholds ; // 0.00
//  uniform float thresholds ; // 0.00
    uniform float      blend ; // 0.01
//  uniform float      blend ; // 0.01

    float getGrayScale(sampler2D sampler, vec2 coods) {
//  float getGrayScale(sampler2D sampler, vec2 coods) {
    vec4     color = texture(sampler,      coods) ;
//  vec4     color = texture(sampler,      coods) ;
    float  gray    = (color.r
//  float  gray    = (color.r
    +  color.g
//  +  color.g
    +  color.b
//  +  color.b
    ) / 3.0;
//  ) / 3.0;
    return gray;
//  return gray;
    }
//  }

    void main() {
    vec2    delta  = vec2(0.0 , 0.003);
//  vec2    delta  = vec2(0.0 , 0.003);
    float        m = max(canvasSize.x
//  float        m = max(canvasSize.x
    ,     canvasSize.y);
//  ,     canvasSize.y);
    vec2 texCoords = vTexCoord;
//  vec2 texCoords = vTexCoord;
    
    vec3 screen_color = texture(tex0, vTexCoord).rgb;
//  vec3 screen_color = texture(tex0, vTexCoord).rgb;
    
    float c1y = getGrayScale(tex0, texCoords.xy - delta    / 2.0);
//  float c1y = getGrayScale(tex0, texCoords.xy - delta    / 2.0);
    float c2y = getGrayScale(tex0, texCoords.xy + delta    / 2.0);
//  float c2y = getGrayScale(tex0, texCoords.xy + delta    / 2.0);
    
    float c1x = getGrayScale(tex0, texCoords.xy - delta.yx / 2.0);
//  float c1x = getGrayScale(tex0, texCoords.xy - delta.yx / 2.0);
    float c2x = getGrayScale(tex0, texCoords.xy + delta.yx / 2.0);
//  float c2x = getGrayScale(tex0, texCoords.xy + delta.yx / 2.0);
    
    float dcdx = (c2x - c1x) / (delta.y * 10.0);
//  float dcdx = (c2x - c1x) / (delta.y * 10.0);
    float dcdy = (c2y - c1y) / (delta.y * 10.0);
//  float dcdy = (c2y - c1y) / (delta.y * 10.0);
    
    vec2  dcdi =   vec2(dcdx  , dcdy);
//  vec2  dcdi =   vec2(dcdx  , dcdy);
    float edge = length(dcdi) / 10.0 ;
//  float edge = length(dcdi) / 10.0 ;
    edge = 1.0 - edge;
//  edge = 1.0 - edge;
    edge = smoothstep(thresholds
//  edge = smoothstep(thresholds
    ,            thresholds + blend, edge);
//  ,            thresholds + blend, edge);
    
    fragColor.rgb = mix(  edge_color.rgb
//  fragColor.rgb = mix(  edge_color.rgb
    ,     screen_color.rgb, edge);
//  ,     screen_color.rgb, edge);
    }


    // https://godotshaders.com/shader/cheaper-edge-detection-post-processing/
//  // https://godotshaders.com/shader/cheaper-edge-detection-post-processing/
