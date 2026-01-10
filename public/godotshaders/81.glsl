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

    // Desired number of squares per row and column
//  // Desired number of squares per row and column
    // @@@@@@@ @@@@@@ @@ @@@@@@@ @@@ @@@ @@@ @@@@@@
//  // @@@@@@@ @@@@@@ @@ @@@@@@@ @@@ @@@ @@@ @@@@@@
    // const float pix_num = 50.00;
//  // const float pix_num = 50.00;
    // const bool   custom = false;
//  // const bool   custom = false;
    // const int   cus_row_num = 30;
//  // const int   cus_row_num = 30;
    // const int   cus_col_num = 30;
//  // const int   cus_col_num = 30;

    uniform float pix_num ; // 50.00
//  uniform float pix_num ; // 50.00
    uniform bool   custom ; // false
//  uniform bool   custom ; // false
    uniform int   cus_row_num ; // 30
//  uniform int   cus_row_num ; // 30
    uniform int   cus_col_num ; // 30
//  uniform int   cus_col_num ; // 30

    void main()
    {
    // Aspect ratio of the viewport
//  // Aspect ratio of the viewport
    // @@@@@@ @@@@@ @@ @@@ @@@@@@@@
//  // @@@@@@ @@@@@ @@ @@@ @@@@@@@@
    float aspectRatio = (1.0 / canvasSize).x
//  float aspectRatio = (1.0 / canvasSize).x
    / (1.0 / canvasSize).y;
//  / (1.0 / canvasSize).y;

    // Normalized pixel coordinates (from 0 to 1)
//  // Normalized pixel coordinates (from 0 to 1)
    // @@@@@@@@@@ @@@@@ @@@@@@@@@@@ @@@@@ @ @@ @@
//  // @@@@@@@@@@ @@@@@ @@@@@@@@@@@ @@@@@ @ @@ @@
    vec2 uv    =  vTexCoord ;
//  vec2 uv    =  vTexCoord ;

    // Adjust uv coordinates to keep squares as squares
//  // Adjust uv coordinates to keep squares as squares
    // @@@@@@ @@ @@@@@@@@@@@ @@ @@@@ @@@@@@@ @@ @@@@@@@
//  // @@@@@@ @@ @@@@@@@@@@@ @@ @@@@ @@@@@@@ @@ @@@@@@@
    uv.x *= aspectRatio;
//  uv.x *= aspectRatio;
    // Creating grid of squares
//  // Creating grid of squares
    // @@@@@@@@ @@@@ @@ @@@@@@@
//  // @@@@@@@@ @@@@ @@ @@@@@@@
    if (custom == false)
//  if (custom == false)
    {
//  {
    uv = vec2(
//  uv = vec2(
    float(int(uv.x * pix_num)) / pix_num,
//  float(int(uv.x * pix_num)) / pix_num,
    float(int(uv.y * pix_num)) / pix_num
//  float(int(uv.y * pix_num)) / pix_num
    );
//  );
    }
//  }
    else
//  else
    {
//  {
    uv = vec2(
//  uv = vec2(
    float(int(uv.x * float(cus_row_num))) / float(cus_row_num),
//  float(int(uv.x * float(cus_row_num))) / float(cus_row_num),
    float(int(uv.y * float(cus_col_num))) / float(cus_col_num)
//  float(int(uv.y * float(cus_col_num))) / float(cus_col_num)
    );
//  );
    }
//  }
    
    

    // Resetting the aspect ratio effect on x coordinate after grid placement
//  // Resetting the aspect ratio effect on x coordinate after grid placement
    // @@@@@@@@@ @@@ @@@@@@ @@@@@ @@@@@@ @@ @ @@@@@@@@@@ @@@@@ @@@@ @@@@@@@@@
//  // @@@@@@@@@ @@@ @@@@@@ @@@@@ @@@@@@ @@ @ @@@@@@@@@@ @@@@@ @@@@ @@@@@@@@@
    uv.x /= aspectRatio;
//  uv.x /= aspectRatio;

    // Time varying pixel color ######
//  // Time varying pixel color ######
    // @@@@ @@@@@@@ @@@@@ @@@@@ ######
//  // @@@@ @@@@@@@ @@@@@ @@@@@ ######
    vec3  col = texture(tex0, uv).rgb;
//  vec3  col = texture(tex0, uv).rgb;
    // ###############################
//  // ###############################

    // Output to screen #######
//  // Output to screen #######
    // @@@@@@ @@ @@@@@@ #######
//  // @@@@@@ @@ @@@@@@ #######
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    // ########################
//  // ########################
    }



    // https://godotshaders.com/shader/pixelate-filter/
//  // https://godotshaders.com/shader/pixelate-filter/
