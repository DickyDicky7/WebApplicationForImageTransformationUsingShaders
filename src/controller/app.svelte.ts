    import * as ai from "../a.i.effects";
//  import * as ai from "../a.i.effects";
    import * as global from "../state/global.svelte";
//  import * as global from "../state/global.svelte";
    import * as common from "../common";
//  import * as common from "../common";
    import * as types from "../types";
//  import * as types from "../types";
    import * as state from "../state";
//  import * as state from "../state";
    import * as constants from "../constants";
//  import * as constants from "../constants";
    import p5 from "p5";
//  import p5 from "p5";
    import SFMonoRegularURL from "../assets/fonts/SF-Mono-Regular.otf";
//  import SFMonoRegularURL from "../assets/fonts/SF-Mono-Regular.otf";
    import * as svelte from "svelte";
//  import * as svelte from "svelte";

    export class AppController {
//  export class AppController {
        appState: state.AppState = new state.AppState();
//      appState: state.AppState = new state.AppState();

        constructor() {
//      constructor() {
        }
//      }

        async init(): Promise<void> {
//      async init(): Promise<void> {
            this.appState.uiState.isInitializing = true;
//          this.appState.uiState.isInitializing = true;
            await new Promise(r => setTimeout(r, 1000)); // Yield to render initial loading state
//          await new Promise(r => setTimeout(r, 1000)); // Yield to render initial loading state

            await ui("theme", "#000000");
//          await ui("theme", "#000000");
            await ui("mode", "dark");
//          await ui("mode", "dark");

            await new Promise(r => setTimeout(r, 1000)); // Yield
//          await new Promise(r => setTimeout(r, 1000)); // Yield

            let bgShader: p5.Shader = null!;
//          let bgShader: p5.Shader = null!;
            let chosenBG: string = await this.loadAsset(constants.bgURLs[Math.floor(Math.random() * 5)]);
//          let chosenBG: string = await this.loadAsset(constants.bgURLs[Math.floor(Math.random() * 5)]);

            await new Promise(r => setTimeout(r, 1000)); // Yield
//          await new Promise(r => setTimeout(r, 1000)); // Yield

            this.appState.canvasState.canvasInstanceBG = new p5((p: p5): void => {
//          this.appState.canvasState.canvasInstanceBG = new p5((p: p5): void => {
                p.setup = async (): Promise<void> => {
//              p.setup = async (): Promise<void> => {
                    p.setAttributes({
//                  p.setAttributes({
                        antialias: false,
//                      antialias: false,
                        alpha: false,
//                      alpha: false,
                        depth: false,
//                      depth: false,
                        stencil: false,
//                      stencil: false,
                        premultipliedAlpha: false,
//                      premultipliedAlpha: false,
                        preserveDrawingBuffer: false,
//                      preserveDrawingBuffer: false,
                        perPixelLighting: true,
//                      perPixelLighting: true,
                    });
//                  });
                    p.createCanvas(window.innerWidth, window.innerHeight, p.WEBGL);
//                  p.createCanvas(window.innerWidth, window.innerHeight, p.WEBGL);
                    p.disableFriendlyErrors = true;
//                  p.disableFriendlyErrors = true;
                    p.noLights();
//                  p.noLights();
                    p.noDebugMode();
//                  p.noDebugMode();
                    p.noSmooth();
//                  p.noSmooth();
                    bgShader = p.createFilterShader(chosenBG);
//                  bgShader = p.createFilterShader(chosenBG);
                };
//              };
                p.draw = (): void => {
//              p.draw = (): void => {
                    if (this.appState.uiState.isInitializing) {
//                  if (this.appState.uiState.isInitializing) {
                        return;
//                      return;
                    }
//                  }
                    bgShader.setUniform("time", p.millis() / 1000);
//                  bgShader.setUniform("time", p.millis() / 1000);
                    p.filter(bgShader);
//                  p.filter(bgShader);
                };
//              };
            }, this.appState.canvasState.canvasBG);
//          }, this.appState.canvasState.canvasBG);

            await new Promise(r => setTimeout(r, 1000)); // Yield for BG canvas init
//          await new Promise(r => setTimeout(r, 1000)); // Yield for BG canvas init

            this.appState.canvasState.canvasInstance = new p5((p: p5): void => this.canvasP5Logic(p), this.appState.canvasState.canvas);
//          this.appState.canvasState.canvasInstance = new p5((p: p5): void => this.canvasP5Logic(p), this.appState.canvasState.canvas);

            /*
            bufferInstance =
//          bufferInstance =
            appState.canvasState.canvasInstance.createGraphics( Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
//          appState.canvasState.canvasInstance.createGraphics( Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                                                                Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
//                                                              Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
            appState.canvasState.canvasInstance.WEBGL,        );
//          appState.canvasState.canvasInstance.WEBGL,        );
            */

            await new Promise(r => setTimeout(r, 1000)); // Yield
//          await new Promise(r => setTimeout(r, 1000)); // Yield

            global.globalState.texturesNoise     = [... global.globalState.texturesNoise    , ... await common.fetchAllTextures_Noise    (               )].sort();
//          global.globalState.texturesNoise     = [... global.globalState.texturesNoise    , ... await common.fetchAllTextures_Noise    (               )].sort();
            global.globalState.texturesBayer     = [... global.globalState.texturesBayer    , ... await common.fetchAllTextures_Bayer    (               )].sort();
//          global.globalState.texturesBayer     = [... global.globalState.texturesBayer    , ... await common.fetchAllTextures_Bayer    (               )].sort();
            global.globalState.texturesPalette   = [... global.globalState.texturesPalette  , ... await common.fetchAllTextures_Palette  (global.supabase)].sort();
//          global.globalState.texturesPalette   = [... global.globalState.texturesPalette  , ... await common.fetchAllTextures_Palette  (global.supabase)].sort();
            global.globalState.texturesPencil_   = [... global.globalState.texturesPencil_  , ... await common.fetchAllTextures_Pencil_  (global.supabase)].sort();
//          global.globalState.texturesPencil_   = [... global.globalState.texturesPencil_  , ... await common.fetchAllTextures_Pencil_  (global.supabase)].sort();
            global.globalState.texturesASCII     = [... global.globalState.texturesASCII    , ... await common.fetchAllTextures_ASCII    (global.supabase)].sort();
//          global.globalState.texturesASCII     = [... global.globalState.texturesASCII    , ... await common.fetchAllTextures_ASCII    (global.supabase)].sort();
            global.globalState.texturesTiled     = [... global.globalState.texturesTiled    , ... await common.fetchAllTextures_Tiled    (global.supabase)].sort();
//          global.globalState.texturesTiled     = [... global.globalState.texturesTiled    , ... await common.fetchAllTextures_Tiled    (global.supabase)].sort();
            global.globalState.texturesShaderToy = [... global.globalState.texturesShaderToy, ... await common.fetchAllTextures_ShaderToy(global.supabase)].sort();
//          global.globalState.texturesShaderToy = [... global.globalState.texturesShaderToy, ... await common.fetchAllTextures_ShaderToy(global.supabase)].sort();
            global.globalState.customFonts = [... global.globalState.customFonts, ... await common.fetchAllFonts_TTF_ITCHIO(global.supabase), ... await common.fetchAllFonts_OTF_ITCHIO(global.supabase)].sort();
//          global.globalState.customFonts = [... global.globalState.customFonts, ... await common.fetchAllFonts_TTF_ITCHIO(global.supabase), ... await common.fetchAllFonts_OTF_ITCHIO(global.supabase)].sort();

            await new Promise(r => setTimeout(r, 1000)); // Final yield
//          await new Promise(r => setTimeout(r, 1000)); // Final yield
            this.appState.uiState.isInitializing = false;
//          this.appState.uiState.isInitializing = false;
        }
//      }

        async destroy(): Promise<void> {
//      async destroy(): Promise<void> {
            this.appState.canvasState.canvasInstance.remove();
//          this.appState.canvasState.canvasInstance.remove();
        }
//      }

        canvasP5Logic(p: p5): void {
//      canvasP5Logic(p: p5): void {
            p.mousePressed = (e?: object): void => {
//          p.mousePressed = (e?: object): void => {
                for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//              for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                    if (fragmentShaderSourceType________) {
//                  if (fragmentShaderSourceType________) {
                        continue;
//                      continue;
                    }
//                  }
                    if (!draggableText) {
//                  if (!draggableText) {
                        continue;
//                      continue;
                    }
//                  }
                    common.onMousePressed(draggableText, p);
//                  common.onMousePressed(draggableText, p);
                }
//              }
            };
//          };
            p.mouseDragged = (e?: object): void => {
//          p.mouseDragged = (e?: object): void => {
                for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//              for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                    if (fragmentShaderSourceType________) {
//                  if (fragmentShaderSourceType________) {
                        continue;
//                      continue;
                    }
//                  }
                    if (!draggableText) {
//                  if (!draggableText) {
                        continue;
//                      continue;
                    }
//                  }
                    common.startDragging(draggableText, p);
//                  common.startDragging(draggableText, p);
                }
//              }
            };
//          };
            p.mouseReleased = (e?: object): void => {
//          p.mouseReleased = (e?: object): void => {
                for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//              for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                    if (fragmentShaderSourceType________) {
//                  if (fragmentShaderSourceType________) {
                        continue;
//                      continue;
                    }
//                  }
                    if (!draggableText) {
//                  if (!draggableText) {
                        continue;
//                      continue;
                    }
//                  }
                    common.ceaseDragging(draggableText, p);
//                  common.ceaseDragging(draggableText, p);
                }
//              }
            };
