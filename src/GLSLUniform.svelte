<!--<svelte:options runes={true}></svelte:options>-->
    <svelte:options runes={true}></svelte:options>
<!--<svelte:options runes={true}></svelte:options>-->
<script lang="ts">
    import "beercss";
//  import "beercss";
    import "material-dynamic-colors";
//  import "material-dynamic-colors";
    import p5 from "p5";
//  import p5 from "p5";
    import * as types from "./types";
//  import * as types from "./types";
    import * as controller from "./controller";
//  import * as controller from "./controller";
    import * as svelte from "svelte";
//  import * as svelte from "svelte";
    import * as common from "./common";
//  import * as common from "./common";
    import * as global from "./state/global.svelte";
//  import * as global from "./state/global.svelte";
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

    const glslUniformController: controller.GLSLUniformController = new controller.GLSLUniformController();
//  const glslUniformController: controller.GLSLUniformController = new controller.GLSLUniformController();

    $effect((): void => {
//  $effect((): void => {
        glslUniformController.canvasInstance = canvasInstance;
//      glslUniformController.canvasInstance = canvasInstance;
        glslUniformController.uniforms = uniforms;
//      glslUniformController.uniforms = uniforms;
        glslUniformController.onUpdate = onUpdate;
//      glslUniformController.onUpdate = onUpdate;
    });
//  });
</script>

