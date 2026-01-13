<!--<svelte:options runes={true}></svelte:options>-->
    <svelte:options runes={true}></svelte:options>
<!--<svelte:options runes={true}></svelte:options>-->
<script lang="ts">
    import p5 from "p5";
//  import p5 from "p5";
    import * as types from "./types";
//  import * as types from "./types";
    import * as controller from "./controller";
//  import * as controller from "./controller";
    import * as common from "./common";
//  import * as common from "./common";
    import * as global from "./state/global.svelte";
//  import * as global from "./state/global.svelte";

    let {
//  let {
        canvasInstance = $bindable(),
//      canvasInstance = $bindable(),
        draggableText = $bindable({
//      draggableText = $bindable({
            colorFilling: { r: 0, g: 0, b: 0, a: 255 },
//          colorFilling: { r: 0, g: 0, b: 0, a: 255 },
            colorOutline: { r: 0, g: 0, b: 0, a: 255 },
//          colorOutline: { r: 0, g: 0, b: 0, a: 255 },
            fontSize    : 24                          ,
//          fontSize    : 24                          ,
            contents    : "Text"                      ,
//          contents    : "Text"                      ,
            alignHOption: "center"                    ,
//          alignHOption: "center"                    ,
            alignVOption: "center"                    ,
//          alignVOption: "center"                    ,
            font        : null!                       ,
//          font        : null!                       ,
            stylesOption: "normal"                    ,
//          stylesOption: "normal"                    ,
            positionX   : 0                           ,
//          positionX   : 0                           ,
            positionY   : 0                           ,
//          positionY   : 0                           ,
            dimensionW  : 24 * 4                      ,
//          dimensionW  : 24 * 4                      ,
            dimensionH  : 24 * 1                      ,
//          dimensionH  : 24 * 1                      ,
            isDragging  : false                       ,
//          isDragging  : false                       ,
            offsetX     : 0                           ,
//          offsetX     : 0                           ,
            offsetY     : 0                           ,
//          offsetY     : 0                           ,
            spacings    : 24                          ,
//          spacings    : 24                          ,
            wrapMode    : null!                       ,
//          wrapMode    : null!                       ,
        }),
//      }),
    } : {
//  } : {
        canvasInstance: p5;
//      canvasInstance: p5;
        draggableText: types.DraggableText;
//      draggableText: types.DraggableText;
    }
//  }
    = $props<{
//  = $props<{
        canvasInstance: p5;
//      canvasInstance: p5;
        draggableText: types.DraggableText;
//      draggableText: types.DraggableText;
    }>();
//  }>();

    const draggableTextController: controller.DraggableTextController = new controller.DraggableTextController();
//  const draggableTextController: controller.DraggableTextController = new controller.DraggableTextController();

    $effect((): void => {
//  $effect((): void => {
        draggableTextController.canvasInstance = canvasInstance;
//      draggableTextController.canvasInstance = canvasInstance;
        draggableTextController.draggableText = draggableText;
//      draggableTextController.draggableText = draggableText;
    });
//  });
</script>

<div>
    <div class="row responsive">
        <div class="field textarea round label max responsive suffix white-text large-elevate slow-ripple">
            <textarea onchange={async (e) => await draggableTextController.handleContentChange(e)} value={draggableText.contents}></textarea>
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Content</label>
        </div>
        <!-- svelte-ignore a11y_consider_explicit_label -->
        <button class="circle slow-ripple large-elevate deep-orange white-text top-round right-round">
            <i class="fa-solid fa-palette"></i>
            <input type="color" onchange={async (e) => await draggableTextController.handleColorFillingChange(e)}/>
        </button>
        <!-- svelte-ignore a11y_consider_explicit_label -->
        <button class="circle slow-ripple large-elevate deep-orange white-text top-round right-round">
            <i class="fa-solid fa-palette"></i>
            <input type="color" onchange={async (e) => await draggableTextController.handleColorOutlineChange(e)}/>
        </button>
    </div>
    <table>
        <thead>
            <tr>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div class="field label suffix round white-text large-elevate slow-ripple">
                        <select oninput={async (e) => await draggableTextController.handleFontChange(e)}>
                            {#each global.globalState.customFonts as customFont (customFont)}
                                <option
                                    value={customFont.customFontPath}
                                    class="grey10 white-text"
                                >
                                    {#if customFont &&
                                         customFont.customFontName}
                                        {customFont.customFontName.replace(".ttf", "").replace(".otf", "")}
                                    {:else}
                                        nothing
                                    {/if}
                                </option>
                            {/each}
                        </select>
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <label>Font</label>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </td>
                <td>
                    <div class="field label suffix round white-text large-elevate slow-ripple">
                        <input type="number" value={draggableText.fontSize} oninput={async (e) => await draggableTextController.handleFontSizeChange(e)} />
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <label>FontSize</label>
                    </div>
                </td>
                <td>
                    <div class="field label suffix round white-text large-elevate slow-ripple">
                        <input type="number" value={draggableText.spacings} oninput={async (e) => await draggableTextController.handleSpacingsChange(e)} />
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <label>Spacings</label>
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<style>
    i        { text-shadow: 0 0 3px; }
    i        { text-shadow: 0 0 3px; }
    /*
    h6       { text-shadow: 0 0 3px; }
    h6       { text-shadow: 0 0 3px; }
    span     { text-shadow: 0 0 3px; }
    span     { text-shadow: 0 0 3px; }
    */
    label    { text-shadow: 0 0 3px; }
    label    { text-shadow: 0 0 3px; }
    input    { text-shadow: 0 0 3px; }
    input    { text-shadow: 0 0 3px; }
    select   { text-shadow: 0 0 3px; }
    select   { text-shadow: 0 0 3px; }
    button   { text-shadow: 0 0 3px; }
    button   { text-shadow: 0 0 3px; }
    textarea { text-shadow: 0 0 3px; }
    textarea { text-shadow: 0 0 3px; }

    table    { width: 100%; table-layout: fixed; }
    table    { width: 100%; table-layout: fixed; }
</style>
