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
    thisUniformSampler2DImg      :         p5.Image | null,
    thisUniformSampler2DEle      : HTMLImageElement | null,
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
     colorOutline: { r: number, g: number, b: number, a: number, },//
     colorFilling: { r: number, g: number, b: number, a: number, },//
     fontSize    : number                                         ,//
     contents    : string                                         ,//
     alignHOption: p5.HORIZ_ALIGN                                 ,//
     alignVOption: p5. VERT_ALIGN                                 ,//
     font        : p5.Font                                        ,//
     stylesOption: p5. THE_STYLE                                  ,//
     wrapMode    : p5.WRAP_STYLE                                  ,//
     spacings    : number                                         ,//
     positionX   : number                                         ,//
     positionY   : number                                         ,//
     dimensionW  : number                                         ,//
     dimensionH  : number                                         ,//
     isDragging  : boolean                                        ,
     offsetX     : number                                         ,
     offsetY     : number                                         ,
};

