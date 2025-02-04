import     ImgurClient                    from                 "imgur"  ;
export let imgurClient
     = new ImgurClient({ clientId: import.meta.env.VITE_CLIENT_ID____ });

import type { DraggableText    } from "./types";
import type { GLSLUniform_     } from "./types";
import type { GLSLUniforms     } from "./types";
import type { GLSLUniformValue } from "./types";
import type { TextureForShader } from "./types";
import type { Writable } from "svelte/store";
import      { writable } from "svelte/store";

export let texturesNoise    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesBayer    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesPalette  : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesPencil_  : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesASCII    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesTiled    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesShaderToy: Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);


import {   createClient } from "@supabase/supabase-js";
import { SupabaseClient } from "@supabase/supabase-js";
export const supabase = createClient (
import.meta.env.VITE_SUPABASE_URL     ,
import.meta.env.VITE_SUPABASE_KEY_PUB);


export let effectsUsedForFiltering: Writable<Array<{ fragmentShaderSourceType________: "AI" |  "NI" | null,
                                                     fragmentShaderSourceCode________:       string | null,
                                                     fragmentShader______GLSLUniforms: GLSLUniforms | null,
                                                     fragmentShaderFiltering_Instance: any          | null,
                                                     fragmentShader_HTMLSelectElement:
                                                                    HTMLSelectElement               | null,
                                                     draggableText                   :
                                                     DraggableText                                  | null,
                                                   }>> = writable(
                                                   [
                                                   {
                                                     fragmentShaderSourceType________:                "NI",
                                                     fragmentShaderSourceCode________:                null,
                                                     fragmentShader______GLSLUniforms:                null,
                                                     fragmentShaderFiltering_Instance:                null,
                                                     fragmentShader_HTMLSelectElement:                null,
                                                     draggableText                   :                null,
//                                                   draggableText                   :                null,
                                                   }
                                                   ]             );


import { type EditorSnapshot } from "./types"                     ;
export let    editorSnapshotsRedoStack: Array<EditorSnapshot> = [];
export let    editorSnapshotsUndoStack: Array<EditorSnapshot> = [];


    import type { CustomFont } from "./types";
//  import type { CustomFont } from "./types";
    export let customFonts: Writable<Array<CustomFont>> = writable([{ customFontName: "none", customFontPath: "none", customFontFace: null, }]);
//  export let customFonts: Writable<Array<CustomFont>> = writable([{ customFontName: "none", customFontPath: "none", customFontFace: null, }]);



export let successScript: Writable<string> = writable("");
export let failureScript: Writable<string> = writable("");


                                                   





                                                   


























