    import p5 from "p5";
//  import p5 from "p5";
    import * as types from "../types";
//  import * as types from "../types";
    import * as state from "../state";
//  import * as state from "../state";
    import * as common from "../common";
//  import * as common from "../common";
    import * as global from "../state/global.svelte";
//  import * as global from "../state/global.svelte";

    export class DraggableTextController {
//  export class DraggableTextController {
        canvasInstance: p5 | undefined = $state();
//      canvasInstance: p5 | undefined = $state();
        draggableText: types.DraggableText | undefined = $state();
//      draggableText: types.DraggableText | undefined = $state();

        // State
//      // State
        draggableTextState: state.DraggableTextState = new state.DraggableTextState(null!);
//      draggableTextState: state.DraggableTextState = new state.DraggableTextState(null!);

        constructor() {
//      constructor() {
        }
//      }

        // Handlers
//      // Handlers
        async handleContentChange(e: Event & { currentTarget: EventTarget & HTMLTextAreaElement }): Promise<void> {
//      async handleContentChange(e: Event & { currentTarget: EventTarget & HTMLTextAreaElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLTextAreaElement = e.target as HTMLTextAreaElement;
//          const ele: HTMLTextAreaElement = e.target as HTMLTextAreaElement;
            let oldContents: string = this.draggableText.contents;
//          let oldContents: string = this.draggableText.contents;
            this.draggableText.contents = ele.value;
//          this.draggableText.contents = ele.value;
            let newContents: string = this.draggableText.contents;
//          let newContents: string = this.draggableText.contents;
            this.draggableText.dimensionW = this.draggableText.fontSize * this.draggableText.contents.length;
//          this.draggableText.dimensionW = this.draggableText.fontSize * this.draggableText.contents.length;
            this.draggableText.dimensionH = this.draggableText.fontSize * this.draggableText.contents.split("\n").length;
//          this.draggableText.dimensionH = this.draggableText.fontSize * this.draggableText.contents.split("\n").length;

            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            editorSnapshot.dynamicStorage.set("oldContents", oldContents);
//          editorSnapshot.dynamicStorage.set("oldContents", oldContents);
            editorSnapshot.dynamicStorage.set("newContents", newContents);
//          editorSnapshot.dynamicStorage.set("newContents", newContents);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.contents = dynamicStorage.get("oldContents"); } };
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.contents = dynamicStorage.get("oldContents"); } };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.contents = dynamicStorage.get("newContents"); } };
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.contents = dynamicStorage.get("newContents"); } };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleColorFillingChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleColorFillingChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
//          const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
            let oldColorFilling = structuredClone($state.snapshot(this.draggableText.colorFilling));
//          let oldColorFilling = structuredClone($state.snapshot(this.draggableText.colorFilling));
            this.draggableText.colorFilling = { r, g, b, a: this.draggableText.colorFilling.a, };
//          this.draggableText.colorFilling = { r, g, b, a: this.draggableText.colorFilling.a, };
            let newColorFilling = structuredClone($state.snapshot(this.draggableText.colorFilling));
//          let newColorFilling = structuredClone($state.snapshot(this.draggableText.colorFilling));
            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            editorSnapshot.dynamicStorage.set("oldColorFilling", oldColorFilling);
//          editorSnapshot.dynamicStorage.set("oldColorFilling", oldColorFilling);
            editorSnapshot.dynamicStorage.set("newColorFilling", newColorFilling);
//          editorSnapshot.dynamicStorage.set("newColorFilling", newColorFilling);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorFilling = dynamicStorage.get("oldColorFilling"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorFilling.r, this.draggableText.colorFilling.g, this.draggableText.colorFilling.b, this.draggableText.colorFilling.a)).slice(0, -2); } };
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorFilling = dynamicStorage.get("oldColorFilling"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorFilling.r, this.draggableText.colorFilling.g, this.draggableText.colorFilling.b, this.draggableText.colorFilling.a)).slice(0, -2); } };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorFilling = dynamicStorage.get("newColorFilling"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorFilling.r, this.draggableText.colorFilling.g, this.draggableText.colorFilling.b, this.draggableText.colorFilling.a)).slice(0, -2); } };
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorFilling = dynamicStorage.get("newColorFilling"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorFilling.r, this.draggableText.colorFilling.g, this.draggableText.colorFilling.b, this.draggableText.colorFilling.a)).slice(0, -2); } };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleColorOutlineChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleColorOutlineChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
//          const { r, g, b, } = await common.noHexToRgbNormalized(ele.value);
            let oldColorOutline = structuredClone($state.snapshot(this.draggableText.colorOutline));
