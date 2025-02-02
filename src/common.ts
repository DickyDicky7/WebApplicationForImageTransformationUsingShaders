export type ShaderName = string;
export type ShaderPath = string;
export const Shaders: Map<ShaderName, ShaderPath> = new Map([
    [
        "0                    ",
        `./lib/${  0}.glsl?raw`,
    ]
    ,
    [
        "CRT #001             ",
        `./lib/${  1}.glsl?raw`,
    ]
    ,
    [
        "VHS #001             ",
        `./lib/${  2}.glsl?raw`,
    ]
    ,
    [
        "RAIN OR SNOW #001    ",
        `./lib/${  3}.glsl?raw`,
    ]
    ,
    [
        "CELL #001            ",
        `./lib/${  4}.glsl?raw`,
    ]
    ,
    [
        "DITHER #001          ",
        `./lib/${  5}.glsl?raw`,
    ]
    ,
    [
        "VDROPS #001          ",
        `./lib/${  6}.glsl?raw`,
    ]
    ,
    [
        "CRT #002             ",
        `./lib/${  7}.glsl?raw`,
    ]
    ,
    [
        "CHROMATIC #001       ",
        `./lib/${  8}.glsl?raw`,
    ]
    ,
    [
        "GREY #001            ",
        `./lib/${  9}.glsl?raw`,
    ]
    ,
    [
        "EDGE #001            ",
        `./lib/${ 10}.glsl?raw`,
    ]
    ,
    [
        "GLITCH #001          ",
        `./lib/${ 14}.glsl?raw`,
    ]
    ,
    [
        "VCR #001             ",
        `./lib/${ 15}.glsl?raw`,
    ]
    ,
    [
        "PIXELIZE #001        ",
        `./lib/${ 16}.glsl?raw`,
    ]
    ,
    [
        "CHROMATIC #002       ",
        `./lib/${ 17}.glsl?raw`,
    ]
    ,
    [
        "VIGNETTE #002        ",
        `./lib/${ 18}.glsl?raw`,
    ]
    ,
    [
        "CHROMATIC #003       ",
        `./lib/${ 19}.glsl?raw`,
    ]
    ,
    [
        "CHROMATIC #004       ",
        `./lib/${ 20}.glsl?raw`,
    ]
    ,
    [
        "CRT #003             ",
        `./lib/${ 23}.glsl?raw`,
    ]
    ,
    [
        "PIXEL SORTING #001   ",
        `./lib/${ 24}.glsl?raw`,
    ]
    ,
    [
        "PIXELIZE #002        ",
        `./lib/${ 25}.glsl?raw`,
    ]
    ,
    [
        "BODY CAM #001        ",
        `./lib/${ 27}.glsl?raw`,
    ]
    ,
    [
        "GAMMA CORRECTION #001",
        `./lib/${ 29}.glsl?raw`,
    ]
    ,
    [
        "MOTION LINES #001    ",
        `./lib/${ 30}.glsl?raw`,
    ]
    ,
    [
        "VHS #002             ",
        `./lib/${ 31}.glsl?raw`,
    ]
    ,
    [
        "DITHER #002          ",
        `./lib/${ 33}.glsl?raw`,
    ]
    ,
    [
        "HOLOGRAM #001        ",
        `./lib/${ 34}.glsl?raw`,
    ]
    ,
    [
        "CRT #004             ",
        `./lib/${ 35}.glsl?raw`,
    ]
    ,
    [
        "GREY #002            ",
        `./lib/${ 37}.glsl?raw`,
    ]
    ,
    [
        "CHROMATIC #005       ",
        `./lib/${ 38}.glsl?raw`,
    ]
    ,
    [
        "PENCIL #001          ",
        `./lib/${ 39}.glsl?raw`,
    ]
    ,
    [
        "RIPPLE #001          ",
        `./lib/${ 40}.glsl?raw`,
    ]
    ,
    [
        "PIXEL SORTING #002",
        `./lib/${ 42}.glsl?raw`,
    ]
    ,
    [
        "KUWAHARA #001        ",
        `./lib/${ 43}.glsl?raw`,
    ]
    ,
    [
        "GLITCH #002          ",
        `./lib/${ 44}.glsl?raw`,
    ]
    ,
    [
        "WATER #001           ",
        `./lib/${ 46}.glsl?raw`,
    ]
    ,
    [
        "BLUR #001            ",
        `./lib/${ 47}.glsl?raw`,
    ]
    ,
    [
        "PIXELIZE #003        ",
        `./lib/${ 48}.glsl?raw`,
    ]
    ,
    [
        "HALFTONE #001        ",
        `./lib/${ 49}.glsl?raw`,
    ]
    ,
    [
        "CHROMATIC #006       ",
        `./lib/${ 50}.glsl?raw`,
    ]
    ,
    [
        "SCREEN NOISE #001    ",
        `./lib/${ 51}.glsl?raw`,
    ]
    ,
    [
        "HOPERAMPS #001       ",
        `./lib/${ 52}.glsl?raw`,
    ]
    ,
    [
        "CYCLINGPA #001       ",
        `./lib/${ 53}.glsl?raw`,
    ]
    ,
    [
        "RETRO TVS #001       ",
        `./lib/${ 54}.glsl?raw`,
    ]
    ,
    [
        "HALFTONE #002        ",
        `./lib/${ 56}.glsl?raw`,
    ]
    ,
    [
        "ASCIIS #001          ",
        `./lib/${ 57}.glsl?raw`,
    ]
    ,
    [
        "VORTEX #001          ",
        `./lib/${ 58}.glsl?raw`,
    ]
    ,
    [
        "LEDDOT #001          ",
        `./lib/${ 59}.glsl?raw`,
    ]
    ,
    [
        "PIXELIZE HEX #001    ",
        `./lib/${ 60}.glsl?raw`,
    ]
    ,
    [
        "GRADIENT DIT #001    ",
        `./lib/${ 61}.glsl?raw`,
    ]
    ,
    [
        "COLOFLIP #001        ",
        `./lib/${ 64}.glsl?raw`,
    ]
    ,
    [
        "VHS&&CRT #001        ",
        `./lib/${ 65}.glsl?raw`,
    ]
    ,
    [
        "CRT #005             ",
        `./lib/${ 66}.glsl?raw`,
    ]
    ,
    [
        "CRT #006             ",
        `./lib/${ 67}.glsl?raw`,
    ]
    ,
    [
        "FISHEYE #001         ",
        `./lib/${ 68}.glsl?raw`,
    ]
    ,
    [
        "MANGAKA #001         ",
        `./lib/${ 69}.glsl?raw`,
    ]
    ,
    [
        "DISPLACEMENT #001    ",
        `./lib/${ 72}.glsl?raw`,
    ]
    ,
    [
        "SINEWAVESCAM #001    ",
        `./lib/${ 74}.glsl?raw`,
    ]
    ,
    [
        "GRADIENTMAPP #001    ",
        `./lib/${ 75}.glsl?raw`,
    ]
    ,
    [
        "FILMS GRAINY #001    ",
        `./lib/${ 76}.glsl?raw`,
    ]
    ,
    [
        "ANALOG #001          ",
        `./lib/${ 77}.glsl?raw`,
    ]
    ,
    [
        "PERLIN #001          ",
        `./lib/${ 80}.glsl?raw`,
    ]
    ,
    [
        "PIXELIZE #004        ",
        `./lib/${ 81}.glsl?raw`,
    ]
    ,
    [
        "DITHER #003          ",
        `./lib/${ 82}.glsl?raw`,
    ]
    ,
    [
        "LINE ART #001        ",
        `./lib/${ 83}.glsl?raw`,
    ]
    ,
    [
        "VHS #003             ",
        `./lib/${ 84}.glsl?raw`,
    ]
    ,
    [
        "HSV #001             ",
        `./lib/${ 86}.glsl?raw`,
    ]
    ,
    [
        "EDGE #002            ",
        `./lib/${ 87}.glsl?raw`,
    ]
    ,
    [
        "BAYER DITHERING #001@",
        `./lib/${ 88}.glsl?raw`,
    ]
    ,
    [
        "VHS XXX              ",
        `./lib/${ 21}.glsl?raw`,
    ]
    ,
    [
        "PIXEL ART GRADIENT   ",
        `./lib/${ 78}.glsl?raw`,
    ]
    ,
    [
        "DITHER 1-BIT         ",
        `./lib/${ 85}.glsl?raw`,
    ]
    ,
    [
        "GAMEBOYS OVERLAYS    ",
        `./lib/${ 89}.glsl?raw`,
    ]
    ,
    [
        "GRADIENT BLENDING    ",
        `./lib/${ 90}.glsl?raw`,
    ]
    ,
    [
        "MULTILAYER-SNOWFALL--",
        `./lib/${ 91}.glsl?raw`,
    ]
    ,
    [
        "VERYSIMPLE-CRT-------",
        `./lib/${ 92}.glsl?raw`,
    ]
    ,
    [
        "CHROMATIC #007          ",
        `./lib/${"p5.1"}.glsl?raw`,
    ]
    ,
    [
        "WARPEDPOS #001          ",
        `./lib/${"p5.2"}.glsl?raw`,
    ]
    ,
    [
        "SKETCHY #001                ",
        `./shadertoys/${  1}.glsl?raw`,
    ]
    ,
    [
        "GLITCHY #001                ",
        `./shadertoys/${  2}.glsl?raw`,
    ]
    ,
    [
        "GLITCHY #002                ",
        `./shadertoys/${  3}.glsl?raw`,
    ]
    ,
    [
        "HALFTONE #003               ",
        `./shadertoys/${  4}.glsl?raw`,
    ]
    ,
    [
        "RIPPLE #002                 ",
        `./shadertoys/${  5}.glsl?raw`,
    ]
    ,
    [
        "DAWN BRINGER #001           ",
        `./shadertoys/${  6}.glsl?raw`,
    ]
    ,
    [
        "LUMI DOTS #001              ",
        `./shadertoys/${  7}.glsl?raw`,
    ]
    ,
    [
        "DITHER #004                 ",
        `./shadertoys/${  8}.glsl?raw`,
    ]
    ,
    [
        "WATER #002                  ",
        `./shadertoys/${  9}.glsl?raw`,
    ]
    ,
    [
        "COLOR REDUCTION #001        ",
        `./shadertoys/${ 10}.glsl?raw`,
    ]
    ,
    [
        "POSTERIZE #001              ",
        `./shadertoys/${ 11}.glsl?raw`,
    ]
    ,
    [
        "GAMEBOY #001                ",
        `./shadertoys/${ 12}.glsl?raw`,
    ]
    ,
    [
        "KNITTED #001                ",
        `./shadertoys/${ 13}.glsl?raw`,
    ]
    ,
    [
        "TOONISH #001                ",
        `./shadertoys/${ 14}.glsl?raw`,
    ]
    ,
    [
        "POSTC64 #001                ",
        `./shadertoys/${ 15}.glsl?raw`,
    ]
    ,
    [
        "1-BIT NOISE #001            ",
        `./shadertoys/${ 16}.glsl?raw`,
    ]
    ,
    [
        "TILES #001                  ",
        `./shadertoys/${ 17}.glsl?raw`,
    ]
    ,
    [
        "SMOOTH CHROMATIC ABERRATIONS",
        `./shadertoys/${ 18}.glsl?raw`,
    ]
    ,
    [
        "BLEACH #001                 ",
        `./shadertoys/${ 20}.glsl?raw`,
    ]
    ,
    [
        "GREY #003                   ",
        `./shadertoys/${ 21}.glsl?raw`,
    ]
    ,
    [
        "SHARPENING #001             ",
        `./shadertoys/${ 23}.glsl?raw`,
    ]
    ,
    [
        "HATCHING #001               ",
        `./shadertoys/${ 24}.glsl?raw`,
    ]
    ,
    [
        "VORTEX AND SHRINK           ",
        `./shadertoys/${ 25}.glsl?raw`,
    ]
    ,
    [
        "LENS FLARE #001             ",
        `./shadertoys/${ 26}.glsl?raw`,
    ]
    ,
    [
        "SPIRAL QUANTIZATION #001    ",
        `./shadertoys/${ 27}.glsl?raw`,
    ]
    ,
    [
        "REFRACTION #001             ",
        `./shadertoys/${ 28}.glsl?raw`,
    ]
    ,
    [
        "SIMPLE CHROMATIC ABERRATIONS",
        `./shadertoys/${ 30}.glsl?raw`,
    ]
    ,
    [
        "HSV+ DITHER+ POSTERIZE+ #001",
        `./shadertoys/${ 31}.glsl?raw`,
    ]
    ,
    [
        "YUMMY COLORS #001           ",
        `./shadertoys/${ 33}.glsl?raw`,
    ]
    ,
    [
        "POSTERIZE #002              ",
        `./shadertoys/${ 34}.glsl?raw`,
    ]
    ,
    [
        "HATCHING #002               ",
        `./shadertoys/${ 36}.glsl?raw`,
    ]
    ,
    [
        "PREDATOR THERMAL #001       ",
        `./shadertoys/${ 37}.glsl?raw`,
    ]
    ,
    [
        "DOTS LINE DITHER #001       ",
        `./shadertoys/${ 38}.glsl?raw`,
    ]
    ,
    [
        "YUMMY COLORS #002           ",
        `./shadertoys/${ 40}.glsl?raw`,
    ]
    ,
    [
        "WOBBLE #001                 ",
        `./shadertoys/${ 41}.glsl?raw`,
    ]
    ,
    [
        "GLITCH ANALOG NOISE #001    ",
        `./shadertoys/${ 42}.glsl?raw`,
    ]
    ,
    [
        "PALETTE LIMITER #001        ",
        `./shadertoys/${ 43}.glsl?raw`,
    ]
    ,
    [
        "DEREZZED #001               ",
        `./shadertoys/${ 44}.glsl?raw`,
    ]
    ,
    [
        "HALFTONE #004               ",
        `./shadertoys/${ 45}.glsl?raw`,
    ]
    ,
    [
        "JOJO #001                   ",
        `./shadertoys/${ 46}.glsl?raw`,
    ]
    ,
    [
        "GLITCHY #003                ",
        `./shadertoys/${ 47}.glsl?raw`,
    ]
    ,
    [
        "HALFTONE #005 (CMYK)        ",
        `./shadertoys/${ 48}.glsl?raw`,
    ]
    ,
    [
        "WHITE #001                  ",
        `./shadertoys/${ 49}.glsl?raw`,
    ]
    ,
    [
        "ACIDS #001                  ",
        `./shadertoys/${ 50}.glsl?raw`,
    ]
    ,
    [
        "KUWAHARA #002               ",
        `./shadertoys/${ 51}.glsl?raw`,
    ]
    ,
    [
        "BLUR #002                   ",
        `./shadertoys/${ 52}.glsl?raw`,
    ]
    ,
    [
        "POSTERIZE #003              ",
        `./shadertoys/${ 53}.glsl?raw`,
    ]
    ,
    [
        "VIGNETTE #003               ",
        `./shadertoys/${ 54}.glsl?raw`,
    ]
    ,
    [
        "MIRAGE #001                 ",
        `./shadertoys/${ 55}.glsl?raw`,
    ]
    ,
    [
        "RETRO CARTOON #001          ",
        `./shadertoys/${ 56}.glsl?raw`,
    ]
    ,
    [
        "QUANRIZATIONS #001          ",
        `./shadertoys/${ 57}.glsl?raw`,
    ]
    ,
    [
        "HUE #001                    ",
        `./shadertoys/${ 58}.glsl?raw`,
    ]
    ,
    [
        "QUADTREE #001               ",
        `./shadertoys/${ 59}.glsl?raw`,
    ]
    ,
    [
        "VHS #004                    ",
        `./shadertoys/${ 60}.glsl?raw`,
    ]
    ,
    [
        "SHATTER #001                ",
        `./shadertoys/${ 61}.glsl?raw`,
    ]
    ,
    [
        "HUE JAZZ #001               ",
        `./shadertoys/${ 62}.glsl?raw`,
    ]
    ,
    [
        "PENCIL #002                 ",
        `./shadertoys/${ 63}.glsl?raw`,
    ]
    ,
    [
        "GLITCH #003                 ",
        `./shadertoys/${ 64}.glsl?raw`,
    ]
    ,
    [
        "REDBLU #001                 ",
        `./shadertoys/${ 65}.glsl?raw`,
    ]
    ,
    [
        "VCR #002                    ",
        `./shadertoys/${ 66}.glsl?raw`,
    ]
    ,
    [
        "HAL #001                    ",
        `./shadertoys/${ 68}.glsl?raw`,
    ]
    ,
    [
        "RAIN DROPS #001             ",
        `./shadertoys/${ 70}.glsl?raw`,
    ]
    ,
    [
        "RAIN DROPS #002             ",
        `./shadertoys/${ 72}.glsl?raw`,
    ]
    ,
    [
        "PENCIL #003                 ",
        `./shadertoys/${ 75}.glsl?raw`,
    ]
    ,
    [
        "CLOUDS #001                 ",
        `./shadertoys/${ 76}.glsl?raw`,
    ]
    ,
    [
        "RAIN DROPS #003             ",
        `./shadertoys/${ 77}.glsl?raw`,
    ]
    ,
    [
        "RAIN DROPS #004             ",
        `./shadertoys/${ 78}.glsl?raw`,
    ]
    ,
    [
        "RAIN DROPS RIPPLE #001      ",
        `./shadertoys/${ 79}.glsl?raw`,
    ]
    ,
    [
        "CLOUDS #002                 ",
        `./shadertoys/${ 80}.glsl?raw`,
    ]
    ,
    [
        "STAR NEST #001              ",
        `./shadertoys/${ 82}.glsl?raw`,
    ]
    ,
    [
        "PC98 COLOR LOADING #001     ",
        `./shadertoys/${ 92}.glsl?raw`,
    ]
    ,
    [
        "PC98 COLOR LOADING #002     ",
        `./shadertoys/${ 93}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 100          ",
        `./shadertoys/${100}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 101          ",
        `./shadertoys/${101}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 102          ",
        `./shadertoys/${102}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 106          ",
        `./shadertoys/${106}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 107          ",
        `./shadertoys/${107}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 108          ",
        `./shadertoys/${108}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 109          ",
        `./shadertoys/${109}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 110          ",
        `./shadertoys/${110}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 111          ",
        `./shadertoys/${111}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 112          ",
        `./shadertoys/${112}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 113          ",
        `./shadertoys/${113}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 114          ",
        `./shadertoys/${114}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 116          ",
        `./shadertoys/${116}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 117          ",
        `./shadertoys/${117}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 118          ",
        `./shadertoys/${118}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 119          ",
        `./shadertoys/${119}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 120          ",
        `./shadertoys/${120}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 121          ",
        `./shadertoys/${121}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 122          ",
        `./shadertoys/${122}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 123          ",
        `./shadertoys/${123}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 124          ",
        `./shadertoys/${124}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 125          ",
        `./shadertoys/${125}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 126          ",
        `./shadertoys/${126}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 128          ",
        `./shadertoys/${128}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 129          ",
        `./shadertoys/${129}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 130          ",
        `./shadertoys/${130}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 131          ",
        `./shadertoys/${131}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 134          ",
        `./shadertoys/${134}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 135          ",
        `./shadertoys/${135}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 136          ",
        `./shadertoys/${136}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 137          ",
        `./shadertoys/${137}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 140          ",
        `./shadertoys/${140}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 143          ",
        `./shadertoys/${143}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 144          ",
        `./shadertoys/${144}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 146          ",
        `./shadertoys/${146}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 147          ",
        `./shadertoys/${147}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 149          ",
        `./shadertoys/${149}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 150          ",
        `./shadertoys/${150}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 151          ",
        `./shadertoys/${151}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 153          ",
        `./shadertoys/${153}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 154          ",
        `./shadertoys/${154}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 155          ",
        `./shadertoys/${155}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 156          ",
        `./shadertoys/${156}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 157          ",
        `./shadertoys/${157}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 158          ",
        `./shadertoys/${158}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 159          ",
        `./shadertoys/${159}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 160          ",
        `./shadertoys/${160}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 165          ",
        `./shadertoys/${165}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 166          ",
        `./shadertoys/${166}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 169          ",
        `./shadertoys/${169}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 170          ",
        `./shadertoys/${170}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 171          ",
        `./shadertoys/${171}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 173          ",
        `./shadertoys/${173}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 174          ",
        `./shadertoys/${174}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 175          ",
        `./shadertoys/${175}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 177          ",
        `./shadertoys/${177}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 178          ",
        `./shadertoys/${178}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 179          ",
        `./shadertoys/${179}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 180          ",
        `./shadertoys/${180}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 181          ",
        `./shadertoys/${181}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 182          ",
        `./shadertoys/${182}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 183          ",
        `./shadertoys/${183}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 184          ",
        `./shadertoys/${184}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 185          ",
        `./shadertoys/${185}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 186          ",
        `./shadertoys/${186}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 187          ",
        `./shadertoys/${187}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 188          ",
        `./shadertoys/${188}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 189          ",
        `./shadertoys/${189}.glsl?raw`,
    ]
    ,
    [
        "UNNAMED EFFECT 190          ",
        `./shadertoys/${190}.glsl?raw`,
    ]
    ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    // [
    //     "PC98 COLOR LOADING #002     ",
    //     `./shadertoys/${ 93}.glsl?raw`,
    // ]
    // ,
    [
        "  LYGIA BlendAdd         ",
        `./lygia/BlendAdd.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendAverage         ",
        `./lygia/BlendAverage.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendColor         ",
        `./lygia/BlendColor.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendColorBurn         ",
        `./lygia/BlendColorBurn.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendColorDodge         ",
        `./lygia/BlendColorDodge.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendDarken         ",
        `./lygia/BlendDarken.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendDifference         ",
        `./lygia/BlendDifference.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendExclusion         ",
        `./lygia/BlendExclusion.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendGlow         ",
        `./lygia/BlendGlow.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendHardLight         ",
        `./lygia/BlendHardLight.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendHardMix         ",
        `./lygia/BlendHardMix.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendHue         ",
        `./lygia/BlendHue.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendLighten         ",
        `./lygia/BlendLighten.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendLinearBurn         ",
        `./lygia/BlendLinearBurn.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendLinearDodge         ",
        `./lygia/BlendLinearDodge.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendLinearLight         ",
        `./lygia/BlendLinearLight.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendLuminosity         ",
        `./lygia/BlendLuminosity.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendMultiply         ",
        `./lygia/BlendMultiply.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendNegation         ",
        `./lygia/BlendNegation.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendOverlay         ",
        `./lygia/BlendOverlay.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendPhoenix         ",
        `./lygia/BlendPhoenix.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendPinLight         ",
        `./lygia/BlendPinLight.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendReflect         ",
        `./lygia/BlendReflect.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendSaturation         ",
        `./lygia/BlendSaturation.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendScreen         ",
        `./lygia/BlendScreen.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendSoftLight         ",
        `./lygia/BlendSoftLight.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendSubstract         ",
        `./lygia/BlendSubstract.glsl?raw`,
    ]
    ,
    [
        "  LYGIA BlendVividLight         ",
        `./lygia/BlendVividLight.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorBrightnessContrast         ",
        `./lygia/ColorBrightnessContrast.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorContrast         ",
        `./lygia/ColorContrast.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDaltonize         ",
        `./lygia/ColorDaltonize.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDesaturate         ",
        `./lygia/ColorDesaturate.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDitherBayer         ",
        `./lygia/ColorDitherBayer.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDitherBlueNoise         ",
        `./lygia/ColorDitherBlueNoise.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDitherInterleavedGradientNoise         ",
        `./lygia/ColorDitherInterleavedGradientNoise.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDitherShift         ",
        `./lygia/ColorDitherShift.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDitherTriangleNoise         ",
        `./lygia/ColorDitherTriangleNoise.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorDitherVlachos         ",
        `./lygia/ColorDitherVlachos.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorExposure         ",
        `./lygia/ColorExposure.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorHueShift         ",
        `./lygia/ColorHueShift.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorLevels         ",
        `./lygia/ColorLevels.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapACES         ",
        `./lygia/ColorTonemapACES.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapDebug         ",
        `./lygia/ColorTonemapDebug.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapFilmic         ",
        `./lygia/ColorTonemapFilmic.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapLinear         ",
        `./lygia/ColorTonemapLinear.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapReinhard         ",
        `./lygia/ColorTonemapReinhard.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapReinhardJodie         ",
        `./lygia/ColorTonemapReinhardJodie.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapUncharted         ",
        `./lygia/ColorTonemapUncharted.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapUncharted2         ",
        `./lygia/ColorTonemapUncharted2.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorTonemapUnreal         ",
        `./lygia/ColorTonemapUnreal.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorVibrance         ",
        `./lygia/ColorVibrance.glsl?raw`,
    ]
    ,
    [
        "  LYGIA ColorWhiteBalance         ",
        `./lygia/ColorWhiteBalance.glsl?raw`,
    ]
    ,
    [
        "  LYGIA DistortBarrel         ",
        `./lygia/DistortBarrel.glsl?raw`,
    ]
    ,
    [
        "  LYGIA DistortChromaAB         ",
        `./lygia/DistortChromaAB.glsl?raw`,
    ]
    ,
    [
        "  LYGIA DistortGrain         ",
        `./lygia/DistortGrain.glsl?raw`,
    ]
    ,
    [
        "  LYGIA DistortPincushion         ",
        `./lygia/DistortPincushion.glsl?raw`,
    ]
    ,
    [
        "  LYGIA DistortStretch         ",
        `./lygia/DistortStretch.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterBilateral         ",
        `./lygia/FilterBilateral.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterBilinear         ",
        `./lygia/FilterBilinear.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterBoxBlur         ",
        `./lygia/FilterBoxBlur.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterEdge         ",
        `./lygia/FilterEdge.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterFibonacciBokeh         ",
        `./lygia/FilterFibonacciBokeh.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterGaussianBlur         ",
        `./lygia/FilterGaussianBlur.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterJointBilateral         ",
        `./lygia/FilterJointBilateral.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterKuwahara         ",
        `./lygia/FilterKuwahara.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterLaplacian         ",
        `./lygia/FilterLaplacian.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterMean         ",
        `./lygia/FilterMean.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterMedian         ",
        `./lygia/FilterMedian.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterNoiseBlur         ",
        `./lygia/FilterNoiseBlur.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterRadialBlur         ",
        `./lygia/FilterRadialBlur.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterSharpen         ",
        `./lygia/FilterSharpen.glsl?raw`,
    ]
    ,
    [
        "  LYGIA FilterSmartDeNoise         ",
        `./lygia/FilterSmartDeNoise.glsl?raw`,
    ]
    ,

]);

import { imgurClient } from "./global";

const shareImage = async (
    htmlCanvasElement    :
    HTMLCanvasElement    ,
    name                 : string =
   "name___.png"         ,
    title                : string =
   "title@@@@@@"         ,
    description          : string =
   "description"         ,
    text                 : string =
   "text"                ,
                         )
                         : Promise<void> => {
    const uploadResult = await imgurClient.upload({ image        : htmlCanvasElement.toDataURL("image/png", 1.0).split(",")[1]
                                          ,         type         : "base64"
//                                        ,         type         : "base64"
                                          ,         name         :
                                                    name
                                          ,         title        :
                                                    title
                                          ,         description  :
                                                    description
                                          ,         disable_audio: "1"
//                                        ,         disable_audio: "1"
                                          ,
    });
    console.log(uploadResult.data           );
                window      .navigator.share({
        title:
        title,
        text :
        text ,
        url  :  uploadResult.data
                            .link
             ,
//      files: [new File([b as Blob], "image.png", { type: "image/png", })],
//      files: [new File([b as Blob], "image.png", { type: "image/png", })],
    });
};



const shareVideo = async (
      shareVideoBlob     :
                Blob     ,
    htmlCanvasElement    :
    HTMLCanvasElement    ,
    name                 : string =
   "name___.mp4"         ,
    title                : string =
   "title@@@@@@"         ,
    description          : string =
   "description"         ,
    text                 : string =
   "text"                ,
                         )
                         : Promise<void> => {
    const uploadResult = await imgurClient.upload({ image        : await blobToBase64(shareVideoBlob)
                                          ,         type         :            "base64"
//                                        ,         type         :            "base64"
                                          ,         name         :
                                                    name
                                          ,         title        :
                                                    title
                                          ,         description  :
                                                    description
                                          ,         disable_audio: "1"
//                                        ,         disable_audio: "1"
                                          ,
    });
    console.log(uploadResult.data           );
                window      .navigator.share({
        title:
        title,
        text :
        text ,
        url  :  uploadResult.data
                            .link
             ,
//      files: [new File([b as Blob], "image.png", { type: "image/png", })],
//      files: [new File([b as Blob], "image.png", { type: "image/png", })],
    });
};


const shareWebcam = async (
      shareWebcamBlob     :
                 Blob     ,
    htmlCanvasElement     :
    HTMLCanvasElement     ,
    name                  : string =
   "name___.mp4"          ,
    title                 : string =
   "title@@@@@@"          ,
    description           : string =
   "description"          ,
    text                  : string =
   "text"                 ,
                          )
                          : Promise<void> => {
    const uploadResult = await imgurClient.upload({ image        : await blobToBase64(shareWebcamBlob)
                                          ,         type         :            "base64"
//                                        ,         type         :            "base64"
                                          ,         name         :
                                                    name
                                          ,         title        :
                                                    title
                                          ,         description  :
                                                    description
                                          ,         disable_audio: "1"
//                                        ,         disable_audio: "1"
                                          ,
    });
    console.log(uploadResult.data           );
                window      .navigator.share({
        title:
        title,
        text :
        text ,
        url  :  uploadResult.data
                            .link
             ,
//      files: [new File([b as Blob], "image.png", { type: "image/png", })],
//      files: [new File([b as Blob], "image.png", { type: "image/png", })],
    });
};


export {
    shareImage ,
    shareVideo ,
    shareWebcam,
};



function blobToBase64(blob: Blob): Promise<string> { return new Promise((resolve
                                 ,                                       rejects) => {
        const  reader = new
           FileReader(          );

               reader.onloadend = () => {
            if (         reader.result) {
                // Split to remove the data URL prefix and get only the base64 part
                // Split to remove the data URL prefix and get only the base64 part
                resolve((reader.result as string).split(",")[1]);
//              resolve((reader.result as string).split(",")[1]);
            }                      else {
                rejects(new Error("FileReader result is null!"));
//              rejects(new Error("FileReader result is null!"));
            }
        };

        reader.      onerror = () => rejects(new Error("Failed to read the Blob as a Data URL"));
        reader.readAsDataURL(blob);  /*                 Starts to read the blob as a Data URL  */
    });
};




import type {     GLSLUniformValue,
                  GLSLUniforms    ,
                  GLSLUniform_    ,
            } from "./types";
export let exampleGLSLUniforms: GLSLUniforms = [
    { thisUniformName: "a", thisUniformNameJustForDisplay: "a", thisUniformType: "float", thisUniformDefaultValue: 0.0  , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "b", thisUniformNameJustForDisplay: "b", thisUniformType: "int"  , thisUniformDefaultValue: 0    , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "c", thisUniformNameJustForDisplay: "c", thisUniformType: "bool" , thisUniformDefaultValue: false, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },    
    
    { thisUniformName: "d", thisUniformNameJustForDisplay: "d", thisUniformType: "vec2", thisUniformDefaultValue: [0.0, 0.0          ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "e", thisUniformNameJustForDisplay: "e", thisUniformType: "vec3", thisUniformDefaultValue: [0.0, 0.0, 0.0     ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "f", thisUniformNameJustForDisplay: "f", thisUniformType: "vec4", thisUniformDefaultValue: [0.0, 0.0, 0.0, 0.0], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    
    { thisUniformName: "g", thisUniformNameJustForDisplay: "g", thisUniformType: "ivec2", thisUniformDefaultValue: [0, 0      ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "h", thisUniformNameJustForDisplay: "h", thisUniformType: "ivec3", thisUniformDefaultValue: [0, 0, 0   ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "i", thisUniformNameJustForDisplay: "i", thisUniformType: "ivec4", thisUniformDefaultValue: [0, 0, 0, 0], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    
    { thisUniformName: "j", thisUniformNameJustForDisplay: "j", thisUniformType: "mat2", thisUniformDefaultValue: [0.0, 0.0,          
                                                                                                                   0.0, 0.0            ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "k", thisUniformNameJustForDisplay: "k", thisUniformType: "mat3", thisUniformDefaultValue: [0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0       ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "l", thisUniformNameJustForDisplay: "l", thisUniformType: "mat4", thisUniformDefaultValue: [0.0, 0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0, 0.0, 
                                                                                                                   0.0, 0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0, 0.0  ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    
   
    { thisUniformName:         "m", thisUniformNameJustForDisplay:         "m", thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName:   "noise_m", thisUniformNameJustForDisplay:   "noise_m", thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName:   "bayer_m", thisUniformNameJustForDisplay:   "bayer_m", thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    { thisUniformName: "palette_m", thisUniformNameJustForDisplay: "palette_m", thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
];



export function parseGLSL(glslCode: string): GLSLUniforms {
    const           uniformRegex  : RegExp = /uniform\s+(\w+)\s+(\w+)\s*;\s*(\/\/\s*([\w.\-, ]+))?/g;
    const           uniforms               : GLSLUniforms = []                                      ;
    let     match                 : RegExpExecArray| null                                           ;

    while ((match = uniformRegex.exec(glslCode)) !== null) {
        const [
              , type
              , name
              ,
              , defaultValueRaw
              ]   =    match    ;

        // guard - filter
        // guard - filter
        // not editable - auto set internal
        // not editable - auto set internal
        if (name === "tex0"
        ||  name === "vTexCoord"
        ||  name === "fragColor"
        ||  name === "time"
        ||  name === "canvasSize"
        ||  name ===            "texelSize"
        ||  name ===                      "mousePosition"
        ||  name === "frameCount"
           )
        {
            continue;
        }

        // Parse the default value based on type
        // Parse the default value based on type
        let         parsedValue: GLSLUniformValue | null = null;
        if (                         defaultValueRaw) {
            const  cleanedValue =    defaultValueRaw.replace(/\s+/g, ""); // Remove spaces

            switch (type) {
                case "float"         :
                case       "int"     :
                case           "uint":
                    parsedValue = parseFloat(
                   cleanedValue             );
                    break;
                case "bool":
                    parsedValue =           (
                   cleanedValue ===  "true" ||
                   cleanedValue === "!false");
                    break;
                case  "vec2":
                case  "vec3":
                case  "vec4":
                case "ivec2":
                case "ivec3":
                case "ivec4":
                case "uvec2":
                case "uvec3":
                case "uvec4":
                case  "mat2":
                case  "mat3":
                case  "mat4":
                    parsedValue = cleanedValue.split(",").map(v => parseFloat(v));
                    break;
                case "sampler2D"  :
                case "sampler3D"  :
                case "samplerCube":
                    parsedValue = cleanedValue                                   ; // ########### #### Use the raw string for sampler types
                    break;
                default:
                    parsedValue =        null!                                   ; // Unsupported type ### ### ### ###### ### ####### #####
                // bvec2
                // bvec3
                // bvec4
                // mat2x3
                // mat2x4
                // mat3x2
                // mat3x4
                // mat4x2
                // mat4x3

                // samplerCube 
                // sampler2D@@Array@ 
                // sampler2D@@Shadow 
                // samplerCubeShadow 
                // isampler2D 
                // isampler3D 
                // isamplerCube 
                // isampler2DArray 
                // usampler2D 
                // usampler3D 
                // usamplerCube 
                // usampler2DArray 
                // struct
            }
        }

        uniforms.push({
            thisUniformName              :       name ,
            thisUniformNameJustForDisplay:       null!,
            thisUniformType              :       type ,
            thisUniformDefaultValue      : parsedValue,
            thisUniformSampler2DImg      :       null!,
            thisUniformSampler2DEle      :       null!,
        });
    }

    return uniforms;
};



export function splitArrayIntoGroups(
           array    : number[]
,          groupSize: number        ): number[][] {
    return array.reduce((      result: number[][]
                ,               value: number
                ,               index: number) => {
        if (index % groupSize  === 0) {
                               result.push([]);
        }
                               result[result.length - 1].push(value);
    return                     result                               ;
    }
, []);
};



import type { TextureForShader } from "./types"              ;
import type { SupabaseClient   } from "@supabase/supabase-js";

export const fetchAllTextures_Bayer = (): TextureForShader[] => {
    let ns    :           number[]  = [2, 4, 8, 16];
    let result: TextureForShader[]  = [           ];
    ns.forEach(n1 => {
        result.push(
            {
                name:                                                                                                 `bayer${n1}.png`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}.png`,
            }
        );
    ns.forEach(n2 => {
        result.push(
            {
                name:                                                                                                 `bayer${n1}tile${n2}.png`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}tile${n2}.png`,
            }
        );
    });
    });
    return result;
};

export const fetchAllTextures_Noise = (): TextureForShader[] => {
    let pathsA: { path1: string,
                  path2: string,
                } [] = [
        { path1: "sbs_-_noise_texture_pack_-_128x128", path2: "128x128", },
        { path1: "sbs_-_noise_texture_pack_-_256x256", path2: "256x256", },
        { path1: "sbs_-_noise_texture_pack_-_512x512", path2: "512x512", },
    ];
    let pathsB: { path3: string,
                    min: number,
                    max: number,
                } [] = [
        { path3: "Super Perlin"                           , min: 1, max: 14, },
        { path3: "Melt"                                   , min: 1, max: 14, },
        { path3: "Vein"                                   , min: 1, max: 14, },
        { path3: "Gabor"                                  , min: 1, max: 14, },
        { path3: "Milky"                                  , min: 1, max: 14, },
        { path3: "Swirl"                                  , min: 1, max: 14, },
        { path3: "Cracks"                                 , min: 1, max: 14, },
        { path3: "Grainy"                                 , min: 1, max: 14, },
        { path3: "Marble"                                 , min: 1, max: 14, },
        { path3: "Perlin"                                 , min: 1, max: 24, },
        { path3: "Spokes"                                 , min: 1, max: 14, },
        { path3: "Streak"                                 , min: 1, max: 14, },
        { path3: "Techno"                                 , min: 1, max: 14, },
        { path3: "Craters"                                , min: 1, max: 14, },
        { path3: "Voronoi"                                , min: 1, max: 14, },
        { path3:         "Manifold"                       , min: 1, max: 14, },
        { path3:                  "Turbulence"            , min: 1, max: 14, },
        { path3:                             "Super Noise", min: 1, max: 14, },
    ];
    let result: TextureForShader[] = []           ;
    for     (let pathA of pathsA) {
        for (let pathB of pathsB) {
            for (let n = pathB.min; n <= pathB.max; ++n) {
                result.push(
                    {
                        name:                                                                                                                               `${pathB.path3} ${n} - ${pathA.path2}.png`,
                        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/noise_textures/${pathA.path1}/${pathA.path2}/${pathB.path3}/${pathB.path3} ${n} - ${pathA.path2}.png`,
                    }
                );
            }
        }
    }
    return result;
};


