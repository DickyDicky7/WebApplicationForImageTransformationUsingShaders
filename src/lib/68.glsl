#version 300 es
precision highp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

const float     aspect = 1.0;
const float distortion = 1.0;
const float     radius = 1.0;
const float alpha = 1.0;
const float  crop = 1.0;
const vec4   crop_color = vec4(0.0, 0.0, 0.0, 1.0);

vec2 distort(vec2 p)
{
    float d = length(p);
    float z = sqrt(distortion + d * d * -distortion);
    float r =   atan(d  , z  ) / 3.1415926535;
    float phi = atan(p.y, p.x)               ;
    return vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);
}

void main()
{
    vec2 xy = (vTexCoord * 2.0 - 1.0);
         xy =
    vec2(xy.x * aspect,
         xy.y);

    float d = length(xy);

    vec4 tex;

    if (d < radius)
    {
         xy = distort(xy);
        tex = texture(tex0, xy);
        fragColor   = tex;
        fragColor.a = alpha;
    }

    // radial crop
    if (d > crop)
    {
        fragColor = crop_color;
    }
}

// https://godotshaders.com/shader/2d-radial-distortion-fisheye-barrel/