#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// Desired number of squares per row and column
// @@@@@@@ @@@@@@ @@ @@@@@@@ @@@ @@@ @@@ @@@@@@
const float pix_num = 50.00;
const bool   custom = false;
const int   cus_row_num = 30;
const int   cus_col_num = 30;

void main()
{
    // Aspect ratio of the viewport
    // @@@@@@ @@@@@ @@ @@@ @@@@@@@@
    float aspectRatio = (1.0 / canvasSize).x
                      / (1.0 / canvasSize).y;

    // Normalized pixel coordinates (from 0 to 1)
    // @@@@@@@@@@ @@@@@ @@@@@@@@@@@ @@@@@ @ @@ @@
    vec2 uv    =  vTexCoord ;

    // Adjust uv coordinates to keep squares as squares
    // @@@@@@ @@ @@@@@@@@@@@ @@ @@@@ @@@@@@@ @@ @@@@@@@
         uv.x *= aspectRatio;
    // Creating grid of squares
    // @@@@@@@@ @@@@ @@ @@@@@@@
    if (custom == false)
    {
        uv = vec2(
            float(int(uv.x * pix_num)) / pix_num,
            float(int(uv.y * pix_num)) / pix_num
        );
    }
    else
    {
        uv = vec2(
            float(int(uv.x * float(cus_row_num))) / float(cus_row_num),
            float(int(uv.y * float(cus_col_num))) / float(cus_col_num)
        );
    }
    
    

    // Resetting the aspect ratio effect on x coordinate after grid placement
    // @@@@@@@@@ @@@ @@@@@@ @@@@@ @@@@@@ @@ @ @@@@@@@@@@ @@@@@ @@@@ @@@@@@@@@
    uv.x /= aspectRatio;

    // Time varying pixel color ######
    // @@@@ @@@@@@@ @@@@@ @@@@@ ######
    vec3  col = texture(tex0, uv).rgb;
    // ###############################

    // Output to screen #######
    // @@@@@@ @@ @@@@@@ #######
    fragColor = vec4(col, 1.0);
    // ########################
}



// https://godotshaders.com/shader/pixelate-filter/