//          let oldColorOutline = structuredClone($state.snapshot(this.draggableText.colorOutline));
            this.draggableText.colorOutline = { r, g, b, a: this.draggableText.colorOutline.a, };
//          this.draggableText.colorOutline = { r, g, b, a: this.draggableText.colorOutline.a, };
            let newColorOutline = structuredClone($state.snapshot(this.draggableText.colorOutline));
//          let newColorOutline = structuredClone($state.snapshot(this.draggableText.colorOutline));
            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            editorSnapshot.dynamicStorage.set("oldColorOutline", oldColorOutline);
//          editorSnapshot.dynamicStorage.set("oldColorOutline", oldColorOutline);
            editorSnapshot.dynamicStorage.set("newColorOutline", newColorOutline);
//          editorSnapshot.dynamicStorage.set("newColorOutline", newColorOutline);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorOutline = dynamicStorage.get("oldColorOutline"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorOutline.r, this.draggableText.colorOutline.g, this.draggableText.colorOutline.b, this.draggableText.colorOutline.a)).slice(0, -2); } };
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorOutline = dynamicStorage.get("oldColorOutline"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorOutline.r, this.draggableText.colorOutline.g, this.draggableText.colorOutline.b, this.draggableText.colorOutline.a)).slice(0, -2); } };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorOutline = dynamicStorage.get("newColorOutline"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorOutline.r, this.draggableText.colorOutline.g, this.draggableText.colorOutline.b, this.draggableText.colorOutline.a)).slice(0, -2); } };
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.colorOutline = dynamicStorage.get("newColorOutline"); ele.value = (await common.rgba_ToHexNormalized(this.draggableText.colorOutline.r, this.draggableText.colorOutline.g, this.draggableText.colorOutline.b, this.draggableText.colorOutline.a)).slice(0, -2); } };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleFontChange(e: Event & { currentTarget: EventTarget & HTMLSelectElement }): Promise<void> {
//      async handleFontChange(e: Event & { currentTarget: EventTarget & HTMLSelectElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLSelectElement = e.target as HTMLSelectElement;
//          const ele: HTMLSelectElement = e.target as HTMLSelectElement;
            if (ele.options[ele.selectedIndex].value === "none") {
//          if (ele.options[ele.selectedIndex].value === "none") {
                global.globalState.customFonts[ele.selectedIndex].customFontFace = this.draggableTextState.defaultFont;
//              global.globalState.customFonts[ele.selectedIndex].customFontFace = this.draggableTextState.defaultFont;
            }
//          }
            if (!global.globalState.customFonts[ele.selectedIndex].customFontFace) {
//          if (!global.globalState.customFonts[ele.selectedIndex].customFontFace) {
                if (this.canvasInstance) {
//              if (this.canvasInstance) {
                    global.globalState.customFonts[ele.selectedIndex].customFontFace = await this.canvasInstance.loadFont(
//                  global.globalState.customFonts[ele.selectedIndex].customFontFace = await this.canvasInstance.loadFont(
                    global.globalState.customFonts[ele.selectedIndex].customFontPath!);
//                  global.globalState.customFonts[ele.selectedIndex].customFontPath!);
                }
//              }
            }
//          }
            this.draggableText.font = global.globalState.customFonts[ele.selectedIndex].customFontFace!;
//          this.draggableText.font = global.globalState.customFonts[ele.selectedIndex].customFontFace!;

            let oldFontFaceSelectedIndex: number = this.draggableTextState.fontFaceSelectedIndex;
//          let oldFontFaceSelectedIndex: number = this.draggableTextState.fontFaceSelectedIndex;
            this.draggableTextState.fontFaceSelectedIndex = ele.selectedIndex;
//          this.draggableTextState.fontFaceSelectedIndex = ele.selectedIndex;
            let newFontFaceSelectedIndex: number = this.draggableTextState.fontFaceSelectedIndex;
//          let newFontFaceSelectedIndex: number = this.draggableTextState.fontFaceSelectedIndex;

            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            editorSnapshot.dynamicStorage.set("oldFontFaceSelectedIndex", oldFontFaceSelectedIndex);
//          editorSnapshot.dynamicStorage.set("oldFontFaceSelectedIndex", oldFontFaceSelectedIndex);
            editorSnapshot.dynamicStorage.set("newFontFaceSelectedIndex", newFontFaceSelectedIndex);
//          editorSnapshot.dynamicStorage.set("newFontFaceSelectedIndex", newFontFaceSelectedIndex);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                if (dynamicStorage && this.draggableText) {
//              if (dynamicStorage && this.draggableText) {
                    if (!global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace) {
//                  if (!global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace) {
                        global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace = this.draggableTextState.defaultFont;
//                      global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace = this.draggableTextState.defaultFont;
                    }
//                  }
                    this.draggableText.font = global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace!;
//                  this.draggableText.font = global.globalState.customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace!;
                    ele.selectedIndex = dynamicStorage.get("oldFontFaceSelectedIndex");
//                  ele.selectedIndex = dynamicStorage.get("oldFontFaceSelectedIndex");
                }
