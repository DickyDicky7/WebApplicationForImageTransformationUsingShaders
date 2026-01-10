#version 300 es
// #version 300 es
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

    // Grayscale conversion function
//  // Grayscale conversion function
    // Grayscale conversion function
//  // Grayscale conversion function
    float greyScale(in    vec3 col) {
//  float greyScale(in    vec3 col) {
    return  dot(col , vec3(0.2126, 0.7152, 0.0722));
//  return  dot(col , vec3(0.2126, 0.7152, 0.0722));
    }
//  }

    // 2D rotation matrix
//  // 2D rotation matrix
    // 2D rotation matrix
//  // 2D rotation matrix
    mat2 rotate2d(float angle) { return mat2(+cos(angle), -sin(angle),
//  mat2 rotate2d(float angle) { return mat2(+cos(angle), -sin(angle),
    +sin(angle), +cos(angle));
//  +sin(angle), +cos(angle));
    }
//  }

    // Dot screen effect
//  // Dot screen effect
    // Dot screen effect
//  // Dot screen effect
    float dotScreen(in vec2 uv, in float angle, in float scale) {
//  float dotScreen(in vec2 uv, in float angle, in float scale) {
    vec2 p =                                                 (uv - vec2(0.5)) * canvasSize.xy;
//  vec2 p =                                                 (uv - vec2(0.5)) * canvasSize.xy;
    vec2 q =                                                                                  rotate2d(angle) * p * scale;
//  vec2 q =                                                                                  rotate2d(angle) * p * scale;
    return ( sin(q.x)   *
//  return ( sin(q.x)   *
    sin(q.y) ) * 4.0;
//  sin(q.y) ) * 4.0;
    }
//  }

    void main() {
    // Normalized coordinates
//  // Normalized coordinates
    // Normalized coordinates
//  // Normalized coordinates
    vec2 uv = vTexCoord;
//  vec2 uv = vTexCoord;

    // Sample the texture and convert to grayscale
//  // Sample the texture and convert to grayscale
    // Sample the texture and convert to grayscale
//  // Sample the texture and convert to grayscale
    vec3  col  =  texture  (tex0, uv).rgb;
//  vec3  col  =  texture  (tex0, uv).rgb;
    float grey =  greyScale(col);
//  float grey =  greyScale(col);

    // Dynamic angle and scale based on mouse position and time
//  // Dynamic angle and scale based on mouse position and time
    // Dynamic angle and scale based on mouse position and time
//  // Dynamic angle and scale based on mouse position and time
    float angle = mousePosition.y < 1e-3 ? 0.4 :
//  float angle = mousePosition.y < 1e-3 ? 0.4 :
    mousePosition.x /
//  mousePosition.x /
    mousePosition.y ;
//  mousePosition.y ;
    float scale = 1.0 + 0.3 * sin(time);
//  float scale = 1.0 + 0.3 * sin(time);

    // Apply the dot screen effect
//  // Apply the dot screen effect
    // Apply the dot screen effect
//  // Apply the dot screen effect
    col = vec3(grey * 10.0 - 5.0 + dotScreen(uv, angle, scale));
//  col = vec3(grey * 10.0 - 5.0 + dotScreen(uv, angle, scale));

    // Output the final color
//  // Output the final color
    // Output the final color
//  // Output the final color
    fragColor = vec4(col, 1.0);
//  fragColor = vec4(col, 1.0);
    }


    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/4sBBDK
//  // https://www.shadertoy.com/view/4sBBDK
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
