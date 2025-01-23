import p5 from "p5";

type GLSLUniformValue =
| number   // FLOAT INT
| boolean  //       BOOLEAN
| number[] //       VEC MAT
| string;  // SAMPLER2D

type GLSLUniform_     =
{
    thisUniformName              : string           | null,
    thisUniformNameJustForDisplay: string           | null,
    thisUniformType              : string           | null,
    thisUniformDefaultValue      : GLSLUniformValue | null,
    thisUniformSampler2DImg      :         p5.Image | null
                                 |         p5.MediaElement,
    thisUniformSampler2DEle      : HTMLImageElement | null
                                 | HTMLVideoElement | null,
}

type GLSLUniforms     = Array<
     GLSLUniform_            >;

export
enum MODE {
     IMAGE ,
     VIDEO ,
     WEBCAM,
};

type TextureForShader = {
     name: string,
     path: string,
};

export type
{
     TextureForShader,
     GLSLUniformValue,
     GLSLUniforms    ,
     GLSLUniform_    ,
};

export
enum MODE_CAPTURE_IMAGE {
     AS_IMAGE,
//   AS_VIDEO_FULLSHOT,
     AS_VIDEO_SNAPSHOT,
};

export
enum MODE_CAPTURE_VIDEO {
     AS_IMAGE,
     AS_VIDEO_FULLSHOT,
     AS_VIDEO_SNAPSHOT,
};

export
type EditorSnapshot = {
     undo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null,
     redo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null,
             dynamicStorage: Map<string, any> | null                         ,
};


















export type DraggableText = {
     textColorFill: {r:number,g:number,b:number,a:number,},
     textFontSize  : number ,
     text      : string ,
     textAlignH : p5.HORIZ_ALIGN,
     textAlignV : p5. VERT_ALIGN,
     textFont  : p5.Font,
     textStyle : p5.THE_STYLE,
     x         : number ,
     y         : number ,
     w         : number ,
     h         : number ,
     isDragging: boolean,
     offsetX   : number ,
     offsetY   : number ,
};