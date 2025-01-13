#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// https://www.shadertoy.com/view/4XdyzS

#define R iResolution.xy
#define L(U) texture(iChannel0,U/R).rgb

#define THRESHOLD .333

void mainImage(out vec4 O, vec2 U) {
  vec3 color = L(U);
  
  int pressure = 0;
  int height = int(R.y);
  int y = int(U.y);
  
  while(y < height) {
    vec2 nU = vec2(U.x, y);
    float diff = distance(color, L(nU));
    if(diff > THRESHOLD) break;
    
    y++; pressure++;
  }
  
  float press = float(pressure) / float(height);
  O = vec4(sqrt(press));
}