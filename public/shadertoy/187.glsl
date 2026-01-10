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

    // https://www.shadertoy.com/view/4ctBR7
//  // https://www.shadertoy.com/view/4ctBR7

    uniform float amount ; // 1.0
//  uniform float amount ; // 1.0
    uniform float mode   ; // 1.0
//  uniform float mode   ; // 1.0

    void main()
    {
    
    vec2       uv =     vTexCoord;
//  vec2       uv =     vTexCoord;
    vec2 dir = uv - vec2(0.5,0.5);
//  vec2 dir = uv - vec2(0.5,0.5);

    // Time varying pixel color
//  // Time varying pixel color
    // Time varying pixel color
//  // Time varying pixel color
    vec3 col0 = texture(tex0, uv                      ).xyz;
//  vec3 col0 = texture(tex0, uv                      ).xyz;
    vec3 col1 = texture(tex0, uv + dir * 0.02 * amount).xyz;
//  vec3 col1 = texture(tex0, uv + dir * 0.02 * amount).xyz;
    vec3 col2 = texture(tex0, uv + dir * 0.04 * amount).xyz;
//  vec3 col2 = texture(tex0, uv + dir * 0.04 * amount).xyz;
    
    // Standard chromatic abberation
//  // Standard chromatic abberation
    // Standard chromatic abberation
//  // Standard chromatic abberation
    vec3 chromaticAbberationStandard = vec3(col0.r, col1.g, col2.b);
//  vec3 chromaticAbberationStandard = vec3(col0.r, col1.g, col2.b);
    
    // Non-Orgthogonal Basis abberation
//  // Non-Orgthogonal Basis abberation
    // Non-Orgthogonal Basis abberation
//  // Non-Orgthogonal Basis abberation
    vec3 basisX =  vec3(174.0 / 255.0, 052.0 / 255.0, 235.0 / 255.0);
//  vec3 basisX =  vec3(174.0 / 255.0, 052.0 / 255.0, 235.0 / 255.0);
    vec3 basisY =  vec3(052.0 / 255.0, 192.0 / 255.0, 235.0 / 255.0);
//  vec3 basisY =  vec3(052.0 / 255.0, 192.0 / 255.0, 235.0 / 255.0);
    vec3 basisZ = cross(
//  vec3 basisZ = cross(
    basisX ,
//  basisX ,
    basisY        );
//  basisY        );
    
    mat3  B =    mat3(basisZ
//  mat3  B =    mat3(basisZ
    ,         basisY
//  ,         basisY
    ,         basisX
//  ,         basisX
    );
//  );
    mat3 IB = inverse(
//  mat3 IB = inverse(
    B          );
//  B          );
    
    vec3 x0 = B * col0;
//  vec3 x0 = B * col0;
    vec3 x1 = B * col1;
//  vec3 x1 = B * col1;
    vec3 x2 = B * col2;
//  vec3 x2 = B * col2;
    vec3 chromaticAbberationNonOrtho = IB * vec3(x0.r, x1.g, x2.b);
//  vec3 chromaticAbberationNonOrtho = IB * vec3(x0.r, x1.g, x2.b);

    // Output to screen
//  // Output to screen
    // Output to screen
//  // Output to screen
    if (mode > 0.5)
//  if (mode > 0.5)
    fragColor = vec4(chromaticAbberationNonOrtho, 1.0);
//  fragColor = vec4(chromaticAbberationNonOrtho, 1.0);
    else
//  else
    fragColor = vec4(chromaticAbberationStandard, 1.0);
//  fragColor = vec4(chromaticAbberationStandard, 1.0);
    }










