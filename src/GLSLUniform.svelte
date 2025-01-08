<script lang="ts">
  import p5 from "p5";
  import          "beercss"       ;
  import "material-dynamic-colors";
  import type { GLSLUniformValue, GLSLUniforms } from "./types";
import {onMount} from "svelte";


  export let canvasInstance: p5 = null!;
  export let uniforms:                   GLSLUniforms  =  [  ];
  export let onUpdate: (updatedUniforms: GLSLUniforms) => void;

  import { createClient, SupabaseClient } from '@supabase/supabase-js'


  type TextureForShader = {
    name: string,
    path: string,
  }

  const fetchAllTextures_BayerMatrix = (): TextureForShader[] => {
    let ns: number[] = [2,4,8,16];
    let result: TextureForShader[] = [];
    ns.forEach(n1 => {
      result.push(
        {
          name: `bayer${n1}.png`,
          path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}.png`,
        }
      );
      ns.forEach(n2 => {
        result.push(
          {
            name: `bayer${n1}tile${n2}.png`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}tile${n2}.png`,
          }
        );
      });
    });
    return result;
  }

  const fetchAllTextures_Noise = (): TextureForShader[] => {
    let pathsA: {path1: string, path2: string}[] = [
      {path1: "sbs_-_noise_texture_pack_-_128x128", path2: "128x128"},
      {path1: "sbs_-_noise_texture_pack_-_256x256", path2: "256x256"},
      {path1: "sbs_-_noise_texture_pack_-_512x512", path2: "512x512"},
    ];
    let pathsB: {path3: string, min: number, max: number}[] = [
      {path3: "Cracks"      , min: 1, max: 14},
      {path3: "Craters"     , min: 1, max: 14},
      {path3: "Gabor"       , min: 1, max: 14},
      {path3: "Grainy"      , min: 1, max: 14},
      {path3: "Manifold"    , min: 1, max: 14},
      {path3: "Marble"      , min: 1, max: 14},
      {path3: "Melt"        , min: 1, max: 14},
      {path3: "Milky"       , min: 1, max: 14},
      {path3: "Perlin"      , min: 1, max: 24},
      {path3: "Spokes"      , min: 1, max: 14},
      {path3: "Streak"      , min: 1, max: 14},
      {path3: "Super Noise" , min: 1, max: 14},
      {path3: "Super Perlin", min: 1, max: 14},
      {path3: "Swirl"       , min: 1, max: 14},
      {path3: "Techno"      , min: 1, max: 14},
      {path3: "Turbulence"  , min: 1, max: 14},
      {path3: "Vein"        , min: 1, max: 14},
      {path3: "Voronoi"     , min: 1, max: 14},
    ];
    let result:TextureForShader[] = [];
    for (let pathA of pathsA) {
      for (let pathB of pathsB) {
        for (let n = pathB.min; n <= pathB.max; ++n) {
          result.push(
            {
              name: `${pathB.path3} ${n} - ${pathA.path2}.png`,
              path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/noise_textures/${pathA.path1}/${pathA.path2}/${pathB.path3}/${pathB.path3} ${n} - ${pathA.path2}.png`,
            }
          );
        }
      }
    }
    return result;
  }


  const fetchAllTextures_Palette = async (supabase: SupabaseClient): Promise<TextureForShader[]> => {
    let {data,error} = await supabase.storage.from("palette_textures").list("lospec");
    let result: TextureForShader[] = [];
    for (let item of data ?? []) {
      if (item.name === ".emptyFolderPlaceholder") {
        continue;
      }
      result.push({
        name: `${item.name}`,
        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/palette_textures/lospec/${item.name}`,
      });
    }
    return result;
  } 

  const fetchAllTextures_Pencil = async (supabase: SupabaseClient): Promise<TextureForShader[]> => {
    let {data, error} = await supabase.storage.from("pencil_textures").list("godot");
    let result: TextureForShader[] = [];
    for (let item of data ?? []) {
      if (item.name === ".emptyFolderPlaceholder") {
        continue;
      }
      result.push({
        name: `Pencil ${item.name}`,
        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/pencil_textures/godot/${item.name}`,
      });
    }
    return result;
  }

  const fetchAllTextures_ASCII = async (supabase: SupabaseClient): Promise<TextureForShader[]> => {
    let {data, error} = await supabase.storage.from("ascii_textures").list("godot");
    let result: TextureForShader[] = [];
    for (let item of data ?? []) {
      if (item.name === ".emptyFolderPlaceholder") {
        continue;
      }
      result.push({
        name: `ASCII ${item.name}`,
        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/ascii_textures/godot/${item.name}`,
      });
    }
    return result;
  }

  const fetchAllTextures_Tiled = async (supabase: SupabaseClient): Promise<TextureForShader[]> => {
    let {data, error} = await supabase.storage.from("tiled_textures").list("godot");
    let result: TextureForShader[] = [];
    for (let item of data ?? []) {
      if (item.name === ".emptyFolderPlaceholder") {
        continue;
      }
      result.push({
        name: `Tiled ${item.name}`,
        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/tiled_textures/godot/${item.name}`,
      });
    }
    return result;
  }

  const fetchAllTextures_ShaderToy = async (supabase: SupabaseClient): Promise<TextureForShader[]> => {
    let {data, error} = await supabase.storage.from("shader_toy_textures").list("shader_toy");
    let result: TextureForShader[] = [];
    for (let item of data ?? []) {
      if (item.name === ".emptyFolderPlaceholder") {
        continue;
      }
      result.push({
        name: `Shader Toy ${item.name}`,
        path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/shader_toy_textures/shader_toy/${item.name}`,
      });
    }
    return result;
  }

  let imageElement: HTMLImageElement;
  let texturesNoise: Array<TextureForShader> = [{ name: "none", path: "none", }];
  let texturesBayer: Array<TextureForShader> = [{ name: "none", path: "none", }];
  let texturespalette: Array<TextureForShader> = [{ name: "none", path: "none", }];
  let texturesPencil: Array<TextureForShader> = [{ name: "none", path: "none", }];
  let texturesASCII: Array<TextureForShader> = [{ name: "none", path: "none", }];
  let texturesTiled: Array<TextureForShader> = [{ name: "none", path: "none", }];
  let texturesShaderToy: Array<TextureForShader> = [{ name: "none", path: "none", }];

onMount(async () => {
  const supabase = createClient(import.meta.env.VITE_SUPABASE_URL
, import.meta.env.VITE_SUPABASE_KEY_PUB);

  // let publicUrls = [];
  // for (let item of (await supabase.storage.from("noise_textures").list()).data ?? [])
  // {
       
  // }

  // let result = await supabase.storage.from("noise_textures").list("sbs_-_noise_texture_pack_-_128x128", {
  //   // limit: 100,
  //   // offset: 0,
  //   // sortBy: { column: 'name', order: 'asc' },
  // });
  // console.dir(result.data, { depth: null, colors: true })

  console.dir(await fetchAllTextures_Palette(supabase), { depth: null, colors: true })

  texturesNoise = [... texturesNoise, ... await fetchAllTextures_Noise()];
  texturesBayer = [... texturesBayer, ... await fetchAllTextures_BayerMatrix()];
  texturespalette = [... texturespalette, ... await fetchAllTextures_Palette(supabase)];
  texturesPencil = [... texturesPencil, ... await fetchAllTextures_Pencil(supabase)];
  texturesASCII = [... texturesASCII, ... await fetchAllTextures_ASCII(supabase)];
  texturesTiled = [... texturesTiled, ... await fetchAllTextures_Tiled(supabase)];
  texturesShaderToy = [... texturesShaderToy, ... await fetchAllTextures_ShaderToy(supabase)];
});

  // const getType = (value: GLSLUniformValue): string => {
  //   if (Array.isArray(value)) {
  //     if (value.length ===  2) return "vec2";
  //     if (value.length ===  3) return "vec3";
  //     if (value.length ===  4) return "vec4";
  //     if (value.length ===  9) return "mat3";
  //     if (value.length === 16) return "mat4";
  //   }
  //   if (typeof value === "boolean") return "bool";
  //   if (typeof value === "number" && !Number.isInteger(value)) return "float";
  //   if (typeof value === "number" &&  Number.isInteger(value)) return       "int";
  //   if (typeof value === "string"                            ) return "sampler2D";
  //   return "unknown";
  // };

  // Update uniforms when a value is changed
  const updateUniform = (
    key: number,
    index: number | null,
    newValue: number | boolean | string,
  ): void => {
    // const updatedUniforms: GLSLUniforms = { ...uniforms };
    if (Array.isArray(uniforms[key].thisUniformDefaultValue)) {
      if (index !== null)
        (uniforms[key].thisUniformDefaultValue as number[])[index] = newValue as number;
    } else {
      uniforms[key].thisUniformDefaultValue = newValue;
    }
    if (canvasInstance && uniforms[key].thisUniformType === "sampler2D") {
      uniforms[key].thisUniformSampler2DImg = canvasInstance.loadImage(uniforms[key].thisUniformDefaultValue as string);
    }
    onUpdate?.(uniforms); // Trigger callback
  };

  function splitArrayIntoGroups(array: number[], groupSize:number): number[][] {
  return array.reduce((result: number[][], value: number, index: number) => {
    if (index % groupSize === 0) {
      result.push([]);
    }
    result[result.length - 1].push(value);
    return result;
  }, []);
}

  let interval:NodeJS.Timeout;
</script>

<div>
  {#each uniforms as {thisUniformName, thisUniformNameJustForDisplay, thisUniformType, thisUniformDefaultValue}, ii (thisUniformName)}
    <div>
      <strong>{thisUniformNameJustForDisplay ?? thisUniformName} ({thisUniformType}):</strong>
      <!-- Render inputs based on type -->
      {#if ((thisUniformType ?? "").startsWith("vec") || (thisUniformType ?? "").startsWith("ivec") || (thisUniformType ?? "").startsWith("uvec")) && thisUniformDefaultValue instanceof Array}
        <table class="center-align">
          <thead>
            <tr>
              {#if thisUniformDefaultValue.length >= 2}
                <th>x</th>
                <th>y</th>
              {/if}
              {#if thisUniformDefaultValue.length >= 3}
                <th>z</th>
              {/if}
              {#if thisUniformDefaultValue.length >= 4}
                <th>a</th>
              {/if}
            </tr>
          </thead>
          <tbody>
            <tr>
              {#each thisUniformDefaultValue as v, i}
                <td class="s2 field small border">
                  <input
                    type="number"
                    step="0.01"
                    value={v}
                    on:input={(e) =>
                      updateUniform(ii, i, parseFloat(e.currentTarget.value))}
                  />
                </td>
              {/each}
            </tr>
          </tbody>
        </table>
      {:else if (thisUniformType ?? "").startsWith("mat") && thisUniformDefaultValue instanceof Array}
        {#if thisUniformDefaultValue.length === 4}
          {#each splitArrayIntoGroups(thisUniformDefaultValue,2) as r, ri }
            <table class="center-align">
              <thead>
                <tr>
                  {#if ri === 0}
                    <th>x0</th>
                    <th>x1</th>
                  {/if}
                  {#if ri === 1}
                    <th>y0</th>
                    <th>y1</th>
                  {/if}
                </tr>
              </thead>
              <tbody>
                <tr>
                  {#each r as c, ci }
                    <td class="s2 field small border">
                      <input
                        type="number"
                        step="0.01"
                        value={c}
                        on:input={(e) =>
                        updateUniform(ii, ri * 2 + ci, parseFloat(e.currentTarget.value))}
                      />
                    </td>
                  {/each}
                </tr>
              </tbody>
            </table>
          {/each}
        {/if}
        {#if thisUniformDefaultValue.length === 9}
          {#each splitArrayIntoGroups(thisUniformDefaultValue,3) as r, ri }
            <table class="center-align">
              <thead>
                <tr>
                  {#if ri === 0}
                    <th>x0</th>
                    <th>x1</th>
                    <th>x2</th>
                  {/if}
                  {#if ri === 1}
                    <th>y0</th>
                    <th>y1</th>
                    <th>y2</th>
                  {/if}
                  {#if ri ===2}
                    <th>z0</th>
                    <th>z1</th>
                    <th>z2</th>
                  {/if}
                </tr>
              </thead>
              <tbody>
                <tr>
                  {#each r as c, ci }
                    <td class="s2 field small border">
                      <input
                        type="number"
                        step="0.01"
                        value={c}
                        on:input={(e) =>
                        updateUniform(ii, ri * 3 + ci, parseFloat(e.currentTarget.value))}
                      />
                    </td>
                  {/each}
                </tr>
              </tbody>
            </table>
          {/each}
        {/if}
        {#if thisUniformDefaultValue.length === 16}
          {#each splitArrayIntoGroups(thisUniformDefaultValue,4) as r, ri }
            <table>
              <thead>
                <tr>
                  {#if ri === 0}
                    <th>x0</th>
                    <th>x1</th>
                    <th>x2</th>
                    <th>x3</th>
                  {/if}
                  {#if ri === 1}
                    <th>y0</th>
                    <th>y1</th>
                    <th>y2</th>
                    <th>y3</th>
                  {/if}
                  {#if ri === 2}
                    <th>z0</th>
                    <th>z1</th>
                    <th>z2</th>
                    <th>z3</th>
                  {/if}
                  {#if ri === 3}
                    <th>a0</th>
                    <th>a1</th>
                    <th>a2</th>
                    <th>a3</th>
                  {/if}
                </tr>
              </thead>
              <tbody>
                <tr>
                  {#each r as c, ci }
                    <td class="s2 field small border">
                      <input
                        type="number"
                        step="0.01"
                        value={c}
                        on:input={(e) =>
                        updateUniform(ii, ri * 4 + ci, parseFloat(e.currentTarget.value))}
                      />
                    </td>
                  {/each}
                </tr>
              </tbody>
            </table>
          {/each}
        {/if}
      {:else if (thisUniformType ?? "") === "bool" && typeof thisUniformDefaultValue === "boolean"}
        <label class="switch">
          <input
            type="checkbox"
            checked={thisUniformDefaultValue}
            on:change={(e) => updateUniform(ii, null, e.currentTarget.checked)}
          />
          <span>
            <i></i>
            <i></i>
          </span>
        </label>
      {:else if (thisUniformType ?? "") === "float" || (thisUniformType ?? "") === "int" || (thisUniformType ?? "") === "uint"}
        <div class="grid">
          <div class="s2 field small border">
            <input
              type="number"
              step="1"
              value={thisUniformDefaultValue}
              on:input={(e) =>
                updateUniform(
                  ii,
                  null,
                  (thisUniformType ?? "") === "int" || (thisUniformType ?? "") === "uint"
                    ? parseInt  (e.currentTarget.value)
                    : parseFloat(e.currentTarget.value),
                )}
            />
          </div>
          <div      class="center center-align">
            <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
            <button class="circle        small"
            on:mousedown ={async (e) => { interval = setInterval(() => { if (typeof(thisUniformDefaultValue) === "number") { updateUniform(ii, null, thisUniformDefaultValue - 0.00001); } }, 75); }}
            on:mouseout  ={async (e) => { clearInterval(interval); }}
            on:mouseup   ={async (e) => { clearInterval(interval); }}
            on:mouseleave={async (e) => { clearInterval(interval); }}><i class="fa-solid fa-caret-left "></i></button >
            <div class="space"></div>
            <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
            <button class="circle        small"
            on:mousedown ={async (e) => { interval = setInterval(() => { if (typeof(thisUniformDefaultValue) === "number") { updateUniform(ii, null, thisUniformDefaultValue + 0.00001); } }, 75); }}
            on:mouseout  ={async (e) => { clearInterval(interval); }}
            on:mouseup   ={async (e) => { clearInterval(interval); }}
            on:mouseleave={async (e) => { clearInterval(interval); }}><i class="fa-solid fa-caret-right"></i></button >
          </div>
        </div>
      {:else if ((thisUniformType ?? "") === "sampler2D" || (thisUniformType ?? "") === "sampler3D") && typeof thisUniformDefaultValue === "string"}
        <!-- <span>sampler2D (not editable)</span> -->
        <img class="small-width small-height" src={thisUniformDefaultValue} alt="" bind:this={imageElement}/>
        <!-- {#if (thisUniformName ?? "").startsWith("noise")}
          
        {:else if (thisUniformName ?? "").startsWith("bayer")}
        {:else if (thisUniformName ?? "").startsWith("palette")}
        {/if} -->
        <div class="field label suffix round border">
          <select on:change={async (e) => {
            let chosen = e.currentTarget.options[e.currentTarget.selectedIndex].value;
            if (chosen === "none") {
              uniforms[ii].thisUniformDefaultValue = null;
              uniforms[ii].thisUniformSampler2DImg = null;
              return;
            }
            imageElement.src = chosen;
            updateUniform(ii, null, chosen);
          }}>
            {#each ((thisUniformName ?? "").startsWith("noise") ? texturesNoise : 
                    (thisUniformName ?? "").startsWith("bayer") ? texturesBayer : 
                    (thisUniformName ?? "").startsWith("palette") ? texturespalette : 
                    (thisUniformName ?? "").startsWith("pencil") ? texturesPencil :
                    (thisUniformName ?? "").startsWith("ascii") ? texturesASCII :
                    (thisUniformName ?? "").startsWith("tiled") ? texturesTiled :
                    (thisUniformName ?? "").startsWith("shaderToy") ? texturesShaderToy :
                    [{ name: "none", path: "none", }]) as textureForShader (textureForShader)}
              <option value={textureForShader.path}>{textureForShader.name}</option>            
            {/each}
          </select>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label>Texture For Shader</label>
          <i class="fa-solid fa-chevron-down"></i>
      </div>

      {:else}
        <span>Unsupported type</span>
      {/if}
    </div>
    <div class="large-space"></div>
    <div class="large-space"></div>
  {/each}
</div>




