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
    uniform vec4       mousePosition;
//  uniform vec4       mousePosition;

    void main() {
    vec2  uv = vTexCoord;
//  vec2  uv = vTexCoord;
    vec4 col = texture(tex0, uv);
//  vec4 col = texture(tex0, uv);
    
    float colorQuality = 2.0 + (mousePosition.y / canvasSize.y) * 8.0; // (1-255)
//  float colorQuality = 2.0 + (mousePosition.y / canvasSize.y) * 8.0; // (1-255)
    
    if (vec4(vTexCoord * canvasSize, 0.0, 1.0).x <        mousePosition.x               )
//  if (vec4(vTexCoord * canvasSize, 0.0, 1.0).x <        mousePosition.x               )
    fragColor = col;
//  fragColor = col;
    else
//  else
    {
//  {
    // output
//  // output
    vec3       q = vec3(colorQuality);
//  vec3       q = vec3(colorQuality);
    fragColor = vec4(floor(col.rgb * q) / q, col.a);
//  fragColor = vec4(floor(col.rgb * q) / q, col.a);
    }
//  }
    }

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/Ml33Dl
//  // https://www.shadertoy.com/view/Ml33Dl
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
