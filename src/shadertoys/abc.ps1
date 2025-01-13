# Define the content to write into the files
# Define the content to write into the files
# Define the content to write into the files
$content = @"
#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;
"@

# Loop through files 100.glsl to 200.glsl and write the content
# Loop through files 100.glsl to 200.glsl and write the content
# Loop through files 100.glsl to 200.glsl and write the content
for ($i =   100;
     $i -le 200;
     $i++
    )
{
                      $fileName =     "$i.glsl"
    Set-Content -Path $fileName -Value $content
}