//          };
            p.setup = async (): Promise<void> => {
//          p.setup = async (): Promise<void> => {
                this.appState.canvasState.defaultFont = await p.loadFont(SFMonoRegularURL);
//              this.appState.canvasState.defaultFont = await p.loadFont(SFMonoRegularURL);
                /*
                appState.draggableText.font = appState.canvasState.defaultFont;
//              appState.draggableText.font = appState.canvasState.defaultFont;
                */
                p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: true, perPixelLighting: true, });
//              p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: true, perPixelLighting: true, });
                p.createCanvas( Math.floor(constants.DEFAULT_CANVAS_SIZE.WIDTH_ * constants.DPR),
//              p.createCanvas( Math.floor(constants.DEFAULT_CANVAS_SIZE.WIDTH_ * constants.DPR),
                                Math.floor(constants.DEFAULT_CANVAS_SIZE.HEIGHT * constants.DPR),
//                              Math.floor(constants.DEFAULT_CANVAS_SIZE.HEIGHT * constants.DPR),
                                p.WEBGL );
//                              p.WEBGL );
                p.background(255);
//              p.background(255);
                p.imageMode(p.CENTER);
//              p.imageMode(p.CENTER);
                p.frameRate(this.appState.settingsState.fps);
//              p.frameRate(this.appState.settingsState.fps);
                p.disableFriendlyErrors = true;
//              p.disableFriendlyErrors = true;
    //EXPERIMENT
//  //EXPERIMENT
                p.noLights();
//              p.noLights();
                p.noDebugMode();
//              p.noDebugMode();
                p.noSmooth();
//              p.noSmooth();
    //EXPERIMENT
//  //EXPERIMENT
            };
//          };
            p.draw = (): void => {
//          p.draw = (): void => {
                if (this.appState.uiState.isInitializing) {
//              if (this.appState.uiState.isInitializing) {
                    return;
//                  return;
                }
//              }
                p.background(255);
//              p.background(255);
                for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//              for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                    if (fragmentShaderSourceType________) {
//                  if (fragmentShaderSourceType________) {
                        continue;
//                      continue;
                    }
//                  }
                    if (!draggableText) {
//                  if (!draggableText) {
                        continue;
//                      continue;
                    }
//                  }
                    common.display(draggableText, p);
//                  common.display(draggableText, p);
                }
//              }
            };
//          };
        }
//      }

        successCallback(image_Instance: p5.Image): void {
//      successCallback(image_Instance: p5.Image): void {
            if (this.appState.mediaState.video) {
//          if (this.appState.mediaState.video) {
                this.appState.mediaState.video.remove();
//              this.appState.mediaState.video.remove();
            }
//          }
            let imageRatio: number = 1.0;
//          let imageRatio: number = 1.0;
            this.appState.canvasState.canvasInstance.resizeCanvas(image_Instance.width * imageRatio * constants.DPR, image_Instance.height * imageRatio * constants.DPR);
//          this.appState.canvasState.canvasInstance.resizeCanvas(image_Instance.width * imageRatio * constants.DPR, image_Instance.height * imageRatio * constants.DPR);
            image_Instance.resize                                (image_Instance.width * imageRatio * constants.DPR, image_Instance.height * imageRatio * constants.DPR);
//          image_Instance.resize                                (image_Instance.width * imageRatio * constants.DPR, image_Instance.height * imageRatio * constants.DPR);
            this.appState.canvasState.canvasInstance.draw = (): void => {
//          this.appState.canvasState.canvasInstance.draw = (): void => {
                this.appState.canvasState.canvasInstance.textureWrap("repeat");
//              this.appState.canvasState.canvasInstance.textureWrap("repeat");
                this.appState.canvasState.canvasInstance.image(image_Instance, 0.0, 0.0);
//              this.appState.canvasState.canvasInstance.image(image_Instance, 0.0, 0.0);
                for (let {  fragmentShaderSourceType________,
//              for (let {  fragmentShaderSourceType________,
                            fragmentShaderSourceCode________,
//                          fragmentShaderSourceCode________,
                            fragmentShader______GLSLUniforms,
//                          fragmentShader______GLSLUniforms,
                            fragmentShaderFiltering_Instance,
//                          fragmentShaderFiltering_Instance,
                            draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
//                          draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
                    if (!fragmentShaderSourceType________) {
//                  if (!fragmentShaderSourceType________) {
                        if (!draggableText) { continue; }
//                      if (!draggableText) { continue; }
                        common.display(draggableText, this.appState.canvasState.canvasInstance);
//                      common.display(draggableText, this.appState.canvasState.canvasInstance);
                        continue;
//                      continue;
                    }
//                  }
                    if (!fragmentShaderSourceCode________) { continue; }
//                  if (!fragmentShaderSourceCode________) { continue; }
                    if (!fragmentShader______GLSLUniforms) { continue; }
//                  if (!fragmentShader______GLSLUniforms) { continue; }
                    if (!fragmentShaderFiltering_Instance) { continue; }
//                  if (!fragmentShaderFiltering_Instance) { continue; }
                    this.shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
//                  this.shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
                    if (fragmentShader______GLSLUniforms) {
//                  if (fragmentShader______GLSLUniforms) {
                        for (let glslUniform of fragmentShader______GLSLUniforms) {
//                      for (let glslUniform of fragmentShader______GLSLUniforms) {
                            if (glslUniform.thisUniformType === "sampler2D"
//                          if (glslUniform.thisUniformType === "sampler2D"
                            ||  glslUniform.thisUniformType === "sampler3D") {
//                          ||  glslUniform.thisUniformType === "sampler3D") {
                                if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
//                              if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
                                    fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
//                                  fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
                                }
//                              }
                            } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
//                          } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
                                fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
//                              fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
                            }
//                          }
                        }
//                      }
                    }
//                  }
                    this.appState.canvasState.canvasInstance.filter(fragmentShaderFiltering_Instance);
//                  this.appState.canvasState.canvasInstance.filter(fragmentShaderFiltering_Instance);
                }
//              }
            };
//          };
            this.appState.settingsState.mode = types.MODE.IMAGE;
//          this.appState.settingsState.mode = types.MODE.IMAGE;
        }
