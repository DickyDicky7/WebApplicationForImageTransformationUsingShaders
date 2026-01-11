<svelte:options runes={true}></svelte:options>
<script lang="ts">
    import p5 from "p5";
//  import p5 from "p5";
    import * as types from "./types";
//  import * as types from "./types";
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

    // State
//  // State
    let fontFaceSelectedIndex: number = $state<number>(0);
//  let fontFaceSelectedIndex: number = $state<number>(0);
    let defaultFont: p5.Font = $state<p5.Font>(draggableText.font);
//  let defaultFont: p5.Font = $state<p5.Font>(draggableText.font);

    // Handlers
//  // Handlers
    async function handleContentChange(e: Event & { currentTarget: EventTarget & HTMLTextAreaElement }): Promise<void> {
//  async function handleContentChange(e: Event & { currentTarget: EventTarget & HTMLTextAreaElement }): Promise<void> {
        const ele: HTMLTextAreaElement = e.target as HTMLTextAreaElement;
//      const ele: HTMLTextAreaElement = e.target as HTMLTextAreaElement;
        let oldContents: string = draggableText.contents;
//      let oldContents: string = draggableText.contents;
        draggableText.contents = ele.value;
//      draggableText.contents = ele.value;
        let newContents: string = draggableText.contents;
//      let newContents: string = draggableText.contents;
        draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length;
//      draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length;
        draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length;
//      draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length;

        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        editorSnapshot.dynamicStorage.set("oldContents", oldContents);
//      editorSnapshot.dynamicStorage.set("oldContents", oldContents);
        editorSnapshot.dynamicStorage.set("newContents", newContents);
//      editorSnapshot.dynamicStorage.set("newContents", newContents);
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.contents = dynamicStorage.get("oldContents"); } };
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.contents = dynamicStorage.get("oldContents"); } };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.contents = dynamicStorage.get("newContents"); } };
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.contents = dynamicStorage.get("newContents"); } };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    }
//  }

    async function handleColorFillingChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleColorFillingChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
//      const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
        let oldColorFilling = structuredClone($state.snapshot(draggableText.colorFilling));
//      let oldColorFilling = structuredClone($state.snapshot(draggableText.colorFilling));
        draggableText.colorFilling = { r, g, b, a: draggableText.colorFilling.a, };
//      draggableText.colorFilling = { r, g, b, a: draggableText.colorFilling.a, };
        let newColorFilling = structuredClone($state.snapshot(draggableText.colorFilling));
//      let newColorFilling = structuredClone($state.snapshot(draggableText.colorFilling));
        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        editorSnapshot.dynamicStorage.set("oldColorFilling", oldColorFilling);
//      editorSnapshot.dynamicStorage.set("oldColorFilling", oldColorFilling);
        editorSnapshot.dynamicStorage.set("newColorFilling", newColorFilling);
//      editorSnapshot.dynamicStorage.set("newColorFilling", newColorFilling);
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorFilling = dynamicStorage.get("oldColorFilling"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a)).slice(0, -2); } };
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorFilling = dynamicStorage.get("oldColorFilling"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a)).slice(0, -2); } };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorFilling = dynamicStorage.get("newColorFilling"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a)).slice(0, -2); } };
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorFilling = dynamicStorage.get("newColorFilling"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a)).slice(0, -2); } };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    }
//  }

    async function handleColorOutlineChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleColorOutlineChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
//      const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
        let oldColorOutline = structuredClone($state.snapshot(draggableText.colorOutline));
//      let oldColorOutline = structuredClone($state.snapshot(draggableText.colorOutline));
        draggableText.colorOutline = { r, g, b, a: draggableText.colorOutline.a, };
//      draggableText.colorOutline = { r, g, b, a: draggableText.colorOutline.a, };
        let newColorOutline = structuredClone($state.snapshot(draggableText.colorOutline));
//      let newColorOutline = structuredClone($state.snapshot(draggableText.colorOutline));
        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        editorSnapshot.dynamicStorage.set("oldColorOutline", oldColorOutline);
//      editorSnapshot.dynamicStorage.set("oldColorOutline", oldColorOutline);
        editorSnapshot.dynamicStorage.set("newColorOutline", newColorOutline);
