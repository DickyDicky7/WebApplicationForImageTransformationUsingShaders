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

    // https://www.shadertoy.com/view/MfGBDz
//  // https://www.shadertoy.com/view/MfGBDz

    uniform float strengths   ; // 0.05
//  uniform float strengths   ; // 0.05
    uniform bool  animateOn   ; // true
//  uniform bool  animateOn   ; // true
    uniform float animateSpeed; // 1.00
//  uniform float animateSpeed; // 1.00

    void main()
    {
    vec2 uv = vTexCoord; vec2 P = vec2(0.5, 0.5) * vec2(canvasSize.x / canvasSize.y, 1.); float z = - strengths * float(animateOn) * animateSpeed * time / length(uv * vec2(canvasSize.x / canvasSize.y, 1.) - P); vec2 dir = normalize(P - uv * vec2(canvasSize.x / canvasSize.y, 1.)); uv -= dir * z; fragColor = texture(tex0, uv);
//  vec2 uv = vTexCoord; vec2 P = vec2(0.5, 0.5) * vec2(canvasSize.x / canvasSize.y, 1.); float z = - strengths * float(animateOn) * animateSpeed * time / length(uv * vec2(canvasSize.x / canvasSize.y, 1.) - P); vec2 dir = normalize(P - uv * vec2(canvasSize.x / canvasSize.y, 1.)); uv -= dir * z; fragColor = texture(tex0, uv);
    }







