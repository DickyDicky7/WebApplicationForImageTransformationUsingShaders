#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// Palette colors
// Palette colors
vec3 palette[16];



// Function to calculate the color distance
// Function to calculate the color distance
float colorDistance(vec3 color1, vec3 color2)
{
    return sqrt(
        pow(color2.r - color1.r, 2.0) +
        pow(color2.g - color1.g, 2.0) +
        pow(color2.b - color1.b, 2.0)
    );
}

// Function to find the closest color in the palette
// Function to find the closest color in the palette
vec3 conformColor(vec3 color)
{
    vec3  closestColor    = palette[0];
    float currentDistance =     255.0 ;

    for(int i = 0; i < 16; i++)
    // 16 is the length of the palette
    // 16 is the length of the palette
    {
        float dist =   colorDistance(  palette[i], color  );
        if (  dist < currentDistance)
        {
                     currentDistance = dist      ;
                     closestColor    = palette[i];
        }
    }
    
    return           closestColor                ;
}

// Main function to process the image
// Main function to process the image
void main(void)
{
palette[0 ] =    vec3(0.00, 0.00, 0.00);  // black@@
palette[1 ] =    vec3(0.50, 0.00, 0.00);  // maroon@
palette[2 ] =    vec3(0.00, 0.50, 0.00);  // green@@
palette[3 ] =    vec3(0.50, 0.50, 0.00);  // olive@@
palette[4 ] =    vec3(0.00, 0.00, 0.50);  // navy@@@
palette[5 ] =    vec3(0.50, 0.00, 0.50);  // purple@
palette[6 ] =    vec3(0.00, 0.50, 0.50);  // teal@@@
palette[7 ] =    vec3(0.75, 0.75, 0.75);  // silver@
palette[8 ] =    vec3(0.50, 0.50, 0.50);  // gray@@@
palette[9 ] =    vec3(1.00, 0.00, 0.00);  // red@@@@
palette[10] =    vec3(0.00, 1.00, 0.00);  // lime@@@
palette[11] =    vec3(1.00, 1.00, 0.00);  // yellow@
palette[12] =    vec3(0.00, 0.00, 1.00);  // blue@@@
palette[13] =    vec3(1.00, 0.00, 1.00);  // fuchsia
palette[14] =    vec3(0.00, 1.00, 1.00);  // aqua@@@
palette[15] =    vec3(1.00, 1.00, 1.00);  // white@@

    vec2   uv = gl_FragCoord.xy 
              /   canvasSize.xy;
    vec4                          pixelColor = texture(tex0, uv);
    fragColor = vec4(conformColor(pixelColor.rgb), 1.0)         ;
}


// https://www.shadertoy.com/view/4ljyzW
