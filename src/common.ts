    import type { SupabaseClient } from "@supabase/supabase-js";
//  import type { SupabaseClient } from "@supabase/supabase-js";
    import * as global from "./global.svelte";
//  import * as global from "./global.svelte";
    import * as types from "./types";
//  import * as types from "./types";
    import p5 from "p5";
//  import p5 from "p5";

    const Shaders: Map<types.ShaderName, types.ShaderPath> = new Map([
//  const Shaders: Map<types.ShaderName, types.ShaderPath> = new Map([
        [
//      [
            "0",
//          "0",
            `/godotshaders/${0}.glsl`,
//          `/godotshaders/${0}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CRT #001",
//          "CRT #001",
            `/godotshaders/${1}.glsl`,
//          `/godotshaders/${1}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VHS #001",
//          "VHS #001",
            `/godotshaders/${2}.glsl`,
//          `/godotshaders/${2}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RAIN OR SNOW #001",
//          "RAIN OR SNOW #001",
            `/godotshaders/${3}.glsl`,
//          `/godotshaders/${3}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CELL #001",
//          "CELL #001",
            `/godotshaders/${4}.glsl`,
//          `/godotshaders/${4}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DITHER #001",
//          "DITHER #001",
            `/godotshaders/${5}.glsl`,
//          `/godotshaders/${5}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VDROPS #001",
//          "VDROPS #001",
            `/godotshaders/${6}.glsl`,
//          `/godotshaders/${6}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CRT #002",
//          "CRT #002",
            `/godotshaders/${7}.glsl`,
//          `/godotshaders/${7}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CHROMATIC #001",
//          "CHROMATIC #001",
            `/godotshaders/${8}.glsl`,
//          `/godotshaders/${8}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GREY #001",
//          "GREY #001",
            `/godotshaders/${9}.glsl`,
//          `/godotshaders/${9}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "EDGE #001",
//          "EDGE #001",
            `/godotshaders/${10}.glsl`,
//          `/godotshaders/${10}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GLITCH #001",
//          "GLITCH #001",
            `/godotshaders/${14}.glsl`,
//          `/godotshaders/${14}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VCR #001",
//          "VCR #001",
            `/godotshaders/${15}.glsl`,
//          `/godotshaders/${15}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXELIZE #001",
//          "PIXELIZE #001",
            `/godotshaders/${16}.glsl`,
//          `/godotshaders/${16}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CHROMATIC #002",
//          "CHROMATIC #002",
            `/godotshaders/${17}.glsl`,
//          `/godotshaders/${17}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VIGNETTE #002",
//          "VIGNETTE #002",
            `/godotshaders/${18}.glsl`,
//          `/godotshaders/${18}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CHROMATIC #003",
//          "CHROMATIC #003",
            `/godotshaders/${19}.glsl`,
//          `/godotshaders/${19}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CHROMATIC #004",
//          "CHROMATIC #004",
            `/godotshaders/${20}.glsl`,
//          `/godotshaders/${20}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CRT #003",
//          "CRT #003",
            `/godotshaders/${23}.glsl`,
//          `/godotshaders/${23}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXEL SORTING #001",
//          "PIXEL SORTING #001",
            `/godotshaders/${24}.glsl`,
//          `/godotshaders/${24}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXELIZE #002",
//          "PIXELIZE #002",
            `/godotshaders/${25}.glsl`,
//          `/godotshaders/${25}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "BODY CAM #001",
//          "BODY CAM #001",
            `/godotshaders/${27}.glsl`,
//          `/godotshaders/${27}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GAMMA CORRECTION #001",
//          "GAMMA CORRECTION #001",
            `/godotshaders/${29}.glsl`,
//          `/godotshaders/${29}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "MOTION LINES #001",
//          "MOTION LINES #001",
            `/godotshaders/${30}.glsl`,
//          `/godotshaders/${30}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VHS #002",
//          "VHS #002",
            `/godotshaders/${31}.glsl`,
//          `/godotshaders/${31}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DITHER #002",
//          "DITHER #002",
            `/godotshaders/${33}.glsl`,
//          `/godotshaders/${33}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HOLOGRAM #001",
//          "HOLOGRAM #001",
            `/godotshaders/${34}.glsl`,
//          `/godotshaders/${34}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CRT #004",
//          "CRT #004",
            `/godotshaders/${35}.glsl`,
//          `/godotshaders/${35}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GREY #002",
//          "GREY #002",
            `/godotshaders/${37}.glsl`,
//          `/godotshaders/${37}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CHROMATIC #005",
//          "CHROMATIC #005",
            `/godotshaders/${38}.glsl`,
//          `/godotshaders/${38}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PENCIL #001",
//          "PENCIL #001",
            `/godotshaders/${39}.glsl`,
//          `/godotshaders/${39}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RIPPLE #001",
//          "RIPPLE #001",
            `/godotshaders/${40}.glsl`,
//          `/godotshaders/${40}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXEL SORTING #002",
//          "PIXEL SORTING #002",
            `/godotshaders/${42}.glsl`,
//          `/godotshaders/${42}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "KUWAHARA #001",
//          "KUWAHARA #001",
            `/godotshaders/${43}.glsl`,
//          `/godotshaders/${43}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GLITCH #002",
//          "GLITCH #002",
            `/godotshaders/${44}.glsl`,
//          `/godotshaders/${44}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "WATER #001",
//          "WATER #001",
            `/godotshaders/${46}.glsl`,
//          `/godotshaders/${46}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "BLUR #001",
//          "BLUR #001",
            `/godotshaders/${47}.glsl`,
//          `/godotshaders/${47}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXELIZE #003",
//          "PIXELIZE #003",
            `/godotshaders/${48}.glsl`,
//          `/godotshaders/${48}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HALFTONE #001",
//          "HALFTONE #001",
            `/godotshaders/${49}.glsl`,
//          `/godotshaders/${49}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CHROMATIC #006",
//          "CHROMATIC #006",
            `/godotshaders/${50}.glsl`,
//          `/godotshaders/${50}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SCREEN NOISE #001",
//          "SCREEN NOISE #001",
            `/godotshaders/${51}.glsl`,
//          `/godotshaders/${51}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HOPERAMPS #001",
//          "HOPERAMPS #001",
            `/godotshaders/${52}.glsl`,
//          `/godotshaders/${52}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CYCLINGPA #001",
//          "CYCLINGPA #001",
            `/godotshaders/${53}.glsl`,
//          `/godotshaders/${53}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RETRO TVS #001",
//          "RETRO TVS #001",
            `/godotshaders/${54}.glsl`,
//          `/godotshaders/${54}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HALFTONE #002",
//          "HALFTONE #002",
            `/godotshaders/${56}.glsl`,
//          `/godotshaders/${56}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "ASCIIS #001",
//          "ASCIIS #001",
            `/godotshaders/${57}.glsl`,
//          `/godotshaders/${57}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VORTEX #001",
//          "VORTEX #001",
            `/godotshaders/${58}.glsl`,
//          `/godotshaders/${58}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LEDDOT #001",
//          "LEDDOT #001",
            `/godotshaders/${59}.glsl`,
//          `/godotshaders/${59}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXELIZE HEX #001",
//          "PIXELIZE HEX #001",
            `/godotshaders/${60}.glsl`,
//          `/godotshaders/${60}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GRADIENT DIT #001",
//          "GRADIENT DIT #001",
            `/godotshaders/${61}.glsl`,
//          `/godotshaders/${61}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "COLOFLIP #001",
//          "COLOFLIP #001",
            `/godotshaders/${64}.glsl`,
//          `/godotshaders/${64}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VHS&&CRT #001",
//          "VHS&&CRT #001",
            `/godotshaders/${65}.glsl`,
//          `/godotshaders/${65}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CRT #005",
//          "CRT #005",
            `/godotshaders/${66}.glsl`,
//          `/godotshaders/${66}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CRT #006",
//          "CRT #006",
            `/godotshaders/${67}.glsl`,
//          `/godotshaders/${67}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "FISHEYE #001",
//          "FISHEYE #001",
            `/godotshaders/${68}.glsl`,
//          `/godotshaders/${68}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "MANGAKA #001",
//          "MANGAKA #001",
            `/godotshaders/${69}.glsl`,
//          `/godotshaders/${69}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DISPLACEMENT #001",
//          "DISPLACEMENT #001",
            `/godotshaders/${72}.glsl`,
//          `/godotshaders/${72}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SINEWAVESCAM #001",
//          "SINEWAVESCAM #001",
            `/godotshaders/${74}.glsl`,
//          `/godotshaders/${74}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GRADIENTMAPP #001",
//          "GRADIENTMAPP #001",
            `/godotshaders/${75}.glsl`,
//          `/godotshaders/${75}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "FILMS GRAINY #001",
//          "FILMS GRAINY #001",
            `/godotshaders/${76}.glsl`,
//          `/godotshaders/${76}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "ANALOG #001",
//          "ANALOG #001",
            `/godotshaders/${77}.glsl`,
//          `/godotshaders/${77}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PERLIN #001",
//          "PERLIN #001",
            `/godotshaders/${80}.glsl`,
//          `/godotshaders/${80}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXELIZE #004",
//          "PIXELIZE #004",
            `/godotshaders/${81}.glsl`,
//          `/godotshaders/${81}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DITHER #003",
//          "DITHER #003",
            `/godotshaders/${82}.glsl`,
//          `/godotshaders/${82}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LINE ART #001",
//          "LINE ART #001",
            `/godotshaders/${83}.glsl`,
//          `/godotshaders/${83}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VHS #003",
//          "VHS #003",
            `/godotshaders/${84}.glsl`,
//          `/godotshaders/${84}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HSV #001",
//          "HSV #001",
            `/godotshaders/${86}.glsl`,
//          `/godotshaders/${86}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "EDGE #002",
//          "EDGE #002",
            `/godotshaders/${87}.glsl`,
//          `/godotshaders/${87}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "BAYER DITHERING #001@",
//          "BAYER DITHERING #001@",
            `/godotshaders/${88}.glsl`,
//          `/godotshaders/${88}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VHS XXX",
//          "VHS XXX",
            `/godotshaders/${21}.glsl`,
//          `/godotshaders/${21}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PIXEL ART GRADIENT",
//          "PIXEL ART GRADIENT",
            `/godotshaders/${78}.glsl`,
//          `/godotshaders/${78}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DITHER 1-BIT",
//          "DITHER 1-BIT",
            `/godotshaders/${85}.glsl`,
//          `/godotshaders/${85}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GAMEBOYS OVERLAYS",
//          "GAMEBOYS OVERLAYS",
            `/godotshaders/${89}.glsl`,
//          `/godotshaders/${89}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GRADIENT BLENDING",
//          "GRADIENT BLENDING",
            `/godotshaders/${90}.glsl`,
//          `/godotshaders/${90}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "MULTILAYER-SNOWFALL--",
//          "MULTILAYER-SNOWFALL--",
            `/godotshaders/${91}.glsl`,
//          `/godotshaders/${91}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VERYSIMPLE-CRT-------",
//          "VERYSIMPLE-CRT-------",
            `/godotshaders/${92}.glsl`,
//          `/godotshaders/${92}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CHROMATIC #007",
//          "CHROMATIC #007",
            `/godotshaders/${"p5.1"}.glsl`,
//          `/godotshaders/${"p5.1"}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "WARPEDPOS #001",
//          "WARPEDPOS #001",
            `/godotshaders/${"p5.2"}.glsl`,
//          `/godotshaders/${"p5.2"}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SKETCHY #001",
//          "SKETCHY #001",
            `/shadertoy/${1}.glsl`,
//          `/shadertoy/${1}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GLITCHY #001",
//          "GLITCHY #001",
            `/shadertoy/${2}.glsl`,
//          `/shadertoy/${2}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GLITCHY #002",
//          "GLITCHY #002",
            `/shadertoy/${3}.glsl`,
//          `/shadertoy/${3}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HALFTONE #003",
//          "HALFTONE #003",
            `/shadertoy/${4}.glsl`,
//          `/shadertoy/${4}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RIPPLE #002",
//          "RIPPLE #002",
            `/shadertoy/${5}.glsl`,
//          `/shadertoy/${5}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DAWN BRINGER #001",
//          "DAWN BRINGER #001",
            `/shadertoy/${6}.glsl`,
//          `/shadertoy/${6}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LUMI DOTS #001",
//          "LUMI DOTS #001",
            `/shadertoy/${7}.glsl`,
//          `/shadertoy/${7}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DITHER #004",
//          "DITHER #004",
            `/shadertoy/${8}.glsl`,
//          `/shadertoy/${8}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "WATER #002",
//          "WATER #002",
            `/shadertoy/${9}.glsl`,
//          `/shadertoy/${9}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "COLOR REDUCTION #001",
//          "COLOR REDUCTION #001",
            `/shadertoy/${10}.glsl`,
//          `/shadertoy/${10}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "POSTERIZE #001",
//          "POSTERIZE #001",
            `/shadertoy/${11}.glsl`,
//          `/shadertoy/${11}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GAMEBOY #001",
//          "GAMEBOY #001",
            `/shadertoy/${12}.glsl`,
//          `/shadertoy/${12}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "KNITTED #001",
//          "KNITTED #001",
            `/shadertoy/${13}.glsl`,
//          `/shadertoy/${13}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "TOONISH #001",
//          "TOONISH #001",
            `/shadertoy/${14}.glsl`,
//          `/shadertoy/${14}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "POSTC64 #001",
//          "POSTC64 #001",
            `/shadertoy/${15}.glsl`,
//          `/shadertoy/${15}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "1-BIT NOISE #001",
//          "1-BIT NOISE #001",
            `/shadertoy/${16}.glsl`,
//          `/shadertoy/${16}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "TILES #001",
//          "TILES #001",
            `/shadertoy/${17}.glsl`,
//          `/shadertoy/${17}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SMOOTH CHROMATIC ABERRATIONS",
//          "SMOOTH CHROMATIC ABERRATIONS",
            `/shadertoy/${18}.glsl`,
//          `/shadertoy/${18}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "BLEACH #001",
//          "BLEACH #001",
            `/shadertoy/${20}.glsl`,
//          `/shadertoy/${20}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GREY #003",
//          "GREY #003",
            `/shadertoy/${21}.glsl`,
//          `/shadertoy/${21}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SHARPENING #001",
//          "SHARPENING #001",
            `/shadertoy/${23}.glsl`,
//          `/shadertoy/${23}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HATCHING #001",
//          "HATCHING #001",
            `/shadertoy/${24}.glsl`,
//          `/shadertoy/${24}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VORTEX AND SHRINK",
//          "VORTEX AND SHRINK",
            `/shadertoy/${25}.glsl`,
//          `/shadertoy/${25}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LENS FLARE #001",
//          "LENS FLARE #001",
            `/shadertoy/${26}.glsl`,
//          `/shadertoy/${26}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SPIRAL QUANTIZATION #001",
//          "SPIRAL QUANTIZATION #001",
            `/shadertoy/${27}.glsl`,
//          `/shadertoy/${27}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "REFRACTION #001",
//          "REFRACTION #001",
            `/shadertoy/${28}.glsl`,
//          `/shadertoy/${28}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SIMPLE CHROMATIC ABERRATIONS",
//          "SIMPLE CHROMATIC ABERRATIONS",
            `/shadertoy/${30}.glsl`,
//          `/shadertoy/${30}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HSV+ DITHER+ POSTERIZE+ #001",
//          "HSV+ DITHER+ POSTERIZE+ #001",
            `/shadertoy/${31}.glsl`,
//          `/shadertoy/${31}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "YUMMY COLORS #001",
//          "YUMMY COLORS #001",
            `/shadertoy/${33}.glsl`,
//          `/shadertoy/${33}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "POSTERIZE #002",
//          "POSTERIZE #002",
            `/shadertoy/${34}.glsl`,
//          `/shadertoy/${34}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HATCHING #002",
//          "HATCHING #002",
            `/shadertoy/${36}.glsl`,
//          `/shadertoy/${36}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PREDATOR THERMAL #001",
//          "PREDATOR THERMAL #001",
            `/shadertoy/${37}.glsl`,
//          `/shadertoy/${37}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DOTS LINE DITHER #001",
//          "DOTS LINE DITHER #001",
            `/shadertoy/${38}.glsl`,
//          `/shadertoy/${38}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "YUMMY COLORS #002",
//          "YUMMY COLORS #002",
            `/shadertoy/${40}.glsl`,
//          `/shadertoy/${40}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "WOBBLE #001",
//          "WOBBLE #001",
            `/shadertoy/${41}.glsl`,
//          `/shadertoy/${41}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GLITCH ANALOG NOISE #001",
//          "GLITCH ANALOG NOISE #001",
            `/shadertoy/${42}.glsl`,
//          `/shadertoy/${42}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PALETTE LIMITER #001",
//          "PALETTE LIMITER #001",
            `/shadertoy/${43}.glsl`,
//          `/shadertoy/${43}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "DEREZZED #001",
//          "DEREZZED #001",
            `/shadertoy/${44}.glsl`,
//          `/shadertoy/${44}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HALFTONE #004",
//          "HALFTONE #004",
            `/shadertoy/${45}.glsl`,
//          `/shadertoy/${45}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "JOJO #001",
//          "JOJO #001",
            `/shadertoy/${46}.glsl`,
//          `/shadertoy/${46}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GLITCHY #003",
//          "GLITCHY #003",
            `/shadertoy/${47}.glsl`,
//          `/shadertoy/${47}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HALFTONE #005 (CMYK)",
//          "HALFTONE #005 (CMYK)",
            `/shadertoy/${48}.glsl`,
//          `/shadertoy/${48}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "WHITE #001",
//          "WHITE #001",
            `/shadertoy/${49}.glsl`,
//          `/shadertoy/${49}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "ACIDS #001",
//          "ACIDS #001",
            `/shadertoy/${50}.glsl`,
//          `/shadertoy/${50}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "KUWAHARA #002",
//          "KUWAHARA #002",
            `/shadertoy/${51}.glsl`,
//          `/shadertoy/${51}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "BLUR #002",
//          "BLUR #002",
            `/shadertoy/${52}.glsl`,
//          `/shadertoy/${52}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "POSTERIZE #003",
//          "POSTERIZE #003",
            `/shadertoy/${53}.glsl`,
//          `/shadertoy/${53}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VIGNETTE #003",
//          "VIGNETTE #003",
            `/shadertoy/${54}.glsl`,
//          `/shadertoy/${54}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "MIRAGE #001",
//          "MIRAGE #001",
            `/shadertoy/${55}.glsl`,
//          `/shadertoy/${55}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RETRO CARTOON #001",
//          "RETRO CARTOON #001",
            `/shadertoy/${56}.glsl`,
//          `/shadertoy/${56}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "QUANRIZATIONS #001",
//          "QUANRIZATIONS #001",
            `/shadertoy/${57}.glsl`,
//          `/shadertoy/${57}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HUE #001",
//          "HUE #001",
            `/shadertoy/${58}.glsl`,
//          `/shadertoy/${58}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "QUADTREE #001",
//          "QUADTREE #001",
            `/shadertoy/${59}.glsl`,
//          `/shadertoy/${59}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VHS #004",
//          "VHS #004",
            `/shadertoy/${60}.glsl`,
//          `/shadertoy/${60}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "SHATTER #001",
//          "SHATTER #001",
            `/shadertoy/${61}.glsl`,
//          `/shadertoy/${61}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HUE JAZZ #001",
//          "HUE JAZZ #001",
            `/shadertoy/${62}.glsl`,
//          `/shadertoy/${62}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PENCIL #002",
//          "PENCIL #002",
            `/shadertoy/${63}.glsl`,
//          `/shadertoy/${63}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "GLITCH #003",
//          "GLITCH #003",
            `/shadertoy/${64}.glsl`,
//          `/shadertoy/${64}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "REDBLU #001",
//          "REDBLU #001",
            `/shadertoy/${65}.glsl`,
//          `/shadertoy/${65}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "VCR #002",
//          "VCR #002",
            `/shadertoy/${66}.glsl`,
//          `/shadertoy/${66}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "HAL #001",
//          "HAL #001",
            `/shadertoy/${68}.glsl`,
//          `/shadertoy/${68}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RAIN DROPS #001",
//          "RAIN DROPS #001",
            `/shadertoy/${70}.glsl`,
//          `/shadertoy/${70}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RAIN DROPS #002",
//          "RAIN DROPS #002",
            `/shadertoy/${72}.glsl`,
//          `/shadertoy/${72}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PENCIL #003",
//          "PENCIL #003",
            `/shadertoy/${75}.glsl`,
//          `/shadertoy/${75}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CLOUDS #001",
//          "CLOUDS #001",
            `/shadertoy/${76}.glsl`,
//          `/shadertoy/${76}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RAIN DROPS #003",
//          "RAIN DROPS #003",
            `/shadertoy/${77}.glsl`,
//          `/shadertoy/${77}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RAIN DROPS #004",
//          "RAIN DROPS #004",
            `/shadertoy/${78}.glsl`,
//          `/shadertoy/${78}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "RAIN DROPS RIPPLE #001",
//          "RAIN DROPS RIPPLE #001",
            `/shadertoy/${79}.glsl`,
//          `/shadertoy/${79}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "CLOUDS #002",
//          "CLOUDS #002",
            `/shadertoy/${80}.glsl`,
//          `/shadertoy/${80}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "STAR NEST #001",
//          "STAR NEST #001",
            `/shadertoy/${82}.glsl`,
//          `/shadertoy/${82}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #001",
//          "PC98 COLOR LOADING #001",
            `/shadertoy/${92}.glsl`,
//          `/shadertoy/${92}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 100",
//          "UNNAMED EFFECT 100",
            `/shadertoy/${100}.glsl`,
//          `/shadertoy/${100}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 101",
//          "UNNAMED EFFECT 101",
            `/shadertoy/${101}.glsl`,
//          `/shadertoy/${101}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 102",
//          "UNNAMED EFFECT 102",
            `/shadertoy/${102}.glsl`,
//          `/shadertoy/${102}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 106",
//          "UNNAMED EFFECT 106",
            `/shadertoy/${106}.glsl`,
//          `/shadertoy/${106}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 107",
//          "UNNAMED EFFECT 107",
            `/shadertoy/${107}.glsl`,
//          `/shadertoy/${107}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 108",
//          "UNNAMED EFFECT 108",
            `/shadertoy/${108}.glsl`,
//          `/shadertoy/${108}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 109",
//          "UNNAMED EFFECT 109",
            `/shadertoy/${109}.glsl`,
//          `/shadertoy/${109}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 110",
//          "UNNAMED EFFECT 110",
            `/shadertoy/${110}.glsl`,
//          `/shadertoy/${110}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 111",
//          "UNNAMED EFFECT 111",
            `/shadertoy/${111}.glsl`,
//          `/shadertoy/${111}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 112",
//          "UNNAMED EFFECT 112",
            `/shadertoy/${112}.glsl`,
//          `/shadertoy/${112}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 113",
//          "UNNAMED EFFECT 113",
            `/shadertoy/${113}.glsl`,
//          `/shadertoy/${113}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 114",
//          "UNNAMED EFFECT 114",
            `/shadertoy/${114}.glsl`,
//          `/shadertoy/${114}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 116",
//          "UNNAMED EFFECT 116",
            `/shadertoy/${116}.glsl`,
//          `/shadertoy/${116}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 117",
//          "UNNAMED EFFECT 117",
            `/shadertoy/${117}.glsl`,
//          `/shadertoy/${117}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 118",
//          "UNNAMED EFFECT 118",
            `/shadertoy/${118}.glsl`,
//          `/shadertoy/${118}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 119",
//          "UNNAMED EFFECT 119",
            `/shadertoy/${119}.glsl`,
//          `/shadertoy/${119}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 120",
//          "UNNAMED EFFECT 120",
            `/shadertoy/${120}.glsl`,
//          `/shadertoy/${120}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 121",
//          "UNNAMED EFFECT 121",
            `/shadertoy/${121}.glsl`,
//          `/shadertoy/${121}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 122",
//          "UNNAMED EFFECT 122",
            `/shadertoy/${122}.glsl`,
//          `/shadertoy/${122}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 123",
//          "UNNAMED EFFECT 123",
            `/shadertoy/${123}.glsl`,
//          `/shadertoy/${123}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 124",
//          "UNNAMED EFFECT 124",
            `/shadertoy/${124}.glsl`,
//          `/shadertoy/${124}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 125",
//          "UNNAMED EFFECT 125",
            `/shadertoy/${125}.glsl`,
//          `/shadertoy/${125}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 126",
//          "UNNAMED EFFECT 126",
            `/shadertoy/${126}.glsl`,
//          `/shadertoy/${126}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 128",
//          "UNNAMED EFFECT 128",
            `/shadertoy/${128}.glsl`,
//          `/shadertoy/${128}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 129",
//          "UNNAMED EFFECT 129",
            `/shadertoy/${129}.glsl`,
//          `/shadertoy/${129}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 130",
//          "UNNAMED EFFECT 130",
            `/shadertoy/${130}.glsl`,
//          `/shadertoy/${130}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 131",
//          "UNNAMED EFFECT 131",
            `/shadertoy/${131}.glsl`,
//          `/shadertoy/${131}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 134",
//          "UNNAMED EFFECT 134",
            `/shadertoy/${134}.glsl`,
//          `/shadertoy/${134}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 135",
//          "UNNAMED EFFECT 135",
            `/shadertoy/${135}.glsl`,
//          `/shadertoy/${135}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 136",
//          "UNNAMED EFFECT 136",
            `/shadertoy/${136}.glsl`,
//          `/shadertoy/${136}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 137",
//          "UNNAMED EFFECT 137",
            `/shadertoy/${137}.glsl`,
//          `/shadertoy/${137}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 140",
//          "UNNAMED EFFECT 140",
            `/shadertoy/${140}.glsl`,
//          `/shadertoy/${140}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 143",
//          "UNNAMED EFFECT 143",
            `/shadertoy/${143}.glsl`,
//          `/shadertoy/${143}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 144",
//          "UNNAMED EFFECT 144",
            `/shadertoy/${144}.glsl`,
//          `/shadertoy/${144}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 146",
//          "UNNAMED EFFECT 146",
            `/shadertoy/${146}.glsl`,
//          `/shadertoy/${146}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 147",
//          "UNNAMED EFFECT 147",
            `/shadertoy/${147}.glsl`,
//          `/shadertoy/${147}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 149",
//          "UNNAMED EFFECT 149",
            `/shadertoy/${149}.glsl`,
//          `/shadertoy/${149}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 150",
//          "UNNAMED EFFECT 150",
            `/shadertoy/${150}.glsl`,
//          `/shadertoy/${150}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 151",
//          "UNNAMED EFFECT 151",
            `/shadertoy/${151}.glsl`,
//          `/shadertoy/${151}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 153",
//          "UNNAMED EFFECT 153",
            `/shadertoy/${153}.glsl`,
//          `/shadertoy/${153}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 154",
//          "UNNAMED EFFECT 154",
            `/shadertoy/${154}.glsl`,
//          `/shadertoy/${154}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 155",
//          "UNNAMED EFFECT 155",
            `/shadertoy/${155}.glsl`,
//          `/shadertoy/${155}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 156",
//          "UNNAMED EFFECT 156",
            `/shadertoy/${156}.glsl`,
//          `/shadertoy/${156}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 157",
//          "UNNAMED EFFECT 157",
            `/shadertoy/${157}.glsl`,
//          `/shadertoy/${157}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 158",
//          "UNNAMED EFFECT 158",
            `/shadertoy/${158}.glsl`,
//          `/shadertoy/${158}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 159",
//          "UNNAMED EFFECT 159",
            `/shadertoy/${159}.glsl`,
//          `/shadertoy/${159}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 160",
//          "UNNAMED EFFECT 160",
            `/shadertoy/${160}.glsl`,
//          `/shadertoy/${160}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 165",
//          "UNNAMED EFFECT 165",
            `/shadertoy/${165}.glsl`,
//          `/shadertoy/${165}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 166",
//          "UNNAMED EFFECT 166",
            `/shadertoy/${166}.glsl`,
//          `/shadertoy/${166}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 169",
//          "UNNAMED EFFECT 169",
            `/shadertoy/${169}.glsl`,
//          `/shadertoy/${169}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 170",
//          "UNNAMED EFFECT 170",
            `/shadertoy/${170}.glsl`,
//          `/shadertoy/${170}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 171",
//          "UNNAMED EFFECT 171",
            `/shadertoy/${171}.glsl`,
//          `/shadertoy/${171}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 173",
//          "UNNAMED EFFECT 173",
            `/shadertoy/${173}.glsl`,
//          `/shadertoy/${173}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 174",
//          "UNNAMED EFFECT 174",
            `/shadertoy/${174}.glsl`,
//          `/shadertoy/${174}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 175",
//          "UNNAMED EFFECT 175",
            `/shadertoy/${175}.glsl`,
//          `/shadertoy/${175}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 177",
//          "UNNAMED EFFECT 177",
            `/shadertoy/${177}.glsl`,
//          `/shadertoy/${177}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 178",
//          "UNNAMED EFFECT 178",
            `/shadertoy/${178}.glsl`,
//          `/shadertoy/${178}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 179",
//          "UNNAMED EFFECT 179",
            `/shadertoy/${179}.glsl`,
//          `/shadertoy/${179}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 180",
//          "UNNAMED EFFECT 180",
            `/shadertoy/${180}.glsl`,
//          `/shadertoy/${180}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 181",
//          "UNNAMED EFFECT 181",
            `/shadertoy/${181}.glsl`,
//          `/shadertoy/${181}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 182",
//          "UNNAMED EFFECT 182",
            `/shadertoy/${182}.glsl`,
//          `/shadertoy/${182}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 183",
//          "UNNAMED EFFECT 183",
            `/shadertoy/${183}.glsl`,
//          `/shadertoy/${183}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 184",
//          "UNNAMED EFFECT 184",
            `/shadertoy/${184}.glsl`,
//          `/shadertoy/${184}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 185",
//          "UNNAMED EFFECT 185",
            `/shadertoy/${185}.glsl`,
//          `/shadertoy/${185}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 186",
//          "UNNAMED EFFECT 186",
            `/shadertoy/${186}.glsl`,
//          `/shadertoy/${186}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 187",
//          "UNNAMED EFFECT 187",
            `/shadertoy/${187}.glsl`,
//          `/shadertoy/${187}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 188",
//          "UNNAMED EFFECT 188",
            `/shadertoy/${188}.glsl`,
//          `/shadertoy/${188}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 189",
//          "UNNAMED EFFECT 189",
            `/shadertoy/${189}.glsl`,
//          `/shadertoy/${189}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "UNNAMED EFFECT 190",
//          "UNNAMED EFFECT 190",
            `/shadertoy/${190}.glsl`,
//          `/shadertoy/${190}.glsl`,
        ]
//      ]
        ,
//      ,
        /*
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "PC98 COLOR LOADING #002",
//          "PC98 COLOR LOADING #002",
            `/shadertoy/${93}.glsl`,
//          `/shadertoy/${93}.glsl`,
        ]
//      ]
        ,
//      ,
        */
        [
//      [
            "LYGIA BlendAdd",
//          "LYGIA BlendAdd",
            `/lygia/BlendAdd.glsl`,
//          `/lygia/BlendAdd.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendAverage",
//          "LYGIA BlendAverage",
            `/lygia/BlendAverage.glsl`,
//          `/lygia/BlendAverage.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendColor",
//          "LYGIA BlendColor",
            `/lygia/BlendColor.glsl`,
//          `/lygia/BlendColor.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendColorBurn",
//          "LYGIA BlendColorBurn",
            `/lygia/BlendColorBurn.glsl`,
//          `/lygia/BlendColorBurn.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendColorDodge",
//          "LYGIA BlendColorDodge",
            `/lygia/BlendColorDodge.glsl`,
//          `/lygia/BlendColorDodge.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendDarken",
//          "LYGIA BlendDarken",
            `/lygia/BlendDarken.glsl`,
//          `/lygia/BlendDarken.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendDifference",
//          "LYGIA BlendDifference",
            `/lygia/BlendDifference.glsl`,
//          `/lygia/BlendDifference.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendExclusion",
//          "LYGIA BlendExclusion",
            `/lygia/BlendExclusion.glsl`,
//          `/lygia/BlendExclusion.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendGlow",
//          "LYGIA BlendGlow",
            `/lygia/BlendGlow.glsl`,
//          `/lygia/BlendGlow.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendHardLight",
//          "LYGIA BlendHardLight",
            `/lygia/BlendHardLight.glsl`,
//          `/lygia/BlendHardLight.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendHardMix",
//          "LYGIA BlendHardMix",
            `/lygia/BlendHardMix.glsl`,
//          `/lygia/BlendHardMix.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendHue",
//          "LYGIA BlendHue",
            `/lygia/BlendHue.glsl`,
//          `/lygia/BlendHue.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendLighten",
//          "LYGIA BlendLighten",
            `/lygia/BlendLighten.glsl`,
//          `/lygia/BlendLighten.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendLinearBurn",
//          "LYGIA BlendLinearBurn",
            `/lygia/BlendLinearBurn.glsl`,
//          `/lygia/BlendLinearBurn.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendLinearDodge",
//          "LYGIA BlendLinearDodge",
            `/lygia/BlendLinearDodge.glsl`,
//          `/lygia/BlendLinearDodge.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendLinearLight",
//          "LYGIA BlendLinearLight",
            `/lygia/BlendLinearLight.glsl`,
//          `/lygia/BlendLinearLight.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendLuminosity",
//          "LYGIA BlendLuminosity",
            `/lygia/BlendLuminosity.glsl`,
//          `/lygia/BlendLuminosity.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendMultiply",
//          "LYGIA BlendMultiply",
            `/lygia/BlendMultiply.glsl`,
//          `/lygia/BlendMultiply.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendNegation",
//          "LYGIA BlendNegation",
            `/lygia/BlendNegation.glsl`,
//          `/lygia/BlendNegation.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendOverlay",
//          "LYGIA BlendOverlay",
            `/lygia/BlendOverlay.glsl`,
//          `/lygia/BlendOverlay.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendPhoenix",
//          "LYGIA BlendPhoenix",
            `/lygia/BlendPhoenix.glsl`,
//          `/lygia/BlendPhoenix.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendPinLight",
//          "LYGIA BlendPinLight",
            `/lygia/BlendPinLight.glsl`,
//          `/lygia/BlendPinLight.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendReflect",
//          "LYGIA BlendReflect",
            `/lygia/BlendReflect.glsl`,
//          `/lygia/BlendReflect.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendSaturation",
//          "LYGIA BlendSaturation",
            `/lygia/BlendSaturation.glsl`,
//          `/lygia/BlendSaturation.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendScreen",
//          "LYGIA BlendScreen",
            `/lygia/BlendScreen.glsl`,
//          `/lygia/BlendScreen.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendSoftLight",
//          "LYGIA BlendSoftLight",
            `/lygia/BlendSoftLight.glsl`,
//          `/lygia/BlendSoftLight.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendSubstract",
//          "LYGIA BlendSubstract",
            `/lygia/BlendSubstract.glsl`,
//          `/lygia/BlendSubstract.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA BlendVividLight",
//          "LYGIA BlendVividLight",
            `/lygia/BlendVividLight.glsl`,
//          `/lygia/BlendVividLight.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorBrightnessContrast",
//          "LYGIA ColorBrightnessContrast",
            `/lygia/ColorBrightnessContrast.glsl`,
//          `/lygia/ColorBrightnessContrast.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorContrast",
//          "LYGIA ColorContrast",
            `/lygia/ColorContrast.glsl`,
//          `/lygia/ColorContrast.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDaltonize",
//          "LYGIA ColorDaltonize",
            `/lygia/ColorDaltonize.glsl`,
//          `/lygia/ColorDaltonize.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDesaturate",
//          "LYGIA ColorDesaturate",
            `/lygia/ColorDesaturate.glsl`,
//          `/lygia/ColorDesaturate.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDitherBayer",
//          "LYGIA ColorDitherBayer",
            `/lygia/ColorDitherBayer.glsl`,
//          `/lygia/ColorDitherBayer.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDitherBlueNoise",
//          "LYGIA ColorDitherBlueNoise",
            `/lygia/ColorDitherBlueNoise.glsl`,
//          `/lygia/ColorDitherBlueNoise.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDitherInterleavedGradientNoise",
//          "LYGIA ColorDitherInterleavedGradientNoise",
            `/lygia/ColorDitherInterleavedGradientNoise.glsl`,
//          `/lygia/ColorDitherInterleavedGradientNoise.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDitherShift",
//          "LYGIA ColorDitherShift",
            `/lygia/ColorDitherShift.glsl`,
//          `/lygia/ColorDitherShift.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDitherTriangleNoise",
//          "LYGIA ColorDitherTriangleNoise",
            `/lygia/ColorDitherTriangleNoise.glsl`,
//          `/lygia/ColorDitherTriangleNoise.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorDitherVlachos",
//          "LYGIA ColorDitherVlachos",
            `/lygia/ColorDitherVlachos.glsl`,
//          `/lygia/ColorDitherVlachos.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorExposure",
//          "LYGIA ColorExposure",
            `/lygia/ColorExposure.glsl`,
//          `/lygia/ColorExposure.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorHueShift",
//          "LYGIA ColorHueShift",
            `/lygia/ColorHueShift.glsl`,
//          `/lygia/ColorHueShift.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorLevels",
//          "LYGIA ColorLevels",
            `/lygia/ColorLevels.glsl`,
//          `/lygia/ColorLevels.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapACES",
//          "LYGIA ColorTonemapACES",
            `/lygia/ColorTonemapACES.glsl`,
//          `/lygia/ColorTonemapACES.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapDebug",
//          "LYGIA ColorTonemapDebug",
            `/lygia/ColorTonemapDebug.glsl`,
//          `/lygia/ColorTonemapDebug.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapFilmic",
//          "LYGIA ColorTonemapFilmic",
            `/lygia/ColorTonemapFilmic.glsl`,
//          `/lygia/ColorTonemapFilmic.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapLinear",
//          "LYGIA ColorTonemapLinear",
            `/lygia/ColorTonemapLinear.glsl`,
//          `/lygia/ColorTonemapLinear.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapReinhard",
//          "LYGIA ColorTonemapReinhard",
            `/lygia/ColorTonemapReinhard.glsl`,
//          `/lygia/ColorTonemapReinhard.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapReinhardJodie",
//          "LYGIA ColorTonemapReinhardJodie",
            `/lygia/ColorTonemapReinhardJodie.glsl`,
//          `/lygia/ColorTonemapReinhardJodie.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapUncharted",
//          "LYGIA ColorTonemapUncharted",
            `/lygia/ColorTonemapUncharted.glsl`,
//          `/lygia/ColorTonemapUncharted.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapUncharted2",
//          "LYGIA ColorTonemapUncharted2",
            `/lygia/ColorTonemapUncharted2.glsl`,
//          `/lygia/ColorTonemapUncharted2.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorTonemapUnreal",
//          "LYGIA ColorTonemapUnreal",
            `/lygia/ColorTonemapUnreal.glsl`,
//          `/lygia/ColorTonemapUnreal.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorVibrance",
//          "LYGIA ColorVibrance",
            `/lygia/ColorVibrance.glsl`,
//          `/lygia/ColorVibrance.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA ColorWhiteBalance",
//          "LYGIA ColorWhiteBalance",
            `/lygia/ColorWhiteBalance.glsl`,
//          `/lygia/ColorWhiteBalance.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA DistortBarrel",
//          "LYGIA DistortBarrel",
            `/lygia/DistortBarrel.glsl`,
//          `/lygia/DistortBarrel.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA DistortChromaAB",
//          "LYGIA DistortChromaAB",
            `/lygia/DistortChromaAB.glsl`,
//          `/lygia/DistortChromaAB.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA DistortGrain",
//          "LYGIA DistortGrain",
            `/lygia/DistortGrain.glsl`,
//          `/lygia/DistortGrain.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA DistortPincushion",
//          "LYGIA DistortPincushion",
            `/lygia/DistortPincushion.glsl`,
//          `/lygia/DistortPincushion.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA DistortStretch",
//          "LYGIA DistortStretch",
            `/lygia/DistortStretch.glsl`,
//          `/lygia/DistortStretch.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterBilateral",
//          "LYGIA FilterBilateral",
            `/lygia/FilterBilateral.glsl`,
//          `/lygia/FilterBilateral.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterBilinear",
//          "LYGIA FilterBilinear",
            `/lygia/FilterBilinear.glsl`,
//          `/lygia/FilterBilinear.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterBoxBlur",
//          "LYGIA FilterBoxBlur",
            `/lygia/FilterBoxBlur.glsl`,
//          `/lygia/FilterBoxBlur.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterEdge",
//          "LYGIA FilterEdge",
            `/lygia/FilterEdge.glsl`,
//          `/lygia/FilterEdge.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterFibonacciBokeh",
//          "LYGIA FilterFibonacciBokeh",
            `/lygia/FilterFibonacciBokeh.glsl`,
//          `/lygia/FilterFibonacciBokeh.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterGaussianBlur",
//          "LYGIA FilterGaussianBlur",
            `/lygia/FilterGaussianBlur.glsl`,
//          `/lygia/FilterGaussianBlur.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterJointBilateral",
//          "LYGIA FilterJointBilateral",
            `/lygia/FilterJointBilateral.glsl`,
//          `/lygia/FilterJointBilateral.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterKuwahara",
//          "LYGIA FilterKuwahara",
            `/lygia/FilterKuwahara.glsl`,
//          `/lygia/FilterKuwahara.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterLaplacian",
//          "LYGIA FilterLaplacian",
            `/lygia/FilterLaplacian.glsl`,
//          `/lygia/FilterLaplacian.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterMean",
//          "LYGIA FilterMean",
            `/lygia/FilterMean.glsl`,
//          `/lygia/FilterMean.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterMedian",
//          "LYGIA FilterMedian",
            `/lygia/FilterMedian.glsl`,
//          `/lygia/FilterMedian.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterNoiseBlur",
//          "LYGIA FilterNoiseBlur",
            `/lygia/FilterNoiseBlur.glsl`,
//          `/lygia/FilterNoiseBlur.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterRadialBlur",
//          "LYGIA FilterRadialBlur",
            `/lygia/FilterRadialBlur.glsl`,
//          `/lygia/FilterRadialBlur.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterSharpen",
//          "LYGIA FilterSharpen",
            `/lygia/FilterSharpen.glsl`,
//          `/lygia/FilterSharpen.glsl`,
        ]
//      ]
        ,
//      ,
        [
//      [
            "LYGIA FilterSmartDeNoise",
//          "LYGIA FilterSmartDeNoise",
            `/lygia/FilterSmartDeNoise.glsl`,
//          `/lygia/FilterSmartDeNoise.glsl`,
        ]
//      ]
        ,
//      ,
    ]);