export const fetchAllTextures_Palette = async (supabase:               SupabaseClient  ): Promise<TextureForShader[]> => {
    let {            data        }    = await  supabase.storage.from("palette_textures"). list("lospec");
    let result: TextureForShader[]    = []                                                              ;
    for (let item of data ?? []) {
        if ( item .  name === ".emptyFolderPlaceholder" ) {
            continue;
        }
        result.push({
            name:                                                                                           `${item.name}`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/palette_textures/lospec/${item.name}`,
        });
    }
    return result;
};

export const fetchAllTextures_Pencil_ = async (supabase:              SupabaseClient  ): Promise<TextureForShader[]> => {
    let {            data        }    = await  supabase.storage.from("pencil_textures"). list("godot");
    let result: TextureForShader[]    = []                                                            ;
    for (let item of data ?? []) {
        if ( item .  name === ".emptyFolderPlaceholder" ) {
            continue;
        }
        result.push({
            name:                                                                                  `Pencil ${item.name}`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/${item.name}`,
        });
    }
    return result;
};

export const fetchAllTextures_ASCII = async (supabase:              SupabaseClient ): Promise<TextureForShader[]> => {
    let {            data        }  = await  supabase.storage.from("ascii_textures"). list("godot");
    let result: TextureForShader[]  = []                                                           ;
    for (let item of data ?? []) {
        if ( item .  name === ".emptyFolderPlaceholder" ) {
            continue;
        }
        result.push({
            name:                                                                                  `ASCII ${item.name}`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/ascii_textures/godot/${item.name}`,
        });
    }
    return result;
};

export const fetchAllTextures_Tiled = async (supabase:              SupabaseClient ): Promise<TextureForShader[]> => {
    let {            data        }  = await  supabase.storage.from("tiled_textures"). list("godot");
    let result: TextureForShader[]  = []                                                           ;
    for (let item of data ?? []) {
        if ( item .  name === ".emptyFolderPlaceholder" ) {
            continue;
        }
        result.push({
            name:                                                                                  `Tiled ${item.name}`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/tiled_textures/godot/${item.name}`,
        });
    }
    return result;
};

