    import type { SupabaseClient } from "@supabase/supabase-js";
//  import type { SupabaseClient } from "@supabase/supabase-js";
    import * as types from "../types";
//  import * as types from "../types";

    export function fetchAllTextures_Bayer(): types.TextureForShader[] {
//  export function fetchAllTextures_Bayer(): types.TextureForShader[] {
        let ns: number[] = [2, 4, 8, 16];
//      let ns: number[] = [2, 4, 8, 16];
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        ns.forEach(n1 => {
//      ns.forEach(n1 => {
            result.push(
//          result.push(
                {
//              {
                    name: `bayer${n1}.png`,
//                  name: `bayer${n1}.png`,
                    path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}.png`,
//                  path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}.png`,
                }
//              }
            );
//          );
            ns.forEach(n2 => {
//          ns.forEach(n2 => {
                result.push(
//              result.push(
                    {
//                  {
                        name: `bayer${n1}tile${n2}.png`,
//                      name: `bayer${n1}tile${n2}.png`,
                        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}tile${n2}.png`,
//                      path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}tile${n2}.png`,
                    }
//                  }
                );
//              );
            });
//          });
        });
//      });
        return result;
//      return result;
    }
//  }

    export function fetchAllTextures_Noise(): types.TextureForShader[] {
//  export function fetchAllTextures_Noise(): types.TextureForShader[] {
        let pathsA: {
//      let pathsA: {
            path1: string,
//          path1: string,
            path2: string,
//          path2: string,
        }[] = [
//      }[] = [
            { path1: "sbs_-_noise_texture_pack_-_128x128", path2: "128x128", },
//          { path1: "sbs_-_noise_texture_pack_-_128x128", path2: "128x128", },
            { path1: "sbs_-_noise_texture_pack_-_256x256", path2: "256x256", },
//          { path1: "sbs_-_noise_texture_pack_-_256x256", path2: "256x256", },
            { path1: "sbs_-_noise_texture_pack_-_512x512", path2: "512x512", },
//          { path1: "sbs_-_noise_texture_pack_-_512x512", path2: "512x512", },
        ];
//      ];
        let pathsB: {
//      let pathsB: {
            path3: string,
//          path3: string,
            min: number,
//          min: number,
            max: number,
//          max: number,
        }[] = [
//      }[] = [
            { path3: "Super Perlin", min: 1, max: 14, },
//          { path3: "Super Perlin", min: 1, max: 14, },
            { path3: "Melt"        , min: 1, max: 14, },
//          { path3: "Melt"        , min: 1, max: 14, },
            { path3: "Vein"        , min: 1, max: 14, },
//          { path3: "Vein"        , min: 1, max: 14, },
            { path3: "Gabor"       , min: 1, max: 14, },
//          { path3: "Gabor"       , min: 1, max: 14, },
            { path3: "Milky"       , min: 1, max: 14, },
//          { path3: "Milky"       , min: 1, max: 14, },
            { path3: "Swirl"       , min: 1, max: 14, },
//          { path3: "Swirl"       , min: 1, max: 14, },
            { path3: "Cracks"      , min: 1, max: 14, },
//          { path3: "Cracks"      , min: 1, max: 14, },
            { path3: "Grainy"      , min: 1, max: 14, },
//          { path3: "Grainy"      , min: 1, max: 14, },
            { path3: "Marble"      , min: 1, max: 14, },
//          { path3: "Marble"      , min: 1, max: 14, },
            { path3: "Perlin"      , min: 1, max: 24, },
//          { path3: "Perlin"      , min: 1, max: 24, },
            { path3: "Spokes"      , min: 1, max: 14, },
//          { path3: "Spokes"      , min: 1, max: 14, },
            { path3: "Streak"      , min: 1, max: 14, },
//          { path3: "Streak"      , min: 1, max: 14, },
            { path3: "Techno"      , min: 1, max: 14, },
//          { path3: "Techno"      , min: 1, max: 14, },
            { path3: "Craters"     , min: 1, max: 14, },
//          { path3: "Craters"     , min: 1, max: 14, },
            { path3: "Voronoi"     , min: 1, max: 14, },
//          { path3: "Voronoi"     , min: 1, max: 14, },
            { path3: "Manifold"    , min: 1, max: 14, },
//          { path3: "Manifold"    , min: 1, max: 14, },
            { path3: "Turbulence"  , min: 1, max: 14, },
//          { path3: "Turbulence"  , min: 1, max: 14, },
            { path3: "Super Noise" , min: 1, max: 14, },
//          { path3: "Super Noise" , min: 1, max: 14, },
        ];
//      ];
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let pathA of pathsA) {
//      for (let pathA of pathsA) {
            for (let pathB of pathsB) {
//          for (let pathB of pathsB) {
                for (let n = pathB.min; n <= pathB.max; ++n) {
//              for (let n = pathB.min; n <= pathB.max; ++n) {
                    result.push(
//                  result.push(
                        {
//                      {
                            name: `${pathB.path3} ${n} - ${pathA.path2}.png`,
//                          name: `${pathB.path3} ${n} - ${pathA.path2}.png`,
                            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/noise_textures/${pathA.path1}/${pathA.path2}/${pathB.path3}/${pathB.path3} ${n} - ${pathA.path2}.png`,
//                          path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/noise_textures/${pathA.path1}/${pathA.path2}/${pathB.path3}/${pathB.path3} ${n} - ${pathA.path2}.png`,
                        }
//                      }
                    );
//                  );
                }
//              }
            }
//          }
        }
