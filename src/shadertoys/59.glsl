#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// const float  MAX_ITERATION = 9.0000;
// const float LINE_THICKNESS = 0.0055;


uniform float  MAX_ITERATION ; // 9.0000
uniform float LINE_THICKNESS ; // 0.0055


void main(void)
{
    vec2 uv = (gl_FragCoord.xy * 2.0 - canvasSize.xy)
                               / min(  canvasSize.x
                               ,       canvasSize.y );
         uv = fract(uv);
    
    int iteration;
    {
        vec2  luv =   gl_FragCoord.xy / canvasSize.xy;
        vec3 texc =   texture(tex0, luv).xyz         ;
        float
        intensity = 1.0 - dot(texc, vec3(0.299, 0.587, 0.114));
        iteration = int          (
        intensity * MAX_ITERATION);
    }
    
    vec2 cell_begin = vec2(0.0);
    {
              vec2 cell_uv    = uv;
              vec2 cell_sizes = vec2(1.0     );
        const vec2   boundary = vec2(0.5, 0.5);
        for (int i = 0; i < int(MAX_ITERATION); ++i)
        {   
            if ( i >= iteration ) break;

            vec2    is_out_of_boundary =  step(boundary, cell_uv);
            vec2              fcell_uv = fract(          cell_uv);
            
            cell_uv     = mix(fcell_uv / boundary
                        ,    (fcell_uv - boundary)
                        /    (     1.0 - boundary)
                        ,      is_out_of_boundary);
            cell_begin += mix(vec2(0.0), boundary  * cell_sizes
                        ,      is_out_of_boundary);
            cell_sizes  = mix(           boundary
                        ,          1.0 - boundary
                        ,      is_out_of_boundary) * cell_sizes;
        }
    }
    
    vec2              line = step(cell_begin + LINE_THICKNESS, uv);
    vec3  color = mix(vec3(0.0, 0.0, 0.0)
                ,     vec3(1.0, 1.0, 1.0)
                ,     line.x
                *     line.y
                     );
    
     fragColor = vec4(color, 1.0);
}


// https://www.shadertoy.com/view/Mc3Szf


