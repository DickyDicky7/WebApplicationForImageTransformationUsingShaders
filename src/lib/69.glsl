#version 300 es
precision  lowp float;

uniform         sampler2D          tex0;
in              vec2          vTexCoord;
out             vec4          fragColor;
uniform         float              time;
uniform         vec2         canvasSize;
uniform         vec2          texelSize;
uniform         vec4      mousePosition;

//const bool colorOn =    true;
uniform bool colorOn ; // true

bool is_white(float average, ivec2 pixel_pos) {
    bool pixel_bools[16] = bool[16](
        (pixel_pos.x  )%4==0&&(pixel_pos.y+3)%4==0,
        (pixel_pos.x+2)%4==0&&(pixel_pos.y+1)%4==0,
        (pixel_pos.x+2)%4==0&&(pixel_pos.y+3)%4==0,
        (pixel_pos.x  )%4==0&&(pixel_pos.y+1)%4==0,
        (pixel_pos.x+1)%4==0&&(pixel_pos.y+2)%4==0,
        (pixel_pos.x+3)%4==0&&(pixel_pos.y  )%4==0,
        (pixel_pos.x+3)%4==0&&(pixel_pos.y+2)%4==0,
        (pixel_pos.x+1)%4==0&&(pixel_pos.y  )%4==0,
        (pixel_pos.x+1)%4==0&&(pixel_pos.y+3)%4==0,
        (pixel_pos.x+3)%4==0&&(pixel_pos.y+1)%4==0,
        (pixel_pos.x+3)%4==0&&(pixel_pos.y+3)%4==0,
        (pixel_pos.x+1)%4==0&&(pixel_pos.y+1)%4==0,
        (pixel_pos.x  )%4==0&&(pixel_pos.y+2)%4==0,
        (pixel_pos.x+2)%4==0&&(pixel_pos.y  )%4==0,
        (pixel_pos.x+2)%4==0&&(pixel_pos.y+2)%4==0,
        true
    );
    bool   result = false;
    int    max_i  = int(average * 17.0);
    for (  int i  =     0;
               i  < max_i;
               i++     ) {
           result =
           result || pixel_bools[i];
    }
    return result;
}

void main() {
    vec4  cur_pixel     = texture(tex0, vTexCoord            );
    ivec2     pixel_pos = ivec2  (      vTexCoord / texelSize);
    float average = (cur_pixel.r
                  +  cur_pixel.g
                  +  cur_pixel.b) / 3.0;
    if (is_white(average, pixel_pos))
    {
        fragColor = vec4(1.0, 1.0, 1.0, cur_pixel.a);
    }
    else
    {
        fragColor = vec4(0.0, 0.0, 0.0, cur_pixel.a);
    }
    if (colorOn)
    {
        fragColor *= cur_pixel;
    }
}


// https://godotshaders.com/shader/screentone-black-spaced-pixels/