//      }

        failureCallback(event_Instance: Event): void {
//      failureCallback(event_Instance: Event): void {
            if (this.appState.canvasState.canvas.children.length === 2) {
//          if (this.appState.canvasState.canvas.children.length === 2) {
                /*
                appState.canvasState.canvas.children[1].remove();
//              appState.canvasState.canvas.children[1].remove();
                appState.canvasState.canvas.children[2].remove();
//              appState.canvasState.canvas.children[2].remove();
                */
                if (this.appState.mediaState.video) { this.appState.mediaState.video.remove(); } // the same as the above line of code
//              if (this.appState.mediaState.video) { this.appState.mediaState.video.remove(); } // the same as the above line of code
            }
//          }
            if (this.appState.uiState.input.files) {
//          if (this.appState.uiState.input.files) {
                if (this.appState.mediaState.video_FileBLOB) { window.URL.revokeObjectURL(this.appState.mediaState.video_FileBLOB); }
//              if (this.appState.mediaState.video_FileBLOB) { window.URL.revokeObjectURL(this.appState.mediaState.video_FileBLOB); }
                this.appState.mediaState.video_FileBLOB  = window.URL.createObjectURL(this.appState.uiState.input.files[0]);
//              this.appState.mediaState.video_FileBLOB  = window.URL.createObjectURL(this.appState.uiState.input.files[0]);
                this.appState.mediaState.video = this.appState.canvasState.canvasInstance.createVideo(this.appState.mediaState.video_FileBLOB);
//              this.appState.mediaState.video = this.appState.canvasState.canvasInstance.createVideo(this.appState.mediaState.video_FileBLOB);
                this.appState.mediaState.video?.volume(1.0);
//              this.appState.mediaState.video?.volume(1.0);
                this.appState.mediaState.video?.hide();
//              this.appState.mediaState.video?.hide();
                this.appState.mediaState.video?.loop();
//              this.appState.mediaState.video?.loop();
                /*
                appState.mediaState.video?.play();
//              appState.mediaState.video?.play();
                */
                this.appState.mediaState.videoIsPlaying = true;
//              this.appState.mediaState.videoIsPlaying = true;
                this.appState.mediaState.imageIsPlaying = true;
//              this.appState.mediaState.imageIsPlaying = true;
                this.appState.mediaState.catchFirstTime =  false;
//              this.appState.mediaState.catchFirstTime =  false;
                this.appState.mediaState.startRecord    = !false;
//              this.appState.mediaState.startRecord    = !false;
                this.appState.mediaState.ceaseRecord    =  false;
//              this.appState.mediaState.ceaseRecord    =  false;
                /*
                appState.canvasState.canvasInstance.resizeCanvas(   Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
//              appState.canvasState.canvasInstance.resizeCanvas(   Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                                                                    Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
//                                                                  Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
                                                                );
//                                                              );
                */
                this.appState.canvasState.canvasInstance.resizeCanvas(this.appState.mediaState.video.width * 3.0 * constants.DPR, this.appState.mediaState.video.height * 3.0 * constants.DPR);
//              this.appState.canvasState.canvasInstance.resizeCanvas(this.appState.mediaState.video.width * 3.0 * constants.DPR, this.appState.mediaState.video.height * 3.0 * constants.DPR);
                this.appState.canvasState.canvasInstance.draw = (): void => {
//              this.appState.canvasState.canvasInstance.draw = (): void => {
                    if (!this.appState.mediaState.catchFirstTime
//                  if (!this.appState.mediaState.catchFirstTime
                    &&  !isNaN(this.appState.mediaState.video.duration()))
//                  &&  !isNaN(this.appState.mediaState.video.duration()))
                    {
//                  {
                        this.appState.uiState.videoProgressSlider_.max = this.appState.mediaState.video.duration();
//                      this.appState.uiState.videoProgressSlider_.max = this.appState.mediaState.video.duration();
                        this.appState.mediaState.catchFirstTime = true;
//                      this.appState.mediaState.catchFirstTime = true;
                    }
//                  }
                    this.appState.canvasState.canvasInstance.textureWrap("repeat");
//                  this.appState.canvasState.canvasInstance.textureWrap("repeat");
                    /*
                    appState.canvasState.canvasInstance.background(255);
//                  appState.canvasState.canvasInstance.background(255);
                    */
                    this.appState.canvasState.canvasInstance.push();
//                  this.appState.canvasState.canvasInstance.push();
                    this.appState.canvasState.canvasInstance.imageMode(this.appState.canvasState.canvasInstance.CENTER);
//                  this.appState.canvasState.canvasInstance.imageMode(this.appState.canvasState.canvasInstance.CENTER);
                    this.appState.canvasState.canvasInstance.image(
//                  this.appState.canvasState.canvasInstance.image(
                        this.appState.mediaState.video,
//                      this.appState.mediaState.video,
                        0.0,
//                      0.0,
                        0.0,
//                      0.0,
                        this.appState.canvasState.canvasInstance.width,
//                      this.appState.canvasState.canvasInstance.width,
                        this.appState.canvasState.canvasInstance.height,
//                      this.appState.canvasState.canvasInstance.height,
                        0.0,
//                      0.0,
                        0.0,
//                      0.0,
                        this.appState.mediaState.video.width,
//                      this.appState.mediaState.video.width,
                        this.appState.mediaState.video.height,
//                      this.appState.mediaState.video.height,
                        this.appState.canvasState.canvasInstance.COVER,
//                      this.appState.canvasState.canvasInstance.COVER,
                    );
//                  );
                    this.appState.canvasState.canvasInstance.pop();
//                  this.appState.canvasState.canvasInstance.pop();
                    this.appState.uiState.videoProgressSlider_.value = this.appState.mediaState.video.time();
//                  this.appState.uiState.videoProgressSlider_.value = this.appState.mediaState.video.time();
                    for (let {  fragmentShaderSourceType________,
//                  for (let {  fragmentShaderSourceType________,
                                fragmentShaderSourceCode________,
//                              fragmentShaderSourceCode________,
                                fragmentShader______GLSLUniforms,
//                              fragmentShader______GLSLUniforms,
                                fragmentShaderFiltering_Instance,
//                              fragmentShaderFiltering_Instance,
                                draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
//                              draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
                        if (!fragmentShaderSourceType________) {
//                      if (!fragmentShaderSourceType________) {
                            if (!draggableText) { continue; }
//                          if (!draggableText) { continue; }
                            common.display(draggableText, this.appState.canvasState.canvasInstance);
//                          common.display(draggableText, this.appState.canvasState.canvasInstance);
                            continue;
//                          continue;
                        }
//                      }
                        if (!fragmentShaderSourceCode________) { continue; }
//                      if (!fragmentShaderSourceCode________) { continue; }
                        if (!fragmentShader______GLSLUniforms) { continue; }
//                      if (!fragmentShader______GLSLUniforms) { continue; }
                        if (!fragmentShaderFiltering_Instance) { continue; }
//                      if (!fragmentShaderFiltering_Instance) { continue; }
                        this.shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
//                      this.shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
                        if (fragmentShader______GLSLUniforms) {
//                      if (fragmentShader______GLSLUniforms) {
                            for (let glslUniform of fragmentShader______GLSLUniforms) {
//                          for (let glslUniform of fragmentShader______GLSLUniforms) {
                                if (glslUniform.thisUniformType === "sampler2D"
//                              if (glslUniform.thisUniformType === "sampler2D"
                                ||  glslUniform.thisUniformType === "sampler3D") {
//                              ||  glslUniform.thisUniformType === "sampler3D") {
                                    if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
//                                  if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
                                        fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
//                                      fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
                                    }
//                                  }
                                } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
//                              } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
                                    fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
//                                  fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
                                }
//                              }
                            }
//                          }
                        }
//                      }
                        this.appState.canvasState.canvasInstance.filter(fragmentShaderFiltering_Instance);
//                      this.appState.canvasState.canvasInstance.filter(fragmentShaderFiltering_Instance);
                    }
//                  }
                    if (!this.appState.mediaState.ceaseRecord
//                  if (!this.appState.mediaState.ceaseRecord
                    &&   this.appState.mediaState.fshotRecord
//                  &&   this.appState.mediaState.fshotRecord
                    &&  !isNaN(this.appState.mediaState.video.duration())
//                  &&  !isNaN(this.appState.mediaState.video.duration())
                    &&   this.appState.mediaState.video.time() === this.appState.mediaState.video.duration()) {
//                  &&   this.appState.mediaState.video.time() === this.appState.mediaState.video.duration()) {
                        this.appState.mediaState.ceaseRecord = true;
//                      this.appState.mediaState.ceaseRecord = true;
                        this.appState.mediaState.fshotRecord = true;
//                      this.appState.mediaState.fshotRecord = true;
                        this.ceaseCaptureAsVideoFullshot();
//                      this.ceaseCaptureAsVideoFullshot();
                        this.appState.mediaState.recording = false;
//                      this.appState.mediaState.recording = false;
                    }
//                  }
                };
//              };
                this.appState.settingsState.mode = types.MODE.VIDEO;
//              this.appState.settingsState.mode = types.MODE.VIDEO;
            }
//          }
        }