//      }
        return result;
//      return result;
    }
//  }


    export async function fetchAllTextures_Palette(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
//  export async function fetchAllTextures_Palette(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
        let { data, error, } = await supabase.storage.from("palette_textures").list("lospec");
//      let { data, error, } = await supabase.storage.from("palette_textures").list("lospec");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `${item.name}`,
//              name: `${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/palette_textures/lospec/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/palette_textures/lospec/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    }
//  }

    export async function fetchAllTextures_Pencil_(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
//  export async function fetchAllTextures_Pencil_(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
        let { data, error, } = await supabase.storage.from("pencil_textures").list("godot");
//      let { data, error, } = await supabase.storage.from("pencil_textures").list("godot");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `Pencil ${item.name}`,
//              name: `Pencil ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    }
//  }

    export async function fetchAllTextures_ASCII(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
//  export async function fetchAllTextures_ASCII(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
        let { data, error, } = await supabase.storage.from("ascii_textures").list("godot");
//      let { data, error, } = await supabase.storage.from("ascii_textures").list("godot");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `ASCII ${item.name}`,
//              name: `ASCII ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/ascii_textures/godot/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/ascii_textures/godot/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    }
//  }

    export async function fetchAllTextures_Tiled(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
//  export async function fetchAllTextures_Tiled(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
        let { data, error, } = await supabase.storage.from("tiled_textures").list("godot");
//      let { data, error, } = await supabase.storage.from("tiled_textures").list("godot");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `Tiled ${item.name}`,
//              name: `Tiled ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/tiled_textures/godot/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/tiled_textures/godot/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    }
//  }

    export async function fetchAllTextures_ShaderToy(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
//  export async function fetchAllTextures_ShaderToy(supabase: SupabaseClient): Promise<types.TextureForShader[]> {
        let { data, error, } = await supabase.storage.from("shader_toy_textures").list("shader_toy");
//      let { data, error, } = await supabase.storage.from("shader_toy_textures").list("shader_toy");
        if (error) {
//      if (error) {
            console.error(error);
//          console.error(error);
        }
//      }
        let result: types.TextureForShader[] = [];
//      let result: types.TextureForShader[] = [];
        for (let item of data ?? []) {
//      for (let item of data ?? []) {
            if (item.name === ".emptyFolderPlaceholder") {
//          if (item.name === ".emptyFolderPlaceholder") {
                continue;
//              continue;
            }
//          }
            result.push({
//          result.push({
                name: `Shader Toy ${item.name}`,
//              name: `Shader Toy ${item.name}`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/shader_toy_textures/shader_toy/${item.name}`,
//              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/shader_toy_textures/shader_toy/${item.name}`,
            });
//          });
        }
//      }
        return result;
//      return result;
    }
//  }

    export async function fetchAllFonts_TTF_ITCHIO(supabase: SupabaseClient): Promise<types.CustomFont[]> { let { data } = await supabase.storage.from("fonts").list("itchio/ttf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `TTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/ttf/${item.name}`, customFontFace: null, }); } return result; }
//  export async function fetchAllFonts_TTF_ITCHIO(supabase: SupabaseClient): Promise<types.CustomFont[]> { let { data } = await supabase.storage.from("fonts").list("itchio/ttf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `TTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/ttf/${item.name}`, customFontFace: null, }); } return result; }
    export async function fetchAllFonts_OTF_ITCHIO(supabase: SupabaseClient): Promise<types.CustomFont[]> { let { data } = await supabase.storage.from("fonts").list("itchio/otf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `OTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/otf/${item.name}`, customFontFace: null, }); } return result; }
//  export async function fetchAllFonts_OTF_ITCHIO(supabase: SupabaseClient): Promise<types.CustomFont[]> { let { data } = await supabase.storage.from("fonts").list("itchio/otf", { limit: 1000 }); let result: types.CustomFont[] = []; for (let item of data ?? []) { if (item.name === ".emptyFolderPlaceholder") { continue; } if (item.name === "Divinity_Regular_1.ttf" || item.name === "Divinity_Italic_1.ttf" || item.name === "Divinity_Regular_1.otf") { continue; } result.push({ customFontName: `OTF Font: ${item.name}`, customFontPath: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/fonts/itchio/otf/${item.name}`, customFontFace: null, }); } return result; }

    export async function fetchShaderMetadata(shaderPath: string): Promise<types.GLSLUniforms> {
//  export async function fetchShaderMetadata(shaderPath: string): Promise<types.GLSLUniforms> {
        try {
//      try {
            const response: Response = await fetch(`${shaderPath}.meta.json`);
//          const response: Response = await fetch(`${shaderPath}.meta.json`);
            if (!response.ok) {
//          if (!response.ok) {
                console.warn(`Failed to fetch metadata for ${shaderPath}`);
//              console.warn(`Failed to fetch metadata for ${shaderPath}`);
                return [];
//              return [];
            }
//          }
            const data: any = await response.json();
//          const data: any = await response.json();
            const uniforms: types.GLSLUniforms = (data.shaderUniforms || []).map((u: any): types.GLSLUniform_ => {
//          const uniforms: types.GLSLUniforms = (data.shaderUniforms || []).map((u: any): types.GLSLUniform_ => {
                return {
//              return {
                    thisUniformName: u.uniformVarName,
//                  thisUniformName: u.uniformVarName,
                    thisUniformNameJustForDisplay: u.uniformDisName,
//                  thisUniformNameJustForDisplay: u.uniformDisName,
                    thisUniformType: u.uniformVarType,
//                  thisUniformType: u.uniformVarType,
                    thisUniformDefaultValue: u.uniformDefVal,
//                  thisUniformDefaultValue: u.uniformDefVal,
                    thisUniformSampler2DImg: null,
//                  thisUniformSampler2DImg: null,
                    thisUniformSampler2DEle: null,
//                  thisUniformSampler2DEle: null,
                };
//              };
            });
//          });
            return uniforms;
//          return uniforms;
        } catch (error: unknown) {
//      } catch (error: unknown) {
            console.error(error);
//          console.error(error);
            return [];
//          return [];
        }
//      }
    }
//  }

    export async function loadAsset(assetPath: string): Promise<string> {
//  export async function loadAsset(assetPath: string): Promise<string> {
        return (await fetch(assetPath)).text();
//      return (await fetch(assetPath)).text();
    }
//  }
