#version 300 es
// #version 300 es
    //  precision lowp float;
//  //  precision lowp float;
    precision lowp float;
//  precision lowp float;

    //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  //  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
    out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;
//  out vec4 fragColor; in vec2 vTexCoord; uniform sampler2D tex0; uniform float time; uniform vec2 canvasSize; uniform vec2 texelSize; uniform vec4 mousePosition;

#define TWO_PI 6.28318530718
// #define TWO_PI 6.28318530718

    vec3 random3(vec3 st) {
//  vec3 random3(vec3 st) {
    st = vec3(dot(st, vec3(127.1f, 311.7f, 211.2f) / 20.f), dot(st, vec3(269.5f, 183.3f, 157.1f)), dot(st, vec3(269.5f, 183.3f, 17.1f))); return -1.0f + 2.0f * fract(sin(st) * 43758.5453123f);
//  st = vec3(dot(st, vec3(127.1f, 311.7f, 211.2f) / 20.f), dot(st, vec3(269.5f, 183.3f, 157.1f)), dot(st, vec3(269.5f, 183.3f, 17.1f))); return -1.0f + 2.0f * fract(sin(st) * 43758.5453123f);
    }
//  }

    float noise3D(vec3 st)
//  float noise3D(vec3 st)
    {
//  {
    vec3 i = floor(st);
//  vec3 i = floor(st);
    vec3 f = fract(st);
//  vec3 f = fract(st);
    vec3 u = smoothstep(0., 1., f);
//  vec3 u = smoothstep(0., 1., f);
    
    float valueNowxy01 =mix( mix( dot( random3(i + vec3(0.0,0.0,0.0) ), f - vec3(0.0,0.0,0.0) ),
//  float valueNowxy01 =mix( mix( dot( random3(i + vec3(0.0,0.0,0.0) ), f - vec3(0.0,0.0,0.0) ),
    dot( random3(i + vec3(1.0,0.0,0.0) ), f - vec3(1.0,0.0,0.0) ), u.x),
//  dot( random3(i + vec3(1.0,0.0,0.0) ), f - vec3(1.0,0.0,0.0) ), u.x),
    mix(      dot( random3(i + vec3(0.0,1.0,0.0) ), f - vec3(0.0,1.0,0.0) ),
//  mix(      dot( random3(i + vec3(0.0,1.0,0.0) ), f - vec3(0.0,1.0,0.0) ),
    dot( random3(i + vec3(1.0,1.0,0.0) ), f - vec3(1.0,1.0,0.0) ), u.x), u.y);
//  dot( random3(i + vec3(1.0,1.0,0.0) ), f - vec3(1.0,1.0,0.0) ), u.x), u.y);
    float valueNowxy02 =mix( mix( dot( random3(i + vec3(0.0,0.0,1.0) ), f - vec3(0.0,0.0,1.0) ),
//  float valueNowxy02 =mix( mix( dot( random3(i + vec3(0.0,0.0,1.0) ), f - vec3(0.0,0.0,1.0) ),
    dot( random3(i + vec3(1.0,0.0,1.0) ), f - vec3(1.0,0.0,1.0) ), u.x),
//  dot( random3(i + vec3(1.0,0.0,1.0) ), f - vec3(1.0,0.0,1.0) ), u.x),
    mix(      dot( random3(i + vec3(0.0,1.0,1.0) ), f - vec3(0.0,1.0,1.0) ),
//  mix(      dot( random3(i + vec3(0.0,1.0,1.0) ), f - vec3(0.0,1.0,1.0) ),
    dot( random3(i + vec3(1.0,1.0,1.0) ), f - vec3(1.0,1.0,1.0) ), u.x), u.y);
//  dot( random3(i + vec3(1.0,1.0,1.0) ), f - vec3(1.0,1.0,1.0) ), u.x), u.y);

    float toReturn = abs(mix(valueNowxy01, valueNowxy02, u.z)); return pow(.2, toReturn) -0.4;;
//  float toReturn = abs(mix(valueNowxy01, valueNowxy02, u.z)); return pow(.2, toReturn) -0.4;;
    }