//      }

        async onChange(e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> {
//      async onChange(e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> {
            const reader: FileReader = new FileReader();
//          const reader: FileReader = new FileReader();
            reader.addEventListener("load", async (): Promise<void> => {
//          reader.addEventListener("load", async (): Promise<void> => {
                if (typeof reader.result === "string") {
//              if (typeof reader.result === "string") {
                    await this.appState.canvasState.canvasInstance.loadImage(reader.result, (image: p5.Image): void => this.successCallback(image), (event: Event): void => this.failureCallback(event));
//                  await this.appState.canvasState.canvasInstance.loadImage(reader.result, (image: p5.Image): void => this.successCallback(image), (event: Event): void => this.failureCallback(event));
                    /*
                    console.log(reader.result);
//                  console.log(reader.result);
                    */
                }
//              }
            });
//          });
            reader.addEventListener("abort", async (): Promise<void> => {
//          reader.addEventListener("abort", async (): Promise<void> => {
            });
//          });
            reader.addEventListener("error", async (): Promise<void> => {
//          reader.addEventListener("error", async (): Promise<void> => {
            });
//          });
            let file: File | null = null;
//          let file: File | null = null;
            if (this.appState.uiState.input.files && this.appState.uiState.input.files.length >= 1)
//          if (this.appState.uiState.input.files && this.appState.uiState.input.files.length >= 1)
            {
//          {
                file = this.appState.uiState.input.files[0];
//              file = this.appState.uiState.input.files[0];
            }
//          }
            if (file) { reader.readAsDataURL(file); }
//          if (file) { reader.readAsDataURL(file); }
        }
//      }

        shaderSetNecessaryUniforms(shader: p5.Shader): void {
//      shaderSetNecessaryUniforms(shader: p5.Shader): void {
            shader.setUniform("time", this.appState.canvasState.canvasInstance.millis() / 1000);
//          shader.setUniform("time", this.appState.canvasState.canvasInstance.millis() / 1000);
            shader.setUniform("canvasSize", [ this.appState.canvasState.canvasInstance.width, this.appState.canvasState.canvasInstance.height ]);
//          shader.setUniform("canvasSize", [ this.appState.canvasState.canvasInstance.width, this.appState.canvasState.canvasInstance.height ]);
            shader.setUniform("texelSize", [ 1.0 / (this.appState.canvasState.canvasInstance.width * this.appState.canvasState.canvasInstance.pixelDensity()), 1.0 / (this.appState.canvasState.canvasInstance.height * this.appState.canvasState.canvasInstance.pixelDensity()) ]);
//          shader.setUniform("texelSize", [ 1.0 / (this.appState.canvasState.canvasInstance.width * this.appState.canvasState.canvasInstance.pixelDensity()), 1.0 / (this.appState.canvasState.canvasInstance.height * this.appState.canvasState.canvasInstance.pixelDensity()) ]);
            /*
            shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
//          shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
            */
            shader.setUniform("mousePosition", [ this.appState.canvasState.canvasInstance.mouseX, this.appState.canvasState.canvasInstance.mouseY, this.appState.canvasState.canvasInstance.mouseIsPressed ? 1.0 : 0.0, this.appState.canvasState.canvasInstance.mouseIsPressed ? 1.0 : 0.0 ]);
//          shader.setUniform("mousePosition", [ this.appState.canvasState.canvasInstance.mouseX, this.appState.canvasState.canvasInstance.mouseY, this.appState.canvasState.canvasInstance.mouseIsPressed ? 1.0 : 0.0, this.appState.canvasState.canvasInstance.mouseIsPressed ? 1.0 : 0.0 ]);
            shader.setUniform("frameCount", this.appState.canvasState.canvasInstance.frameCount);
//          shader.setUniform("frameCount", this.appState.canvasState.canvasInstance.frameCount);
        }
//      }

        async startCaptureAsVideoFullshot(): Promise<void> { // VIDEO: Y | IMAGE: N | WEBCAM: N
//      async startCaptureAsVideoFullshot(): Promise<void> { // VIDEO: Y | IMAGE: N | WEBCAM: N
            this.appState.mediaState.fshotRecord = !false;
//          this.appState.mediaState.fshotRecord = !false;
            this.appState.mediaState.sshotRecord =  false;
//          this.appState.mediaState.sshotRecord =  false;
            if (this.appState.mediaState.video) {
//          if (this.appState.mediaState.video) {
                this.appState.mediaState.video.stop();
//              this.appState.mediaState.video.stop();
                this.appState.mediaState.video.noLoop();
//              this.appState.mediaState.video.noLoop();
                this.appState.mediaState.video.volume(1.0);
//              this.appState.mediaState.video.volume(1.0);
                this.appState.mediaState.video.play();
//              this.appState.mediaState.video.play();
            }
//          }
            let htmlCanvasElement: HTMLCanvasElement = this.appState.canvasState.canvas.children[0] as HTMLCanvasElement;
//          let htmlCanvasElement: HTMLCanvasElement = this.appState.canvasState.canvas.children[0] as HTMLCanvasElement;
            let videoElement: HTMLVideoElement = this.appState.canvasState.canvas.children[1] as HTMLVideoElement;
//          let videoElement: HTMLVideoElement = this.appState.canvasState.canvas.children[1] as HTMLVideoElement;
            let audioContext: AudioContext = new AudioContext();
//          let audioContext: AudioContext = new AudioContext();
            let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
//          let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
            let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
//          let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
            if (this.appState.settingsState.mode === types.MODE.VIDEO) {
//          if (this.appState.settingsState.mode === types.MODE.VIDEO) {
                let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
//              let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
                mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
//              mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
                mediaElementAudioSourceNode.connect(audioContext.destination);
//              mediaElementAudioSourceNode.connect(audioContext.destination);
            }
//          }
            this.appState.mediaState.downloadStream = null!;
//          this.appState.mediaState.downloadStream = null!;
            this.appState.mediaState.downloadStream = htmlCanvasElement.captureStream(this.appState.settingsState.fps);
//          this.appState.mediaState.downloadStream = htmlCanvasElement.captureStream(this.appState.settingsState.fps);
            if (this.appState.settingsState.mode === types.MODE.VIDEO) {
//          if (this.appState.settingsState.mode === types.MODE.VIDEO) {
                this.appState.mediaState.downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
//              this.appState.mediaState.downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
            }
//          }
            const recordedChunkes: BlobPart[] = [];
//          const recordedChunkes: BlobPart[] = [];
            const recordedOptions = { mimeType: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].mimeType,
//          const recordedOptions = { mimeType: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].mimeType,
            };
//          };
            this.appState.mediaState.mediaRecorder = new MediaRecorder(this.appState.mediaState.downloadStream, recordedOptions);
//          this.appState.mediaState.mediaRecorder = new MediaRecorder(this.appState.mediaState.downloadStream, recordedOptions);
            this.appState.mediaState.mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
//          this.appState.mediaState.mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
                if (blobEvent.data.size > 0) {
//              if (blobEvent.data.size > 0) {
                    recordedChunkes.push(blobEvent.data);
//                  recordedChunkes.push(blobEvent.data);
                    const blob: Blob = new Blob(recordedChunkes,
//                  const blob: Blob = new Blob(recordedChunkes,
                        {
//                      {
                            type: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].blobType,
//                          type: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].blobType,
                        },
//                      },
                    );
//                  );
                    const url: string = URL.createObjectURL(blob);
//                  const url: string = URL.createObjectURL(blob);
                    const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
//                  const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
                    document.body.appendChild(anchor);
//                  document.body.appendChild(anchor);
                    anchor.href = url;
//                  anchor.href = url;
                    anchor.download = `test_video_${new Date().toLocaleString()}.${constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].extension}`;
//                  anchor.download = `test_video_${new Date().toLocaleString()}.${constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].extension}`;
                    anchor.click();
//                  anchor.click();
                    window.URL.revokeObjectURL(url);
//                  window.URL.revokeObjectURL(url);
                    this.appState.mediaState.videoToShare = blob;
//                  this.appState.mediaState.videoToShare = blob;
                    anchor.remove();
//                  anchor.remove();
                }
//              }
            };
//          };
            this.appState.mediaState.mediaRecorder.start();
//          this.appState.mediaState.mediaRecorder.start();
        }
//      }

        async startCaptureAsVideoSnapshot(): Promise<void> { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
//      async startCaptureAsVideoSnapshot(): Promise<void> { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
            this.appState.mediaState.fshotRecord =  false;
//          this.appState.mediaState.fshotRecord =  false;
            this.appState.mediaState.sshotRecord = !false;
//          this.appState.mediaState.sshotRecord = !false;
            if (this.appState.mediaState.video) {
//          if (this.appState.mediaState.video) {
                /*
                appState.mediaState.video.stop();
//              appState.mediaState.video.stop();
                appState.mediaState.video.noLoop();
//              appState.mediaState.video.noLoop();
                */
                this.appState.mediaState.video.loop();
//              this.appState.mediaState.video.loop();
                this.appState.mediaState.video.volume(1.0);
//              this.appState.mediaState.video.volume(1.0);
                this.appState.mediaState.video.play();
//              this.appState.mediaState.video.play();
            }
//          }
            let htmlCanvasElement: HTMLCanvasElement = this.appState.canvasState.canvas.children[0] as HTMLCanvasElement;
//          let htmlCanvasElement: HTMLCanvasElement = this.appState.canvasState.canvas.children[0] as HTMLCanvasElement;
            let videoElement: HTMLVideoElement = this.appState.canvasState.canvas.children[1] as HTMLVideoElement;
//          let videoElement: HTMLVideoElement = this.appState.canvasState.canvas.children[1] as HTMLVideoElement;
            let audioContext: AudioContext = new AudioContext();
//          let audioContext: AudioContext = new AudioContext();
            let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
//          let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
            let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
//          let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
            if (this.appState.settingsState.mode === types.MODE.VIDEO) {
//          if (this.appState.settingsState.mode === types.MODE.VIDEO) {
                let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
//              let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
                mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
//              mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
                mediaElementAudioSourceNode.connect(audioContext.destination);
//              mediaElementAudioSourceNode.connect(audioContext.destination);
            }
//          }
            this.appState.mediaState.downloadStream = null!;
//          this.appState.mediaState.downloadStream = null!;
            this.appState.mediaState.downloadStream = htmlCanvasElement.captureStream(this.appState.settingsState.fps);
//          this.appState.mediaState.downloadStream = htmlCanvasElement.captureStream(this.appState.settingsState.fps);
            if (this.appState.settingsState.mode === types.MODE.VIDEO) {
//          if (this.appState.settingsState.mode === types.MODE.VIDEO) {
                this.appState.mediaState.downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
//              this.appState.mediaState.downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
            }
//          }
            const recordedChunkes: BlobPart[] = [];
//          const recordedChunkes: BlobPart[] = [];
            const recordedOptions = { mimeType: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].mimeType,
//          const recordedOptions = { mimeType: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].mimeType,
            };
//          };
            this.appState.mediaState.mediaRecorder = new MediaRecorder(this.appState.mediaState.downloadStream, recordedOptions);
//          this.appState.mediaState.mediaRecorder = new MediaRecorder(this.appState.mediaState.downloadStream, recordedOptions);
            this.appState.mediaState.mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
//          this.appState.mediaState.mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
                if (blobEvent.data.size > 0) {
//              if (blobEvent.data.size > 0) {
                    recordedChunkes.push(blobEvent.data);
//                  recordedChunkes.push(blobEvent.data);
                    const blob: Blob = new Blob(recordedChunkes,
//                  const blob: Blob = new Blob(recordedChunkes,
                        {
//                      {
                            type: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].blobType,
//                          type: constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].blobType,
                        },
//                      },
                    );
//                  );
                    const url: string = URL.createObjectURL(blob);
//                  const url: string = URL.createObjectURL(blob);
                    const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
//                  const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
                    document.body.appendChild(anchor);
//                  document.body.appendChild(anchor);
                    anchor.href = url;
//                  anchor.href = url;
                    anchor.download = `test_video_${new Date().toLocaleString()}.${constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].extension}`;
//                  anchor.download = `test_video_${new Date().toLocaleString()}.${constants.videoFormats[this.appState.uiState.videoFormatSelection.selectedIndex].extension}`;
                    anchor.click();
//                  anchor.click();
                    window.URL.revokeObjectURL(url);
//                  window.URL.revokeObjectURL(url);
                    this.appState.mediaState.videoToShare = blob;
//                  this.appState.mediaState.videoToShare = blob;
                    anchor.remove();
//                  anchor.remove();
                }
//              }
            };
//          };
            this.appState.mediaState.mediaRecorder.start();
//          this.appState.mediaState.mediaRecorder.start();
        }
//      }

        async startCaptureAsImage(): Promise<void> { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
//      async startCaptureAsImage(): Promise<void> { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
            this.appState.canvasState.canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, constants.imageFormats[this.appState.uiState.imageFormatSelection.selectedIndex].extension);
//          this.appState.canvasState.canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, constants.imageFormats[this.appState.uiState.imageFormatSelection.selectedIndex].extension);
        }
//      }

        async ceaseCaptureAsVideoFullshot(): Promise<void> {
//      async ceaseCaptureAsVideoFullshot(): Promise<void> {
            this.appState.mediaState.video?.stop();
//          this.appState.mediaState.video?.stop();
            this.appState.mediaState.mediaRecorder?.stop();
//          this.appState.mediaState.mediaRecorder?.stop();
            this.appState.mediaState.mediaRecorder = null!;
//          this.appState.mediaState.mediaRecorder = null!;
            this.appState.mediaState.mediaRecorderWebCam?.stop();
//          this.appState.mediaState.mediaRecorderWebCam?.stop();
            this.appState.mediaState.mediaRecorderWebCam = null!;
//          this.appState.mediaState.mediaRecorderWebCam = null!;
        }
