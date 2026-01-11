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

    export class GLSLUniformController {
//  export class GLSLUniformController {
        canvasInstance: p5 | undefined = $state();
//      canvasInstance: p5 | undefined = $state();
        uniforms: types.GLSLUniforms = $state([]);
//      uniforms: types.GLSLUniforms = $state([]);
        onUpdate: ((updatedUniforms: types.GLSLUniforms) => void) | undefined = $state();
//      onUpdate: ((updatedUniforms: types.GLSLUniforms) => void) | undefined = $state();

        // State
//      // State
        glslUniformState: state.GLSLUniformState = new state.GLSLUniformState();
//      glslUniformState: state.GLSLUniformState = new state.GLSLUniformState();

        constructor() {
//      constructor() {
        }
//      }

        // Helper for matrix indices
//      // Helper for matrix indices
        getMatrixIndex(rowIndex: number, colIndex: number, colCount: number): number { return rowIndex * colCount + colIndex; }
//      getMatrixIndex(rowIndex: number, colIndex: number, colCount: number): number { return rowIndex * colCount + colIndex; }

        // Update uniforms when a value is changed
//      // Update uniforms when a value is changed
        async updateUniform(
//      async updateUniform(
            uniformIndex: number,
//          uniformIndex: number,
            elementIndex: number | null,
//          elementIndex: number | null,
            newValue: number | boolean | string,
//          newValue: number | boolean | string,
        ): Promise<void> {
//      ): Promise<void> {
            let editorSnapshot: types.EditorSnapshot = {
//          let editorSnapshot: types.EditorSnapshot = {
                undo          : null,
//              undo          : null,
                redo          : null,
//              redo          : null,
                dynamicStorage: null,
//              dynamicStorage: null,
            };
//          };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            if (Array.isArray(this.uniforms[uniformIndex].thisUniformDefaultValue)) {
//          if (Array.isArray(this.uniforms[uniformIndex].thisUniformDefaultValue)) {
                if (elementIndex) {
//              if (elementIndex) {
                    editorSnapshot.dynamicStorage.set(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
//                  editorSnapshot.dynamicStorage.set(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
                    (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = newValue as number;
//                  (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = newValue as number;
                    editorSnapshot.dynamicStorage.set(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
//                  editorSnapshot.dynamicStorage.set(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`, (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex]);
                    editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
//                  editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`undo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
                    editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
//                  editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { (this.uniforms[uniformIndex].thisUniformDefaultValue as number[])[elementIndex] = dynamicStorage?.get(`redo(uniforms[${uniformIndex}].thisUniformDefaultValue as number[])[${elementIndex}]`); };
                }
//              }
            } else {
//          } else {
                editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`, this.uniforms[uniformIndex].thisUniformDefaultValue);
//              editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`, this.uniforms[uniformIndex].thisUniformDefaultValue);
                this.uniforms[uniformIndex].thisUniformDefaultValue = newValue;
//              this.uniforms[uniformIndex].thisUniformDefaultValue = newValue;
                editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`, this.uniforms[uniformIndex].thisUniformDefaultValue);
//              editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`, this.uniforms[uniformIndex].thisUniformDefaultValue);
                editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
//              editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
                editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
//              editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); };
            }
//          }
            if (this.canvasInstance && this.uniforms[uniformIndex].thisUniformType === "sampler2D") {
//          if (this.canvasInstance && this.uniforms[uniformIndex].thisUniformType === "sampler2D") {
                editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformSampler2DImg`, this.uniforms[uniformIndex].thisUniformSampler2DImg);
//              editorSnapshot.dynamicStorage.set(`undoUniforms[${uniformIndex}].thisUniformSampler2DImg`, this.uniforms[uniformIndex].thisUniformSampler2DImg);
                this.uniforms[uniformIndex].thisUniformSampler2DImg = await this.canvasInstance.loadImage(this.uniforms[uniformIndex].thisUniformDefaultValue as string);
//              this.uniforms[uniformIndex].thisUniformSampler2DImg = await this.canvasInstance.loadImage(this.uniforms[uniformIndex].thisUniformDefaultValue as string);
                editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`, this.uniforms[uniformIndex].thisUniformSampler2DImg);
//              editorSnapshot.dynamicStorage.set(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`, this.uniforms[uniformIndex].thisUniformSampler2DImg);
                editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); this.uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
//              editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`undoUniforms[${uniformIndex}].thisUniformDefaultValue`); this.uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
                editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); this.uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
//              editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => { this.uniforms[uniformIndex].thisUniformDefaultValue = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformDefaultValue`); this.uniforms[uniformIndex].thisUniformSampler2DImg = dynamicStorage?.get(`redoUniforms[${uniformIndex}].thisUniformSampler2DImg`); };
            }
//          }
            // Trigger callback
//          // Trigger callback
            this.onUpdate?.(this.uniforms);
