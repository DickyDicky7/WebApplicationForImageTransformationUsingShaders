    #version 300 es
//  #version 300 es
    precision  lowp float;
//  precision  lowp float;

    uniform sampler2D  tex0;
//  uniform sampler2D  tex0;
    in      vec2           vTexCoord;
//  in      vec2           vTexCoord;
    out     vec4           fragColor;
//  out     vec4           fragColor;
    uniform float      time;
//  uniform float      time;
    uniform vec2 canvasSize;
//  uniform vec2 canvasSize;
    uniform vec2           texelSize;
//  uniform vec2           texelSize;

    float randF(vec2 co) {
//  float randF(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
//  return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
    }
//  }

    void main() {
    // Fragment @@@ coordinates @@@@@@@ normalized to the resolution
//  // Fragment @@@ coordinates @@@@@@@ normalized to the resolution
    vec2 uv =vTexCoord;
//  vec2 uv =vTexCoord;
    // Sample@@ the texture@@@@ (video) @@@@@@@@@@ @@ @@@ @@@@@@@@@@
//  // Sample@@ the texture@@@@ (video) @@@@@@@@@@ @@ @@@ @@@@@@@@@@
    vec3 video = texture(tex0, uv).rgb;
//  vec3 video = texture(tex0, uv).rgb;
    // Convert@ to@ grayscale@@ @@@@@@@ @@@@@@@@@@ @@ @@@ @@@@@@@@@@
//  // Convert@ to@ grayscale@@ @@@@@@@ @@@@@@@@@@ @@ @@@ @@@@@@@@@@
    float
//  float
    grey = (video.r
//  grey = (video.r
    +  video.g
//  +  video.g
    +  video.b) / 3.0;
//  +  video.b) / 3.0;
    // Increase @@@ @contrast@@ using@@ smoothstep @@ @@@ @@@@@@@@@@
//  // Increase @@@ @contrast@@ using@@ smoothstep @@ @@@ @@@@@@@@@@
    grey =  smoothstep(1.0,
//  grey =  smoothstep(1.0,
    0.0, grey      );
//  0.0, grey      );
    // Convert@ to@ @1-bit@@@@@ using@@ noise@@@@@ @@ @@@ @@@@@@@@@@
//  // Convert@ to@ @1-bit@@@@@ using@@ noise@@@@@ @@ @@@ @@@@@@@@@@
    grey =        step(     grey , randF(uv + time / 1000.0));
//  grey =        step(     grey , randF(uv + time / 1000.0));
    // @Output@ the @final@@@@@ color@@ @@@@@@@@@@ @@ @@@ @@@@@@@@@@
//  // @Output@ the @final@@@@@ color@@ @@@@@@@@@@ @@ @@@ @@@@@@@@@@
    fragColor  =  vec4(vec3(grey), 1.0);
//  fragColor  =  vec4(vec3(grey), 1.0);
    }



    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/NdjSRD
//  // https://www.shadertoy.com/view/NdjSRD
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@












