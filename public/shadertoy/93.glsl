#version 300 es
// #version 300 es
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

    // vec3 color0  = vec3(0.1098, 0.0314, 0.0627);
//  // vec3 color0  = vec3(0.1098, 0.0314, 0.0627);
    // vec3 color1  = vec3(0.3333, 0.0627, 0.0314);
//  // vec3 color1  = vec3(0.3333, 0.0627, 0.0314);
    // vec3 color2  = vec3(0.4902, 0.0941, 0.0941);
//  // vec3 color2  = vec3(0.4902, 0.0941, 0.0941);
    // vec3 color3  = vec3(0.4431, 0.2039, 0.0627);
//  // vec3 color3  = vec3(0.4431, 0.2039, 0.0627);
    // vec3 color4  = vec3(0.3961, 0.4431, 0.3137);
//  // vec3 color4  = vec3(0.3961, 0.4431, 0.3137);
    // vec3 color5  = vec3(0.6824, 0.2980, 0.1882);
//  // vec3 color5  = vec3(0.6824, 0.2980, 0.1882);
    // vec3 color6  = vec3(0.7137, 0.0627, 0.1882);
//  // vec3 color6  = vec3(0.7137, 0.0627, 0.1882);
    // vec3 color7  = vec3(0.7922, 0.4431, 0.2353);
//  // vec3 color7  = vec3(0.7922, 0.4431, 0.2353);
    // vec3 color8  = vec3(0.4431, 0.5843, 0.5529);
//  // vec3 color8  = vec3(0.4431, 0.5843, 0.5529);
    // vec3 color9  = vec3(0.8549, 0.6471, 0.4275);
//  // vec3 color9  = vec3(0.8549, 0.6471, 0.4275);
    // vec3 color10 = vec3(0.9176, 0.8392, 0.6667);
//  // vec3 color10 = vec3(0.9176, 0.8392, 0.6667);
    // vec3 color11 = vec3(0.6471, 0.7294, 0.6824);
//  // vec3 color11 = vec3(0.6471, 0.7294, 0.6824);
    // vec3 color12 = vec3(0.8863, 0.2510, 0.3137);
//  // vec3 color12 = vec3(0.8863, 0.2510, 0.3137);
    // vec3 color13 = vec3(0.9333, 0.4431, 0.4588);
//  // vec3 color13 = vec3(0.9333, 0.4431, 0.4588);
    // vec3 color14 = vec3(0.9647, 0.6157, 0.6157);
//  // vec3 color14 = vec3(0.9647, 0.6157, 0.6157);
    // vec3 color15 = vec3(1.0000, 1.0000, 0.9490);
//  // vec3 color15 = vec3(1.0000, 1.0000, 0.9490);

    uniform vec3 color0  ; // 0.1098, 0.0314, 0.0627
//  uniform vec3 color0  ; // 0.1098, 0.0314, 0.0627
    uniform vec3 color1  ; // 0.3333, 0.0627, 0.0314
//  uniform vec3 color1  ; // 0.3333, 0.0627, 0.0314
    uniform vec3 color2  ; // 0.4902, 0.0941, 0.0941
//  uniform vec3 color2  ; // 0.4902, 0.0941, 0.0941
    uniform vec3 color3  ; // 0.4431, 0.2039, 0.0627
//  uniform vec3 color3  ; // 0.4431, 0.2039, 0.0627
    uniform vec3 color4  ; // 0.3961, 0.4431, 0.3137
//  uniform vec3 color4  ; // 0.3961, 0.4431, 0.3137
    uniform vec3 color5  ; // 0.6824, 0.2980, 0.1882
//  uniform vec3 color5  ; // 0.6824, 0.2980, 0.1882
    uniform vec3 color6  ; // 0.7137, 0.0627, 0.1882
//  uniform vec3 color6  ; // 0.7137, 0.0627, 0.1882
    uniform vec3 color7  ; // 0.7922, 0.4431, 0.2353
//  uniform vec3 color7  ; // 0.7922, 0.4431, 0.2353
    uniform vec3 color8  ; // 0.4431, 0.5843, 0.5529
//  uniform vec3 color8  ; // 0.4431, 0.5843, 0.5529
    uniform vec3 color9  ; // 0.8549, 0.6471, 0.4275
