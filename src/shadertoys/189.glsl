#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4cGcDd

const int N = 5;

vec2 anchorsLast[N] = vec2[](
  vec2(0.0, 0.0),
  vec2(1.0, 0.0),
  vec2(0.0, 1.0),
  vec2(1.0, 1.0),
  vec2(0.5, 0.5));

vec2 anchorsCurr[N] = vec2[](
  vec2(0.0, 0.0),
  vec2(1.0, 0.0),
  vec2(0.0, 1.0),
  vec2(1.0, 1.0),
  vec2(0.5, 0.5));

void main() {

    // Move the central anchor around to show the warping
    // Move the central anchor around to show the warping
    const int   animatedAnchor  = 4;
    anchorsCurr[animatedAnchor] = vec2(0.5, 0.5) + vec2(cos(time) * 0.1, sin(time) * 0.1);
    // Click the image to move the anchor interactively
    // Click the image to move the anchor interactively
    if (mousePosition.z > 0.
    &&  mousePosition.w < 0.
       )
    {
        anchorsCurr[animatedAnchor] = mousePosition.xy / canvasSize.y;
    }

    vec2 uv = gl_FragCoord.xy / canvasSize.y;
    
    // Step 1: Calculate how similar is the current fragment to each anchor
    // Step 1: Calculate how similar is the current fragment to each anchor
    float similarity[N]  ;
    for (int i = 0; i < N; ++i) {
          similarity[i] = 1. / distance(anchorsCurr[i], uv);
    }
    
    // Step 2: Normalize the anchor similarity using softmax
    // Step 2: Normalize the anchor similarity using softmax
    float expArr[N]  ;
    float expSum = 0.;
    for (int   i = 0 ; i < N; ++i) {
        // glsl exp function cannot handle high exponents
        // glsl exp function cannot handle high exponents
        expArr[i]  = exp(min(50., similarity[i]));
        expSum    +=
        expArr[i]                                ;
    }
    for (int   i = 0 ; i < N; ++i) {
        similarity[i] =  expArr[i]
                      /  expSum
                            ;
    }
    
    // Step 3: Shift the UV by weighted sum of anchor displacements
    // Step 3: Shift the UV by weighted sum of anchor displacements
    vec2 displacements[N];
    for (int i = 0; i < N; ++i) {
         displacements[i] = anchorsLast[i]
                          - anchorsCurr[i];
    }
    for (int i = 0; i < N; ++i) {
  uv +=  displacements[i] *  similarity[i];
    }
    
    // Step 4: Sample the texture at the shifted UV
    // Step 4: Sample the texture at the shifted UV
    fragColor.rgb = texture(tex0, uv).rgb;
    
    // Debug output: show similarity to some anchors
    // Debug output: show similarity to some anchors
    // fragColor.r = similarity[0];
    // fragColor.g = similarity[3];
    // fragColor.b = similarity[4];
}