//              }
            };
//          };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                if (dynamicStorage && this.draggableText) {
//              if (dynamicStorage && this.draggableText) {
                    if (!global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace) {
//                  if (!global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace) {
                        global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace = this.draggableTextState.defaultFont;
//                      global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace = this.draggableTextState.defaultFont;
                    }
//                  }
                    this.draggableText.font = global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace!;
//                  this.draggableText.font = global.globalState.customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace!;
                    ele.selectedIndex = dynamicStorage.get("newFontFaceSelectedIndex");
//                  ele.selectedIndex = dynamicStorage.get("newFontFaceSelectedIndex");
                }
//              }
            };
//          };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleFontSizeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleFontSizeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            let oldFontSize: number = this.draggableText.fontSize;
//          let oldFontSize: number = this.draggableText.fontSize;
            this.draggableText.fontSize = ele.valueAsNumber;
//          this.draggableText.fontSize = ele.valueAsNumber;
            let newFontSize: number = this.draggableText.fontSize;
//          let newFontSize: number = this.draggableText.fontSize;
            this.draggableText.dimensionW = this.draggableText.fontSize * this.draggableText.contents.length;
//          this.draggableText.dimensionW = this.draggableText.fontSize * this.draggableText.contents.length;
            this.draggableText.dimensionH = this.draggableText.fontSize * this.draggableText.contents.split("\n").length;
//          this.draggableText.dimensionH = this.draggableText.fontSize * this.draggableText.contents.split("\n").length;
            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            editorSnapshot.dynamicStorage.set("oldFontSize", oldFontSize);
//          editorSnapshot.dynamicStorage.set("oldFontSize", oldFontSize);
            editorSnapshot.dynamicStorage.set("newFontSize", newFontSize);
//          editorSnapshot.dynamicStorage.set("newFontSize", newFontSize);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.fontSize = dynamicStorage.get("oldFontSize"); } };
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.fontSize = dynamicStorage.get("oldFontSize"); } };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.fontSize = dynamicStorage.get("newFontSize"); } };
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.fontSize = dynamicStorage.get("newFontSize"); } };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleSpacingsChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleSpacingsChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            let oldSpacings: number = this.draggableText.spacings;
//          let oldSpacings: number = this.draggableText.spacings;
            this.draggableText.spacings = ele.valueAsNumber;
//          this.draggableText.spacings = ele.valueAsNumber;
            let newSpacings: number = this.draggableText.spacings;
//          let newSpacings: number = this.draggableText.spacings;
            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            editorSnapshot.dynamicStorage.set("oldSpacings", oldSpacings);
//          editorSnapshot.dynamicStorage.set("oldSpacings", oldSpacings);
            editorSnapshot.dynamicStorage.set("newSpacings", newSpacings);
//          editorSnapshot.dynamicStorage.set("newSpacings", newSpacings);
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.spacings = dynamicStorage.get("oldSpacings"); } };
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.spacings = dynamicStorage.get("oldSpacings"); } };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.spacings = dynamicStorage.get("newSpacings"); } };
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { if (dynamicStorage && this.draggableText) { this.draggableText.spacings = dynamicStorage.get("newSpacings"); } };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleAlignHChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleAlignHChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            this.draggableText.alignHOption = ele.value as types.TextAlignHOption;
//          this.draggableText.alignHOption = ele.value as types.TextAlignHOption;
        }
//      }

        async handleAlignVChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleAlignVChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            this.draggableText.alignVOption = ele.value as types.TextAlignVOption;
//          this.draggableText.alignVOption = ele.value as types.TextAlignVOption;
        }
//      }

        async handleWrapModeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleWrapModeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            if (ele.value === "none") {
//          if (ele.value === "none") {
                this.draggableText.wrapMode = null!;
//              this.draggableText.wrapMode = null!;
            } else {
//          } else {
                this.draggableText.wrapMode = ele.value as types.TextWrapModeOption;
//              this.draggableText.wrapMode = ele.value as types.TextWrapModeOption;
            }
//          }
        }
//      }

        async handleStyleChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleStyleChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            if (!this.draggableText) { return; }
//          if (!this.draggableText) { return; }
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            this.draggableText.stylesOption = ele.value as types.TextStyleOption;
//          this.draggableText.stylesOption = ele.value as types.TextStyleOption;
        }
//      }
    }
//  }