//  ]);

    const shareImage = async (
//  const shareImage = async (
        htmlCanvasElement: HTMLCanvasElement,
//      htmlCanvasElement: HTMLCanvasElement,
        name: string = "image_name.png",
//      name: string = "image_name.png",
        title: string = "image_title",
//      title: string = "image_title",
        description: string = "image_description",
//      description: string = "image_description",
        text: string = "image_text",
//      text: string = "image_text",
    ): Promise<void> => {
//  ): Promise<void> => {
        const uploadResult = await global.imgurClient.upload({
//      const uploadResult = await global.imgurClient.upload({
            image: htmlCanvasElement.toDataURL("image/png", 1.0).split(",")[1],
//          image: htmlCanvasElement.toDataURL("image/png", 1.0).split(",")[1],
            type: "base64",
//          type: "base64",
            name: name,
//          name: name,
            title: title,
//          title: title,
            description: description,
//          description: description,
            disable_audio: "1",
//          disable_audio: "1",
        });
//      });
        console.info(uploadResult.data);
//      console.info(uploadResult.data);
        window.navigator.share({
//      window.navigator.share({
            title: title,
//          title: title,
            text: text,
//          text: text,
            url: uploadResult.data.link,
//          url: uploadResult.data.link,
            /*
            files: [new File([b as Blob], "image.png", { type: "image/png", })],
//          files: [new File([b as Blob], "image.png", { type: "image/png", })],
            */
        });
//      });
    };
