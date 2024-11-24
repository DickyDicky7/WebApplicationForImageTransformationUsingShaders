#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize;

float getChannel(int channel, sampler2D tex, vec2 uv)
{
    return dot(texture(tex, uv), vec4(channel == 0,
                                        channel == 1,
                                        channel == 2,
                                        channel == 3));
}

void main()
{
    vec2       uv =              vTexCoord ;
    float channel = getChannel(2, tex0, uv);
                                           fragColor = vec4(vec3(channel), 1.0);
}




// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://www.shadertoy.com/view/XdsfzH
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



















