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
}

type GLSLUniforms     = Array<
     GLSLUniform_            >;

export type
{
     GLSLUniformValue,
     GLSLUniforms    ,
     GLSLUniform_    ,
};

export enum MODE
{
    IMAGE,
    VIDEO,
    WEBCAM,
};