//      editorSnapshot.dynamicStorage.set("newColorOutline", newColorOutline);
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorOutline = dynamicStorage.get("oldColorOutline"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorOutline.r, draggableText.colorOutline.g, draggableText.colorOutline.b, draggableText.colorOutline.a)).slice(0, -2); } };
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorOutline = dynamicStorage.get("oldColorOutline"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorOutline.r, draggableText.colorOutline.g, draggableText.colorOutline.b, draggableText.colorOutline.a)).slice(0, -2); } };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorOutline = dynamicStorage.get("newColorOutline"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorOutline.r, draggableText.colorOutline.g, draggableText.colorOutline.b, draggableText.colorOutline.a)).slice(0, -2); } };
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.colorOutline = dynamicStorage.get("newColorOutline"); ele.value = (await common.rgba_ToHexNormalized(draggableText.colorOutline.r, draggableText.colorOutline.g, draggableText.colorOutline.b, draggableText.colorOutline.a)).slice(0, -2); } };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    }
//  }

    async function handleFontChange(e: Event & { currentTarget: EventTarget & HTMLSelectElement }): Promise<void> {
//  async function handleFontChange(e: Event & { currentTarget: EventTarget & HTMLSelectElement }): Promise<void> {
        const ele: HTMLSelectElement = e.target as HTMLSelectElement;
//      const ele: HTMLSelectElement = e.target as HTMLSelectElement;
        if (ele.options[ele.selectedIndex].value === "none") {
//      if (ele.options[ele.selectedIndex].value === "none") {
            global.globalState.customFonts[ele.selectedIndex].customFontFace = defaultFont;
//          global.globalState.customFonts[ele.selectedIndex].customFontFace = defaultFont;
        }
//      }
        if (!global.globalState.customFonts[ele.selectedIndex].customFontFace) {
//      if (!global.globalState.customFonts[ele.selectedIndex].customFontFace) {
            global.globalState.customFonts[ele.selectedIndex].customFontFace = await canvasInstance.loadFont(
//          global.globalState.customFonts[ele.selectedIndex].customFontFace = await canvasInstance.loadFont(
            global.globalState.customFonts[ele.selectedIndex].customFontPath!);
//          global.globalState.customFonts[ele.selectedIndex].customFontPath!);
        }
//      }
        draggableText.font = global.globalState.customFonts[ele.selectedIndex].customFontFace!;
//      draggableText.font = global.globalState.customFonts[ele.selectedIndex].customFontFace!;

        let oldFontFaceSelectedIndex: number = fontFaceSelectedIndex;
//      let oldFontFaceSelectedIndex: number = fontFaceSelectedIndex;
        fontFaceSelectedIndex = ele.selectedIndex;
//      fontFaceSelectedIndex = ele.selectedIndex;
        let newFontFaceSelectedIndex: number = fontFaceSelectedIndex;
//      let newFontFaceSelectedIndex: number = fontFaceSelectedIndex;

        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        editorSnapshot.dynamicStorage.set("oldFontFaceSelectedIndex", oldFontFaceSelectedIndex);
//      editorSnapshot.dynamicStorage.set("oldFontFaceSelectedIndex", oldFontFaceSelectedIndex);
        editorSnapshot.dynamicStorage.set("newFontFaceSelectedIndex", newFontFaceSelectedIndex);
//      editorSnapshot.dynamicStorage.set("newFontFaceSelectedIndex", newFontFaceSelectedIndex);
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
            if (dynamicStorage) {
//          if (dynamicStorage) {
                if (!global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace) {
//              if (!global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace) {
                    global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace = defaultFont;
//                  global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace = defaultFont;
                }
//              }
                draggableText.font = global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace!;
//              draggableText.font = global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace!;
                ele.selectedIndex = dynamicStorage.get("oldFontFaceSelectedIndex");
//              ele.selectedIndex = dynamicStorage.get("oldFontFaceSelectedIndex");
            }
//          }
        };
//      };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
            if (dynamicStorage) {
//          if (dynamicStorage) {
                if (!global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace) {
//              if (!global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace) {
                    global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace = defaultFont;
//                  global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace = defaultFont;
                }
//              }
                draggableText.font = global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace!;
//              draggableText.font = global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace!;
                ele.selectedIndex = dynamicStorage.get("newFontFaceSelectedIndex");
//              ele.selectedIndex = dynamicStorage.get("newFontFaceSelectedIndex");
            }
//          }
        };
//      };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    }
//  }

    async function handleFontSizeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleFontSizeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        let oldFontSize: number = draggableText.fontSize;
