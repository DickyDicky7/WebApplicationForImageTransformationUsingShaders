    #version 300 es
//  #version 300 es
    //  precision lowp float;
//  //  precision lowp float;
    precision lowp float;
//  precision lowp float;

    //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

    #define N_DELTA 0.015625
//  #define N_DELTA 0.015625
    float rand(vec3 n) {
//  float rand(vec3 n) {
    return fract(sin(dot(n, vec3(95.43583f, 93.323197f, 94.993431f))) * 65536.32f);
//  return fract(sin(dot(n, vec3(95.43583f, 93.323197f, 94.993431f))) * 65536.32f);
    }
//  }

    float perlin2(vec3 n) {
//  float perlin2(vec3 n) {
    vec3 base = floor(n / N_DELTA) * N_DELTA;
//  vec3 base = floor(n / N_DELTA) * N_DELTA;
    vec3   dd = vec3(     N_DELTA
//  vec3   dd = vec3(     N_DELTA
    , 0.0f
//  , 0.0f
    , 0.0f);
//  , 0.0f);
    float  tl = rand(base + dd.yyy)
//  float  tl = rand(base + dd.yyy)
    ,  tr = rand(base + dd.xyy)
//  ,  tr = rand(base + dd.xyy)
    ,  bl = rand(base + dd.yxy)
//  ,  bl = rand(base + dd.yxy)
    ,  br = rand(base + dd.xxy);
//  ,  br = rand(base + dd.xxy);
    vec3   p  = (n - base)/ dd.xxx ;
//  vec3   p  = (n - base)/ dd.xxx ;
    float  t  = mix(tl, tr, p.x);
//  float  t  = mix(tl, tr, p.x);
    float  b  = mix(bl, br, p.x);
//  float  b  = mix(bl, br, p.x);
    return      mix(t , b , p.y);
//  return      mix(t , b , p.y);
    }
//  }

    float perlin3(vec3 n) {
//  float perlin3(vec3 n) {
    vec3 base = vec3(n.x, n.y, floor(n.z / N_DELTA) * N_DELTA); vec3 dd = vec3(N_DELTA, 0.0f, 0.0f); vec3 p = (n - base) / dd.xxx; float front = perlin2(base + dd.yyy); float back = perlin2(base + dd.yyx); return mix(front, back, p.z);
//  vec3 base = vec3(n.x, n.y, floor(n.z / N_DELTA) * N_DELTA); vec3 dd = vec3(N_DELTA, 0.0f, 0.0f); vec3 p = (n - base) / dd.xxx; float front = perlin2(base + dd.yyy); float back = perlin2(base + dd.yyx); return mix(front, back, p.z);
    }
//  }

    float fbm(vec3 n) {
//  float fbm(vec3 n) {
    float total = 0.0f; float m1 = 1.0f; float m2 = 0.1f; for(int i = 0; i < 5; i++) { total += perlin3(n * m1) * m2; m2 *= 2.0f; m1 *= 0.5f; } return total;
//  float total = 0.0f; float m1 = 1.0f; float m2 = 0.1f; for(int i = 0; i < 5; i++) { total += perlin3(n * m1) * m2; m2 *= 2.0f; m1 *= 0.5f; } return total;
    }
//  }

    float nebula1(vec3  uv) {
//  float nebula1(vec3  uv) {
    float  n1 = fbm(uv      * 2.90f - 1000.0f);
//  float  n1 = fbm(uv      * 2.90f - 1000.0f);
    float  n2 = fbm(uv + n1 * 0.05f          );
//  float  n2 = fbm(uv + n1 * 0.05f          );
    return n2;
//  return n2;
    }
//  }

    float nebula2(vec3 uv) {
//  float nebula2(vec3 uv) {
    float n1 = fbm(uv      * 1.30f + 115.0f);
//  float n1 = fbm(uv      * 1.30f + 115.0f);
    float n2 = fbm(uv + n1 * 0.35f         );
//  float n2 = fbm(uv + n1 * 0.35f         );
    return     fbm(uv + n2 * 0.17f         );
//  return     fbm(uv + n2 * 0.17f         );
    }
//  }

    float nebula3(vec3  uv) {
//  float nebula3(vec3  uv) {
    float  n1 = fbm(uv      * 3.00f);
//  float  n1 = fbm(uv      * 3.00f);
    float  n2 = fbm(uv + n1 * 0.15f);
//  float  n2 = fbm(uv + n1 * 0.15f);
    return n2;
//  return n2;
    }
//  }

    vec3 nebula(vec3 uv) {
//  vec3 nebula(vec3 uv) {
    uv *= 10.0f;
//  uv *= 10.0f;
    return nebula1(uv * 0.5f) * vec3(1.0f, 0.0f, 0.0f) +
//  return nebula1(uv * 0.5f) * vec3(1.0f, 0.0f, 0.0f) +
    nebula2(uv * 0.4f) * vec3(0.0f, 1.0f, 0.0f) +
//  nebula2(uv * 0.4f) * vec3(0.0f, 1.0f, 0.0f) +
    nebula3(uv * 0.6f) * vec3(0.0f, 0.0f, 1.0f) ;
//  nebula3(uv * 0.6f) * vec3(0.0f, 0.0f, 1.0f) ;

    }
//  }

    void main() {
    float size = max(canvasSize.x, canvasSize.y); vec2 xy = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy * 0.5f) / size * 2.0f; vec3 rayDir = normalize(vec3(xy, 1.0f)); vec2 uv = xy * 0.5f + 0.5f; fragColor = vec4(vec3((nebula(vec3(uv * 5.1f, time * 0.1f) * 0.1f) - 1.0f)), 1.0f);
//  float size = max(canvasSize.x, canvasSize.y); vec2 xy = (vec4(vTexCoord * canvasSize, 0.0, 1.0).xy - canvasSize.xy * 0.5f) / size * 2.0f; vec3 rayDir = normalize(vec3(xy, 1.0f)); vec2 uv = xy * 0.5f + 0.5f; fragColor = vec4(vec3((nebula(vec3(uv * 5.1f, time * 0.1f) * 0.1f) - 1.0f)), 1.0f);
    }

    // https://www.shadertoy.com/view/MtcXDr
//  // https://www.shadertoy.com/view/MtcXDr
    // https://www.shadertoy.com/view/MtcXDr
//  // https://www.shadertoy.com/view/MtcXDr
    // https://www.shadertoy.com/view/MtcXDr
//  // https://www.shadertoy.com/view/MtcXDr





