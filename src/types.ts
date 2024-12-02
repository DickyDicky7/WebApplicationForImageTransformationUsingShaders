type GLSLUniformValue =
| number   // FLOAT INT
| boolean  //       BOOLEAN
| number[] //       VEC MAT
| string;  // SAMPLER2D

      interface    GLSLUniforms
{
    [key: string]: GLSLUniformValue;
};

export type
{
     GLSLUniformValue,
     GLSLUniforms    ,
};

export enum MODE
{
    IMAGE,
    VIDEO,
    WEBCAM,
};
