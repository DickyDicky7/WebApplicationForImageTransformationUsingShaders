    import p5 from "p5";
//  import p5 from "p5";

    export type GLSLUniformValue =
//  export type GLSLUniformValue =
        | number   // FLOAT INT
//      | number   // FLOAT INT
        | boolean  // BOOLEAN
//      | boolean  // BOOLEAN
        | number[] // VEC MAT
//      | number[] // VEC MAT
        | string;  // SAMPLER2D
//      | string;  // SAMPLER2D

    export type GLSLUniform_ = {
//  export type GLSLUniform_ = {
        thisUniformName: string | null;
//      thisUniformName: string | null;
        thisUniformNameJustForDisplay: string | null;
//      thisUniformNameJustForDisplay: string | null;
        thisUniformType: string | null;
//      thisUniformType: string | null;
        thisUniformDefaultValue: GLSLUniformValue | null;
//      thisUniformDefaultValue: GLSLUniformValue | null;
        thisUniformSampler2DImg: p5.Image | p5.MediaElement | null;
//      thisUniformSampler2DImg: p5.Image | p5.MediaElement | null;
        thisUniformSampler2DEle: HTMLImageElement | HTMLVideoElement | null;
//      thisUniformSampler2DEle: HTMLImageElement | HTMLVideoElement | null;
    }
//  }

    export type GLSLUniforms = Array<GLSLUniform_>;
//  export type GLSLUniforms = Array<GLSLUniform_>;

    export type TextureForShader = {
//  export type TextureForShader = {
        name: string;
//      name: string;
        path: string;
//      path: string;
    }
//  }

    export type EditorSnapshot = {
//  export type EditorSnapshot = {
        undo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
//      undo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
        redo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
//      redo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
        dynamicStorage: Map<string, any> | null;
//      dynamicStorage: Map<string, any> | null;
    }
//  }

    export type ShaderName = string;
//  export type ShaderName = string;
    export type ShaderPath = string;
//  export type ShaderPath = string;
