    import p5 from "p5";
//  import p5 from "p5";

    type GLSLUniformValue =
//  type GLSLUniformValue =
        | number   // FLOAT INT
//      | number   // FLOAT INT
        | boolean  // BOOLEAN
//      | boolean  // BOOLEAN
        | number[] // VEC MAT
//      | number[] // VEC MAT
        | string;  // SAMPLER2D
//      | string;  // SAMPLER2D

    type GLSLUniform_ = {
//  type GLSLUniform_ = {
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

    type GLSLUniforms = Array<GLSLUniform_>;
//  type GLSLUniforms = Array<GLSLUniform_>;

    enum MODE {
//  enum MODE {
        IMAGE,
//      IMAGE,
        VIDEO,
//      VIDEO,
        WEBCAM,
//      WEBCAM,
    }
//  }

    type TextureForShader = {
//  type TextureForShader = {
        name: string;
//      name: string;
        path: string;
//      path: string;
    }
//  }

    enum MODE_CAPTURE_IMAGE {
//  enum MODE_CAPTURE_IMAGE {
        AS_IMAGE,
//      AS_IMAGE,
        //   AS_VIDEO_FULLSHOT,
//      //   AS_VIDEO_FULLSHOT,
        AS_VIDEO_SNAPSHOT,
//      AS_VIDEO_SNAPSHOT,
    }
//  }

    enum MODE_CAPTURE_VIDEO {
//  enum MODE_CAPTURE_VIDEO {
        AS_IMAGE,
//      AS_IMAGE,
        AS_VIDEO_FULLSHOT,
//      AS_VIDEO_FULLSHOT,
        AS_VIDEO_SNAPSHOT,
//      AS_VIDEO_SNAPSHOT,
    }
//  }

    type EditorSnapshot = {
//  type EditorSnapshot = {
        undo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
//      undo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
        redo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
//      redo: ((dynamicStorage: Map<string, any> | null) => Promise<void>) | null;
        dynamicStorage: Map<string, any> | null;
//      dynamicStorage: Map<string, any> | null;
    }
//  }

    type DraggableText = {
//  type DraggableText = {
        colorOutline: { r: number; g: number; b: number; a: number }; //
//      colorOutline: { r: number; g: number; b: number; a: number }; //
        colorFilling: { r: number; g: number; b: number; a: number }; //
//      colorFilling: { r: number; g: number; b: number; a: number }; //
        fontSize: number; //
//      fontSize: number; //
        contents: string; //
//      contents: string; //
        alignHOption: TextAlignHOption; //
//      alignHOption: TextAlignHOption; //
        alignVOption: TextAlignVOption; //
//      alignVOption: TextAlignVOption; //
        font: p5.Font; //
//      font: p5.Font; //
        stylesOption: TextStyleOption; //
//      stylesOption: TextStyleOption; //
        wrapMode: TextWrapModeOption; //
//      wrapMode: TextWrapModeOption; //
        spacings: number; //
//      spacings: number; //
        positionX: number; //
//      positionX: number; //
        positionY: number; //
//      positionY: number; //
        dimensionW: number; //
//      dimensionW: number; //
        dimensionH: number; //
//      dimensionH: number; //
        isDragging: boolean;
//      isDragging: boolean;
        offsetX: number;
//      offsetX: number;
        offsetY: number;
//      offsetY: number;
    }
//  }

    type CustomFont = {
//  type CustomFont = {
        customFontName: string | null;
//      customFontName: string | null;
        customFontPath: string | null;
//      customFontPath: string | null;
        customFontFace: p5.Font | null;
//      customFontFace: p5.Font | null;
    }
//  }

    type TextAlignHOption = typeof p5.LEFT | typeof p5.CENTER | typeof p5.RIGHT;
//  type TextAlignHOption = typeof p5.LEFT | typeof p5.CENTER | typeof p5.RIGHT;
    type TextAlignVOption = typeof p5.TOP  | typeof p5.BOTTOM | typeof p5.CENTER | typeof p5.BASELINE;
//  type TextAlignVOption = typeof p5.TOP  | typeof p5.BOTTOM | typeof p5.CENTER | typeof p5.BASELINE;
    type TextStyleOption = typeof p5.NORMAL| typeof p5.ITALIC | typeof p5.BOLD | typeof p5.BOLDITALIC;
//  type TextStyleOption = typeof p5.NORMAL| typeof p5.ITALIC | typeof p5.BOLD | typeof p5.BOLDITALIC;
    type TextWrapModeOption = typeof p5.WORD | typeof p5.CHAR;
//  type TextWrapModeOption = typeof p5.WORD | typeof p5.CHAR;

    type EffectUsedForFiltering = {
//  type EffectUsedForFiltering = {
        fragmentShaderSourceType________: "AI" | "NI" | null;
//      fragmentShaderSourceType________: "AI" | "NI" | null;
        fragmentShaderSourceCode________: string | null;
//      fragmentShaderSourceCode________: string | null;
        fragmentShader______GLSLUniforms: GLSLUniforms | null;
//      fragmentShader______GLSLUniforms: GLSLUniforms | null;
        fragmentShaderFiltering_Instance: p5.Shader | null;
//      fragmentShaderFiltering_Instance: p5.Shader | null;
        fragmentShader_HTMLSelectElement: HTMLSelectElement | null;
//      fragmentShader_HTMLSelectElement: HTMLSelectElement | null;
        draggableText: DraggableText | null;
//      draggableText: DraggableText | null;
    }
//  }

    type ShaderName = string;
//  type ShaderName = string;
    type ShaderPath = string;
//  type ShaderPath = string;

    export type {
//  export type {
        GLSLUniformValue,
//      GLSLUniformValue,
        GLSLUniform_,
//      GLSLUniform_,
        GLSLUniforms,
//      GLSLUniforms,
        TextureForShader,
//      TextureForShader,
        EditorSnapshot,
//      EditorSnapshot,
        DraggableText,
//      DraggableText,
        CustomFont,
//      CustomFont,
        TextAlignHOption,
//      TextAlignHOption,
        TextAlignVOption,
//      TextAlignVOption,
        TextStyleOption,
//      TextStyleOption,
        TextWrapModeOption,
//      TextWrapModeOption,
        EffectUsedForFiltering,
//      EffectUsedForFiltering,
        ShaderName,
//      ShaderName,
        ShaderPath,
//      ShaderPath,
    }
//  }

    export {
//  export {
        MODE,
//      MODE,
        MODE_CAPTURE_IMAGE,
//      MODE_CAPTURE_IMAGE,
        MODE_CAPTURE_VIDEO,
//      MODE_CAPTURE_VIDEO,
    }
//  }