//      }

        async ceaseCaptureAsVideoSnapshot(): Promise<void> {
//      async ceaseCaptureAsVideoSnapshot(): Promise<void> {
            /*
            appState.mediaState.video?.stop();
//          appState.mediaState.video?.stop();
            */
            this.appState.mediaState.mediaRecorder?.stop();
//          this.appState.mediaState.mediaRecorder?.stop();
            this.appState.mediaState.mediaRecorder = null!;
//          this.appState.mediaState.mediaRecorder = null!;
            this.appState.mediaState.mediaRecorderWebCam?.stop();
//          this.appState.mediaState.mediaRecorderWebCam?.stop();
            this.appState.mediaState.mediaRecorderWebCam = null!;
//          this.appState.mediaState.mediaRecorderWebCam = null!;
        }
//      }

        async ceaseCaptureAsImage(): Promise<void> {
//      async ceaseCaptureAsImage(): Promise<void> {
            this.appState.canvasState.canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, constants.imageFormats[this.appState.uiState.imageFormatSelection.selectedIndex].extension);
//          this.appState.canvasState.canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, constants.imageFormats[this.appState.uiState.imageFormatSelection.selectedIndex].extension);
        }
//      }

        async startWebCam(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): Promise<void> {
//      async startWebCam(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): Promise<void> {
            this.appState.mediaState.webcamCapture = this.appState.canvasState.canvasInstance.createCapture({ video: { mandatory: { minWidth: 1280, minHeight: 720, }, optional: [{ maxFrameRate: 120, }] }, audio: true, });
//          this.appState.mediaState.webcamCapture = this.appState.canvasState.canvasInstance.createCapture({ video: { mandatory: { minWidth: 1280, minHeight: 720, }, optional: [{ maxFrameRate: 120, }] }, audio: true, });
            this.appState.canvasState.canvasInstance.resizeCanvas(1280 * 2 / 3, 720 * 2 / 3);
//          this.appState.canvasState.canvasInstance.resizeCanvas(1280 * 2 / 3, 720 * 2 / 3);
            /*
            appState.canvasState.canvasInstance.resizeCanvas(DEFAULT_CANVAS_SIZE.WIDTH_, DEFAULT_CANVAS_SIZE.HEIGHT);
//          appState.canvasState.canvasInstance.resizeCanvas(DEFAULT_CANVAS_SIZE.WIDTH_, DEFAULT_CANVAS_SIZE.HEIGHT);
            */
            this.appState.mediaState.webcamCapture.size(this.appState.canvasState.canvasInstance.width, this.appState.canvasState.canvasInstance.height);
//          this.appState.mediaState.webcamCapture.size(this.appState.canvasState.canvasInstance.width, this.appState.canvasState.canvasInstance.height);
            this.appState.mediaState.webcamCapture.hide();
//          this.appState.mediaState.webcamCapture.hide();
            this.appState.canvasState.canvasInstance.draw = (): void => {
//          this.appState.canvasState.canvasInstance.draw = (): void => {
                this.appState.canvasState.canvasInstance.textureWrap("repeat");
//              this.appState.canvasState.canvasInstance.textureWrap("repeat");
                this.appState.canvasState.canvasInstance.image(this.appState.mediaState.webcamCapture, 0.0, 0.0);
//              this.appState.canvasState.canvasInstance.image(this.appState.mediaState.webcamCapture, 0.0, 0.0);
                for (let {  fragmentShaderSourceType________,
//              for (let {  fragmentShaderSourceType________,
                            fragmentShaderSourceCode________,
//                          fragmentShaderSourceCode________,
                            fragmentShader______GLSLUniforms,
//                          fragmentShader______GLSLUniforms,
                            fragmentShaderFiltering_Instance,
//                          fragmentShaderFiltering_Instance,
                            draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
//                          draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
                    if (!fragmentShaderSourceType________) {
//                  if (!fragmentShaderSourceType________) {
                        if (!draggableText) { continue; }
//                      if (!draggableText) { continue; }
                        common.display(draggableText, this.appState.canvasState.canvasInstance);
//                      common.display(draggableText, this.appState.canvasState.canvasInstance);
                        continue;
//                      continue;
                    }
//                  }
                    if (!fragmentShaderSourceCode________) { continue; }
//                  if (!fragmentShaderSourceCode________) { continue; }
                    if (!fragmentShader______GLSLUniforms) { continue; }
//                  if (!fragmentShader______GLSLUniforms) { continue; }
                    if (!fragmentShaderFiltering_Instance) { continue; }
//                  if (!fragmentShaderFiltering_Instance) { continue; }
                    this.shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
//                  this.shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
                    if (fragmentShader______GLSLUniforms) {
//                  if (fragmentShader______GLSLUniforms) {
                        for (let glslUniform of fragmentShader______GLSLUniforms) {
//                      for (let glslUniform of fragmentShader______GLSLUniforms) {
                            if (glslUniform.thisUniformType === "sampler2D"
//                          if (glslUniform.thisUniformType === "sampler2D"
                            ||  glslUniform.thisUniformType === "sampler3D") {
//                          ||  glslUniform.thisUniformType === "sampler3D") {
                                if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
//                              if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
                                    fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
//                                  fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
                                }
//                              }
                            } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
//                          } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
                                fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
//                              fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
                            }
//                          }
                        }
//                      }
                    }
//                  }
                    this.appState.canvasState.canvasInstance.filter(fragmentShaderFiltering_Instance);
//                  this.appState.canvasState.canvasInstance.filter(fragmentShaderFiltering_Instance);
                }
//              }
            };
//          };
            this.appState.settingsState.mode = types.MODE.WEBCAM;
//          this.appState.settingsState.mode = types.MODE.WEBCAM;
        }
//      }

        ceaseWebCam(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): void {
//      ceaseWebCam(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): void {
            this.appState.mediaState.mediaRecorder?.stop();
//          this.appState.mediaState.mediaRecorder?.stop();
            this.appState.mediaState.mediaRecorder = null!;
//          this.appState.mediaState.mediaRecorder = null!;
            this.appState.mediaState.mediaRecorderWebCam?.stop();
//          this.appState.mediaState.mediaRecorderWebCam?.stop();
            this.appState.mediaState.mediaRecorderWebCam = null!;
//          this.appState.mediaState.mediaRecorderWebCam = null!;
            this.appState.mediaState.webcamCapture.remove();
//          this.appState.mediaState.webcamCapture.remove();
            this.appState.mediaState.webcamCapture = null!;
//          this.appState.mediaState.webcamCapture = null!;
            this.appState.canvasState.canvasInstance.draw = (): void => {
//          this.appState.canvasState.canvasInstance.draw = (): void => {
                this.appState.canvasState.canvasInstance.background(255);
//              this.appState.canvasState.canvasInstance.background(255);
            };
//          };
        }
//      }

        async handleCaptureAsVideo(): Promise<void> {
//      async handleCaptureAsVideo(): Promise<void> {
            if (this.appState.mediaState.recording === false) {
//          if (this.appState.mediaState.recording === false) {
                this.appState.mediaState.recording = true;
//              this.appState.mediaState.recording = true;
                if (this.appState.settingsState.selectedCaptureOption === "Snapshot") {
//              if (this.appState.settingsState.selectedCaptureOption === "Snapshot") {
                    await this.startCaptureAsVideoSnapshot();
//                  await this.startCaptureAsVideoSnapshot();
                }
//              }
                else
//              else
                if (this.appState.settingsState.selectedCaptureOption === "Fullshot") {
//              if (this.appState.settingsState.selectedCaptureOption === "Fullshot") {
                    await this.startCaptureAsVideoFullshot();
//                  await this.startCaptureAsVideoFullshot();
                }
//              }
            }
//          }
            else {
//          else {
                this.appState.mediaState.recording = false;
//              this.appState.mediaState.recording = false;
                if (this.appState.settingsState.selectedCaptureOption === "Snapshot") {
//              if (this.appState.settingsState.selectedCaptureOption === "Snapshot") {
                    await this.ceaseCaptureAsVideoSnapshot();
//                  await this.ceaseCaptureAsVideoSnapshot();
                }
//              }
                else
//              else
                if (this.appState.settingsState.selectedCaptureOption === "Fullshot") {
//              if (this.appState.settingsState.selectedCaptureOption === "Fullshot") {
                    await this.ceaseCaptureAsVideoFullshot();
//                  await this.ceaseCaptureAsVideoFullshot();
                }
//              }
            }
//          }
        }
//      }

        toggleWebCam(e: Event & { currentTarget: EventTarget & HTMLInputElement }): void {
//      toggleWebCam(e: Event & { currentTarget: EventTarget & HTMLInputElement }): void {
            const fakeMouseEvent: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement } = new MouseEvent("click", { bubbles: true, cancelable: true, }) as MouseEvent & { currentTarget: EventTarget & HTMLButtonElement };
//          const fakeMouseEvent: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement } = new MouseEvent("click", { bubbles: true, cancelable: true, }) as MouseEvent & { currentTarget: EventTarget & HTMLButtonElement };
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            if (ele.checked) {
//          if (ele.checked) {
                this.startWebCam(fakeMouseEvent);
//              this.startWebCam(fakeMouseEvent);
            }
//          }
            else {
//          else {
                this.ceaseWebCam(fakeMouseEvent);
//              this.ceaseWebCam(fakeMouseEvent);
            }
//          }
        }
