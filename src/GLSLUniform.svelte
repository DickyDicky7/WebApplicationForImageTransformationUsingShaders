<svelte:options runes={true}></svelte:options>
<script lang="ts">
    import "beercss";
//  import "beercss";
    import "material-dynamic-colors";
//  import "material-dynamic-colors";
    import p5 from "p5";
//  import p5 from "p5";
    import * as types from "./types";
//  import * as types from "./types";
    import * as svelte from "svelte";
//  import * as svelte from "svelte";
    import * as common from "./common";
//  import * as common from "./common";
    import * as global from "./global.svelte";
//  import * as global from "./global.svelte";
    import svelteSvg from "./assets/svelte.svg";
//  import svelteSvg from "./assets/svelte.svg";

    let { canvasInstance = $bindable(), uniforms = $bindable([]), onUpdate, } : { canvasInstance: p5, uniforms: types.GLSLUniforms, onUpdate: (updatedUniforms: types.GLSLUniforms) => void, } = $props<{
//  let { canvasInstance = $bindable(), uniforms = $bindable([]), onUpdate, } : { canvasInstance: p5, uniforms: types.GLSLUniforms, onUpdate: (updatedUniforms: types.GLSLUniforms) => void, } = $props<{
        canvasInstance: p5;
//      canvasInstance: p5;
        uniforms: types.GLSLUniforms;
//      uniforms: types.GLSLUniforms;
        onUpdate: (updatedUniforms: types.GLSLUniforms) => void;
//      onUpdate: (updatedUniforms: types.GLSLUniforms) => void;
    }>();
//  }>();

    // State
//  // State
    let interval: NodeJS.Timeout | undefined = $state<NodeJS.Timeout>();
//  let interval: NodeJS.Timeout | undefined = $state<NodeJS.Timeout>();
    let input: HTMLInputElement | undefined = $state<HTMLInputElement>();
//  let input: HTMLInputElement | undefined = $state<HTMLInputElement>();

    // Helper for matrix indices
//  // Helper for matrix indices
    const getMatrixIndex = (rowIndex: number, colIndex: number, colCount: number) => rowIndex * colCount + colIndex;
//  const getMatrixIndex = (rowIndex: number, colIndex: number, colCount: number) => rowIndex * colCount + colIndex;

    // Update uniforms when a value is changed
//  // Update uniforms when a value is changed
    const updateUniform = async (
//  const updateUniform = async (
        uniformIndex: number,
//      uniformIndex: number,
        elementIndex: number | null,
//      elementIndex: number | null,
        newValue: number | boolean | string,
//      newValue: number | boolean | string,
    ): Promise<void> => {
//  ): Promise<void> => {
        let editorSnapshot: types.EditorSnapshot = {
//      let editorSnapshot: types.EditorSnapshot = {
            undo          : null,
//          undo          : null,
            redo          : null,
//          redo          : null,
            dynamicStorage: null,
//          dynamicStorage: null,
        };
//      };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        if (Array.isArray(uniforms[uniformIndex].thisUniformDefaultValue)) {
//      if (Array.isArray(uniforms[uniformIndex].thisUniformDefaultValue)) {
            if (elementIndex) {
//          if (elementIndex) {
                editorSnapshot.dynamicStorage.set(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
//              editorSnapshot.dynamicStorage.set(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
                (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = newValue as number;
//              (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = newValue as number;
                editorSnapshot.dynamicStorage.set(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
//              editorSnapshot.dynamicStorage.set(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
                editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
//              editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
                editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
//              editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
            }
//          }
        } else {
//      } else {
            editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`, uniforms[uniformIndex].thisUniformDefaultValue);
//          editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`, uniforms[uniformIndex].thisUniformDefaultValue);
            uniforms[uniformIndex].thisUniformDefaultValue = newValue;
//          uniforms[uniformIndex].thisUniformDefaultValue = newValue;
            editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`, uniforms[uniformIndex].thisUniformDefaultValue);
//          editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`, uniforms[uniformIndex].thisUniformDefaultValue);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
        }
//      }
        if (canvasInstance && uniforms[uniformIndex].thisUniformType === "sampler2D") {
//      if (canvasInstance && uniforms[uniformIndex].thisUniformType === "sampler2D") {
            editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformSampler2DImg`, uniforms[uniformIndex].thisUniformSampler2DImg);
//          editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformSampler2DImg`, uniforms[uniformIndex].thisUniformSampler2DImg);
            uniforms[uniformIndex].thisUniformSampler2DImg = await canvasInstance.loadImage(uniforms[uniformIndex].thisUniformDefaultValue as string);
//          uniforms[uniformIndex].thisUniformSampler2DImg = await canvasInstance.loadImage(uniforms[uniformIndex].thisUniformDefaultValue as string);
            editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`, uniforms[uniformIndex].thisUniformSampler2DImg);
//          editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`, uniforms[uniformIndex].thisUniformSampler2DImg);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
        }