export const fetchAllTextures_ShaderToy = async (supabase        :      SupabaseClient      ):     Promise<TextureForShader[]> => {
    let {            data        } =      await  supabase.storage.from("shader_toy_textures").list("shader_toy");
    let result: TextureForShader[] = []                                                                         ;
    for (let item of data ?? []) {
        if ( item .  name === ".emptyFolderPlaceholder" ) {
            continue;
        }
        result.push({
            name:                                                                                       `Shader Toy ${item.name}`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/shader_toy_textures/shader_toy/${item.name}`,
        });
    }
    return result;
};


import { type EditorSnapshot } from "./types";
import { editorSnapshotsRedoStack } from "./global";
import { editorSnapshotsUndoStack } from "./global";

export const onRedoActionExecuted = async () => {
    let redoEditorSnapshot: EditorSnapshot | undefined = editorSnapshotsRedoStack.pop();
    if (redoEditorSnapshot) {
        await
        redoEditorSnapshot.redo!(
        redoEditorSnapshot.dynamicStorage);
                                                         editorSnapshotsUndoStack
                          .push (
        redoEditorSnapshot               );
    }
};

export const onUndoActionExecuted = async () => {
    let undoEditorSnapshot: EditorSnapshot | undefined = editorSnapshotsUndoStack.pop();
    if (undoEditorSnapshot) {
        await
        undoEditorSnapshot.undo!(
        undoEditorSnapshot.dynamicStorage);
                                                         editorSnapshotsRedoStack
                          .push (
        undoEditorSnapshot               );
    }
};


export const doHexToRgbNormalized = async (hex: string): Promise<{ r: number, g: number, b: number }> => {
    hex = hex.replace(/^#/, '');
    const r = parseInt(hex.substring(0, 2), 16) / 255;
    const g = parseInt(hex.substring(2, 4), 16) / 255;
    const b = parseInt(hex.substring(4, 6), 16) / 255;
    return { r, g, b };
};

export const noHexToRgbNormalized = async (hex: string): Promise<{ r: number, g: number, b: number }> => {
    hex = hex.replace(/^#/, '');
    const r = parseInt(hex.substring(0, 2), 16);
    const g = parseInt(hex.substring(2, 4), 16);
    const b = parseInt(hex.substring(4, 6), 16);
    return { r, g, b };
};

export const rgba_ToHexNormalized = async (r: number
                                  ,        g: number
                                  ,        b: number
                                  ,        a: number
                                  ,       ) : Promise<string> => {
    r = Math.round(Math.max(0, Math.min(255, r)));
    g = Math.round(Math.max(0, Math.min(255, g)));
    b = Math.round(Math.max(0, Math.min(255, b)));
    a = Math.round(Math.max(0, Math.min(255, a)));
    const  hex = `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}${a.toString(16).padStart(2, '0')}`;
//  const  hex = `#${r.toString(16).padStart(2, '0')}${g.toString(16).padStart(2, '0')}${b.toString(16).padStart(2, '0')}${a.toString(16).padStart(2, '0')}`;
    return hex ;
};


import type { DraggableText } from "./types";
import type {               } from "./types";
import type              p5   from "p5"     ;
import type {               } from "p5"     ;
export const display = (draggableText: DraggableText, canvasInstance: p5): void => {
    canvasInstance.push();
//  canvasInstance.push();
    canvasInstance.textLeading(                    draggableText.spacings);
    canvasInstance.textSize   (                    draggableText.fontSize);
    if (                       draggableText.font                        )
    canvasInstance.textFont   (draggableText.font, draggableText.fontSize);
//  canvasInstance.strokeWeight(10);
//  canvasInstance.stroke(draggableText.colorOutline.r, draggableText.colorOutline.g, draggableText.colorOutline.b, draggableText.colorOutline.a);
    canvasInstance.fill  (draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a);
//  canvasInstance.strokeWeight(10);
//  if (                    draggableText.wrapMode) {
//  if (                    draggableText.wrapMode) {
//  canvasInstance.textWrap(draggableText.wrapMode) ;
//  canvasInstance.textWrap(draggableText.wrapMode) ;
//  }
//  }
//  canvasInstance.textStyle(draggableText.stylesOption);
    canvasInstance.textAlign(draggableText.alignHOption
                  ,          draggableText.alignVOption);
    canvasInstance.text(draggableText. contents
                  ,     draggableText. positionX
                  ,     draggableText. positionY
//                ,     draggableText.dimensionW
//                ,     draggableText.dimensionH
                  ,    );
    canvasInstance.pop();
//  canvasInstance.pop();
};

export const onMousePressed = (draggableText: DraggableText, canvasInstance: p5): void => {
    if (canvasInstance.mouseX - canvasInstance.width  / 2 > draggableText.positionX                            &&
        canvasInstance.mouseX - canvasInstance.width  / 2 < draggableText.positionX + draggableText.dimensionW &&
        canvasInstance.mouseY - canvasInstance.height / 2 < draggableText.positionY + draggableText.dimensionH &&
        canvasInstance.mouseY - canvasInstance.height / 2 > draggableText.positionY) {
        draggableText.isDragging = true;
//      draggableText.isDragging = true;
    }
};

export const startDragging  = (draggableText: DraggableText, canvasInstance: p5): void => {
    if (draggableText.isDragging) {
        draggableText.positionX = canvasInstance.mouseX - canvasInstance.width  / 2;
//      draggableText.positionX = canvasInstance.mouseX - canvasInstance.width  / 2;
        draggableText.positionY = canvasInstance.mouseY - canvasInstance.height / 2;
//      draggableText.positionY = canvasInstance.mouseY - canvasInstance.height / 2;
      }
};

export const ceaseDragging  = (draggableText: DraggableText, canvasInstance: p5): void => {
  draggableText.isDragging  = false;
//draggableText.isDragging  = false;
};

import                                                                     type { CustomFont } from "./types";
export const fetchAllFonts_TTF_ITCHIO = async (supabase: SupabaseClient): Promise<CustomFont[]> => { let { data } = await supabase.storage.from("fonts").list("itchio/ttf", { limit: 1000 }); let result: CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `TTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/ttf/${item.name}`, customFontFace: null, }); } return result; };
export const fetchAllFonts_OTF_ITCHIO = async (supabase: SupabaseClient): Promise<CustomFont[]> => { let { data } = await supabase.storage.from("fonts").list("itchio/otf", { limit: 1000 }); let result: CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `OTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/otf/${item.name}`, customFontFace: null, }); } return result; };