//  }
    mat2 rotate2d(float _angle){
//  mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle) ,
//  return mat2(cos(_angle),-sin(_angle) ,
    sin(_angle), cos(_angle));
//  sin(_angle), cos(_angle));
    }
//  }


    float fbm(vec2 st) {
//  float fbm(vec2 st) {
    const int n = 6; float toReturn = 0.f; float frequencyIncrease = 2.9f; float amplitudeDecrese = 0.5f; float amplitude = 0.9f; float frequency = 1.f; for(int i = 0; i < n; i++) { float det = float(mod(float(i), 2.f) == 0.f); int signMul = (int(det) * 2) - 1; toReturn += amplitude * noise3D(vec3(st.xy * rotate2d(float(i / n)) * frequency, time * 0.1f * amplitude)); amplitude *= amplitudeDecrese; frequency *= frequencyIncrease; } return toReturn;
//  const int n = 6; float toReturn = 0.f; float frequencyIncrease = 2.9f; float amplitudeDecrese = 0.5f; float amplitude = 0.9f; float frequency = 1.f; for(int i = 0; i < n; i++) { float det = float(mod(float(i), 2.f) == 0.f); int signMul = (int(det) * 2) - 1; toReturn += amplitude * noise3D(vec3(st.xy * rotate2d(float(i / n)) * frequency, time * 0.1f * amplitude)); amplitude *= amplitudeDecrese; frequency *= frequencyIncrease; } return toReturn;
    }
//  }

    void main() {
    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.y; uv.y = 1.0f - uv.y; vec2 toCenter = vec2(0.5f) - uv; float dis = length(toCenter); float angle = (acos(toCenter.x * 1.0f / dis) / TWO_PI) * 2.f;
//  vec2 uv = vec4(vTexCoord * canvasSize, 0.0, 1.0).xy / canvasSize.y; uv.y = 1.0f - uv.y; vec2 toCenter = vec2(0.5f) - uv; float dis = length(toCenter); float angle = (acos(toCenter.x * 1.0f / dis) / TWO_PI) * 2.f;
    //vec2 st = vec2(angle , dis );
//  //vec2 st = vec2(angle , dis );
    vec2 st = uv;
//  vec2 st = uv;
    // Time varying pixel color
//  // Time varying pixel color
    float r1 = fbm(st); float r2 = fbm(st * rotate2d(1.14f) + vec2(1412.f, 124.f) + r1); float colt = fbm(st * rotate2d(0.213f) + vec2(14122.f, 14.f) + r2);
//  float r1 = fbm(st); float r2 = fbm(st * rotate2d(1.14f) + vec2(1412.f, 124.f) + r1); float colt = fbm(st * rotate2d(0.213f) + vec2(14122.f, 14.f) + r2);
    // Output to screen
//  // Output to screen
    vec3 finColor = mix(vec3(r1, r2, colt), vec3(0.121f, pow(min(r1, r2), 2.f), 0.2f), colt); finColor = mix(finColor, vec3(dot(finColor, vec3(0.91f, abs(sin(time * 0.2f)), 0.2f)), dot(finColor, vec3(colt)), colt * r1), r2); fragColor = vec4(finColor, 1.f);
//  vec3 finColor = mix(vec3(r1, r2, colt), vec3(0.121f, pow(min(r1, r2), 2.f), 0.2f), colt); finColor = mix(finColor, vec3(dot(finColor, vec3(0.91f, abs(sin(time * 0.2f)), 0.2f)), dot(finColor, vec3(colt)), colt * r1), r2); fragColor = vec4(finColor, 1.f);
    }

    // https://www.shadertoy.com/view/XsKyz3
//  // https://www.shadertoy.com/view/XsKyz3
    // https://www.shadertoy.com/view/XsKyz3
//  // https://www.shadertoy.com/view/XsKyz3
    // https://www.shadertoy.com/view/XsKyz3
//  // https://www.shadertoy.com/view/XsKyz3