//      }

        async handleStartCaptureAsImage(e: MouseEvent): Promise<void> {
//      async handleStartCaptureAsImage(e: MouseEvent): Promise<void> {
            await this.startCaptureAsImage();
//          await this.startCaptureAsImage();
        }
//      }

        async handleVideoToggle(e: MouseEvent): Promise<void> {
//      async handleVideoToggle(e: MouseEvent): Promise<void> {
            await this.handleCaptureAsVideo();
//          await this.handleCaptureAsVideo();
        }
//      }

        async handleShare(e: MouseEvent): Promise<void> {
//      async handleShare(e: MouseEvent): Promise<void> {
            if (this.appState.settingsState.mode === types.MODE.IMAGE) {
//          if (this.appState.settingsState.mode === types.MODE.IMAGE) {
                await common.shareImage(this.appState.canvasState.canvas.children[0] as HTMLCanvasElement);
//              await common.shareImage(this.appState.canvasState.canvas.children[0] as HTMLCanvasElement);
            }
//          }
            else
//          else
            if (this.appState.settingsState.mode === types.MODE.VIDEO && this.appState.mediaState.videoToShare) {
//          if (this.appState.settingsState.mode === types.MODE.VIDEO && this.appState.mediaState.videoToShare) {
                await common.shareVideo(this.appState.mediaState.videoToShare, this.appState.canvasState.canvas.children[0] as HTMLCanvasElement);
//              await common.shareVideo(this.appState.mediaState.videoToShare, this.appState.canvasState.canvas.children[0] as HTMLCanvasElement);
            }
//          }
            else
//          else
            if (this.appState.settingsState.mode === types.MODE.WEBCAM && this.appState.mediaState.videoToShare) {
//          if (this.appState.settingsState.mode === types.MODE.WEBCAM && this.appState.mediaState.videoToShare) {
                await common.shareWebcam(this.appState.mediaState.videoToShare, this.appState.canvasState.canvas.children[0] as HTMLCanvasElement);
//              await common.shareWebcam(this.appState.mediaState.videoToShare, this.appState.canvasState.canvas.children[0] as HTMLCanvasElement);
            }
//          }
        }
//      }

        async handleAddEffectNI(e: MouseEvent): Promise<void> {
//      async handleAddEffectNI(e: MouseEvent): Promise<void> {
            global.globalState.effectsUsedForFiltering = [ ...
//          global.globalState.effectsUsedForFiltering = [ ...
                global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
//              global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
                                                            ,   fragmentShaderSourceCode________: null
//                                                          ,   fragmentShaderSourceCode________: null
                                                            ,   fragmentShader______GLSLUniforms: null
//                                                          ,   fragmentShader______GLSLUniforms: null
                                                            ,   fragmentShaderFiltering_Instance: null
//                                                          ,   fragmentShaderFiltering_Instance: null
                                                            ,   fragmentShader_HTMLSelectElement: null
//                                                          ,   fragmentShader_HTMLSelectElement: null
                                                            ,   draggableText                   : null
//                                                          ,   draggableText                   : null
                                                            , }
//                                                          , }
            ];
//          ];
            global.globalState.editorSnapshotsUndoStack.push({
//          global.globalState.editorSnapshotsUndoStack.push({
                undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//              undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                    global.globalState.effectsUsedForFiltering.pop();
//                  global.globalState.effectsUsedForFiltering.pop();
                    /*
                    global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//                  global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                    */
                }
//              }
                ,
//              ,
                redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//              redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                    global.globalState.effectsUsedForFiltering = [ ...
//                  global.globalState.effectsUsedForFiltering = [ ...
                        global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
//                      global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
                                                                    ,   fragmentShaderSourceCode________: null
//                                                                  ,   fragmentShaderSourceCode________: null
                                                                    ,   fragmentShader______GLSLUniforms: null
//                                                                  ,   fragmentShader______GLSLUniforms: null
                                                                    ,   fragmentShaderFiltering_Instance: null
//                                                                  ,   fragmentShaderFiltering_Instance: null
                                                                    ,   fragmentShader_HTMLSelectElement: null
//                                                                  ,   fragmentShader_HTMLSelectElement: null
                                                                    ,   draggableText                   : null
//                                                                  ,   draggableText                   : null
                                                                    , }
//                                                                  , }
                    ];
//                  ];
                }
//              }
                ,
//              ,
                dynamicStorage: null
//              dynamicStorage: null
                ,
//              ,
            });
//          });

            await svelte.tick();
//          await svelte.tick();
            this.appState.uiState.bigList.scroll({ top: this.appState.uiState.bigList.scrollHeight, behavior: "smooth", });
//          this.appState.uiState.bigList.scroll({ top: this.appState.uiState.bigList.scrollHeight, behavior: "smooth", });

            await common.makeNewSnackbarSuccess(`A new NI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
//          await common.makeNewSnackbarSuccess(`A new NI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
        }
//      }

        async handleAddEffectAI(e: MouseEvent): Promise<void> {
//      async handleAddEffectAI(e: MouseEvent): Promise<void> {
            global.globalState.effectsUsedForFiltering = [ ...
//          global.globalState.effectsUsedForFiltering = [ ...
                global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
//              global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
                                                            ,   fragmentShaderSourceCode________: null
//                                                          ,   fragmentShaderSourceCode________: null
                                                            ,   fragmentShader______GLSLUniforms: null
//                                                          ,   fragmentShader______GLSLUniforms: null
                                                            ,   fragmentShaderFiltering_Instance: null
//                                                          ,   fragmentShaderFiltering_Instance: null
                                                            ,   fragmentShader_HTMLSelectElement: null
//                                                          ,   fragmentShader_HTMLSelectElement: null
                                                            ,   draggableText                   : null
//                                                          ,   draggableText                   : null
                                                            , }
//                                                          , }
            ];
//          ];
            global.globalState.editorSnapshotsUndoStack.push({
//          global.globalState.editorSnapshotsUndoStack.push({
                undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//              undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                    global.globalState.effectsUsedForFiltering.pop();
//                  global.globalState.effectsUsedForFiltering.pop();
                    /*
                    global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//                  global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                    */
                }
//              }
                ,
//              ,
                redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//              redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                    global.globalState.effectsUsedForFiltering = [ ...
//                  global.globalState.effectsUsedForFiltering = [ ...
                        global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
//                      global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
                                                                    ,   fragmentShaderSourceCode________: null
//                                                                  ,   fragmentShaderSourceCode________: null
                                                                    ,   fragmentShader______GLSLUniforms: null
//                                                                  ,   fragmentShader______GLSLUniforms: null
                                                                    ,   fragmentShaderFiltering_Instance: null
//                                                                  ,   fragmentShaderFiltering_Instance: null
                                                                    ,   fragmentShader_HTMLSelectElement: null
//                                                                  ,   fragmentShader_HTMLSelectElement: null
                                                                    ,   draggableText                   : null
//                                                                  ,   draggableText                   : null
                                                                    , }
//                                                                  , }
                    ];
//                  ];
                }
//              }
                ,
//              ,
                dynamicStorage: null
//              dynamicStorage: null
                ,
//              ,
            });
//          });

            await svelte.tick();
//          await svelte.tick();
            this.appState.uiState.bigList.scroll({ top: this.appState.uiState.bigList.scrollHeight, behavior: "smooth", });
//          this.appState.uiState.bigList.scroll({ top: this.appState.uiState.bigList.scrollHeight, behavior: "smooth", });

            await common.makeNewSnackbarSuccess(`A new AI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
//          await common.makeNewSnackbarSuccess(`A new AI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
        }
//      }

        async handleInsertText(e: MouseEvent): Promise<void> {
//      async handleInsertText(e: MouseEvent): Promise<void> {
            global.globalState.effectsUsedForFiltering = [ ...
//          global.globalState.effectsUsedForFiltering = [ ...
                global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
//              global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
                                                            ,   fragmentShaderSourceCode________: null
//                                                          ,   fragmentShaderSourceCode________: null
                                                            ,   fragmentShader______GLSLUniforms: null
//                                                          ,   fragmentShader______GLSLUniforms: null
                                                            ,   fragmentShaderFiltering_Instance: null
//                                                          ,   fragmentShaderFiltering_Instance: null
                                                            ,   fragmentShader_HTMLSelectElement: null
//                                                          ,   fragmentShader_HTMLSelectElement: null
                                                            ,   draggableText                   : {
//                                                          ,   draggableText                   : {
                                                                    colorFilling: { r: 0, g: 0, b: 0, a: 255 }          ,
//                                                                  colorFilling: { r: 0, g: 0, b: 0, a: 255 }          ,
                                                                    colorOutline: { r: 0, g: 0, b: 0, a: 255 }          ,
//                                                                  colorOutline: { r: 0, g: 0, b: 0, a: 255 }          ,
                                                                    fontSize    : 24                                    ,
//                                                                  fontSize    : 24                                    ,
                                                                    contents    : "Text"                                ,
//                                                                  contents    : "Text"                                ,
                                                                    alignHOption: "center"                              ,
//                                                                  alignHOption: "center"                              ,
                                                                    alignVOption: "center"                              ,
//                                                                  alignVOption: "center"                              ,
                                                                    font        : this.appState.canvasState.defaultFont!,
//                                                                  font        : this.appState.canvasState.defaultFont!,
                                                                    stylesOption: "normal"                              ,
//                                                                  stylesOption: "normal"                              ,
                                                                    positionX   : 0                                     ,
//                                                                  positionX   : 0                                     ,
                                                                    positionY   : 0                                     ,
//                                                                  positionY   : 0                                     ,
                                                                    dimensionW  : 24 * 4                                ,
//                                                                  dimensionW  : 24 * 4                                ,
                                                                    dimensionH  : 24 * 1                                ,
//                                                                  dimensionH  : 24 * 1                                ,
                                                                    isDragging  : false                                 ,
//                                                                  isDragging  : false                                 ,
                                                                    offsetX     : 0                                     ,
//                                                                  offsetX     : 0                                     ,
                                                                    offsetY     : 0                                     ,
//                                                                  offsetY     : 0                                     ,
                                                                    spacings    : 24                                    ,
//                                                                  spacings    : 24                                    ,
                                                                    wrapMode    : null!                                 ,
//                                                                  wrapMode    : null!                                 ,
                                                                }
//                                                              }
                                                            , }
//                                                          , }
            ];