<div>
    {#each uniforms as uniform, uniformIndex (uniform.thisUniformName)}
        {@const uniformName: string = uniform.thisUniformName ?? ""}
        {@const uniformType: string = uniform.thisUniformType ?? ""}
        <div class="container">
            <span>{uniform.thisUniformNameJustForDisplay ?? uniform.thisUniformName} ({uniform.thisUniformType}):</span>
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
                                <button class="circle slow-ripple large-elevate blue white-text top-round right-round"><i class="fa-solid fa-palette white-text"></i><input id={`${uniform.thisUniformName}-color-button`} type="color" oninput={async (e) => await glslUniformController.handleColorInput(e, uniformIndex)}></button>
                            </td>
                            {#each uniform.thisUniformDefaultValue as value, index}
                                <td class="border white-text  slow-ripple">
                                    <div class="s2 field small">
                                        <input
                                            type="number"
                                            step="0.0100"
                                            value={value}
                                            oninput={async (e) => await glslUniformController.handleVectorInput(e, uniformIndex, index, uniform.thisUniformName, uniform.thisUniformDefaultValue as number[])}
                                        />
                                    </div>
                                </td>
                            {/each}
                        </tr>
                    </tbody>
                </table>
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
                                                    oninput={async (e) => await glslUniformController.handleMatrixInput(e, uniformIndex, rowIndex * 2 + colIndex)}
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
                                                    oninput={async (e) => await glslUniformController.handleMatrixInput(e, uniformIndex, rowIndex * 3 + colIndex)}
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
                                                    oninput={async (e) => await glslUniformController.handleMatrixInput(e, uniformIndex, rowIndex * 4 + colIndex)}
                                                />
                                            </div>
                                        </td>
                                    {/each}
                                </tr>
                            {/each}
                        </tbody>
                    </table>
                {/if}
            {:else if uniformType === "bool" && typeof uniform.thisUniformDefaultValue === "boolean"}
                <label class="switch center-align icon">
                    <input type="checkbox"
                        checked={uniform.thisUniformDefaultValue} onchange={async (e) => await glslUniformController.handleBooleanInput(e, uniformIndex)}
                    />
                    <span>
                        <i class="deep-orange white-text"></i>
                        <i class="blue        white-text"></i>
                    </span>
                </label>
            {:else if uniformType === "float" || uniformType === "int" || uniformType === "uint"}
                <div class="row center-align middle-align">
                    <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
                <!--<button class="circle small large-elevate deep-orange white-text    top-round right-round" onmousedown={(e) => glslUniformController.startDecrement(uniformIndex, uniform)} onmouseout={(e) => glslUniformController.stopInterval()} onmouseup={(e) => glslUniformController.stopInterval()} onmouseleave={(e) => glslUniformController.stopInterval()}>-->
                    <button class="circle small large-elevate deep-orange white-text    top-round right-round" onmousedown={(e) => glslUniformController.startDecrement(uniformIndex, uniform)} onmouseout={(e) => glslUniformController.stopInterval()} onmouseup={(e) => glslUniformController.stopInterval()} onmouseleave={(e) => glslUniformController.stopInterval()}>
                <!--<button class="circle small large-elevate deep-orange white-text    top-round right-round" onmousedown={(e) => glslUniformController.startDecrement(uniformIndex, uniform)} onmouseout={(e) => glslUniformController.stopInterval()} onmouseup={(e) => glslUniformController.stopInterval()} onmouseleave={(e) => glslUniformController.stopInterval()}>-->
                    <!--<i class="fa-solid fa-caret-left  white-text"></i>-->
                        <i class="fa-solid fa-caret-left  white-text"></i>
                    <!--<i class="fa-solid fa-caret-left  white-text"></i>-->
                <!--</button>-->
                    </button>
                <!--</button>-->
                    <div class="s2 field small min suffix round white-text large-elevate slow-ripple">
                        <input
                            type="number"
                            step="1.0000"
                            value={uniform.thisUniformDefaultValue}
                            oninput={async (e) => await glslUniformController.handleNumberInput(e, uniformIndex, uniformType)}
                        />
                    </div>
                    <!-- svelte-ignore a11y_consider_explicit_label --><!-- svelte-ignore a11y_mouse_events_have_key_events -->
                <!--<button class="circle small large-elevate blue        white-text bottom-round  left-round" onmousedown={(e) => glslUniformController.startIncrement(uniformIndex, uniform)} onmouseout={(e) => glslUniformController.stopInterval()} onmouseup={(e) => glslUniformController.stopInterval()} onmouseleave={(e) => glslUniformController.stopInterval()}>-->
                    <button class="circle small large-elevate blue        white-text bottom-round  left-round" onmousedown={(e) => glslUniformController.startIncrement(uniformIndex, uniform)} onmouseout={(e) => glslUniformController.stopInterval()} onmouseup={(e) => glslUniformController.stopInterval()} onmouseleave={(e) => glslUniformController.stopInterval()}>
                <!--<button class="circle small large-elevate blue        white-text bottom-round  left-round" onmousedown={(e) => glslUniformController.startIncrement(uniformIndex, uniform)} onmouseout={(e) => glslUniformController.stopInterval()} onmouseup={(e) => glslUniformController.stopInterval()} onmouseleave={(e) => glslUniformController.stopInterval()}>-->
                    <!--<i class="fa-solid fa-caret-right white-text"></i>-->
                        <i class="fa-solid fa-caret-right white-text"></i>
                    <!--<i class="fa-solid fa-caret-right white-text"></i>-->
                <!--</button>-->
                    </button>
                <!--</button>-->
                </div>
            {:else if (uniformType === "sampler2D" || uniformType === "sampler3D") && typeof uniform.thisUniformDefaultValue === "string"}
            <!--<div class="max center-align"><img class="max center-align small-width small-height no-round" src={uniform.thisUniformDefaultValue === "null".trim() ? svelteSvg : uniform.thisUniformDefaultValue} alt="" bind:this={uniforms[uniformIndex].thisUniformSampler2DEle} style:box-shadow="0 0 5px #222222" style:object-fit="content" /></div>-->
                <div class="max center-align"><img class="max center-align small-width small-height no-round" src={uniform.thisUniformDefaultValue === "null".trim() ? svelteSvg : uniform.thisUniformDefaultValue} alt="" bind:this={uniforms[uniformIndex].thisUniformSampler2DEle} style:box-shadow="0 0 5px #222222" style:object-fit="content" /></div>
            <!--<div class="max center-align"><img class="max center-align small-width small-height no-round" src={uniform.thisUniformDefaultValue === "null".trim() ? svelteSvg : uniform.thisUniformDefaultValue} alt="" bind:this={uniforms[uniformIndex].thisUniformSampler2DEle} style:box-shadow="0 0 5px #222222" style:object-fit="content" /></div>-->
                {#if uniformName.startsWith("upload")}
                <!--<form action=""><input bind:this={glslUniformController.glslUniformState.input} onchange={glslUniformController.onChange(uniformIndex)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate deep-orange white-text"><i class="fas fa-paperclip white-text"></i><span>Load Image Or Video</span></button></form>-->
                    <form action=""><input bind:this={glslUniformController.glslUniformState.input} onchange={glslUniformController.onChange(uniformIndex)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate deep-orange white-text"><i class="fas fa-paperclip white-text"></i><span>Load Image Or Video</span></button></form>
                <!--<form action=""><input bind:this={glslUniformController.glslUniformState.input} onchange={glslUniformController.onChange(uniformIndex)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /><button class="slow-ripple large-elevate deep-orange white-text"><i class="fas fa-paperclip white-text"></i><span>Load Image Or Video</span></button></form>-->
                {:else}
                    <div class="field label suffix round white-text large-elevate slow-ripple">
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                    <!--<label class="active">Texture</label>-->
                        <label class="active">Texture</label>
                    <!--<label class="active">Texture</label>-->
                    <!--<select onchange={async (e) => await glslUniformController.handleTextureSelect(e, uniformIndex)}>-->
                        <select onchange={async (e) => await glslUniformController.handleTextureSelect(e, uniformIndex)}>
                    <!--<select onchange={async (e) => await glslUniformController.handleTextureSelect(e, uniformIndex)}>-->
                        <!--{#each (uniformName.startsWith("noise") ? global.globalState.texturesNoise : uniformName.startsWith("bayer") ? global.globalState.texturesBayer : uniformName.startsWith("palette") ? global.globalState.texturesPalette : uniformName.startsWith("pencil") ? global.globalState.texturesPencil_ : uniformName.startsWith("ascii") ? global.globalState.texturesASCII : uniformName.startsWith("tiled") ? global.globalState.texturesTiled : uniformName.startsWith("shaderToy") ? global.globalState.texturesShaderToy : []) as textureForShader (textureForShader)}-->
                            {#each (uniformName.startsWith("noise") ? global.globalState.texturesNoise : uniformName.startsWith("bayer") ? global.globalState.texturesBayer : uniformName.startsWith("palette") ? global.globalState.texturesPalette : uniformName.startsWith("pencil") ? global.globalState.texturesPencil_ : uniformName.startsWith("ascii") ? global.globalState.texturesASCII : uniformName.startsWith("tiled") ? global.globalState.texturesTiled : uniformName.startsWith("shaderToy") ? global.globalState.texturesShaderToy : []) as textureForShader (textureForShader)}
                        <!--{#each (uniformName.startsWith("noise") ? global.globalState.texturesNoise : uniformName.startsWith("bayer") ? global.globalState.texturesBayer : uniformName.startsWith("palette") ? global.globalState.texturesPalette : uniformName.startsWith("pencil") ? global.globalState.texturesPencil_ : uniformName.startsWith("ascii") ? global.globalState.texturesASCII : uniformName.startsWith("tiled") ? global.globalState.texturesTiled : uniformName.startsWith("shaderToy") ? global.globalState.texturesShaderToy : []) as textureForShader (textureForShader)}-->
                            <!--<option value={textureForShader.path} class="grey10 white-text">{textureForShader.name}</option>-->
                                <option value={textureForShader.path} class="grey10 white-text">{textureForShader.name}</option>
                            <!--<option value={textureForShader.path} class="grey10 white-text">{textureForShader.name}</option>-->
                        <!--{/each}-->
                            {/each}
                        <!--{/each}-->
                    <!--</select>-->
                        </select>
                    <!--</select>-->
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                    <!--<label>Texture For Shader</label>-->
                        <label>Texture For Shader</label>
                    <!--<label>Texture For Shader</label>-->
                    <!--<i class="fa-solid fa-chevron-down"></i>-->
                        <i class="fa-solid fa-chevron-down"></i>
                    <!--<i class="fa-solid fa-chevron-down"></i>-->
                    </div>
                {/if}
            {:else}
                <span>Unsupported type</span>
                <span>Unsupported type</span>
                <span>Unsupported type</span>
            {/if}
        </div>
    {/each}
</div>

<style>
    .container { display: flex; flex-direction: row; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 0.5rem; }
    .container { display: flex; flex-direction: row; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-bottom: 0.5rem; }

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