//  };

    const shareVideo = async (
//  const shareVideo = async (
        shareVideoBlob: Blob,
//      shareVideoBlob: Blob,
        htmlCanvasElement: HTMLCanvasElement,
//      htmlCanvasElement: HTMLCanvasElement,
        name: string = "video_name.mp4",
//      name: string = "video_name.mp4",
        title: string = "video_title",
//      title: string = "video_title",
        description: string = "video_description",
//      description: string = "video_description",
        text: string = "video_text",
//      text: string = "video_text",
    ): Promise<void> => {
//  ): Promise<void> => {
        const uploadResult = await global.imgurClient.upload({
//      const uploadResult = await global.imgurClient.upload({
            image: await blobToBase64(shareVideoBlob),
//          image: await blobToBase64(shareVideoBlob),
            type: "base64",
//          type: "base64",
            name: name,
//          name: name,
            title: title,
//          title: title,
            description: description,
//          description: description,
            disable_audio: "1",
//          disable_audio: "1",
        });
//      });
        console.info(uploadResult.data);
//      console.info(uploadResult.data);
        window.navigator.share({
//      window.navigator.share({
            title: title,
//          title: title,
            text: text,
//          text: text,
            url: uploadResult.data.link,
//          url: uploadResult.data.link,
            /*
            files: [new File([b as Blob], "image.png", { type: "image/png", })],
//          files: [new File([b as Blob], "image.png", { type: "image/png", })],
            */
        });
//      });
    };
