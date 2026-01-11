    import p5 from "p5";
//  import p5 from "p5";

    export type TextAlignHOption = typeof p5.LEFT | typeof p5.CENTER | typeof p5.RIGHT;
//  export type TextAlignHOption = typeof p5.LEFT | typeof p5.CENTER | typeof p5.RIGHT;
    export type TextAlignVOption = typeof p5.TOP  | typeof p5.BOTTOM | typeof p5.CENTER | typeof p5.BASELINE;
//  export type TextAlignVOption = typeof p5.TOP  | typeof p5.BOTTOM | typeof p5.CENTER | typeof p5.BASELINE;
    export type TextStyleOption = typeof p5.NORMAL| typeof p5.ITALIC | typeof p5.BOLD | typeof p5.BOLDITALIC;
//  export type TextStyleOption = typeof p5.NORMAL| typeof p5.ITALIC | typeof p5.BOLD | typeof p5.BOLDITALIC;
    export type TextWrapModeOption = typeof p5.WORD | typeof p5.CHAR;
//  export type TextWrapModeOption = typeof p5.WORD | typeof p5.CHAR;

    export type DraggableText = {
//  export type DraggableText = {
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

    export type CustomFont = {
//  export type CustomFont = {
        customFontName: string | null;
//      customFontName: string | null;
        customFontPath: string | null;
//      customFontPath: string | null;
        customFontFace: p5.Font | null;
//      customFontFace: p5.Font | null;
    }
//  }