//          ];


            global.globalState.editorSnapshotsUndoStack.push({
//          global.globalState.editorSnapshotsUndoStack.push({
                undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//              undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                    global.globalState.effectsUsedForFiltering.pop();
//                  global.globalState.effectsUsedForFiltering.pop();
                    /*
                    global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//                  global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                    */
                }
//              }
                ,
//              ,
                redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//              redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                    global.globalState.effectsUsedForFiltering = [ ...
//                  global.globalState.effectsUsedForFiltering = [ ...
                        global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
//                      global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
                                                                    ,   fragmentShaderSourceCode________: null
//                                                                  ,   fragmentShaderSourceCode________: null
                                                                    ,   fragmentShader______GLSLUniforms: null
//                                                                  ,   fragmentShader______GLSLUniforms: null
                                                                    ,   fragmentShaderFiltering_Instance: null
//                                                                  ,   fragmentShaderFiltering_Instance: null
                                                                    ,   fragmentShader_HTMLSelectElement: null
//                                                                  ,   fragmentShader_HTMLSelectElement: null
                                                                    ,   draggableText                   : {
//                                                                  ,   draggableText                   : {
                                                                            colorFilling: { r: 0, g: 0, b: 0, a: 255 }          ,
//                                                                          colorFilling: { r: 0, g: 0, b: 0, a: 255 }          ,
                                                                            colorOutline: { r: 0, g: 0, b: 0, a: 255 }          ,
//                                                                          colorOutline: { r: 0, g: 0, b: 0, a: 255 }          ,
                                                                            fontSize    : 24                                    ,
//                                                                          fontSize    : 24                                    ,
                                                                            contents    : "Text"                                ,
//                                                                          contents    : "Text"                                ,
                                                                            alignHOption: "center"                              ,
//                                                                          alignHOption: "center"                              ,
                                                                            alignVOption: "center"                              ,
//                                                                          alignVOption: "center"                              ,
                                                                            font        : this.appState.canvasState.defaultFont!,
//                                                                          font        : this.appState.canvasState.defaultFont!,
                                                                            stylesOption: "normal"                              ,
//                                                                          stylesOption: "normal"                              ,
                                                                            positionX   : 0                                     ,
//                                                                          positionX   : 0                                     ,
                                                                            positionY   : 0                                     ,
//                                                                          positionY   : 0                                     ,
                                                                            dimensionW  : 24 * 4                                ,
//                                                                          dimensionW  : 24 * 4                                ,
                                                                            dimensionH  : 24 * 1                                ,
//                                                                          dimensionH  : 24 * 1                                ,
                                                                            isDragging  : false                                 ,
//                                                                          isDragging  : false                                 ,
                                                                            offsetX     : 0                                     ,
//                                                                          offsetX     : 0                                     ,
                                                                            offsetY     : 0                                     ,
//                                                                          offsetY     : 0                                     ,
                                                                            spacings    : 24                                    ,
//                                                                          spacings    : 24                                    ,
                                                                            wrapMode    : null!                                 ,
//                                                                          wrapMode    : null!                                 ,
                                                                        }
//                                                                      }
                                                                    , }
//                                                                  , }
                    ];
//                  ];
                }
//              }
                ,
//              ,
                dynamicStorage: null
//              dynamicStorage: null
                ,
//              ,
            });
//          });

            await svelte.tick();
//          await svelte.tick();
            this.appState.uiState.bigList.scroll({ top: this.appState.uiState.bigList.scrollHeight, behavior: "smooth", });
//          this.appState.uiState.bigList.scroll({ top: this.appState.uiState.bigList.scrollHeight, behavior: "smooth", });

            await common.makeNewSnackbarSuccess(`A new text effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
//          await common.makeNewSnackbarSuccess(`A new text effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
        }
//      }

        async handleEffectNIChange(e: Event & { currentTarget: EventTarget & HTMLSelectElement }, effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> {
//      async handleEffectNIChange(e: Event & { currentTarget: EventTarget & HTMLSelectElement }, effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> {
            const ele: HTMLSelectElement = e.target as HTMLSelectElement;
//          const ele: HTMLSelectElement = e.target as HTMLSelectElement;
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
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                effect.fragmentShaderSourceType________ = dynamicStorage?.get("undoFragmentShaderSourceType________");
//              effect.fragmentShaderSourceType________ = dynamicStorage?.get("undoFragmentShaderSourceType________");
                effect.fragmentShaderSourceCode________ = dynamicStorage?.get("undoFragmentShaderSourceCode________");
//              effect.fragmentShaderSourceCode________ = dynamicStorage?.get("undoFragmentShaderSourceCode________");
                effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("undoFragmentShader______GLSLUniforms");
//              effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("undoFragmentShader______GLSLUniforms");
                effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("undoFragmentShaderFiltering_Instance");
//              effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("undoFragmentShaderFiltering_Instance");
                effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("undoCachedSelectedIndex");
//              effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("undoCachedSelectedIndex");
            };
//          };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                effect.fragmentShaderSourceType________ = dynamicStorage?.get("redoFragmentShaderSourceType________");
//              effect.fragmentShaderSourceType________ = dynamicStorage?.get("redoFragmentShaderSourceType________");
                effect.fragmentShaderSourceCode________ = dynamicStorage?.get("redoFragmentShaderSourceCode________");
//              effect.fragmentShaderSourceCode________ = dynamicStorage?.get("redoFragmentShaderSourceCode________");
                effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("redoFragmentShader______GLSLUniforms");
//              effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("redoFragmentShader______GLSLUniforms");
                effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("redoFragmentShaderFiltering_Instance");
//              effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("redoFragmentShaderFiltering_Instance");
                effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("redoCachedSelectedIndex");
//              effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("redoCachedSelectedIndex");
            };
//          };
            editorSnapshot.dynamicStorage = new Map<string, any>();
//          editorSnapshot.dynamicStorage = new Map<string, any>();
            editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
//          editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
            editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
