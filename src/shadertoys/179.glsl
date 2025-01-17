#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/Xc3BR2

// length of edges of grid
// length of edges of grid
uniform float size  ; // 6.0
uniform float angle ; // 0.0
#define SEPERATE_CHANNELS

const float sin30 =      0.5          ;
const float cos30 =      0.86602540378; // = sin60 = sqrt(3) / 2.0
const float sqrt3 = sqrt(3.0)         ;

    bool       feq(float a, float b) { return abs(a - b) < 1e-5; }
//  bool       feq(float a, float b) { return abs(a - b) < 1e-5; }
    float lengthSq(vec2  v         ) { return dot(v , v)       ; }
//  float lengthSq(vec2  v         ) { return dot(v , v)       ; }

vec2 triangleCell(  vec2 xy  ) {
    vec2 pos = xy / vec2(size * sin30
             ,           size * cos30);
    vec2 i = floor(pos);
    vec2 r = fract(pos);
    if(feq(mod(i.x, 2.), 1.)
    ^^ feq(mod(i.y, 2.), 1.)) { 
        if (r.x
        +   r.y  <  1.0)
            i.x--; 
    }
    else                      { 
        if (r.x
        -   r.y  <  0.0)
            i.x--; 
    }
    return  i    ;
}

mat2 rotm(in float r)
{
    float cr = cos(r);
    float sr = sin(r);
    return mat2(
          cr ,
         -sr ,
          sr ,
          cr
    );
}

vec2 findNearest(vec2 p,
                 vec2 a,
                 vec2 b,
                 vec2 c) {
    vec2      nearest =              a ;
    float best_distSq = lengthSq(p - a);
    float f;
    if ( (f = lengthSq(p - b)) < best_distSq) {
          best_distSq =    f;
              nearest =    b;
    }
    if ( (f = lengthSq(p - c)) < best_distSq) {
          best_distSq =    f;
              nearest =    c;
    }
    return    nearest       ;
}

vec2  nearestTriangleVertex(vec2 xy) {
    vec2 i = triangleCell  (     xy) ;
    
    vec2     origin = vec2( i           ) * vec2(size * sin30
                    ,                            size * cos30);
    vec2 x = origin                      ;
    vec2 y = origin + vec2(size      , 0);
    vec2 z = origin + vec2(size * 0.5, 0);
    
    if (feq(mod(i.y, 2.), 1.)
    ^^  feq(mod(i.x, 2.), 1.))
    {
        x.y += size * cos30;
        y.y += size * cos30;
    }
    else
        z.y += size * cos30;
    
    vec2   nearest_vertex = findNearest(xy, x, y, z);
    return nearest_vertex                           ;
}

    vec3 halftone_dist(vec2 xy, mat2 m) { vec2 rxy = m * xy; vec2 triangle_xy = nearestTriangleVertex(m * xy) * m; float dSq = lengthSq(xy - triangle_xy); vec2 uv = triangle_xy / canvasSize.xy; uv.x = uv.x * 2.2; vec3 col = texture(tex0, uv).rgb; col = pow(col, vec3(4.5)); /* convert texture to linear gamma */ float maxCircleSizeSq = 0.38 * size * size; /* max circle size = 0.5 * size */ /* radius = sqrt(linear color) * maxCircleSize */ vec3 radiusSq = vec3(col.x, col.y, col.z) * maxCircleSizeSq; return dSq / radiusSq; /* return ratio distance^2 / radius^2 */ }
//  vec3 halftone_dist(vec2 xy, mat2 m) { vec2 rxy = m * xy; vec2 triangle_xy = nearestTriangleVertex(m * xy) * m; float dSq = lengthSq(xy - triangle_xy); vec2 uv = triangle_xy / canvasSize.xy; uv.x = uv.x * 2.2; vec3 col = texture(tex0, uv).rgb; col = pow(col, vec3(4.5)); /* convert texture to linear gamma */ float maxCircleSizeSq = 0.38 * size * size; /* max circle size = 0.5 * size */ /* radius = sqrt(linear color) * maxCircleSize */ vec3 radiusSq = vec3(col.x, col.y, col.z) * maxCircleSizeSq; return dSq / radiusSq; /* return ratio distance^2 / radius^2 */ }

void main()
{
    if (mousePosition.z > 0.5) {
        size  = mix(3., 100., mousePosition.y / canvasSize.y);
//      size  = 250.0;
        angle = 360.0       * mousePosition.x / canvasSize.x ;
//      angle
    }
    
    mat2 mb = rotm(radians( 0.0 + angle));
    
    vec3                          ratio  ;
#ifdef SEPERATE_CHANNELS
    mat2 mr = rotm(radians(15.0 + angle));
    mat2 mg = rotm(radians(45.0 + angle));
    mat2 ma = rotm(radians(45.0 + angle));

    ratio.r = halftone_dist(gl_FragCoord, mr).r;
    ratio.g = halftone_dist(gl_FragCoord, mg).g;
    ratio.b = halftone_dist(gl_FragCoord, mb).b;
#else
    ratio   = halftone_dist(gl_FragCoord, mb)  ;
#endif
    
    vec3               col = vec3(1.);
    if (ratio.r > 1.0) col.r =    0. ;
    if (ratio.g > 1.0) col.g =    0. ;
    if (ratio.b > 1.0) col.b =    0. ;

    fragColor = vec4(col, 1.0);
}
















