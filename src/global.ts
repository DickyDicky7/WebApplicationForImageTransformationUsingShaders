import     ImgurClient                    from                 "imgur"  ;
export let imgurClient
     = new ImgurClient({ clientId: import.meta.env.VITE_CLIENT_ID____ });

import type { TextureForShader } from "./types";
import type { Writable } from "svelte/store";
import      { writable } from "svelte/store";

export let texturesNoise    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesBayer    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesPalette  : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesPencil   : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesASCII    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesTiled    : Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);
export let texturesShaderToy: Writable<Array<TextureForShader>> = writable([{ name: "none", path: "none", }]);


import {   createClient } from "@supabase/supabase-js";
import { SupabaseClient } from "@supabase/supabase-js";
export const supabase = createClient (
import.meta.env.VITE_SUPABASE_URL     ,
import.meta.env.VITE_SUPABASE_KEY_PUB);


