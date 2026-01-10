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

#define t       time
// #define t       time
#define r canvasSize.xy
// #define r canvasSize.xy

    void main(  ) {
    vec3  c       ;
//  vec3  c       ;
    float l, z = t;
//  float l, z = t;
    for(int  i = 0;
//  for(int  i = 0;
    i < 3;
//  i < 3;
    i++   ) {
//  i++   ) {
    vec2 uv , p = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / r;
//  vec2 uv , p = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / r;
    uv = p                      ;
//  uv = p                      ;
    p   -= 0.5;
//  p   -= 0.5;
    p.x *= r.x
//  p.x *= r.x
    / r.y;
//  / r.y;
    z   +=       .07;
//  z   +=       .07;
    l    = length(p);
//  l    = length(p);
    uv  += p
//  uv  += p
    / l
//  / l
    *    (sin(z             ) + 1.0)
//  *    (sin(z             ) + 1.0)
    * abs(sin(l * 9. - z - z)      );
//  * abs(sin(l * 9. - z - z)      );
    c[i] = .01 / length(mod(uv,1.) - 0.5);
//  c[i] = .01 / length(mod(uv,1.) - 0.5);
    }
//  }
    fragColor = vec4(c / l, t);
//  fragColor = vec4(c / l, t);
    fragColor = max (fragColor, (1.0 - fragColor) * texture(tex0, vTexCoord));
//  fragColor = max (fragColor, (1.0 - fragColor) * texture(tex0, vTexCoord));
    }


    // https://www.shadertoy.com/view/XsXXDn
//  // https://www.shadertoy.com/view/XsXXDn

    // http://www.pouet.net/prod.php?which=57245
//  // http://www.pouet.net/prod.php?which=57245
    // http://www.pouet.net/prod.php?which=57245
//  // http://www.pouet.net/prod.php?which=57245
    // If you intend to reuse this shader, please add credits to 'Danilo Guanabara'
//  // If you intend to reuse this shader, please add credits to 'Danilo Guanabara'
    // If you intend to reuse this shader, please add credits to 'Danilo Guanabara'
//  // If you intend to reuse this shader, please add credits to 'Danilo Guanabara'