//      }
        // Trigger callback
//      // Trigger callback
        onUpdate?.(uniforms);
//      onUpdate?.(uniforms);
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    };
//  };

    const successCallback = (key: number) => (image_Instance: p5.Image): void => {
//  const successCallback = (key: number) => (image_Instance: p5.Image): void => {
        uniforms[key].thisUniformSampler2DImg = image_Instance;
//      uniforms[key].thisUniformSampler2DImg = image_Instance;
        if (!input || !input.files || !input.files[0]) { return; }
//      if (!input || !input.files || !input.files[0]) { return; }
        let imageObjectURL: string = window.URL.createObjectURL(input.files[0]);
//      let imageObjectURL: string = window.URL.createObjectURL(input.files[0]);
        if (!uniforms[key].thisUniformSampler2DEle) { return; }
//      if (!uniforms[key].thisUniformSampler2DEle) { return; }
        uniforms[key].thisUniformSampler2DEle.src = imageObjectURL;
//      uniforms[key].thisUniformSampler2DEle.src = imageObjectURL;
    };
//  };

    const failureCallback = (key: number) => (event_Instance: Event): void => {
//  const failureCallback = (key: number) => (event_Instance: Event): void => {
        if (!input || !input.files || !input.files[0]) { return; }
//      if (!input || !input.files || !input.files[0]) { return; }
        let videoObjectURL: string = window.URL.createObjectURL(input.files[0]);
//      let videoObjectURL: string = window.URL.createObjectURL(input.files[0]);
        uniforms[key].thisUniformSampler2DImg = canvasInstance.createVideo(videoObjectURL);
//      uniforms[key].thisUniformSampler2DImg = canvasInstance.createVideo(videoObjectURL);
        uniforms[key].thisUniformSampler2DImg.hide();
//      uniforms[key].thisUniformSampler2DImg.hide();
        uniforms[key].thisUniformSampler2DImg.loop();
//      uniforms[key].thisUniformSampler2DImg.loop();
        uniforms[key].thisUniformSampler2DImg.volume(0);
//      uniforms[key].thisUniformSampler2DImg.volume(0);
        if (!uniforms[key].thisUniformSampler2DEle) { return; }
//      if (!uniforms[key].thisUniformSampler2DEle) { return; }
        uniforms[key].thisUniformSampler2DEle.src = videoObjectURL;
//      uniforms[key].thisUniformSampler2DEle.src = videoObjectURL;
    };
//  };

    const onChange = (key: number) => async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => {
//  const onChange = (key: number) => async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => {
        const reader = new FileReader();
//      const reader = new FileReader();
        reader.addEventListener("load", async (): Promise<void> => {
//      reader.addEventListener("load", async (): Promise<void> => {
            if (typeof reader.result === "string") {
//          if (typeof reader.result === "string") {
                await canvasInstance.loadImage(reader.result, successCallback(key), failureCallback(key));
//              await canvasInstance.loadImage(reader.result, successCallback(key), failureCallback(key));
            }
//          }
        }, false);
//      }, false);
        const file = input?.files?.[0];
//      const file = input?.files?.[0];
        if (file) {
//      if (file) {
            reader.readAsDataURL(file);
//          reader.readAsDataURL(file);
        }
//      }
    };
//  };

    // Handlers
