<script lang="ts">
  import      p5                   from "p5";
  import          "beercss"       ;
  import "material-dynamic-colors";
  import type { EditorSnapshot   } from "./types";
  import type { GLSLUniformValue } from "./types";
  import type { GLSLUniforms     } from "./types";
  import type { TextureForShader } from "./types";
  import {               onMount } from   "svelte";
  import { splitArrayIntoGroups  } from "./common";
  import { doHexToRgbNormalized  } from "./common";
  import { noHexToRgbNormalized  } from "./common";
  import { rgba_ToHexNormalized  } from "./common";
  export let canvasInstance: p5 = null!;
  export let uniforms:                   GLSLUniforms  =  [  ];
  export let onUpdate: (updatedUniforms: GLSLUniforms) => void;
  import { texturesNoise     } from "./global";
  import { texturesBayer     } from "./global";
  import { texturesPalette   } from "./global";
  import { texturesPencil_   } from "./global";
  import { texturesASCII     } from "./global";
  import { texturesTiled     } from "./global";
  import { texturesShaderToy } from "./global";
  import { editorSnapshotsUndoStack } from "./global";
  import { editorSnapshotsRedoStack } from "./global";



  // Update uniforms when a value is changed
  // Update uniforms when a value is changed
  const updateUniform = (
    key     : number
  ,    index: number | null
  , newValue: number | boolean | string
  ,
                        ): void => {
    let editorSnapshot: EditorSnapshot = {
        undo          : null,
        redo          : null,
        dynamicStorage: null,
    };
    editorSnapshot.dynamicStorage =   new Map<string, any>();
//  editorSnapshot.dynamicStorage.set("undoUniforms", uniforms);
//  editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { uniforms = dynamicStorage?.get("undoUniforms"); };
//  editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { uniforms = dynamicStorage?.get("redoUniforms"); };
    // const updatedUniforms: GLSLUniforms = { ...uniforms };
    // const updatedUniforms: GLSLUniforms = { ...uniforms };
    if (Array.isArray(uniforms[key].thisUniformDefaultValue)) {
    if (index !== null)                                       {
       editorSnapshot.dynamicStorage.set(`undo(uniforms[${key}].thisUniformDefaultValue as number[])[${index}]`
                                    ,         (uniforms[  key ].thisUniformDefaultValue as number[])[  index ]);
      (
        uniforms[key].thisUniformDefaultValue as number[])[index] = newValue as number;
       editorSnapshot.dynamicStorage.set(`redo(uniforms[${key}].thisUniformDefaultValue as number[])[${index}]`
                                    ,         (uniforms[  key ].thisUniformDefaultValue as number[])[  index ]);
       editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { (uniforms[key].thisUniformDefaultValue as number[])[index] = dynamicStorage?.get(`undo(uniforms[${key}].thisUniformDefaultValue as number[])[${index}]`); };
       editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { (uniforms[key].thisUniformDefaultValue as number[])[index] = dynamicStorage?.get(`redo(uniforms[${key}].thisUniformDefaultValue as number[])[${index}]`); };
      }
    } else                                                                  {
       editorSnapshot.dynamicStorage.set(`undoUniforms[${key}].thisUniformDefaultValue`, uniforms[key].thisUniformDefaultValue);
        uniforms[key].thisUniformDefaultValue                     = newValue          ;
       editorSnapshot.dynamicStorage.set(`redoUniforms[${key}].thisUniformDefaultValue`, uniforms[key].thisUniformDefaultValue);
       editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { uniforms[key].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${key}].thisUniformDefaultValue`); };
       editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { uniforms[key].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${key}].thisUniformDefaultValue`); };
    }
    if (                                         canvasInstance
    &&  uniforms[key].thisUniformType     ===                  "sampler2D") {
       editorSnapshot.dynamicStorage.set( `undoUniforms[${key}].thisUniformSampler2DImg`, uniforms[key].thisUniformSampler2DImg);
        uniforms[key].thisUniformSampler2DImg =  canvasInstance.loadImage (
        uniforms[key].thisUniformDefaultValue as string                   );
       editorSnapshot.dynamicStorage.set( `redoUniforms[${key}].thisUniformSampler2DImg`, uniforms[key].thisUniformSampler2DImg);
       editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { uniforms[key].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${key}].thisUniformDefaultValue`); uniforms[key].thisUniformSampler2DImg = dynamicStorage?.get(`undoUniforms[${key}].thisUniformSampler2DImg`); };
       editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { uniforms[key].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${key}].thisUniformDefaultValue`); uniforms[key].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${key}].thisUniformSampler2DImg`); };
    }
    // Trigger callback
    // Trigger callback
    onUpdate?.(uniforms);
//  editorSnapshot.dynamicStorage.set("redoUniforms", uniforms);
    editorSnapshotsUndoStack.push(
    editorSnapshot               );
  };



  let interval: NodeJS.Timeout = null!;


  const successCallback = (key: number) => (image_Instance: p5.Image): void => {
    uniforms[key].thisUniformSampler2DImg = image_Instance;
//  uniforms[key].thisUniformSampler2DImg = image_Instance;
    if (!input         ) {
//  if (!input         ) {
      return;
    }
    if (!input.files   ) {
//  if (!input.files   ) {
      return;
    }
    if (!input.files[0]) {
//  if (!input.files[0]) {
      return;
    }
    let imageObjectURL: string = window.URL.createObjectURL(input.files[0]);
//  let imageObjectURL: string = window.URL.createObjectURL(input.files[0]);
    if (!uniforms[key].thisUniformSampler2DEle) {
//  if (!uniforms[key].thisUniformSampler2DEle) {
      return;
    }
         uniforms[key].thisUniformSampler2DEle.src = imageObjectURL;
//       uniforms[key].thisUniformSampler2DEle.src = imageObjectURL;      
  };

  const failureCallback = (key: number) => (event_Instance:    Event): void => {
    if (!input         ) {
//  if (!input         ) {
      return;
    }
    if (!input.files   ) {
//  if (!input.files   ) {
      return;
    }
    if (!input.files[0]) {
//  if (!input.files[0]) {
      return;
    }
    let videoObjectURL: string = window.URL.createObjectURL(input.files[0]);
//  let videoObjectURL: string = window.URL.createObjectURL(input.files[0]);
    uniforms[key].thisUniformSampler2DImg = canvasInstance.createVideo(videoObjectURL);
    uniforms[key].thisUniformSampler2DImg.hide();
    uniforms[key].thisUniformSampler2DImg.loop();
    uniforms[key].thisUniformSampler2DImg.volume(0);
    if (!uniforms[key].thisUniformSampler2DEle) {
//  if (!uniforms[key].thisUniformSampler2DEle) {
      return;
    }
         uniforms[key].thisUniformSampler2DEle.src = videoObjectURL;
//       uniforms[key].thisUniformSampler2DEle.src = videoObjectURL;
  };

    let input: HTMLInputElement;
//  let input: HTMLInputElement;
    const onChange: (key: number) => (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => Promise<void> = (key: number) => { return async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => { const reader = new FileReader(); reader.addEventListener("load", () => { if (typeof reader.result === "string") { canvasInstance.loadImage(reader.result, successCallback(key), failureCallback(key),);
//  const onChange: (key: number) => (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => Promise<void> = (key: number) => { return async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => { const reader = new FileReader(); reader.addEventListener("load", () => { if (typeof reader.result === "string") { canvasInstance.loadImage(reader.result, successCallback(key), failureCallback(key),);
                        // console.log(reader.result);
                        // console.log(reader.result);
                  }
              });
              reader.addEventListener("abort", () => {
              });
              reader.addEventListener("error", () => {
              });
        let file                  ;
//      let file                  ;
        if (        input.files)
//      if (        input.files)
        {
            file  = input.files[0];
//          file  = input.files[0];
        }
        if (file != null) { reader.readAsDataURL(file); }
//      if (file != null) { reader.readAsDataURL(file); }
    }
  };
</script>

<div>
  {#each uniforms as { thisUniformName
   ,                   thisUniformNameJustForDisplay
   ,                   thisUniformType
   ,                   thisUniformDefaultValue
   ,                   thisUniformSampler2DImg
   ,                   thisUniformSampler2DEle
   ,                 }
   ,              ii ( thisUniformName )
  }
    <div class="container">
      <span>{thisUniformNameJustForDisplay ?? thisUniformName} ({thisUniformType}):</span>
      <div class="space"></div>
      <!-- Render inputs based on type -->
      {#if ((thisUniformType ?? "").startsWith( "vec")
        ||  (thisUniformType ?? "").startsWith("ivec")
        ||  (thisUniformType ?? "").startsWith("uvec"))
        &&   thisUniformDefaultValue instanceof Array
      }
        <table class="center-align">
          <thead>
            <tr>
              {#if thisUniformDefaultValue.length >= 2}
                <th class="border">*</th>
                <th class="border">x</th>
                <th class="border">y</th>
              {/if}
              {#if thisUniformDefaultValue.length >= 3}
                <th class="border">z</th>
              {/if}
              {#if thisUniformDefaultValue.length >= 4}
                <th class="border">a</th>
              {/if}
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="border">
                <!-- svelte-ignore a11y_consider_explicit_label -->
                <!-- svelte-ignore a11y_consider_explicit_label -->
                <button class="circle slow-ripple large-elevate"><i class="fa-solid fa-palette"></i><input id={`${thisUniformName}-color-button`} type="color" on:input={ async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => {
                    const { r, g, b } = await doHexToRgbNormalized(e.currentTarget.value);
//                  const { r, g, b } = await doHexToRgbNormalized(e.currentTarget.value);
                    updateUniform(ii, 0, r);
                    updateUniform(ii, 1, g);
                    updateUniform(ii, 2, b);
                      }}>
                </button>
              </td>
              {#each thisUniformDefaultValue as v, i}
                <td class="border">
                  <div class="s2 field small">
                    <input
                      type="number"
                      step="0.0100"
                        value={       v                                                                 }
                      on:input={async (e) => { updateUniform(ii, i, parseFloat(e.currentTarget.value));
                  const input: HTMLInputElement = document.getElementById(`${thisUniformName}-color-button`) as HTMLInputElement;
                        input.value = (await rgba_ToHexNormalized(255 * (thisUniformDefaultValue[0] ?? 1.0)
                              ,                                    255 * (thisUniformDefaultValue[1] ?? 1.0)
                              ,                                    255 * (thisUniformDefaultValue[2] ?? 1.0)
                              ,                                    255 * (thisUniformDefaultValue[3] ?? 1.0))).slice(+0
                                                                                                              ,      -2
                                                                                                              ,     ); }}
                    />
                  </div>
                </td>
              {/each}
            </tr>
          </tbody>
        </table>
        <div class="space"></div>
      {:else if (thisUniformType ?? ""). startsWith("mat")
             &&  thisUniformDefaultValue instanceof Array
      }
        {#if                          thisUniformDefaultValue.length === 4           }
          <table class="center-align">
            <thead>
              <tr>
                <th> </th>
                <th class="border">0</th>
                <th class="border">1</th>
              </tr>
            </thead>
            <tbody>
              {#each splitArrayIntoGroups(thisUniformDefaultValue         ,  2) as r, ri }
                <tr>
                  {#if ri === 0}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>X</span>
                    </td>
                  {/if}
                  {#if ri === 1}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>Y</span>
                    </td>
                  {/if}
                  {#each r as c, ci }
                    <td class="border">
                      <div class="s2 field small">
                        <input
                          type="number"
                          step="0.0100"
                            value={       c                                                                           }
                          on:input={async (e) => { updateUniform(ii, ri * 2 + ci, parseFloat(e.currentTarget.value)); }}
                        />
                      </div>
                    </td>
                  {/each}
                </tr>
              {/each}
            </tbody>
          </table>
        {/if}
        {#if                          thisUniformDefaultValue.length === 9           }
          <table class="center-align">
            <thead>
              <tr>
                <th> </th>
                <th class="border">0</th>
                <th class="border">1</th>
                <th class="border">2</th>
              </tr>
           </thead>
            <tbody>
              {#each splitArrayIntoGroups(thisUniformDefaultValue         ,  3) as r, ri }
                <tr>
                  {#if ri === 0}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>X</span>
                    </td>
                  {/if}
                  {#if ri === 1}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>Y</span>
                    </td>
                  {/if}
                  {#if ri === 2}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>Z</span>
                    </td>
                  {/if}
                  {#each r as c, ci }
                    <td class="border">
                      <div class="s2 field small">
                        <input
                        type="number"
                        step="0.0100"
                           value={       c                                                                           }
                        on:input={async (e) => { updateUniform(ii, ri * 3 + ci, parseFloat(e.currentTarget.value)); }}
                        />
                      </div>
                    </td>
                  {/each}
                </tr>
              {/each}
            </tbody>
          </table>
        {/if}
        {#if                          thisUniformDefaultValue.length === 16          }
          <table class="center-align">
            <thead>
              <tr>
                <th> </th>
                <th class="border">0</th>
                <th class="border">1</th>
                <th class="border">2</th>
                <th class="border">3</th>
              </tr>
            </thead>
            <tbody>
              {#each splitArrayIntoGroups(thisUniformDefaultValue         ,  4) as r, ri }
                <tr>
                  {#if ri === 0}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>X</span>
                    </td>
                  {/if}
                  {#if ri === 1}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>Y</span>
                    </td>
                  {/if}
                  {#if ri === 2}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>Z</span>
                    </td>
                  {/if}
                  {#if ri === 3}
                    <td class="border">
                      <!-- svelte-ignore node_invalid_placement_ssr -->
                      <span>A</span>
                    </td>
                  {/if}
                  {#each r as c, ci }
                    <td class="border">
                      <div class="s2 field small">
                        <input
                          type="number"
                          step="0.0100"
                            value={       c                                                                           }
                          on:input={async (e) => { updateUniform(ii, ri * 4 + ci, parseFloat(e.currentTarget.value)); }}
                        />
                      </div>
                    </td>
                  {/each}
                </tr>
              {/each}
            </tbody>
          </table>
        {/if}
        <div class="space"></div>
      {:else if       (thisUniformType  ??  "") === "bool   ".trim()
             && typeof thisUniformDefaultValue  === "boolean"       }
        <label  class="switch center-align">
          <input
            type="checkbox"
                  checked={                                       thisUniformDefaultValue    }
                on:change={async (e) => { updateUniform(ii, null, e.currentTarget.checked); }}
          />
          <span>
            <i></i>
            <i></i>
          </span>
        </label>
        <div class="space"></div>
      {:else if (thisUniformType ?? "") === "float"
             || (thisUniformType ?? "") ===        "int"
             || (thisUniformType ?? "") ===             "uint"}
        <div      class="row    center-align middle-align        " >
          <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
          <button class="circle        small        large-elevate"
          on:mousedown ={async (e) => { interval = setInterval(() => { if (typeof(thisUniformDefaultValue) === "number") { updateUniform(ii, null, thisUniformDefaultValue - 0.00001); } }, 75); }}
          on:mouseout  ={async (e) => { clearInterval(interval); }}
          on:mouseup   ={async (e) => { clearInterval(interval); }}
          on:mouseleave={async (e) => { clearInterval(interval); }}><i class="fa-solid fa-caret-left "></i></button >
          <div class="s2 field small border min">
            <input
              type="number"
              step="1.0000"
                 value={thisUniformDefaultValue}
              on:input={(e) =>
              updateUniform  (
                   ii ,
                  null,
                  (thisUniformType ?? "") === "int" || (thisUniformType ?? "") === "uint"
                    ? parseInt  (e.currentTarget.value)
                    : parseFloat(e.currentTarget.value)
                             )
                       }
            />
          </div>
          <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
          <button class="circle small large-elevate"
            on:mousedown ={async (e) => { interval = setInterval(() => { if (typeof(thisUniformDefaultValue) === "number") { updateUniform(ii, null, thisUniformDefaultValue + 0.00001); } }, 75); }}
            on:mouseout  ={async (e) => { clearInterval(interval); }}
            on:mouseup   ={async (e) => { clearInterval(interval); }}
            on:mouseleave={async (e) => { clearInterval(interval); }}><i class="fa-solid fa-caret-right"></i></button >
        </div>
        <div class="space"></div>
      {:else if ((thisUniformType ?? "") === "sampler2D"
             ||  (thisUniformType ?? "") === "sampler3D")
             &&                               typeof     thisUniformDefaultValue === "string"}
        <!-- <span>sampler2D (not editable)</span> -->
        <!-- <span>sampler2D (not editable)</span> -->
        <div class="max center-align">
          <img class="small-width small-height"       src={thisUniformDefaultValue}
                                                      alt=""
                                              bind:this={thisUniformSampler2DEle}/>
        </div>
        
        <!-- {#if (thisUniformName ?? "").startsWith("noise")}
        <!-- {#if (thisUniformName ?? "").startsWith("noise")}
        {:else if (thisUniformName ?? "").startsWith("bayer")}
        {:else if (thisUniformName ?? "").startsWith("palette")}
        {/if} -->
        {#if (thisUniformName ?? "").startsWith("upload")}
        <form action=""><input bind:this={input} on:change={onChange(ii)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate"><i class="fas fa-paperclip"></i><span>Load Image Or Video</span></button></form>
<!--    <form action=""><input bind:this={input} on:change={onChange(ii)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate"><i class="fas fa-paperclip"></i><span>Load Image Or Video</span></button></form>    -->
        {:else}
        <div class="field label suffix round border">
          <select on:change={async (e) => {
            let chosen =            e.currentTarget.options[e.currentTarget.selectedIndex].value;
            if (chosen === "none") {
//            uniforms[ii].thisUniformDefaultValue = null;
              uniforms[ii].thisUniformSampler2DImg = null;
              return;
            }
            if (thisUniformSampler2DEle)  {
                thisUniformSampler2DEle.src = chosen;
            }
            updateUniform(ii, null, chosen);
          }}>
            {#each ((thisUniformName ?? "").startsWith("noise"    ) ? $texturesNoise     : 
                    (thisUniformName ?? "").startsWith("bayer"    ) ? $texturesBayer     : 
                    (thisUniformName ?? "").startsWith("palette"  ) ? $texturesPalette   : 
                    (thisUniformName ?? "").startsWith("pencil"   ) ? $texturesPencil_   :
                    (thisUniformName ?? "").startsWith("ascii"    ) ? $texturesASCII     :
                    (thisUniformName ?? "").startsWith("tiled"    ) ? $texturesTiled     :
                    (thisUniformName ?? "").startsWith("shaderToy") ? $texturesShaderToy :
                    [{ name: "none", path: "none", }]) as textureForShader
                                                         (textureForShader)
            }
                   <option value={textureForShader.path}>{textureForShader.name}</option>
            {/each}
          </select>
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <!-- svelte-ignore a11y-label-has-associated-control -->
          <label>Texture For Shader</label>
          <i class="fa-solid fa-chevron-down"></i>
<!--      <i class="fa-solid fa-chevron-down"></i>      -->
        </div>
        {/if}
        <div class="space"></div>  
      {:else}
        <span>Unsupported type</span>
      {/if}
    </div>
    <!-- <div class="large-space"></div> -->
    <!-- <div class="large-space"></div> -->
  {/each}
</div>

<style>
  .container{
    display: flex;
    flex-direction: column;
  }
</style>




