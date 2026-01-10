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

    // const float  MAX_ITERATION = 9.0000;
//  // const float  MAX_ITERATION = 9.0000;
    // const float LINE_THICKNESS = 0.0055;
//  // const float LINE_THICKNESS = 0.0055;


    uniform float  MAX_ITERATION ; // 9.0000
//  uniform float  MAX_ITERATION ; // 9.0000
    uniform float LINE_THICKNESS ; // 0.0055
//  uniform float LINE_THICKNESS ; // 0.0055


    void main(void)
    {
    vec2 uv = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy * 2.0 - canvasSize.xy)
//  vec2 uv = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy * 2.0 - canvasSize.xy)
    / min(  canvasSize.x
//  / min(  canvasSize.x
    ,       canvasSize.y );
//  ,       canvasSize.y );
    uv = fract(uv);
//  uv = fract(uv);
    
    int iteration;
//  int iteration;
    {
//  {
    vec2  luv =   vTexCoord;
//  vec2  luv =   vTexCoord;
    vec3 texc =   texture(tex0, luv).xyz         ;
//  vec3 texc =   texture(tex0, luv).xyz         ;
    float
//  float
    intensity = 1.0 - dot(texc, vec3(0.299, 0.587, 0.114));
//  intensity = 1.0 - dot(texc, vec3(0.299, 0.587, 0.114));
    iteration = int          (
//  iteration = int          (
    intensity * MAX_ITERATION);
//  intensity * MAX_ITERATION);
    }
//  }
    
    vec2 cell_begin = vec2(0.0);
//  vec2 cell_begin = vec2(0.0);
    {
//  {
    vec2 cell_uv    = uv;
//  vec2 cell_uv    = uv;
    vec2 cell_sizes = vec2(1.0     );
//  vec2 cell_sizes = vec2(1.0     );
    const vec2   boundary = vec2(0.5, 0.5);
//  const vec2   boundary = vec2(0.5, 0.5);
    for (int i = 0; i < int(MAX_ITERATION); ++i)
//  for (int i = 0; i < int(MAX_ITERATION); ++i)
    {
//  {
    if ( i >= iteration ) break;
//  if ( i >= iteration ) break;

    vec2    is_out_of_boundary =  step(boundary, cell_uv);
//  vec2    is_out_of_boundary =  step(boundary, cell_uv);
    vec2              fcell_uv = fract(          cell_uv);
//  vec2              fcell_uv = fract(          cell_uv);
            
    cell_uv     = mix(fcell_uv / boundary
//  cell_uv     = mix(fcell_uv / boundary
    ,    (fcell_uv - boundary)
//  ,    (fcell_uv - boundary)
    /    (     1.0 - boundary)
//  /    (     1.0 - boundary)
    ,      is_out_of_boundary);
//  ,      is_out_of_boundary);
    cell_begin += mix(vec2(0.0), boundary  * cell_sizes
//  cell_begin += mix(vec2(0.0), boundary  * cell_sizes
    ,      is_out_of_boundary);
//  ,      is_out_of_boundary);
    cell_sizes  = mix(           boundary
//  cell_sizes  = mix(           boundary
    ,          1.0 - boundary
//  ,          1.0 - boundary
    ,      is_out_of_boundary) * cell_sizes;
//  ,      is_out_of_boundary) * cell_sizes;
    }
//  }
    }
//  }
    
    vec2              line = step(cell_begin + LINE_THICKNESS, uv);
//  vec2              line = step(cell_begin + LINE_THICKNESS, uv);
    vec3  color = mix(vec3(0.0, 0.0, 0.0)
//  vec3  color = mix(vec3(0.0, 0.0, 0.0)
    ,     vec3(1.0, 1.0, 1.0)
//  ,     vec3(1.0, 1.0, 1.0)
    ,     line.x
//  ,     line.x
    *     line.y
//  *     line.y
    );
//  );
    
    fragColor = vec4(color, 1.0);
//  fragColor = vec4(color, 1.0);
    }


    // https://www.shadertoy.com/view/Mc3Szf
//  // https://www.shadertoy.com/view/Mc3Szf


