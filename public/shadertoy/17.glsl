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

    // const vec3   EdgeColor = vec3(0.7);
//  // const vec3   EdgeColor = vec3(0.7);
    // const float  NumsTiles = 40.00;
//  // const float  NumsTiles = 40.00;
    // const float Threshhold = 00.15;
//  // const float Threshhold = 00.15;

    uniform vec3   EdgeColor ; // 0.7, 0.7, 0.7
//  uniform vec3   EdgeColor ; // 0.7, 0.7, 0.7
    uniform float  NumsTiles ; // 40.00
//  uniform float  NumsTiles ; // 40.00
    uniform float Threshhold ; // 00.15
//  uniform float Threshhold ; // 00.15

    vec2 fmod(vec2 a, vec2 b)
//  vec2 fmod(vec2 a, vec2 b)
    {
//  {
    vec2 c = fract(abs(a / b)) * abs(b);
//  vec2 c = fract(abs(a / b)) * abs(b);
    return                       abs(c);
//  return                       abs(c);
    }
//  }

    void main()
    {
    // Normalize @@@@ fragment @@ @coordinates @@@@@@ @@ @@@ @@@@@
//  // Normalize @@@@ fragment @@ @coordinates @@@@@@ @@ @@@ @@@@@
    vec2    uv =       vTexCoord;
//  vec2    uv =       vTexCoord;
    float size = 1.0 / NumsTiles;
//  float size = 1.0 / NumsTiles;

    // Calculate base position of the tile and center of the tile@
//  // Calculate base position of the tile and center of the tile@
    vec2 Pbase   = uv - fmod(uv, vec2(size)     );
//  vec2 Pbase   = uv - fmod(uv, vec2(size)     );
    vec2 PCenter =
//  vec2 PCenter =
    Pbase   +               vec2(size / 2.0);
//  Pbase   +               vec2(size / 2.0);
    
    // Calculate st@@ @@@@@@@@ @@ (coordinates within @@ the tile)
//  // Calculate st@@ @@@@@@@@ @@ (coordinates within @@ the tile)
    vec2 st = (uv - Pbase) / size;
//  vec2 st = (uv - Pbase) / size;

    // Initialize color@ variables
//  // Initialize color@ variables
    vec4 c1 = vec4(0.0);
//  vec4 c1 = vec4(0.0);
    vec4 c2 = vec4(0.0);
//  vec4 c2 = vec4(0.0);
    vec4 invOff = vec4((1.0 - EdgeColor), 1.0);
//  vec4 invOff = vec4((1.0 - EdgeColor), 1.0);

    // Draw@@@@@@ border lines@@@@
//  // Draw@@@@@@ border lines@@@@
    if (st.x > st.y) {
//  if (st.x > st.y) {
    c1 = invOff;
//  c1 = invOff;
    }
//  }

    float threshholdB = 1.0 - Threshhold;
//  float threshholdB = 1.0 - Threshhold;

    if (st.x > threshholdB) {
//  if (st.x > threshholdB) {
    c2 = c1;
//  c2 = c1;
    }
//  }

    if (st.y > threshholdB) {
//  if (st.y > threshholdB) {
    c2 = c1;
//  c2 = c1;
    }
//  }

    vec4 cBottom = c2;
//  vec4 cBottom = c2;
    c1 = vec4(0.0);
//  c1 = vec4(0.0);
    c2 = vec4(0.0);
//  c2 = vec4(0.0);
    
    if (st.x > st.y) {
//  if (st.x > st.y) {
    c1 = invOff;
//  c1 = invOff;
    }
//  }

    if (st.x < Threshhold) {
//  if (st.x < Threshhold) {
    c2 = c1;
//  c2 = c1;
    }
//  }

    if (st.y < Threshhold) {
//  if (st.y < Threshhold) {
    c2 = c1;
//  c2 = c1;
    }
//  }

    vec4 cTop = c2;
//  vec4 cTop = c2;
    
    // Sample texture at the@@@@@@@@ center of the tile
//  // Sample texture at the@@@@@@@@ center of the tile
    vec4           tileColor = texture(tex0 , PCenter);
//  vec4           tileColor = texture(tex0 , PCenter);
    
    // Final@ color@@ @@ calculation @@@@@@ @@ @@@ @@@@
//  // Final@ color@@ @@ calculation @@@@@@ @@ @@@ @@@@
    fragColor = tileColor +         cTop - cBottom ;
//  fragColor = tileColor +         cTop - cBottom ;
    }





    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/MssSDl
//  // https://www.shadertoy.com/view/MssSDl
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@