//  // Handlers
    const handleColorInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> => {
//  const handleColorInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> => {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        const { r, g, b } = await common.doHexToRgbNormalized(ele.value);
//      const { r, g, b } = await common.doHexToRgbNormalized(ele.value);
        await updateUniform(uniformIndex, 0, r);
//      await updateUniform(uniformIndex, 0, r);
        await updateUniform(uniformIndex, 1, g);
//      await updateUniform(uniformIndex, 1, g);
        await updateUniform(uniformIndex, 2, b);
//      await updateUniform(uniformIndex, 2, b);
    };
//  };

    const handleVectorInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number, uniformName: string | null, uniformDefault: number[]): Promise<void> => {
//  const handleVectorInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number, uniformName: string | null, uniformDefault: number[]): Promise<void> => {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        await updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
//      await updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
        if (!uniformName) { return; }
//      if (!uniformName) { return; }
        const colorInput: HTMLInputElement = document.getElementById(`${uniformName}-color-button`) as HTMLInputElement;
//      const colorInput: HTMLInputElement = document.getElementById(`${uniformName}-color-button`) as HTMLInputElement;
        if (colorInput) {
//      if (colorInput) {
            colorInput.value = (await common.rgba_ToHexNormalized(
//          colorInput.value = (await common.rgba_ToHexNormalized(
                255 * (uniformDefault[0] ?? 1.0),
//              255 * (uniformDefault[0] ?? 1.0),
                255 * (uniformDefault[1] ?? 1.0),
//              255 * (uniformDefault[1] ?? 1.0),
                255 * (uniformDefault[2] ?? 1.0),
//              255 * (uniformDefault[2] ?? 1.0),
                255 * (uniformDefault[3] ?? 1.0),
//              255 * (uniformDefault[3] ?? 1.0),
            )).slice(0, -2);
//          )).slice(0, -2);
        }
//      }
    };
//  };

    const handleMatrixInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number): Promise<void> => {
//  const handleMatrixInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number): Promise<void> => {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        await updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
//      await updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
    };
//  };

    const handleBooleanInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> => {
//  const handleBooleanInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> => {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        await updateUniform(uniformIndex, null, ele.checked);
//      await updateUniform(uniformIndex, null, ele.checked);
    };
//  };

    const startDecrement = (uniformIndex: number, uniform: types.GLSLUniform_): void => {
//  const startDecrement = (uniformIndex: number, uniform: types.GLSLUniform_): void => {
        interval = setInterval(async (): Promise<void> => {
//      interval = setInterval(async (): Promise<void> => {
            if (typeof uniform.thisUniformDefaultValue === "number") {
//          if (typeof uniform.thisUniformDefaultValue === "number") {
                await updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue - 0.00001);
//              await updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue - 0.00001);
            }
//          }
        }, 75);
//      }, 75);
    };
//  };

    const startIncrement = (uniformIndex: number, uniform: types.GLSLUniform_): void => {
//  const startIncrement = (uniformIndex: number, uniform: types.GLSLUniform_): void => {
        interval = setInterval(async (): Promise<void> => {
//      interval = setInterval(async (): Promise<void> => {
            if (typeof uniform.thisUniformDefaultValue === "number") {
//          if (typeof uniform.thisUniformDefaultValue === "number") {
                await updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue + 0.00001);
//              await updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue + 0.00001);
            }
//          }
        }, 75);
//      }, 75);
    };
//  };

    const stopInterval = (): void => {
//  const stopInterval = (): void => {
        clearInterval(interval);
//      clearInterval(interval);
    };
//  };

    const handleNumberInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, uniformType: string): Promise<void> => {
//  const handleNumberInput = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, uniformType: string): Promise<void> => {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        await updateUniform(uniformIndex, null, uniformType === "int" || uniformType === "uint" ? parseInt(ele.value) : parseFloat(ele.value));
//      await updateUniform(uniformIndex, null, uniformType === "int" || uniformType === "uint" ? parseInt(ele.value) : parseFloat(ele.value));
    };