//  };

    const shareWebcam = async (
//  const shareWebcam = async (
        shareWebcamBlob: Blob,
//      shareWebcamBlob: Blob,
        htmlCanvasElement: HTMLCanvasElement,
//      htmlCanvasElement: HTMLCanvasElement,
        name: string = "video_name.mp4",
//      name: string = "video_name.mp4",
        title: string = "video_title",
//      title: string = "video_title",
        description: string = "video_description",
//      description: string = "video_description",
        text: string = "video_text",
//      text: string = "video_text",
    ): Promise<void> => {
//  ): Promise<void> => {
        const uploadResult = await global.imgurClient.upload({
//      const uploadResult = await global.imgurClient.upload({
            image: await blobToBase64(shareWebcamBlob),
//          image: await blobToBase64(shareWebcamBlob),
            type: "base64",
//          type: "base64",
            name: name,
//          name: name,
            title: title,
//          title: title,
            description: description,
//          description: description,
            disable_audio: "1",
//          disable_audio: "1",
        });
//      });
        console.info(uploadResult.data);
//      console.info(uploadResult.data);
        window.navigator.share({
//      window.navigator.share({
            title: title,
//          title: title,
            text: text,
//          text: text,
            url: uploadResult.data.link,
//          url: uploadResult.data.link,
            /*
            files: [new File([b as Blob], "image.png", { type: "image/png", })],
//          files: [new File([b as Blob], "image.png", { type: "image/png", })],
            */
        });
//      });
    };
