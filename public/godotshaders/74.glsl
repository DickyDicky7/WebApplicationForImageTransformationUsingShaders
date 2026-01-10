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

    void main() {
    // Calculate @@@ UV coordinates @@@@@ @@ @ @@@@ @@@@
//  // Calculate @@@ UV coordinates @@@@@ @@ @ @@@@ @@@@
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;
    // Offset@@@ the UV coordinates based on a sine wave
//  // Offset@@@ the UV coordinates based on a sine wave
    uv.x += sin(vTexCoord.y * 10.0 + time) * 0.01; // Adjust the frequency and amplitude as needed
//  uv.x += sin(vTexCoord.y * 10.0 + time) * 0.01; // Adjust the frequency and amplitude as needed
    uv.y += sin(vTexCoord.x * 10.0 + time) * 0.01;
//  uv.y += sin(vTexCoord.x * 10.0 + time) * 0.01;

    // Sample the texture using the modified UV coordinates
//  // Sample the texture using the modified UV coordinates
    fragColor = texture(tex0, uv);
//  fragColor = texture(tex0, uv);
    // @@@@@@ @@@ @@@@@@@ @@@@@ @@@ @@@@@@@@ @@ @@@@@@@@@@@
//  // @@@@@@ @@@ @@@@@@@ @@@@@ @@@ @@@@@@@@ @@ @@@@@@@@@@@
    }



    // https://godotshaders.com/shader/sine-wave-camera-view-shader/
//  // https://godotshaders.com/shader/sine-wave-camera-view-shader/
