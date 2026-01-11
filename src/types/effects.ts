    import p5 from "p5";
//  import p5 from "p5";
    import type { GLSLUniforms } from "./core";
//  import type { GLSLUniforms } from "./core";
    import type { DraggableText } from "./text";
//  import type { DraggableText } from "./text";

    export type EffectUsedForFiltering = {
//  export type EffectUsedForFiltering = {
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
