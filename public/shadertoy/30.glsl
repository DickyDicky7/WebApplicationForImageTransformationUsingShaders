    #version 300 es
//  #version 300 es
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

    // const vec2   redOffset = vec2(-0.1, 0.0);
//  // const vec2   redOffset = vec2(-0.1, 0.0);
    // const vec2 greenOffset = vec2( 0.1, 0.0);
//  // const vec2 greenOffset = vec2( 0.1, 0.0);
    // const vec2  blueOffset = vec2( 0.1, 0.0);
//  // const vec2  blueOffset = vec2( 0.1, 0.0);

    uniform vec2   redOffset ; // -0.1, 0.0
//  uniform vec2   redOffset ; // -0.1, 0.0
    uniform vec2 greenOffset ; //  0.1, 0.0
//  uniform vec2 greenOffset ; //  0.1, 0.0
    uniform vec2  blueOffset ; //  0.1, 0.0
//  uniform vec2  blueOffset ; //  0.1, 0.0



    void main() {
    vec2      fragCoord = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy;
//  vec2      fragCoord = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy;
    vec2 uv = fragCoord /   canvasSize.xy;
//  vec2 uv = fragCoord /   canvasSize.xy;

    vec4 color;
//  vec4 color;
    color.r = texture(tex0, uv +   redOffset).r;
//  color.r = texture(tex0, uv +   redOffset).r;
    color.g = texture(tex0, uv + greenOffset).g;
//  color.g = texture(tex0, uv + greenOffset).g;
    color.b = texture(tex0, uv +  blueOffset).b;
//  color.b = texture(tex0, uv +  blueOffset).b;
    color.a = texture(tex0, uv).a;
//  color.a = texture(tex0, uv).a;

    fragColor = color;
//  fragColor = color;
    }


    // https://www.shadertoy.com/view/4tdyzH
//  // https://www.shadertoy.com/view/4tdyzH