//          this.onUpdate?.(this.uniforms);
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        successCallback(key: number): (image_Instance: p5.Image) => void {
//      successCallback(key: number): (image_Instance: p5.Image) => void {
            return (image_Instance: p5.Image): void => {
//          return (image_Instance: p5.Image): void => {
                this.uniforms[key].thisUniformSampler2DImg = image_Instance;
//              this.uniforms[key].thisUniformSampler2DImg = image_Instance;
                if (!this.glslUniformState.input || !this.glslUniformState.input.files || !this.glslUniformState.input.files[0]) { return; }
//              if (!this.glslUniformState.input || !this.glslUniformState.input.files || !this.glslUniformState.input.files[0]) { return; }
                let imageObjectURL: string = window.URL.createObjectURL(this.glslUniformState.input.files[0]);
//              let imageObjectURL: string = window.URL.createObjectURL(this.glslUniformState.input.files[0]);
                if (!this.uniforms[key].thisUniformSampler2DEle) { return; }
//              if (!this.uniforms[key].thisUniformSampler2DEle) { return; }
                this.uniforms[key].thisUniformSampler2DEle.src = imageObjectURL;
//              this.uniforms[key].thisUniformSampler2DEle.src = imageObjectURL;
            };
//          };
        }
//      }

        failureCallback(key: number): (event_Instance: Event) => void {
//      failureCallback(key: number): (event_Instance: Event) => void {
            return (event_Instance: Event): void => {
//          return (event_Instance: Event): void => {
                if (!this.glslUniformState.input || !this.glslUniformState.input.files || !this.glslUniformState.input.files[0]) { return; }
//              if (!this.glslUniformState.input || !this.glslUniformState.input.files || !this.glslUniformState.input.files[0]) { return; }
                let videoObjectURL: string = window.URL.createObjectURL(this.glslUniformState.input.files[0]);
//              let videoObjectURL: string = window.URL.createObjectURL(this.glslUniformState.input.files[0]);
                if (this.canvasInstance) {
//              if (this.canvasInstance) {
                    this.uniforms[key].thisUniformSampler2DImg = this.canvasInstance.createVideo(videoObjectURL);
//                  this.uniforms[key].thisUniformSampler2DImg = this.canvasInstance.createVideo(videoObjectURL);
                    this.uniforms[key].thisUniformSampler2DImg.hide();
//                  this.uniforms[key].thisUniformSampler2DImg.hide();
                    this.uniforms[key].thisUniformSampler2DImg.loop();
//                  this.uniforms[key].thisUniformSampler2DImg.loop();
                    this.uniforms[key].thisUniformSampler2DImg.volume(0);
//                  this.uniforms[key].thisUniformSampler2DImg.volume(0);
                }
//              }
                if (!this.uniforms[key].thisUniformSampler2DEle) { return; }
//              if (!this.uniforms[key].thisUniformSampler2DEle) { return; }
                this.uniforms[key].thisUniformSampler2DEle.src = videoObjectURL;
//              this.uniforms[key].thisUniformSampler2DEle.src = videoObjectURL;
            };
//          };
        }
//      }

        onChange(key: number) { return async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => {
//      onChange(key: number) { return async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => {
            const reader = new FileReader();
//          const reader = new FileReader();
            reader.addEventListener("load", async (): Promise<void> => {
//          reader.addEventListener("load", async (): Promise<void> => {
                if (typeof reader.result === "string") {
//              if (typeof reader.result === "string") {
                    if (this.canvasInstance) {
//                  if (this.canvasInstance) {
                        await this.canvasInstance.loadImage(reader.result, this.successCallback(key), this.failureCallback(key));
//                      await this.canvasInstance.loadImage(reader.result, this.successCallback(key), this.failureCallback(key));
                    }
//                  }
                }
//              }
            }, false);
//          }, false);
            const file: File | undefined = this.glslUniformState.input?.files?.[0];
//          const file: File | undefined = this.glslUniformState.input?.files?.[0];
            if (file) {
//          if (file) {
                reader.readAsDataURL(file);
//              reader.readAsDataURL(file);
            }
//          }
        }}
//      }}

        // Handlers
//      // Handlers
        async handleColorInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> {
//      async handleColorInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> {
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            const { r, g, b, }: { r: number, g: number, b: number, } = await common.doHexToRgbNormalized(ele.value);
//          const { r, g, b, }: { r: number, g: number, b: number, } = await common.doHexToRgbNormalized(ele.value);
            await this.updateUniform(uniformIndex, 0, r);
//          await this.updateUniform(uniformIndex, 0, r);
            await this.updateUniform(uniformIndex, 1, g);
//          await this.updateUniform(uniformIndex, 1, g);
            await this.updateUniform(uniformIndex, 2, b);
//          await this.updateUniform(uniformIndex, 2, b);
        }
