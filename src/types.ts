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





