    import { createClient } from "@supabase/supabase-js";
//  import { createClient } from "@supabase/supabase-js";
    import ImgurClient from "imgur";
//  import ImgurClient from "imgur";
    import * as types from "./types";
//  import * as types from "./types";

    const supabase = createClient(
//  const supabase = createClient(
        import.meta.env.VITE_SUPABASE_URL,
//      import.meta.env.VITE_SUPABASE_URL,
        import.meta.env.VITE_SUPABASE_KEY_PUB,
//      import.meta.env.VITE_SUPABASE_KEY_PUB,
    );
//  );

    const imgurClient: ImgurClient = new ImgurClient({
//  const imgurClient: ImgurClient = new ImgurClient({
        clientId: import.meta.env.VITE_CLIENT_ID____,
//      clientId: import.meta.env.VITE_CLIENT_ID____,
    });
//  });

    class GlobalState {
//  class GlobalState {
        texturesNoise: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
//      texturesNoise: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
            {
//          {
                name: "none",
//              name: "none",
                path: "none",
//              path: "none",
            },
//          },
        ]);
//      ]);
        texturesBayer: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
//      texturesBayer: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
            {
//          {
                name: "none",
//              name: "none",
                path: "none",
//              path: "none",
            },
//          },
        ]);
//      ]);
        texturesPalette: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
//      texturesPalette: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
            {
//          {
                name: "none",
//              name: "none",
                path: "none",
//              path: "none",
            },
//          },
        ]);
//      ]);
        texturesPencil_: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
//      texturesPencil_: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
            {
//          {
                name: "none",
//              name: "none",
                path: "none",
//              path: "none",
            },
//          },
        ]);
//      ]);
        texturesASCII: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
//      texturesASCII: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
            {
//          {
                name: "none",
//              name: "none",
                path: "none",
//              path: "none",
            },
//          },
        ]);
//      ]);
        texturesTiled: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
//      texturesTiled: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
            {
//          {
                name: "none",
//              name: "none",
                path: "none",
//              path: "none",
            },
//          },
        ]);
//      ]);
        texturesShaderToy: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
//      texturesShaderToy: Array<types.TextureForShader> = $state<Array<types.TextureForShader>>([
            {
//          {
                name: "none",
//              name: "none",
                path: "none",
//              path: "none",
            },
//          },
        ]);
//      ]);

        effectsUsedForFiltering: Array<types.EffectUsedForFiltering> = $state<Array<types.EffectUsedForFiltering>>([
//      effectsUsedForFiltering: Array<types.EffectUsedForFiltering> = $state<Array<types.EffectUsedForFiltering>>([
            {
//          {
                fragmentShaderSourceType________: "NI",
//              fragmentShaderSourceType________: "NI",
                fragmentShaderSourceCode________: null,
//              fragmentShaderSourceCode________: null,
                fragmentShader______GLSLUniforms: null,
//              fragmentShader______GLSLUniforms: null,
                fragmentShaderFiltering_Instance: null,
//              fragmentShaderFiltering_Instance: null,
                fragmentShader_HTMLSelectElement: null,
//              fragmentShader_HTMLSelectElement: null,
                draggableText: null,
//              draggableText: null,
            },
//          },
        ]);
//      ]);

        editorSnapshotsRedoStack: Array<types.EditorSnapshot> = $state<Array<types.EditorSnapshot>>([]);
//      editorSnapshotsRedoStack: Array<types.EditorSnapshot> = $state<Array<types.EditorSnapshot>>([]);
        editorSnapshotsUndoStack: Array<types.EditorSnapshot> = $state<Array<types.EditorSnapshot>>([]);
//      editorSnapshotsUndoStack: Array<types.EditorSnapshot> = $state<Array<types.EditorSnapshot>>([]);

        customFonts: Array<types.CustomFont> = $state<Array<types.CustomFont>>([
//      customFonts: Array<types.CustomFont> = $state<Array<types.CustomFont>>([
            {
//          {
                customFontName: "none",
//              customFontName: "none",
                customFontPath: "none",
//              customFontPath: "none",
                customFontFace: null,
//              customFontFace: null,
            },
//          },
        ]);
//      ]);

        successScript: string = $state<string>("");
//      successScript: string = $state<string>("");
        failureScript: string = $state<string>("");
//      failureScript: string = $state<string>("");
    }
//  }

    const globalState: GlobalState = new GlobalState();
//  const globalState: GlobalState = new GlobalState();

    export {
//  export {
        supabase,
//      supabase,
        imgurClient,
//      imgurClient,
        globalState,
//      globalState,
    };
//  };