//          editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
            editorSnapshot.dynamicStorage.set("undoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
//          editorSnapshot.dynamicStorage.set("undoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
            editorSnapshot.dynamicStorage.set("undoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
//          editorSnapshot.dynamicStorage.set("undoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
            editorSnapshot.dynamicStorage.set("undoCachedSelectedIndex", this.appState.uiState.cachedSelectedIndex);
//          editorSnapshot.dynamicStorage.set("undoCachedSelectedIndex", this.appState.uiState.cachedSelectedIndex);
            this.appState.uiState.cachedSelectedIndex = ele.selectedIndex;
//          this.appState.uiState.cachedSelectedIndex = ele.selectedIndex;
            let shaderName = ele.options[ele.selectedIndex].value;
//          let shaderName = ele.options[ele.selectedIndex].value;
            if (shaderName === "none") {
//          if (shaderName === "none") {
                console.log(`Shader name: ${shaderName}`);
//              console.log(`Shader name: ${shaderName}`);
                effect.fragmentShaderSourceCode________ = null;
//              effect.fragmentShaderSourceCode________ = null;
                effect.fragmentShader______GLSLUniforms = null;
//              effect.fragmentShader______GLSLUniforms = null;
                effect.fragmentShaderFiltering_Instance = null;
//              effect.fragmentShaderFiltering_Instance = null;
                editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
//              editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
                editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
//              editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
                editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
//              editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
                editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
//              editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
                editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", this.appState.uiState.cachedSelectedIndex);
//              editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", this.appState.uiState.cachedSelectedIndex);
            }
//          }
            else {
//          else {
                console.log(`Shader name: ${shaderName}`);
//              console.log(`Shader name: ${shaderName}`);
                let shaderPath = common.Shaders.get(shaderName);
//              let shaderPath = common.Shaders.get(shaderName);
                if (!shaderPath) {
//              if (!shaderPath) {
                    console.log(`Shader path: ${shaderPath} not exist`);
//                  console.log(`Shader path: ${shaderPath} not exist`);
                    return;
//                  return;
                }
//              }
                const shaderRawSourceCode = await this.loadAsset(shaderPath);
//              const shaderRawSourceCode = await this.loadAsset(shaderPath);
                if (shaderName.toLowerCase().trim().includes("lygia")) {
//              if (shaderName.toLowerCase().trim().includes("lygia")) {
                    effect.fragmentShaderSourceCode________ = await common.resolveLygiaAsync(shaderRawSourceCode);
//                  effect.fragmentShaderSourceCode________ = await common.resolveLygiaAsync(shaderRawSourceCode);
                    if (shaderName.includes("LYGIA ColorDitherTriangleNoise")) {
//                  if (shaderName.includes("LYGIA ColorDitherTriangleNoise")) {
                        effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll("HIGHP", "     ", );
//                      effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll("HIGHP", "     ", );
                    }
//                  }
                    else
//                  else
                    if (shaderName.includes("LYGIA FilterJointBilateral")) {
//                  if (shaderName.includes("LYGIA FilterJointBilateral")) {
                        effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll(/\bsample\b/g, "samples", );
//                      effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll(/\bsample\b/g, "samples", );
                    }
//                  }
                }
//              }
                else {
//              else {
                    effect.fragmentShaderSourceCode________ = shaderRawSourceCode;
//                  effect.fragmentShaderSourceCode________ = shaderRawSourceCode;
                }
//              }
                if (effect.fragmentShaderSourceCode________.charAt(0) === "-") {
//              if (effect.fragmentShaderSourceCode________.charAt(0) === "-") {
                    effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.substring(1);
//                  effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.substring(1);
                }
//              }
                console.log($state.snapshot(effect.fragmentShaderSourceCode________));
//              console.log($state.snapshot(effect.fragmentShaderSourceCode________));
                effect.fragmentShader______GLSLUniforms = await common.fetchShaderMetadata(shaderPath); // common.parseGLSL(effect.fragmentShaderSourceCode________);
//              effect.fragmentShader______GLSLUniforms = await common.fetchShaderMetadata(shaderPath); // common.parseGLSL(effect.fragmentShaderSourceCode________);
                console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
//              console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
                effect.fragmentShaderFiltering_Instance = this.appState.canvasState.canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________);
//              effect.fragmentShaderFiltering_Instance = this.appState.canvasState.canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________);
                editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
//              editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
                editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
//              editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
                editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
//              editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
                editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
//              editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
                editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", this.appState.uiState.cachedSelectedIndex);
//              editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", this.appState.uiState.cachedSelectedIndex);
            }
//          }
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleRemoveEffect(effectIndex: number, type: string): Promise<void> {
//      async handleRemoveEffect(effectIndex: number, type: string): Promise<void> {
            global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering.filter((otherEffect: types.EffectUsedForFiltering, otherEffectIndex: number): boolean => otherEffectIndex !== effectIndex);
//          global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering.filter((otherEffect: types.EffectUsedForFiltering, otherEffectIndex: number): boolean => otherEffectIndex !== effectIndex);
            await svelte.tick();
//          await svelte.tick();
            await common.makeNewSnackbarFailure(`An old ${type} effect has been removed - ${global.globalState.effectsUsedForFiltering.length} left`);
//          await common.makeNewSnackbarFailure(`An old ${type} effect has been removed - ${global.globalState.effectsUsedForFiltering.length} left`);
        }
//      }

        async handleAskAI(effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> {
//      async handleAskAI(effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> {
            try
//          try
            {
//          {
                this.appState.uiState.isLoading =  true;
//              this.appState.uiState.isLoading =  true;
                effect.fragmentShaderSourceCode________=`#version 300 es\n` + (await (await ai.promptShader(this.appState.uiState.AIInputPrompts!.value.split(";"))).text()).split("#version 300 es")[1].split("\n").slice(+1 , -1).join("\n").replaceAll("`", "");
//              effect.fragmentShaderSourceCode________=`#version 300 es\n` + (await (await ai.promptShader(this.appState.uiState.AIInputPrompts!.value.split(";"))).text()).split("#version 300 es")[1].split("\n").slice(+1 , -1).join("\n").replaceAll("`", "");
                this.appState.uiState.isLoading = !true;
//              this.appState.uiState.isLoading = !true;
                console.log($state.snapshot(effect.fragmentShaderSourceCode________));
//              console.log($state.snapshot(effect.fragmentShaderSourceCode________));
                effect.fragmentShader______GLSLUniforms = common.parseGLSL(effect.fragmentShaderSourceCode________!);
//              effect.fragmentShader______GLSLUniforms = common.parseGLSL(effect.fragmentShaderSourceCode________!);
                console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
//              console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
                effect.fragmentShaderFiltering_Instance = this.appState.canvasState.canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________!);
//              effect.fragmentShaderFiltering_Instance = this.appState.canvasState.canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________!);
            }
//          }
            catch (err: unknown)
//          catch (err: unknown)
            {
//          {
                await common.makeNewSnackbarFailure("LLM generate effect wrong. Please try again!");
//              await common.makeNewSnackbarFailure("LLM generate effect wrong. Please try again!");
            }
//          }
        }
//      }

        async handleMoveEffectUp(effectIndex: number): Promise<void> {
//      async handleMoveEffectUp(effectIndex: number): Promise<void> {
            let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
            let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
            let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
//          let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
            global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex - 1];
//          global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex - 1];
            global.globalState.effectsUsedForFiltering[effectIndex - 1] = temp;
//          global.globalState.effectsUsedForFiltering[effectIndex - 1] = temp;
            if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
            }
//          }
            if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
            }
//          }
            /*
            global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//          global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
            */
            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
                let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex - 1];
//              let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex - 1];
                global.globalState.effectsUsedForFiltering[effectIndex - 1] = global.globalState.effectsUsedForFiltering[effectIndex];
//              global.globalState.effectsUsedForFiltering[effectIndex - 1] = global.globalState.effectsUsedForFiltering[effectIndex];
                global.globalState.effectsUsedForFiltering[effectIndex] = temp;
//              global.globalState.effectsUsedForFiltering[effectIndex] = temp;
                if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                }
//              }
                if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                }
//              }
                /*
                global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//              global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                */
            };
//          };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
                let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
//              let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
                global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex - 1];
//              global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex - 1];
                global.globalState.effectsUsedForFiltering[effectIndex - 1] = temp;
//              global.globalState.effectsUsedForFiltering[effectIndex - 1] = temp;
                if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                }
//              }
                if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                }
//              }
                /*
                global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//              global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                */
            };
//          };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async handleMoveEffectDown(effectIndex: number): Promise<void> {
//      async handleMoveEffectDown(effectIndex: number): Promise<void> {
            let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
            let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
            let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
//          let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
            global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex + 1];
//          global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex + 1];
            global.globalState.effectsUsedForFiltering[effectIndex + 1] = temp;
//          global.globalState.effectsUsedForFiltering[effectIndex + 1] = temp;
            if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
            }
//          }
            if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index1 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index1 as number;
            }
//          }
            /*
            global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//          global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
            */
            let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//          let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
            editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
                let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex + 1];
//              let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex + 1];
                global.globalState.effectsUsedForFiltering[effectIndex + 1] = global.globalState.effectsUsedForFiltering[effectIndex];
//              global.globalState.effectsUsedForFiltering[effectIndex + 1] = global.globalState.effectsUsedForFiltering[effectIndex];
                global.globalState.effectsUsedForFiltering[effectIndex] = temp;
//              global.globalState.effectsUsedForFiltering[effectIndex] = temp;
                if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index2 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index2 as number;
                }
//              }
                if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                }
//              }
                /*
                global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//              global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                */
            };
//          };
            editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
                let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//              let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
//              let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
                global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex + 1];
//              global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex + 1];
                global.globalState.effectsUsedForFiltering[effectIndex + 1] = temp;
//              global.globalState.effectsUsedForFiltering[effectIndex + 1] = temp;
                if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                }
//              }
                if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//              if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                    global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index1 as number;
//                  global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index1 as number;
                }
//              }
                /*
                global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//              global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                */
            };
//          };
            global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
        }
//      }

        async loadAsset(assetPath: string): Promise<string> {
//      async loadAsset(assetPath: string): Promise<string> {
            return (await fetch(assetPath)).text();
//          return (await fetch(assetPath)).text();
        }
//      }

        handleUpdate(updatedUniforms: types.GLSLUniforms): void {
//      handleUpdate(updatedUniforms: types.GLSLUniforms): void {
        }
//      }

        async handleVideoRewind(): Promise<void> {
//      async handleVideoRewind(): Promise<void> {
            this.appState.mediaState.video?.time(this.appState.mediaState.video?.time() - 10);
//          this.appState.mediaState.video?.time(this.appState.mediaState.video?.time() - 10);
        }
//      }

        async handleVideoPlayPause(): Promise<void> {
//      async handleVideoPlayPause(): Promise<void> {
            if (!this.appState.mediaState.videoIsPlaying) { this.appState.mediaState.video?.play(); } else { this.appState.mediaState.video?.pause(); }
//          if (!this.appState.mediaState.videoIsPlaying) { this.appState.mediaState.video?.play(); } else { this.appState.mediaState.video?.pause(); }
            this.appState.mediaState.videoIsPlaying = !this.appState.mediaState.videoIsPlaying;
//          this.appState.mediaState.videoIsPlaying = !this.appState.mediaState.videoIsPlaying;
        }
//      }

        async handleVideoForward(): Promise<void> {
//      async handleVideoForward(): Promise<void> {
            this.appState.mediaState.video?.time(this.appState.mediaState.video?.time() + 10);
//          this.appState.mediaState.video?.time(this.appState.mediaState.video?.time() + 10);
        }
//      }

        async handleVideoVolumeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
//      async handleVideoVolumeChange(e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> {
            const ele: HTMLInputElement = e.target as HTMLInputElement;
//          const ele: HTMLInputElement = e.target as HTMLInputElement;
            this.appState.mediaState.video?.volume(ele.valueAsNumber);
//          this.appState.mediaState.video?.volume(ele.valueAsNumber);
        }
//      }

        async handleUndo(): Promise<void> {
//      async handleUndo(): Promise<void> {
            await common.onUndoActionExecuted();
//          await common.onUndoActionExecuted();
        }
//      }

        async handleRedo(): Promise<void> {
//      async handleRedo(): Promise<void> {
            await common.onRedoActionExecuted();
//          await common.onRedoActionExecuted();
        }
//      }
    }
//  }
