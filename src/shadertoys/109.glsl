#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;
uniform         float        frameCount;

// https://www.shadertoy.com/view/MXGyWD

#define PI 3.14159265359

uvec3 k = uvec3(0x456789abu, 0x6789ab45u, 0x89ab4567u);
uvec3 u = uvec3(1          , 2          , 3          );
const uint UINT_MAX = 0xffffffffu;

uint uhash11(uint n){
  n ^= ( n << u.x);
  n ^= ( n >> u.x);
  n *=        k.x ;
  n ^= ( n << u.x);
  return n *  k.x ;
}

float hash11(float p){
  uint n = floatBitsToUint(p);
  return   float( uhash11 (n)) / float(UINT_MAX);
}

uvec2 uhash22(uvec2 n){
  n ^= ( n.yx << u.xy);
  n ^= ( n.yx >> u.xy);
  n *=           k.xy ;
  n ^= ( n.yx << u.xy);
  return n    *  k.xy ;
}

float hash21(vec2 p){
  uvec2 n = floatBitsToUint(p);
  return    float( uhash22 (n).x) / float(UINT_MAX);
}

uvec3 uhash33(uvec3 n){
  n ^= ( n.yzx << u);
  n ^= ( n.yzx >> u);
  n *=            k ;
  n ^= ( n.yzx << u);
  return n     *  k ;
}

vec3 hash33(vec3 p){
  uvec3 n = floatBitsToUint(p);
  return    vec3(uhash33   (n)) / vec3(UINT_MAX);
}

float gtable2(vec2 lattice, vec2 p){
  uvec2 n  = floatBitsToUint(lattice);
  uint ind =       uhash22(n).x >> 29;
  float u  = 0.92387953 * (ind < 4u ? p.x : p.y);
  float v  = 0.38268343 * (ind < 4u ? p.y : p.x);
  return ((ind & 1u) == 0u ? u : -u)
       + ((ind & 2u) == 0u ? v : -v);
}

float pnoise21(vec2 p){
  vec2 n = floor(p);
  vec2 f = fract(p);
  float[4] v;
  for (int j = 0; j < 2; j++){
  for (int i = 0; i < 2; i++){
      v[i + 2 * j] = gtable2(n + vec2(i, j)
                   ,         f - vec2(i, j));
  }
  }
  f = f * f * f * (10.0 - 15.0 * f + 6.0 * f * f);
  return 0.5 * mix(
               mix(v[0], v[1], f[0])
             , mix(v[2], v[3], f[0])
             ,                 f[1])
             +
         0.5 ;
}

float      base21(vec2 p){
  return pnoise21(     p) - 0.5;
}

float fbm21(vec2 p, float g, int iter){
  float val  = 0.0;
  float amp  = 1.0;
  float freq = 1.0;
  for (int i = 0  ;  i < iter ; i++){
    val  += amp * base21(freq * p  );
    amp  *= g     ;
    freq *= 2.01  ;
  }
  return 0.5
       * val
       + 0.5;
}

vec2 getDistortedUV(vec2 uv, float g)
{
vec2    distortedUV ;
    float  val = 0.0;
    for (int i = 0  ;
             i < 4  ;
           ++i
        )
    {
        float angle = 2.0
                    * PI
                    * val;
                     distortedUV = uv + g * vec2(cos(angle), sin(angle));
        val = base21(distortedUV)                                       ;
    }
    return           distortedUV                                        ;
}

void main()
{
    vec2 uv = vTexCoord;
    if ( uv.x < 0.15
    ||   uv.x > 0.85)
    {
        fragColor = vec4(vec3(0.0), 1.0);
        return                          ;
    }
    float f = fbm21(getDistortedUV(uv * 1.8 + vec2(5000.0 * hash11(float(frameCount)), 0.0), 1.0) , 0.9, 10) > 0.88 ? 1.0 : 0.0;
    vec3            colorNoise = hash33(vec3(floor( uv  * 500.000)
                                                        * 000.002
                               ,                   time          ));
    float yOffset = time * 0.8 +  fbm21(      vec2(time * 0.25 
                               +        floor(     time * 0.50) / 0.5  , 0.0) , 0.5  , 4) * 30.0 * 0.20;
    bool            isScrolled = hash21(floor(vec2(time * 0.10  , 0.0) * 5.0) * 0.2) <             0.25;
          yOffset = isScrolled ?
          yOffset :        0.0 ;
    float s = 10.0;
    float m = hash21(floor(vec2(0.0, time * 0.7 + uv.y) * s) / s);
    float              temp = m     ;
    m = floor(m * s) / s;
    float   t = 1.0 - (1.00 / s)    ;
    m = m < t ? 0.0 : (temp - t) * s;
    uv.x =  m < 0.01  ?
    uv.x :
    uv.x + (m - 0.50) * 0.1;
    float   ny = hash21(floor(vec2((time - 100.0), 0.0) * 1.0) / 1.0);
    bool   dir = hash21(      vec2( time        )            ) < 0.04;
    ny   =    isScrolled ? ny : dir
                         ?      1.0
                              : 0.0;
    uv.y = dir ? min(uv.y, ny)
               : max(uv.y, ny);
    uv = vec2(uv.x + 0.14 * hash21(vec2(0.0, uv.y + time * 0.13)     * 10.0) * (fbm21(
                                   vec2(0.0, uv.y + time * 0.50), 0.8, 10  ) -  0.5  ), uv.y + yOffset);
    vec4                    imageColor = textureLod(tex0,    uv , 0.0                                 );
    imageColor = m < 0.01 ? imageColor 
                          : imageColor 
                   * 0.85 ;
    imageColor.rgb = mix(imageColor.rgb
                   ,     imageColor.rgb * colorNoise
                   ,                      colorNoise);
    imageColor.rgb = mix(vec3(max(imageColor.b
                   ,          max(imageColor.r
                   ,              imageColor.g)))
                   ,     vec3(1.0)
                   ,  f );
     fragColor     =
    imageColor     ;
}