//  };

    function blobToBase64(blob: Blob): Promise<string> {
//  function blobToBase64(blob: Blob): Promise<string> {
        return new Promise((resolve, rejects) => {
//      return new Promise((resolve, rejects) => {
            const reader: FileReader = new FileReader();
//          const reader: FileReader = new FileReader();
            reader.onloadend = () => {
//          reader.onloadend = () => {
                if (reader.result) {
//              if (reader.result) {
                    // Split to remove the data URL prefix and get only the base64 part
//                  // Split to remove the data URL prefix and get only the base64 part
                    resolve((reader.result as string).split(",")[1]);
//                  resolve((reader.result as string).split(",")[1]);
                } else {
//              } else {
                    rejects(new Error("FileReader result is null!"));
//                  rejects(new Error("FileReader result is null!"));
                }
//              }
            };
//          };
            reader.onerror = () => rejects(new Error("Failed to read the Blob as a Data URL"));
//          reader.onerror = () => rejects(new Error("Failed to read the Blob as a Data URL"));
            reader.readAsDataURL(blob); /* Starts to read the blob as a Data URL */
//          reader.readAsDataURL(blob); /* Starts to read the blob as a Data URL */
        });
//      });
    };
//  };

    let exampleGLSLUniforms: types.GLSLUniforms = [
//  let exampleGLSLUniforms: types.GLSLUniforms = [
        { thisUniformName: "a", thisUniformNameJustForDisplay: "a", thisUniformType: "float", thisUniformDefaultValue: 0.0  , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "a", thisUniformNameJustForDisplay: "a", thisUniformType: "float", thisUniformDefaultValue: 0.0  , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "b", thisUniformNameJustForDisplay: "b", thisUniformType: "int"  , thisUniformDefaultValue: 0    , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "b", thisUniformNameJustForDisplay: "b", thisUniformType: "int"  , thisUniformDefaultValue: 0    , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "c", thisUniformNameJustForDisplay: "c", thisUniformType: "bool" , thisUniformDefaultValue: false, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "c", thisUniformNameJustForDisplay: "c", thisUniformType: "bool" , thisUniformDefaultValue: false, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },

        { thisUniformName: "d", thisUniformNameJustForDisplay: "d", thisUniformType: "vec2", thisUniformDefaultValue: [0.0, 0.0]          , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "d", thisUniformNameJustForDisplay: "d", thisUniformType: "vec2", thisUniformDefaultValue: [0.0, 0.0]          , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "e", thisUniformNameJustForDisplay: "e", thisUniformType: "vec3", thisUniformDefaultValue: [0.0, 0.0, 0.0]     , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "e", thisUniformNameJustForDisplay: "e", thisUniformType: "vec3", thisUniformDefaultValue: [0.0, 0.0, 0.0]     , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "f", thisUniformNameJustForDisplay: "f", thisUniformType: "vec4", thisUniformDefaultValue: [0.0, 0.0, 0.0, 0.0], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "f", thisUniformNameJustForDisplay: "f", thisUniformType: "vec4", thisUniformDefaultValue: [0.0, 0.0, 0.0, 0.0], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },

        { thisUniformName: "g", thisUniformNameJustForDisplay: "g", thisUniformType: "ivec2", thisUniformDefaultValue: [0, 0]      , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "g", thisUniformNameJustForDisplay: "g", thisUniformType: "ivec2", thisUniformDefaultValue: [0, 0]      , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "h", thisUniformNameJustForDisplay: "h", thisUniformType: "ivec3", thisUniformDefaultValue: [0, 0, 0]   , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "h", thisUniformNameJustForDisplay: "h", thisUniformType: "ivec3", thisUniformDefaultValue: [0, 0, 0]   , thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "i", thisUniformNameJustForDisplay: "i", thisUniformType: "ivec4", thisUniformDefaultValue: [0, 0, 0, 0], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "i", thisUniformNameJustForDisplay: "i", thisUniformType: "ivec4", thisUniformDefaultValue: [0, 0, 0, 0], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },

        {
//      {
            thisUniformName: "j", thisUniformNameJustForDisplay: "j", thisUniformType: "mat2", thisUniformDefaultValue: [   0.0, 0.0,
//          thisUniformName: "j", thisUniformNameJustForDisplay: "j", thisUniformType: "mat2", thisUniformDefaultValue: [   0.0, 0.0,
                                                                                                                            0.0, 0.0,             ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null,
//                                                                                                                          0.0, 0.0,             ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null,
        },
//      },
        {
//      {
            thisUniformName: "k", thisUniformNameJustForDisplay: "k", thisUniformType: "mat3", thisUniformDefaultValue: [   0.0, 0.0, 0.0,
//          thisUniformName: "k", thisUniformNameJustForDisplay: "k", thisUniformType: "mat3", thisUniformDefaultValue: [   0.0, 0.0, 0.0,
                                                                                                                            0.0, 0.0, 0.0,
//                                                                                                                          0.0, 0.0, 0.0,
                                                                                                                            0.0, 0.0, 0.0,        ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null,
//                                                                                                                          0.0, 0.0, 0.0,        ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null,
        },
//      },
        {
//      {
            thisUniformName: "l", thisUniformNameJustForDisplay: "l", thisUniformType: "mat4", thisUniformDefaultValue: [   0.0, 0.0, 0.0, 0.0,
//          thisUniformName: "l", thisUniformNameJustForDisplay: "l", thisUniformType: "mat4", thisUniformDefaultValue: [   0.0, 0.0, 0.0, 0.0,
                                                                                                                            0.0, 0.0, 0.0, 0.0,
//                                                                                                                          0.0, 0.0, 0.0, 0.0,
                                                                                                                            0.0, 0.0, 0.0, 0.0,
//                                                                                                                          0.0, 0.0, 0.0, 0.0,
                                                                                                                            0.0, 0.0, 0.0, 0.0,   ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null,
//                                                                                                                          0.0, 0.0, 0.0, 0.0,   ], thisUniformSampler2DImg: null, thisUniformSampler2DEle: null,
        },
//      },

        { thisUniformName: "m"        , thisUniformNameJustForDisplay: "m"        , thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "m"        , thisUniformNameJustForDisplay: "m"        , thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "noise_m"  , thisUniformNameJustForDisplay: "noise_m"  , thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "noise_m"  , thisUniformNameJustForDisplay: "noise_m"  , thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "bayer_m"  , thisUniformNameJustForDisplay: "bayer_m"  , thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "bayer_m"  , thisUniformNameJustForDisplay: "bayer_m"  , thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
        { thisUniformName: "palette_m", thisUniformNameJustForDisplay: "palette_m", thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
//      { thisUniformName: "palette_m", thisUniformNameJustForDisplay: "palette_m", thisUniformType: "sampler2D", thisUniformDefaultValue: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/1.jpg`, thisUniformSampler2DImg: null, thisUniformSampler2DEle: null, },
    ];
//  ];

    function parseGLSL(glslCode: string): types.GLSLUniforms {
//  function parseGLSL(glslCode: string): types.GLSLUniforms {
        const uniformRegex: RegExp = /uniform\s+(\w+)\s+(\w+)\s*;\s*(\/\/\s*([\w.\-, ]+))?/g;
//      const uniformRegex: RegExp = /uniform\s+(\w+)\s+(\w+)\s*;\s*(\/\/\s*([\w.\-, ]+))?/g;
        const uniforms: types.GLSLUniforms = [];
//      const uniforms: types.GLSLUniforms = [];
        let match: RegExpExecArray | null;
//      let match: RegExpExecArray | null;
        while ((match = uniformRegex.exec(glslCode)) !== null) {
//      while ((match = uniformRegex.exec(glslCode)) !== null) {
            const [
//          const [
                , type
//              , type
                , name
//              , name
                ,
//              ,
                , defaultValueRaw
//              , defaultValueRaw
            ] = match;
//          ] = match;
            // guard - filter
//          // guard - filter
            // not editable - auto set internal
//          // not editable - auto set internal
            if (name === "tex0"
//          if (name === "tex0"
            ||  name === "vTexCoord"
//          ||  name === "vTexCoord"
            ||  name === "fragColor"
//          ||  name === "fragColor"
            ||  name === "time"
//          ||  name === "time"
            ||  name === "canvasSize"
//          ||  name === "canvasSize"
            ||  name === "texelSize"
//          ||  name === "texelSize"
            ||  name === "mousePosition"
//          ||  name === "mousePosition"
            ||  name === "frameCount"
//          ||  name === "frameCount"
            ) {
//          ) {
                continue;
//              continue;
            }
//          }
            // Parse the default value based on type
//          // Parse the default value based on type
            let parsedValue: types.GLSLUniformValue | null = null;
//          let parsedValue: types.GLSLUniformValue | null = null;
            if (defaultValueRaw) {
//          if (defaultValueRaw) {
                const cleanedValue = defaultValueRaw.replace(/\s+/g, ""); // Remove spaces
//              const cleanedValue = defaultValueRaw.replace(/\s+/g, ""); // Remove spaces
                switch (type) {
//              switch (type) {
                    case "float":
//                  case "float":
                    case "int":
//                  case "int":
                    case "uint":
//                  case "uint":
                        parsedValue = parseFloat(cleanedValue);
//                      parsedValue = parseFloat(cleanedValue);
                        break;
//                      break;
                    case "bool":
//                  case "bool":
                        parsedValue = cleanedValue === "true" || cleanedValue === "!false";
//                      parsedValue = cleanedValue === "true" || cleanedValue === "!false";
                        break;
//                      break;
                    case "vec2":
//                  case "vec2":
                    case "vec3":
//                  case "vec3":
                    case "vec4":
//                  case "vec4":
                    case "ivec2":
//                  case "ivec2":
                    case "ivec3":
//                  case "ivec3":
                    case "ivec4":
//                  case "ivec4":
                    case "uvec2":
//                  case "uvec2":
                    case "uvec3":
//                  case "uvec3":
                    case "uvec4":
//                  case "uvec4":
                    case "mat2":
//                  case "mat2":
                    case "mat3":
//                  case "mat3":
                    case "mat4":
//                  case "mat4":
                        parsedValue = cleanedValue.split(",").map(v => parseFloat(v));
//                      parsedValue = cleanedValue.split(",").map(v => parseFloat(v));
                        break;
//                      break;
                    case "sampler2D":
//                  case "sampler2D":
                    case "sampler3D":
//                  case "sampler3D":
                    case "samplerCube":
//                  case "samplerCube":
                        parsedValue = cleanedValue; // Use the raw string for sampler types
//                      parsedValue = cleanedValue; // Use the raw string for sampler types
                        break;
//                      break;
                    default:
//                  default:
                        parsedValue = null!; // Unsupported type
//                      parsedValue = null!; // Unsupported type
                    // bvec2
//                  // bvec2
                    // bvec3
//                  // bvec3
                    // bvec4
//                  // bvec4
                    // mat2x3
//                  // mat2x3
                    // mat2x4
//                  // mat2x4
                    // mat3x2
//                  // mat3x2
                    // mat3x4
//                  // mat3x4
                    // mat4x2
//                  // mat4x2
                    // mat4x3
//                  // mat4x3
                    // samplerCube
//                  // samplerCube
                    // sampler2D@@Array@
//                  // sampler2D@@Array@
                    // sampler2D@@Shadow
//                  // sampler2D@@Shadow
                    // samplerCubeShadow
//                  // samplerCubeShadow
                    // isampler2D
//                  // isampler2D
                    // isampler3D
//                  // isampler3D
                    // isamplerCube
//                  // isamplerCube
                    // isampler2DArray
//                  // isampler2DArray
                    // usampler2D
//                  // usampler2D
                    // usampler3D
//                  // usampler3D
                    // usamplerCube
//                  // usamplerCube
                    // usampler2DArray
//                  // usampler2DArray
                    // struct
//                  // struct
                }
//              }
            }
//          }
            uniforms.push({
//          uniforms.push({
                thisUniformName: name,
//              thisUniformName: name,
                thisUniformNameJustForDisplay: null,
//              thisUniformNameJustForDisplay: null,
                thisUniformType: type,
//              thisUniformType: type,
                thisUniformDefaultValue: parsedValue,
//              thisUniformDefaultValue: parsedValue,
                thisUniformSampler2DImg: null,
//              thisUniformSampler2DImg: null,
                thisUniformSampler2DEle: null,
//              thisUniformSampler2DEle: null,
            });
//          });
        }
//      }
        return uniforms;
//      return uniforms;
    };
//  };

    function splitArrayIntoGroups(array: number[], groupSize: number): number[][] {
//  function splitArrayIntoGroups(array: number[], groupSize: number): number[][] {
        return array.reduce((result: number[][], value: number, index: number): number[][] => {
//      return array.reduce((result: number[][], value: number, index: number): number[][] => {
            if (index % groupSize === 0) {
//          if (index % groupSize === 0) {
                result.push([]);
//              result.push([]);
            }
//          }
            result[result.length - 1].push(value);
//          result[result.length - 1].push(value);
            return result;
//          return result;
        }, []);
//      }, []);
    };
//  };

    const fetchAllTextures_Bayer = (): types.TextureForShader[] => {
//  const fetchAllTextures_Bayer = (): types.TextureForShader[] => {
        let ns: number[] = [2, 4, 8, 16];
//      let ns: number[] = [2, 4, 8, 16];
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        ns.forEach(n1 => {
//      ns.forEach(n1 => {
            result.push(
//          result.push(
                {
//              {
                    name: `bayer${n1}.png`,
//                  name: `bayer${n1}.png`,
                    path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}.png`,
//                  path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}.png`,
                }
//              }
            );
//          );
            ns.forEach(n2 => {
//          ns.forEach(n2 => {
                result.push(
//              result.push(
                    {
//                  {
                        name: `bayer${n1}tile${n2}.png`,
//                      name: `bayer${n1}tile${n2}.png`,
                        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}tile${n2}.png`,
//                      path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}tile${n2}.png`,
                    }
//                  }
                );
//              );
            });
//          });
        });
//      });
        return result;
//      return result;
    };
//  };

    const fetchAllTextures_Noise = (): types.TextureForShader[] => {
//  const fetchAllTextures_Noise = (): types.TextureForShader[] => {
        let pathsA: {
//      let pathsA: {
            path1: string,
//          path1: string,
            path2: string,
//          path2: string,
        }[] = [
//      }[] = [
            { path1: "sbs_-_noise_texture_pack_-_128x128", path2: "128x128", },
//          { path1: "sbs_-_noise_texture_pack_-_128x128", path2: "128x128", },
            { path1: "sbs_-_noise_texture_pack_-_256x256", path2: "256x256", },
//          { path1: "sbs_-_noise_texture_pack_-_256x256", path2: "256x256", },
            { path1: "sbs_-_noise_texture_pack_-_512x512", path2: "512x512", },
//          { path1: "sbs_-_noise_texture_pack_-_512x512", path2: "512x512", },
        ];
//      ];
        let pathsB: {
//      let pathsB: {
            path3: string,
//          path3: string,
            min: number,
//          min: number,
            max: number,
//          max: number,
        }[] = [
//      }[] = [
            { path3: "Super Perlin", min: 1, max: 14, },
//          { path3: "Super Perlin", min: 1, max: 14, },
            { path3: "Melt"        , min: 1, max: 14, },
//          { path3: "Melt"        , min: 1, max: 14, },
            { path3: "Vein"        , min: 1, max: 14, },
//          { path3: "Vein"        , min: 1, max: 14, },
            { path3: "Gabor"       , min: 1, max: 14, },
//          { path3: "Gabor"       , min: 1, max: 14, },
            { path3: "Milky"       , min: 1, max: 14, },
//          { path3: "Milky"       , min: 1, max: 14, },
            { path3: "Swirl"       , min: 1, max: 14, },
//          { path3: "Swirl"       , min: 1, max: 14, },
            { path3: "Cracks"      , min: 1, max: 14, },
//          { path3: "Cracks"      , min: 1, max: 14, },
            { path3: "Grainy"      , min: 1, max: 14, },
//          { path3: "Grainy"      , min: 1, max: 14, },
            { path3: "Marble"      , min: 1, max: 14, },
//          { path3: "Marble"      , min: 1, max: 14, },
            { path3: "Perlin"      , min: 1, max: 24, },
//          { path3: "Perlin"      , min: 1, max: 24, },
            { path3: "Spokes"      , min: 1, max: 14, },
//          { path3: "Spokes"      , min: 1, max: 14, },
            { path3: "Streak"      , min: 1, max: 14, },
//          { path3: "Streak"      , min: 1, max: 14, },
            { path3: "Techno"      , min: 1, max: 14, },
//          { path3: "Techno"      , min: 1, max: 14, },
            { path3: "Craters"     , min: 1, max: 14, },
//          { path3: "Craters"     , min: 1, max: 14, },
            { path3: "Voronoi"     , min: 1, max: 14, },
//          { path3: "Voronoi"     , min: 1, max: 14, },
            { path3: "Manifold"    , min: 1, max: 14, },
//          { path3: "Manifold"    , min: 1, max: 14, },
            { path3: "Turbulence"  , min: 1, max: 14, },
//          { path3: "Turbulence"  , min: 1, max: 14, },
            { path3: "Super Noise" , min: 1, max: 14, },
//          { path3: "Super Noise" , min: 1, max: 14, },
        ];
//      ];
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let pathA of pathsA) {
//      for (let pathA of pathsA) {
            for (let pathB of pathsB) {
//          for (let pathB of pathsB) {
                for (let n = pathB.min; n <= pathB.max; ++n) {
//              for (let n = pathB.min; n <= pathB.max; ++n) {
                    result.push(
//                  result.push(
                        {
//                      {
                            name: `${pathB.path3} ${n} - ${pathA.path2}.png`,
//                          name: `${pathB.path3} ${n} - ${pathA.path2}.png`,
                            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/noise_textures/${pathA.path1}/${pathA.path2}/${pathB.path3}/${pathB.path3} ${n} - ${pathA.path2}.png`,
//                          path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/noise_textures/${pathA.path1}/${pathA.path2}/${pathB.path3}/${pathB.path3} ${n} - ${pathA.path2}.png`,
                        }
//                      }
                    );
//                  );
                }
//              }
            }
//          }
        }
//      }
        return result;
//      return result;
    };
//  };


    const fetchAllTextures_Palette = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
//  const fetchAllTextures_Palette = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
        let { data, error, } = await supabase.storage.from("palette_textures").list("lospec");
//      let { data, error, } = await supabase.storage.from("palette_textures").list("lospec");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `${item.name}`,
//              name: `${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/palette_textures/lospec/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/palette_textures/lospec/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    };
//  };

    const fetchAllTextures_Pencil_ = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
//  const fetchAllTextures_Pencil_ = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
        let { data, error, } = await supabase.storage.from("pencil_textures").list("godot");
//      let { data, error, } = await supabase.storage.from("pencil_textures").list("godot");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `Pencil ${item.name}`,
//              name: `Pencil ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    };
//  };

    const fetchAllTextures_ASCII = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
//  const fetchAllTextures_ASCII = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
        let { data, error, } = await supabase.storage.from("ascii_textures").list("godot");
//      let { data, error, } = await supabase.storage.from("ascii_textures").list("godot");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `ASCII ${item.name}`,
//              name: `ASCII ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/ascii_textures/godot/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/ascii_textures/godot/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    };
//  };

    const fetchAllTextures_Tiled = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
//  const fetchAllTextures_Tiled = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
        let { data, error, } = await supabase.storage.from("tiled_textures").list("godot");
//      let { data, error, } = await supabase.storage.from("tiled_textures").list("godot");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `Tiled ${item.name}`,
//              name: `Tiled ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/tiled_textures/godot/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/tiled_textures/godot/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    };
//  };

    const fetchAllTextures_ShaderToy = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
//  const fetchAllTextures_ShaderToy = async (supabase: SupabaseClient): Promise<types.TextureForShader[]> => {
        let { data, error, } = await supabase.storage.from("shader_toy_textures").list("shader_toy");
//      let { data, error, } = await supabase.storage.from("shader_toy_textures").list("shader_toy");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `Shader Toy ${item.name}`,
//              name: `Shader Toy ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/shader_toy_textures/shader_toy/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/shader_toy_textures/shader_toy/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    };
//  };

    const onRedoActionExecuted = async (): Promise<void> => {
//  const onRedoActionExecuted = async (): Promise<void> => {
        let redoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsRedoStack.pop();
//      let redoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsRedoStack.pop();
        if (redoEditorSnapshot) {
//      if (redoEditorSnapshot) {
            if (redoEditorSnapshot.redo) {
//          if (redoEditorSnapshot.redo) {
                await redoEditorSnapshot.redo(redoEditorSnapshot.dynamicStorage);
//              await redoEditorSnapshot.redo(redoEditorSnapshot.dynamicStorage);
            }
//          }
            global.globalState.editorSnapshotsUndoStack.push(redoEditorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(redoEditorSnapshot);
        }
//      }
    };
//  };

    const onUndoActionExecuted = async (): Promise<void> => {
//  const onUndoActionExecuted = async (): Promise<void> => {
        let undoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsUndoStack.pop();
//      let undoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsUndoStack.pop();
        if (undoEditorSnapshot) {
//      if (undoEditorSnapshot) {
            if (undoEditorSnapshot.undo) {
//          if (undoEditorSnapshot.undo) {
                await undoEditorSnapshot.undo(undoEditorSnapshot.dynamicStorage);
//              await undoEditorSnapshot.undo(undoEditorSnapshot.dynamicStorage);
            }
//          }
            global.globalState.editorSnapshotsRedoStack.push(undoEditorSnapshot);
//          global.globalState.editorSnapshotsRedoStack.push(undoEditorSnapshot);
        }
//      }
    };
//  };

    const doHexToRgbNormalized = async (hex: string): Promise<{ r: number, g: number, b: number, }> => {
//  const doHexToRgbNormalized = async (hex: string): Promise<{ r: number, g: number, b: number, }> => {
        hex = hex.replace(/^#/, "");
//      hex = hex.replace(/^#/, "");
        const r: number = parseInt(hex.substring(0, 2), 16) / 255;
//      const r: number = parseInt(hex.substring(0, 2), 16) / 255;
        const g: number = parseInt(hex.substring(2, 4), 16) / 255;
//      const g: number = parseInt(hex.substring(2, 4), 16) / 255;
        const b: number = parseInt(hex.substring(4, 6), 16) / 255;
//      const b: number = parseInt(hex.substring(4, 6), 16) / 255;
        return { r: r, g: g, b: b, };
//      return { r: r, g: g, b: b, };
    };
//  };

    const noHexToRgbNormalized = async (hex: string): Promise<{ r: number, g: number, b: number, }> => {
//  const noHexToRgbNormalized = async (hex: string): Promise<{ r: number, g: number, b: number, }> => {
        hex = hex.replace(/^#/, "");
//      hex = hex.replace(/^#/, "");
        const r: number = parseInt(hex.substring(0, 2), 16);
//      const r: number = parseInt(hex.substring(0, 2), 16);
        const g: number = parseInt(hex.substring(2, 4), 16);
//      const g: number = parseInt(hex.substring(2, 4), 16);
        const b: number = parseInt(hex.substring(4, 6), 16);
//      const b: number = parseInt(hex.substring(4, 6), 16);
        return { r: r, g: g, b: b, };
//      return { r: r, g: g, b: b, };
    };
//  };

    const rgba_ToHexNormalized = async (r: number, g: number, b: number, a: number): Promise<string> => {
//  const rgba_ToHexNormalized = async (r: number, g: number, b: number, a: number): Promise<string> => {
        r = Math.round(Math.max(0, Math.min(255, r)));
//      r = Math.round(Math.max(0, Math.min(255, r)));
        g = Math.round(Math.max(0, Math.min(255, g)));
//      g = Math.round(Math.max(0, Math.min(255, g)));
        b = Math.round(Math.max(0, Math.min(255, b)));
//      b = Math.round(Math.max(0, Math.min(255, b)));
        a = Math.round(Math.max(0, Math.min(255, a)));
//      a = Math.round(Math.max(0, Math.min(255, a)));
        const hex = `#${r.toString(16).padStart(2, "0")}${g.toString(16).padStart(2, "0")}${b.toString(16).padStart(2, "0")}${a.toString(16).padStart(2, "0")}`;
//      const hex = `#${r.toString(16).padStart(2, "0")}${g.toString(16).padStart(2, "0")}${b.toString(16).padStart(2, "0")}${a.toString(16).padStart(2, "0")}`;
        return hex;
//      return hex;
    };
//  };

    const display = (draggableText: types.DraggableText, canvasInstance: p5): void => {
//  const display = (draggableText: types.DraggableText, canvasInstance: p5): void => {
        canvasInstance.push();
//      canvasInstance.push();
        canvasInstance.textLeading(draggableText.spacings);
//      canvasInstance.textLeading(draggableText.spacings);
        canvasInstance.textSize(draggableText.fontSize);
//      canvasInstance.textSize(draggableText.fontSize);
        if (draggableText.font)
//      if (draggableText.font)
            canvasInstance.textFont(draggableText.font, draggableText.fontSize);
//          canvasInstance.textFont(draggableText.font, draggableText.fontSize);
            /*
            canvasInstance.strokeWeight(10);
//          canvasInstance.strokeWeight(10);
            canvasInstance.stroke(draggableText.colorOutline.r, draggableText.colorOutline.g, draggableText.colorOutline.b, draggableText.colorOutline.a);
//          canvasInstance.stroke(draggableText.colorOutline.r, draggableText.colorOutline.g, draggableText.colorOutline.b, draggableText.colorOutline.a);
            */
            canvasInstance.fill(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a);
//          canvasInstance.fill(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a);
            /*
            canvasInstance.strokeWeight(10);
//          canvasInstance.strokeWeight(10);
            if (draggableText.wrapMode) {
//          if (draggableText.wrapMode) {
                canvasInstance.textWrap(draggableText.wrapMode);
//              canvasInstance.textWrap(draggableText.wrapMode);
            }
//          }
            canvasInstance.textStyle(draggableText.stylesOption);
//          canvasInstance.textStyle(draggableText.stylesOption);
            */
            canvasInstance.textAlign(draggableText.alignHOption, draggableText.alignVOption);
//          canvasInstance.textAlign(draggableText.alignHOption, draggableText.alignVOption);
            canvasInstance.text(draggableText.contents
//          canvasInstance.text(draggableText.contents
                , draggableText.positionX
//              , draggableText.positionX
                , draggableText.positionY
//              , draggableText.positionY
                /*
                , draggableText.dimensionW
//              , draggableText.dimensionW
                , draggableText.dimensionH
//              , draggableText.dimensionH
                */
            );
//          );
        canvasInstance.pop();
//      canvasInstance.pop();
    };
//  };

    const onMousePressed = (draggableText: types.DraggableText, canvasInstance: p5): void => {
//  const onMousePressed = (draggableText: types.DraggableText, canvasInstance: p5): void => {
        if (canvasInstance.mouseX - canvasInstance.width / 2 > draggableText.positionX &&
//      if (canvasInstance.mouseX - canvasInstance.width / 2 > draggableText.positionX &&
            canvasInstance.mouseX - canvasInstance.width / 2 < draggableText.positionX + draggableText.dimensionW &&
//          canvasInstance.mouseX - canvasInstance.width / 2 < draggableText.positionX + draggableText.dimensionW &&
            canvasInstance.mouseY - canvasInstance.height / 2 < draggableText.positionY + draggableText.dimensionH &&
//          canvasInstance.mouseY - canvasInstance.height / 2 < draggableText.positionY + draggableText.dimensionH &&
            canvasInstance.mouseY - canvasInstance.height / 2 > draggableText.positionY) {
//          canvasInstance.mouseY - canvasInstance.height / 2 > draggableText.positionY) {
            draggableText.isDragging = true;
//          draggableText.isDragging = true;
        }
//      }
    };
//  };

    const startDragging = (draggableText: types.DraggableText, canvasInstance: p5): void => {
//  const startDragging = (draggableText: types.DraggableText, canvasInstance: p5): void => {
        if (draggableText.isDragging) {
//      if (draggableText.isDragging) {
            draggableText.positionX = canvasInstance.mouseX - canvasInstance.width  / 2;
//          draggableText.positionX = canvasInstance.mouseX - canvasInstance.width  / 2;
            draggableText.positionY = canvasInstance.mouseY - canvasInstance.height / 2;
//          draggableText.positionY = canvasInstance.mouseY - canvasInstance.height / 2;
        }
//      }
    };
//  };

    const ceaseDragging = (draggableText: types.DraggableText, canvasInstance: p5): void => {
//  const ceaseDragging = (draggableText: types.DraggableText, canvasInstance: p5): void => {
        draggableText.isDragging = false;
//      draggableText.isDragging = false;
    };
//  };

    const fetchAllFonts_TTF_ITCHIO = async (supabase: SupabaseClient): Promise<types.CustomFont[]> => { let { data } = await supabase.storage.from("fonts").list("itchio/ttf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `TTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/ttf/${item.name}`, customFontFace: null, }); } return result; };
//  const fetchAllFonts_TTF_ITCHIO = async (supabase: SupabaseClient): Promise<types.CustomFont[]> => { let { data } = await supabase.storage.from("fonts").list("itchio/ttf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `TTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/ttf/${item.name}`, customFontFace: null, }); } return result; };
    const fetchAllFonts_OTF_ITCHIO = async (supabase: SupabaseClient): Promise<types.CustomFont[]> => { let { data } = await supabase.storage.from("fonts").list("itchio/otf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `OTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/otf/${item.name}`, customFontFace: null, }); } return result; };
//  const fetchAllFonts_OTF_ITCHIO = async (supabase: SupabaseClient): Promise<types.CustomFont[]> => { let { data } = await supabase.storage.from("fonts").list("itchio/otf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `OTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/otf/${item.name}`, customFontFace: null, }); } return result; };

    const fetchShaderMetadata = async (shaderPath: string): Promise<types.GLSLUniforms> => {
//  const fetchShaderMetadata = async (shaderPath: string): Promise<types.GLSLUniforms> => {
        try {
//      try {
            const response: Response = await fetch(`${shaderPath}.meta.json`);
//          const response: Response = await fetch(`${shaderPath}.meta.json`);
            if (!response.ok) {
//          if (!response.ok) {
                console.warn(`Failed to fetch metadata for ${shaderPath}`);
//              console.warn(`Failed to fetch metadata for ${shaderPath}`);
                return [];
//              return [];
            }
//          }
            const data: any = await response.json();
//          const data: any = await response.json();
            const uniforms: types.GLSLUniforms = (data.shaderUniforms || []).map((u: any): types.GLSLUniform_ => {
//          const uniforms: types.GLSLUniforms = (data.shaderUniforms || []).map((u: any): types.GLSLUniform_ => {
                return {
//              return {
                    thisUniformName: u.uniformVarName,
//                  thisUniformName: u.uniformVarName,
                    thisUniformNameJustForDisplay: u.uniformDisName,
//                  thisUniformNameJustForDisplay: u.uniformDisName,
                    thisUniformType: u.uniformVarType,
//                  thisUniformType: u.uniformVarType,
                    thisUniformDefaultValue: u.uniformDefVal,
//                  thisUniformDefaultValue: u.uniformDefVal,
                    thisUniformSampler2DImg: null,
//                  thisUniformSampler2DImg: null,
                    thisUniformSampler2DEle: null,
//                  thisUniformSampler2DEle: null,
                };
//              };
            });
//          });
            return uniforms;
//          return uniforms;
        } catch (error: unknown) {
//      } catch (error: unknown) {
            console.error(error);
//          console.error(error);
            return [];
//          return [];
        }
//      }
    };
//  };

    const makeNewSnackbarSuccess = async (newSuccessScript: string): Promise<void> => { global.globalState.successScript = newSuccessScript; await ui("#snackbar-success"); };
//  const makeNewSnackbarSuccess = async (newSuccessScript: string): Promise<void> => { global.globalState.successScript = newSuccessScript; await ui("#snackbar-success"); };
    const makeNewSnackbarFailure = async (newFailureScript: string): Promise<void> => { global.globalState.failureScript = newFailureScript; await ui("#snackbar-failure"); };
//  const makeNewSnackbarFailure = async (newFailureScript: string): Promise<void> => { global.globalState.failureScript = newFailureScript; await ui("#snackbar-failure"); };

    export {
//  export {
        Shaders,
//      Shaders,
        shareImage,
//      shareImage,
        shareVideo,
//      shareVideo,
        shareWebcam,
//      shareWebcam,
        exampleGLSLUniforms,
//      exampleGLSLUniforms,
        parseGLSL,
//      parseGLSL,
        splitArrayIntoGroups,
//      splitArrayIntoGroups,
        fetchAllTextures_Bayer,
//      fetchAllTextures_Bayer,
        fetchAllTextures_Noise,
//      fetchAllTextures_Noise,
        fetchAllTextures_Palette,
//      fetchAllTextures_Palette,
        fetchAllTextures_Pencil_,
//      fetchAllTextures_Pencil_,
        fetchAllTextures_ASCII,
//      fetchAllTextures_ASCII,
        fetchAllTextures_Tiled,
//      fetchAllTextures_Tiled,
        fetchAllTextures_ShaderToy,
//      fetchAllTextures_ShaderToy,
        onRedoActionExecuted,
//      onRedoActionExecuted,
        onUndoActionExecuted,
//      onUndoActionExecuted,
        doHexToRgbNormalized,
//      doHexToRgbNormalized,
        noHexToRgbNormalized,
//      noHexToRgbNormalized,
        rgba_ToHexNormalized,
//      rgba_ToHexNormalized,
        display,
//      display,
        onMousePressed,
//      onMousePressed,
        startDragging,
//      startDragging,
        ceaseDragging,
//      ceaseDragging,
        fetchAllFonts_TTF_ITCHIO,
//      fetchAllFonts_TTF_ITCHIO,
        fetchAllFonts_OTF_ITCHIO,
//      fetchAllFonts_OTF_ITCHIO,
        fetchShaderMetadata,
//      fetchShaderMetadata,
        makeNewSnackbarSuccess,
//      makeNewSnackbarSuccess,
        makeNewSnackbarFailure,
//      makeNewSnackbarFailure,
    };
//  };