//      }

        async handleVectorInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number, uniformName: string | null, uniformDefault: number[]): Promise<void> {
//      async handleVectorInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number, uniformName: string | null, uniformDefault: number[]): Promise<void> {
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            await this.updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
//          await this.updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
            if (!uniformName) { return; }
//          if (!uniformName) { return; }
            const colorInput: HTMLInputElement = document.getElementById(`${uniformName}-color-button`) as HTMLInputElement;
//          const colorInput: HTMLInputElement = document.getElementById(`${uniformName}-color-button`) as HTMLInputElement;
            if (colorInput) {
//          if (colorInput) {
                colorInput.value = (await common.rgba_ToHexNormalized(
//              colorInput.value = (await common.rgba_ToHexNormalized(
                    255 * (uniformDefault[0] ?? 1.0),
//                  255 * (uniformDefault[0] ?? 1.0),
                    255 * (uniformDefault[1] ?? 1.0),
//                  255 * (uniformDefault[1] ?? 1.0),
                    255 * (uniformDefault[2] ?? 1.0),
//                  255 * (uniformDefault[2] ?? 1.0),
                    255 * (uniformDefault[3] ?? 1.0),
//                  255 * (uniformDefault[3] ?? 1.0),
                )).slice(0, -2);
//              )).slice(0, -2);
            }
//          }
        }
//      }

        async handleMatrixInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number): Promise<void> {
//      async handleMatrixInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, elementIndex: number): Promise<void> {
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            await this.updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
//          await this.updateUniform(uniformIndex, elementIndex, parseFloat(ele.value));
        }
//      }

        async handleBooleanInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> {
//      async handleBooleanInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number): Promise<void> {
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            await this.updateUniform(uniformIndex, null, ele.checked);
//          await this.updateUniform(uniformIndex, null, ele.checked);
        }
//      }

        startDecrement(uniformIndex: number, uniform: types.GLSLUniform_): void {
//      startDecrement(uniformIndex: number, uniform: types.GLSLUniform_): void {
            this.glslUniformState.interval = setInterval(async (): Promise<void> => {
//          this.glslUniformState.interval = setInterval(async (): Promise<void> => {
                if (typeof uniform.thisUniformDefaultValue === "number") {
//              if (typeof uniform.thisUniformDefaultValue === "number") {
                    await this.updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue - 0.00001);
//                  await this.updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue - 0.00001);
                }
//              }
            }, 75);
//          }, 75);
        }
//      }

        startIncrement(uniformIndex: number, uniform: types.GLSLUniform_): void {
//      startIncrement(uniformIndex: number, uniform: types.GLSLUniform_): void {
            this.glslUniformState.interval = setInterval(async (): Promise<void> => {
//          this.glslUniformState.interval = setInterval(async (): Promise<void> => {
                if (typeof uniform.thisUniformDefaultValue === "number") {
//              if (typeof uniform.thisUniformDefaultValue === "number") {
                    await this.updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue + 0.00001);
//                  await this.updateUniform(uniformIndex, null, uniform.thisUniformDefaultValue + 0.00001);
                }
//              }
            }, 75);
//          }, 75);
        }
//      }

        stopInterval(): void {
//      stopInterval(): void {
            clearInterval(this.glslUniformState.interval);
//          clearInterval(this.glslUniformState.interval);
        }
//      }

        async handleNumberInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, uniformType: string): Promise<void> {
//      async handleNumberInput(e: Event & { currentTarget: EventTarget & HTMLInputElement }, uniformIndex: number, uniformType: string): Promise<void> {
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            await this.updateUniform(uniformIndex, null, uniformType === "int" || uniformType === "uint" ? parseInt(ele.value) : parseFloat(ele.value));
//          await this.updateUniform(uniformIndex, null, uniformType === "int" || uniformType === "uint" ? parseInt(ele.value) : parseFloat(ele.value));
        }
//      }

        async handleTextureSelect(e: Event & { currentTarget: EventTarget & HTMLSelectElement }, uniformIndex: number): Promise<void> {
//      async handleTextureSelect(e: Event & { currentTarget: EventTarget & HTMLSelectElement }, uniformIndex: number): Promise<void> {
            const ele: HTMLSelectElement = e.target as HTMLSelectElement;
//          const ele: HTMLSelectElement = e.target as HTMLSelectElement;
            let chosen = ele.options[ele.selectedIndex].value;
//          let chosen = ele.options[ele.selectedIndex].value;
            if (chosen === "none") {
//          if (chosen === "none") {
                this.uniforms[uniformIndex].thisUniformDefaultValue = "none";
//              this.uniforms[uniformIndex].thisUniformDefaultValue = "none";
            } else {
//          } else {
                this.uniforms[uniformIndex].thisUniformDefaultValue = chosen;
//              this.uniforms[uniformIndex].thisUniformDefaultValue = chosen;
            }
//          }
            await this.updateUniform(uniformIndex, null, chosen);
//          await this.updateUniform(uniformIndex, null, chosen);
        }
//      }
    }
//  }
