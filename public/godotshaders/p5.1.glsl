#version 300 es
// #version 300 es
    precision  lowp float;
//  precision  lowp float;
    uniform sampler2D   tex0;
//  uniform sampler2D   tex0;
    in        vec2 vTexCoord;
//  in        vec2 vTexCoord;
    out       vec4 fragColor;
//  out       vec4 fragColor;
    vec2 zoom(vec2 coord, float amount) {
//  vec2 zoom(vec2 coord, float amount) {
    vec2 relativeToCenter  = coord - 0.5;
//  vec2 relativeToCenter  = coord - 0.5;
    relativeToCenter /= amount;      //     Zoom in
//  relativeToCenter /= amount;      //     Zoom in
    return     relativeToCenter          + 0.5; // Put back into absolute coordinates
//  return     relativeToCenter          + 0.5; // Put back into absolute coordinates
    }
//  }
    void main() {
    // Get each@ color channel@ using coordinates with@@@@ different amounts
//  // Get each@ color channel@ using coordinates with@@@@ different amounts
    // of@ zooms to@@@ displace the@@ colors@@@@@ slightly
//  // of@ zooms to@@@ displace the@@ colors@@@@@ slightly
    fragColor = vec4(
//  fragColor = vec4(
    texture(tex0,      vTexCoord       ).r,
//  texture(tex0,      vTexCoord       ).r,
    texture(tex0, zoom(vTexCoord, 1.05)).g,
//  texture(tex0, zoom(vTexCoord, 1.05)).g,
    texture(tex0, zoom(vTexCoord, 1.10)).b,
//  texture(tex0, zoom(vTexCoord, 1.10)).b,
    texture(tex0,      vTexCoord       ).a
//  texture(tex0,      vTexCoord       ).a
    );
//  );
    }