//      let oldFontSize: number = draggableText.fontSize;
        draggableText.fontSize = ele.valueAsNumber;
//      draggableText.fontSize = ele.valueAsNumber;
        let newFontSize: number = draggableText.fontSize;
//      let newFontSize: number = draggableText.fontSize;
        draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length;
//      draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length;
        draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length;
//      draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length;
        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        editorSnapshot.dynamicStorage.set("oldFontSize", oldFontSize);
//      editorSnapshot.dynamicStorage.set("oldFontSize", oldFontSize);
        editorSnapshot.dynamicStorage.set("newFontSize", newFontSize);
//      editorSnapshot.dynamicStorage.set("newFontSize", newFontSize);
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.fontSize = dynamicStorage.get("oldFontSize"); } };
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.fontSize = dynamicStorage.get("oldFontSize"); } };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.fontSize = dynamicStorage.get("newFontSize"); } };
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.fontSize = dynamicStorage.get("newFontSize"); } };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    }
//  }

    async function handleSpacingsChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleSpacingsChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        let oldSpacings: number = draggableText.spacings;
//      let oldSpacings: number = draggableText.spacings;
        draggableText.spacings = ele.valueAsNumber;
//      draggableText.spacings = ele.valueAsNumber;
        let newSpacings: number = draggableText.spacings;
//      let newSpacings: number = draggableText.spacings;
        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        editorSnapshot.dynamicStorage.set("oldSpacings", oldSpacings);
//      editorSnapshot.dynamicStorage.set("oldSpacings", oldSpacings);
        editorSnapshot.dynamicStorage.set("newSpacings", newSpacings);
//      editorSnapshot.dynamicStorage.set("newSpacings", newSpacings);
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.spacings = dynamicStorage.get("oldSpacings"); } };
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.spacings = dynamicStorage.get("oldSpacings"); } };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.spacings = dynamicStorage.get("newSpacings"); } };
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage) { draggableText.spacings = dynamicStorage.get("newSpacings"); } };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    }
//  }

    async function handleAlignHChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleAlignHChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        draggableText.alignHOption = ele.value as types.TextAlignHOption;
//      draggableText.alignHOption = ele.value as types.TextAlignHOption;
    }
//  }

    async function handleAlignVChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleAlignVChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        draggableText.alignVOption = ele.value as types.TextAlignVOption;
//      draggableText.alignVOption = ele.value as types.TextAlignVOption;
    }
//  }

    async function handleWrapModeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleWrapModeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        if (ele.value === "none") {
//      if (ele.value === "none") {
            draggableText.wrapMode = null!;
//          draggableText.wrapMode = null!;
        } else {
//      } else {
            draggableText.wrapMode = ele.value as types.TextWrapModeOption;
//          draggableText.wrapMode = ele.value as types.TextWrapModeOption;
        }
//      }
    }
//  }

    async function handleStyleChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//  async function handleStyleChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        draggableText.stylesOption = ele.value as types.TextStyleOption;
//      draggableText.stylesOption = ele.value as types.TextStyleOption;
    }
//  }

</script>

<div>
    <div class="row responsive">
        <div class="field textarea round label max responsive suffix white-text large-elevate slow-ripple">
            <textarea onchange={handleContentChange} value={draggableText.contents}></textarea>
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Content</label>
        </div>
        <!-- svelte-ignore a11y_consider_explicit_label -->
        <button class="circle slow-ripple large-elevate deep-orange white-text top-round right-round">
            <i class="fa-solid fa-palette"></i>
            <input type="color" onchange={handleColorFillingChange}/>
        </button>
        <!-- svelte-ignore a11y_consider_explicit_label -->
        <button class="circle slow-ripple large-elevate deep-orange white-text top-round right-round">
            <i class="fa-solid fa-palette"></i>
            <input type="color" onchange={handleColorOutlineChange}/>
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
                        <select oninput={handleFontChange}>
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
                        <input type="number" value={draggableText.fontSize} oninput={handleFontSizeChange} />
                        <!-- svelte-ignore a11y_label_has_associated_control -->
                        <label>FontSize</label>
                    </div>
                </td>
                <td>
                    <div class="field label suffix round white-text large-elevate slow-ripple">
                        <input type="number" value={draggableText.spacings} oninput={handleSpacingsChange} />
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
