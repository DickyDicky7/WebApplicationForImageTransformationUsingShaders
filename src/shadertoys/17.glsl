#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;

vec3   EdgeColor = vec3(0.7);
float  NumsTiles = 40.00;	
float Threshhold = 00.15;

vec2 fmod(vec2 a, vec2 b)
{
    vec2 c = fract(abs(a / b)) * abs(b);
    return                       abs(c);
}

void main() 
{
    // Normalize @@@@ fragment @@ @coordinates @@@@@@ @@ @@@ @@@@@
    vec2    uv =       vTexCoord;
    float size = 1.0 / NumsTiles;

    // Calculate base position of the tile and center of the tile@
    vec2 Pbase   = uv - fmod(uv, vec2(size)     );
    vec2 PCenter =
         Pbase   +               vec2(size / 2.0);
    
    // Calculate st@@ @@@@@@@@ @@ (coordinates within @@ the tile)
    vec2 st = (uv - Pbase) / size;

    // Initialize color@ variables
    vec4 c1 = vec4(0.0);
    vec4 c2 = vec4(0.0);
    vec4 invOff = vec4((1.0 - EdgeColor), 1.0);

    // Draw@@@@@@ border lines@@@@
    if (st.x > st.y) {
        c1 = invOff; 
    }

    float threshholdB = 1.0 - Threshhold;

    if (st.x > threshholdB) { 
        c2 = c1; 
    }

    if (st.y > threshholdB) { 
        c2 = c1; 
    }

    vec4 cBottom = c2;
    c1 = vec4(0.0);
    c2 = vec4(0.0);
    
    if (st.x > st.y) { 
        c1 = invOff; 
    }

    if (st.x < Threshhold) { 
        c2 = c1;
    }

    if (st.y < Threshhold) { 
        c2 = c1; 
    }

    vec4 cTop = c2;
    
    // Sample texture at the@@@@@@@@ center of the tile
    vec4           tileColor = texture(tex0, PCenter);
    
    // Final@ color@@ @@ calculation @@@@@@ @@ @@@ @@@@
    fragColor = tileColor + cTop - cBottom;
}





// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/MssSDl
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@




