#version 300 es
precision  lowp  float;
uniform sampler2D tex0;
in      vec2 vTexCoord;
out     vec4 fragColor;
void main() {
    fragColor = texture(tex0, vTexCoord);
}

// https://godotshaders.com/shader/blur-vignette-post-processing-colorrect-godot-4-2-1/