//  uniform vec3 color9  ; // 0.8549, 0.6471, 0.4275
    uniform vec3 color10 ; // 0.9176, 0.8392, 0.6667
//  uniform vec3 color10 ; // 0.9176, 0.8392, 0.6667
    uniform vec3 color11 ; // 0.6471, 0.7294, 0.6824
//  uniform vec3 color11 ; // 0.6471, 0.7294, 0.6824
    uniform vec3 color12 ; // 0.8863, 0.2510, 0.3137
//  uniform vec3 color12 ; // 0.8863, 0.2510, 0.3137
    uniform vec3 color13 ; // 0.9333, 0.4431, 0.4588
//  uniform vec3 color13 ; // 0.9333, 0.4431, 0.4588
    uniform vec3 color14 ; // 0.9647, 0.6157, 0.6157
//  uniform vec3 color14 ; // 0.9647, 0.6157, 0.6157
    uniform vec3 color15 ; // 1.0000, 1.0000, 0.9490
//  uniform vec3 color15 ; // 1.0000, 1.0000, 0.9490

    vec3 getColor(int index) {
//  vec3 getColor(int index) {
    if (index == 0 ) return color0 ;
//  if (index == 0 ) return color0 ;
    if (index == 1 ) return color1 ;
//  if (index == 1 ) return color1 ;
    if (index == 2 ) return color2 ;
//  if (index == 2 ) return color2 ;
    if (index == 3 ) return color3 ;
//  if (index == 3 ) return color3 ;
    if (index == 4 ) return color4 ;
//  if (index == 4 ) return color4 ;
    if (index == 5 ) return color5 ;
//  if (index == 5 ) return color5 ;
    if (index == 6 ) return color6 ;
//  if (index == 6 ) return color6 ;
    if (index == 7 ) return color7 ;
//  if (index == 7 ) return color7 ;
    if (index == 8 ) return color8 ;
//  if (index == 8 ) return color8 ;
    if (index == 9 ) return color9 ;
//  if (index == 9 ) return color9 ;
    if (index == 10) return color10;
//  if (index == 10) return color10;
    if (index == 11) return color11;
//  if (index == 11) return color11;
    if (index == 12) return color12;
//  if (index == 12) return color12;
    if (index == 13) return color13;
//  if (index == 13) return color13;
    if (index == 14) return color14;
//  if (index == 14) return color14;
    return color15;
//  return color15;
    }
//  }

    int findNearestColorIndex(vec3 color) {
//  int findNearestColorIndex(vec3 color) {
    float   minDist = distance(color, getColor(0));
//  float   minDist = distance(color, getColor(0));
    int nearestIndex = 0;
//  int nearestIndex = 0;
    for (int i = 1; i < 16; i++) {
//  for (int i = 1; i < 16; i++) {
    float  dist = distance(color, getColor(i));
//  float  dist = distance(color, getColor(i));
    if (   dist < minDist) {
//  if (   dist < minDist) {
    minDist =    dist;
//  minDist =    dist;
    nearestIndex = i;
//  nearestIndex = i;
    }
//  }
    }
//  }
    return   nearestIndex    ;
//  return   nearestIndex    ;
    }
//  }

    void main() {
    vec2   uv = vTexCoord;
//  vec2   uv = vTexCoord;
    vec3  col = texture(tex0 , uv).rgb;
//  vec3  col = texture(tex0 , uv).rgb;
    int   nearestIndex = findNearestColorIndex(col);
//  int   nearestIndex = findNearestColorIndex(col);
    float shift        = sin                  (time) * 16.0;
//  float shift        = sin                  (time) * 16.0;
    int   shiftedIndex = int (   clamp(float(nearestIndex) + shift, 0.0, 15.0));
//  int   shiftedIndex = int (   clamp(float(nearestIndex) + shift, 0.0, 15.0));
    fragColor = vec4(getColor(      shiftedIndex)        , 1.0       );
//  fragColor = vec4(getColor(      shiftedIndex)        , 1.0       );
    }

    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
    // https://www.shadertoy.com/view/lftcDs
//  // https://www.shadertoy.com/view/lftcDs
    // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//  // @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
