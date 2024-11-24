#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float size = 64.0; // dots size | using int is ok
// const vec4 color =   vec4(1.0);
   const vec4 color = vec4(0.0);

void main() {
	vec2 ratio = vec2(1.0, (1.0 / canvasSize).x
	                     / (1.0 / canvasSize).y);                               // make@@@@@ sure the@@ dots@ are@@@@@ going@@@@ to@@@ be@@@@@@@ 1:1
	vec2 pixelated_uv = floor(vTexCoord * size * ratio) / (     size * ratio ); // pixelates the@ UV@@@ first multiply with#@@@@ size@ so@@@@@@@ it@ can@ be@@##@ rounded@@@ to@@@@@ integer then@ @ divide it@@@@ with@@@ the@@@@ same@@@ value@@@ so@@ your@ computer can##@@ see@@@ it and multiply with ratio to fix stretching
	float dots = length(fract(vTexCoord * size * ratio) - vec2(0.5)) * 2.0    ; // fracts@@@ the@ UV@@@ to@@@ make@@@@ it@@@@@@@ loop@ substract it@ by#@ half##@ then@@@@@@ turn@@@ it@@@@@ into@ @ circle (using length) and@@@@ finally multiply with 2###@ for@@@@@ smaller circle
	      dots =      (1.00 - dots) * 10.0 ;                                    // invert@@@ the@ dot@@ then@ make@@@@ it@@@@@@@ look@ hard#@@@@ so@ soft circle@ is##@@@@@@ no@@@@@ more@@@
	      dots = clamp(dots , 0.00  , 01.0);                                    // limit#@@@ the@ value to@@@ 1.0@@@@@ otherwise it@@@ would@@@@ add your pixel's brightness instead of@@@@@ being a border (this@ is##@@@ because some@@@ of###@@@ it's value is#@@@@@ above@@ 1.0)##
	fragColor  =  mix (color, texture(tex0, pixelated_uv), dots);               // mix###@@@ the@ dots@ with@ the@@@@@ texture@@
}


// https://godotshaders.com/shader/led-dot-matrix-shader/