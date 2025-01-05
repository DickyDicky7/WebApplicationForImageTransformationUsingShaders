#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

// const int         size = 64 ;         // amount of@ @@@dots@@@
// const float   dot_size = 2.0;         // dots@@ are multiplied by@@@@ dot_size
// const float value_multiplier =  1.0 ; // reduce or@ @increase@ value, @useful@ when its too bright
// const bool            invert = false;

uniform int         size       ; // 64
uniform float   dot_size       ; // 2.0
uniform float value_multiplier ; // 1.0
uniform bool            invert ; // false

vec3 rgb2hsv(vec3 tex) {
    vec3 hsv;
    {
        vec3 c = tex;
        vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
        vec4 p = mix(vec4(c.bg , K.wz ),
                     vec4(c.gb , K.xy ),
                     step(c.b  , c.g  ));
        vec4 q = mix(vec4(p.xyw, c.r  ),
                     vec4(c.r  , p.yzx),
                     step(p.x  , c.r  ));
        float d = q.x - min(
                  q.w , q.y );
        float e = 1.0e-10;
        return tex = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
    }
}

void main() {
    // float version of "size"
    // ##### ####### ## ######
    float fSize = float(size);
    // make sure the dots are going to be 1:1
    // #### #### ### #### ### ##### ## ## ###
    vec2  ratio = vec2(1.0, (1.0 / canvasSize).x
                          / (1.0 / canvasSize).y);
    // pixelates the UV, first multiply with size so it can be rounded to integer then divide it with the same value so your computer can see it and multiply with ratio to fix stretching
    // ######### ### ### ##### ######## #### #### ## ## ### ## ####### ## ####### #### ###### ## #### ### #### ##### ## #### ######## ### ### ## ### ######## #### ##### ## ### ##########
    vec2 pixelated_uv = floor(vTexCoord * fSize * ratio)
                      /      (            fSize * ratio);
    // fracts the UV to make it loop, substract it by half then turn it into circle (using length) and finally multiply with 2 for smaller circle
    // ###### ### ## ## #### ## ##### ######### ## ## #### #### #### ## #### ###### ###### ####### ### ####### ######## #### # ### ####### ######
    float dots = length(fract(vTexCoord * fSize * ratio) - vec2(0.5)) * dot_size;
    // get pixel value (brightness) from hsv; "v" means value
    // ### ##### ##### ############ #### #### ### ##### #####
    float                                                                       value = rgb2hsv(texture(tex0, pixelated_uv).rgb).z;
    // choose between original dots and inverted dots using "invert" since bool are only 0 (false) and 1 (true)
    // ###### ####### ######## #### ### ######## #### ##### ######## ##### #### ### #### # ####### ### # ######
    dots  =   mix(dots, 1.0 - dots, float(invert));
    // add dots with pixels value which will shrink them. Also multiply with value mutliplier because sometimes its too bright
    // ### #### #### ###### ##### ##### #### ###### ##### #### ######## #### ##### ########## ####### ######### ### ### ######
    dots +=                 value                       *                    value_multiplier;
    // make the dots harder but with anti-aliasing (you can use floor function but the edge will be hard)
    // #### ### #### ###### ### #### ############# #### ### ### ##### ######## ### ### #### #### ## #####
    dots  =   pow(dots, 5.0);
    // clamp result value to avoid artifacts when blended with other objects
    // ##### ###### ##### ## ##### ######### #### ####### #### ##### #######
    dots  = clamp(dots, 0.0, 1.0);
    fragColor.rgb =    vec3(dots);
    // the alpha shouldnt be affected too so use original texture instead
    // ### ##### ######## ## ######## ### ## ### ######## ####### #######
    fragColor.a   = texture(tex0, vTexCoord).a;
}


//#-----------------------------------------#
// https://godotshaders.com/shader/halftone/
//#-----------------------------------------#