//  };

    const handleTextureSelect = async (e: Event & { currentTarget: EventTarget & HTMLSelectElement }, uniformIndex: number): Promise<void> => {
//  const handleTextureSelect = async (e: Event & { currentTarget: EventTarget & HTMLSelectElement }, uniformIndex: number): Promise<void> => {
        const ele: HTMLSelectElement = e.target as HTMLSelectElement;
//      const ele: HTMLSelectElement = e.target as HTMLSelectElement;
        let chosen = ele.options[ele.selectedIndex].value;
//      let chosen = ele.options[ele.selectedIndex].value;
        if (chosen === "none") {
//      if (chosen === "none") {
            uniforms[uniformIndex].thisUniformDefaultValue = "none";
//          uniforms[uniformIndex].thisUniformDefaultValue = "none";
        } else {
//      } else {
            uniforms[uniformIndex].thisUniformDefaultValue = chosen;
//          uniforms[uniformIndex].thisUniformDefaultValue = chosen;
        }
//      }
        await updateUniform(uniformIndex, null, chosen);
//      await updateUniform(uniformIndex, null, chosen);
    };
//  };
</script>

<div>
    {#each uniforms as uniform, uniformIndex (uniform.thisUniformName)}
        {@const uniformName: string = uniform.thisUniformName ?? ""}
        {@const uniformType: string = uniform.thisUniformType ?? ""}
        <div class="container">
            <span>{uniform.thisUniformNameJustForDisplay ?? uniform.thisUniformName} ({uniform.thisUniformType}):</span>
            <div class="space"></div>
            <!-- Render inputs based on type -->
            {#if (
                uniformType.startsWith( "vec") ||
                uniformType.startsWith("ivec") ||
                uniformType.startsWith("uvec")
                ) && (uniform.thisUniformDefaultValue instanceof Array)}
                <table class="center-align large-elevate">
                    <thead>
                        <tr>
                            {#if uniform.thisUniformDefaultValue.length >= 2}
                                <th class="border white-text slow-ripple">*</th>
                                <th class="border white-text slow-ripple">x</th>
                                <th class="border white-text slow-ripple">y</th>
                            {/if}
                            {#if uniform.thisUniformDefaultValue.length >= 3}
                                <th class="border white-text slow-ripple">z</th>
                            {/if}
                            {#if uniform.thisUniformDefaultValue.length >= 4}
                                <th class="border white-text slow-ripple">a</th>
                            {/if}
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="border white-text slow-ripple">
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="circle slow-ripple large-elevate blue white-text top-round right-round"><i class="fa-solid fa-palette white-text"></i><input id={`${uniform.thisUniformName}-color-button`} type="color" oninput={async (e) => await handleColorInput(e, uniformIndex)}></button>
                            </td>
                            {#each uniform.thisUniformDefaultValue as value, index}
                                <td class="border white-text  slow-ripple">
                                    <div class="s2 field small">
                                        <input
                                            type="number"
                                            step="0.0100"
                                            value={value}
                                            oninput={async (e) => await handleVectorInput(e, uniformIndex, index, uniform.thisUniformName, uniform.thisUniformDefaultValue as number[])}
                                        />
                                    </div>
                                </td>
                            {/each}
                        </tr>
                    </tbody>
                </table>
                <div class="space"></div>
            {:else if uniformType.startsWith("mat") && uniform.thisUniformDefaultValue instanceof Array}
                {#if uniform.thisUniformDefaultValue.length === 4}
                    <table class="center-align large-elevate">
                        <thead>
                            <tr>
                                <th> </th>
                                <th class="border white-text slow-ripple">0</th>
                                <th class="border white-text slow-ripple">1</th>
                            </tr>
                        </thead>
                        <tbody>
                            {#each common.splitArrayIntoGroups(uniform.thisUniformDefaultValue, 2) as row, rowIndex}
                                <tr>
                                    {#if rowIndex === 0}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>X</span>
                                        </td>
                                    {/if}
                                    {#if rowIndex === 1}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>Y</span>
                                        </td>
                                    {/if}
                                    {#each row as col, colIndex}
                                        <td class="border white-text slow-ripple">
                                            <div class="s2 field small">
                                                <input
                                                    type="number"
                                                    step="0.0100"
                                                    value={col}
                                                    oninput={async (e) => await handleMatrixInput(e, uniformIndex, rowIndex * 2 + colIndex)}
                                                />
                                            </div>
                                        </td>
                                    {/each}
                                </tr>
                            {/each}
                        </tbody>
                    </table>
                {/if}
                {#if uniform.thisUniformDefaultValue.length === 9}
                    <table class="center-align large-elevate">
                        <thead>
                            <tr>
                                <th> </th>
                                <th class="border white-text slow-ripple">0</th>
                                <th class="border white-text slow-ripple">1</th>
                                <th class="border white-text slow-ripple">2</th>
                            </tr>
                        </thead>
                        <tbody>
                            {#each common.splitArrayIntoGroups(uniform.thisUniformDefaultValue, 3) as row, rowIndex}
                                <tr>
                                    {#if rowIndex === 0}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>X</span>
                                        </td>
                                    {/if}
                                    {#if rowIndex === 1}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>Y</span>
                                        </td>
                                    {/if}
                                    {#if rowIndex === 2}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>Z</span>
                                        </td>
                                    {/if}
                                    {#each row as col, colIndex}
                                        <td class="border white-text slow-ripple">
                                            <div class="s2 field small">
                                                <input
                                                    type="number"
                                                    step="0.0100"
                                                    value={col}
                                                    oninput={async (e) => await handleMatrixInput(e, uniformIndex, rowIndex * 3 + colIndex)}
                                                />
                                            </div>
                                        </td>
                                    {/each}
                                </tr>
                            {/each}
                        </tbody>
                    </table>
                {/if}
                {#if uniform.thisUniformDefaultValue.length === 16}
                    <table class="center-align large-elevate">
                        <thead>
                            <tr>
                                <th> </th>
                                <th class="border white-text slow-ripple">0</th>
                                <th class="border white-text slow-ripple">1</th>
                                <th class="border white-text slow-ripple">2</th>
                                <th class="border white-text slow-ripple">3</th>
                            </tr>
                        </thead>
                        <tbody>
                            {#each common.splitArrayIntoGroups(uniform.thisUniformDefaultValue, 4) as row, rowIndex}
                                <tr>
                                    {#if rowIndex === 0}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>X</span>
                                        </td>
                                    {/if}
                                    {#if rowIndex === 1}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>Y</span>
                                        </td>
                                    {/if}
                                    {#if rowIndex === 2}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>Z</span>
                                        </td>
                                    {/if}
                                    {#if rowIndex === 3}
                                        <td class="border white-text slow-ripple">
                                            <!-- svelte-ignore node_invalid_placement_ssr -->
                                            <span>A</span>
                                        </td>
                                    {/if}
                                    {#each row as col, colIndex}
                                        <td class="border white-text slow-ripple">
                                            <div class="s2 field small">
                                                <input
                                                    type="number"
                                                    step="0.0100"
                                                    value={col}
                                                    oninput={async (e) => await handleMatrixInput(e, uniformIndex, rowIndex * 4 + colIndex)}
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
            {:else if uniformType === "bool" && typeof uniform.thisUniformDefaultValue === "boolean"}
                <label class="switch center-align icon">
                    <input type="checkbox"
                        checked={uniform.thisUniformDefaultValue} onchange={async (e) => await handleBooleanInput(e, uniformIndex)}
                    />
                    <span>
                        <i class="deep-orange white-text"></i>
                        <i class="blue        white-text"></i>
                    </span>
                </label>
                <div class="space"></div>
            {:else if uniformType === "float" || uniformType === "int" || uniformType === "uint"}
                <div class="row center-align middle-align">
                    <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
                    <button class="circle small large-elevate deep-orange white-text top-round right-round"
                        onmousedown={() => startDecrement(uniformIndex, uniform)} onmouseout={stopInterval} onmouseup={stopInterval} onmouseleave={stopInterval}
                    >
                        <i class="fa-solid fa-caret-left white-text"></i>
                    </button>
                    <div class="s2 field small min suffix round white-text large-elevate slow-ripple">
                        <input
                            type="number"
                            step="1.0000"
                            value={uniform.thisUniformDefaultValue}
                            oninput={async (e) => await handleNumberInput(e, uniformIndex, uniformType)}
                        />
                    </div>
                    <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
                    <button class="circle small large-elevate blue white-text bottom-round left-round"
                        onmousedown={() => startIncrement(uniformIndex, uniform)} onmouseout={stopInterval} onmouseup={stopInterval} onmouseleave={stopInterval}
                    >
                        <i class="fa-solid fa-caret-right white-text"></i>
                    </button>
                </div>
                <div class="space"></div>
            {:else if (uniformType === "sampler2D" || uniformType  === "sampler3D") && typeof uniform.thisUniformDefaultValue === "string"}
                <div class="max center-align">
                    <img class="max center-align small-width small-height no-round"
                        src={ uniform.thisUniformDefaultValue === "null".trim() ? svelteSvg : uniform.thisUniformDefaultValue }
                        alt="" bind:this={uniforms[uniformIndex].thisUniformSampler2DEle} style:box-shadow="0 0 5px #222222" style:object-fit="content"
                    />
                </div>
                {#if uniformName.startsWith("upload")}
                <!--<form action=""><input bind:this={input} onchange={onChange(uniformIndex)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate deep-orange white-text"><i class="fas fa-paperclip white-text"></i><span>Load Image Or Video</span></button></form>-->
                    <form action=""><input bind:this={input} onchange={onChange(uniformIndex)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate deep-orange white-text"><i class="fas fa-paperclip white-text"></i><span>Load Image Or Video</span></button></form>
                <!--<form action=""><input bind:this={input} onchange={onChange(uniformIndex)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate deep-orange white-text"><i class="fas fa-paperclip white-text"></i><span>Load Image Or Video</span></button></form>-->
                {:else}
                    <div class="field label suffix round white-text large-elevate slow-ripple">
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <label class="active">Texture</label>
                        <select
                            onchange={async (e) => await handleTextureSelect(e, uniformIndex)}
                        >
                            {#each (uniformName.startsWith("noise") ? global.globalState.texturesNoise :
                                    uniformName.startsWith("bayer") ? global.globalState.texturesBayer :
                                    uniformName.startsWith("palette") ? global.globalState.texturesPalette : uniformName.startsWith("pencil") ? global.globalState.texturesPencil_ :
                                    uniformName.startsWith("ascii") ? global.globalState.texturesASCII :
                                    uniformName.startsWith("tiled") ? global.globalState.texturesTiled :
                                    uniformName.startsWith("shaderToy") ? global.globalState.texturesShaderToy : []) as textureForShader (textureForShader)
                            }
                                <option value={textureForShader.path} class="grey10 white-text">{textureForShader.name}</option>
                            {/each}
                        </select>
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <label>Texture For Shader</label>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                {/if}
                <div class="space"></div>
            {:else}
                <span>Unsupported type</span>
                <span>Unsupported type</span>
                <span>Unsupported type</span>
            {/if}
        </div>
    {/each}
</div>

<style>
    .container{ display: flex; flex-direction: column; }
    .container{ display: flex; flex-direction: column; }

    i        { text-shadow: 0 0 3px; }
    i        { text-shadow: 0 0 3px; }
    /*
    h6       { text-shadow: 0 0 3px; }
    h6       { text-shadow: 0 0 3px; }
    */
    th       { text-shadow: 0 0 3px; }
    th       { text-shadow: 0 0 3px; }
    td       { text-shadow: 0 0 3px; }
    td       { text-shadow: 0 0 3px; }
    tr       { text-shadow: 0 0 3px; }
    tr       { text-shadow: 0 0 3px; }
    span     { text-shadow: 0 0 3px; }
    span     { text-shadow: 0 0 3px; }
    label    { text-shadow: 0 0 3px; }
    label    { text-shadow: 0 0 3px; }
    input    { text-shadow: 0 0 3px; }
    input    { text-shadow: 0 0 3px; }
    button   { text-shadow: 0 0 3px; }
    button   { text-shadow: 0 0 3px; }
    select   { text-shadow: 0 0 3px; }
    select   { text-shadow: 0 0 3px; }
    /*
    textarea { text-shadow: 0 0 3px; }
    textarea { text-shadow: 0 0 3px; }
    */

    .switch > input:checked + span:after { border: none; background-color: #222222           ;                          box-shadow: 0 0 10px #222222;                               }
    .switch > input:checked + span:after { border: none; background-color: #222222           ;                          box-shadow: 0 0 10px #222222;                               }
    .switch >                 span:after {                   border-color: #222222 !important; background: #ffffff22; box-shadow: 0 0 10px #222222; border-width: 3px !important; }
    .switch >                 span:after {                   border-color: #222222 !important; background: #ffffff22; box-shadow: 0 0 10px #222222; border-width: 3px !important; }
</style>
