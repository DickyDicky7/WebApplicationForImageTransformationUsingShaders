
<svelte:options runes={true}></svelte:options>
<script lang="ts">
    import * as ai from "./a.i.effects";
//  import * as ai from "./a.i.effects";
    import "beercss";
//  import "beercss";
    import "material-dynamic-colors";
//  import "material-dynamic-colors";
    import * as t from "svelte/transition";
//  import * as t from "svelte/transition";
    import * as global from "./global.svelte";
//  import * as global from "./global.svelte";
    import * as common from "./common";
//  import * as common from "./common";
    import * as svelte from "svelte";
//  import * as svelte from "svelte";
    import * as types from "./types";
//  import * as types from "./types";
    import * as lygia from "./lygia";
//  import * as lygia from "./lygia";
    import p5 from "p5";
//  import p5 from "p5";
    import SFMonoRegularURL from "./assets/fonts/SF-Mono-Regular.otf";
//  import SFMonoRegularURL from "./assets/fonts/SF-Mono-Regular.otf";
    import GlslUniform from "./GLSLUniform.svelte";
//  import GlslUniform from "./GLSLUniform.svelte";
    import DraggableTextComponent from "./DraggableTextComponent.svelte";
//  import DraggableTextComponent from "./DraggableTextComponent.svelte";
    import MouseCursor from "./MouseCursor.svelte";
//  import MouseCursor from "./MouseCursor.svelte";
    import SnackbarSuccess from "./SnackbarSuccess.svelte";
//  import SnackbarSuccess from "./SnackbarSuccess.svelte";
    import SnackbarFailure from "./SnackbarFailure.svelte";
//  import SnackbarFailure from "./SnackbarFailure.svelte";

    // Global Variables & Constants
//  // Global Variables & Constants
    const DEFAULT_CANVAS_SIZE = { WIDTH_: 500, HEIGHT: 500 };
//  const DEFAULT_CANVAS_SIZE = { WIDTH_: 500, HEIGHT: 500 };
    const DPR = window.devicePixelRatio || 1;
//  const DPR = window.devicePixelRatio || 1;
    //  const DPR = window.devicePixelRatio || 2 ;
//  //  const DPR = window.devicePixelRatio || 2 ;

    const videoFormats = [
//  const videoFormats = [
        { mimeType: "video/webm; codecs=vp9", extension: "webm", blobType: "video/webm", },
//      { mimeType: "video/webm; codecs=vp9", extension: "webm", blobType: "video/webm", },
        { mimeType: "video/mp4; codecs=avc1", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=avc1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=hev1", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=hev1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=hvc1", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=hvc1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=mp4v", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=mp4v", extension: "mp4" , blobType: "video/mp4" , },
    ] as const;
//  ] as const;
    const imageFormats = [
//  const imageFormats = [
        { extension: "png" , blobType: "image/png" , },
//      { extension: "png" , blobType: "image/png" , },
        { extension: "jpeg", blobType: "image/jpeg", },
//      { extension: "jpeg", blobType: "image/jpeg", },
        { extension: "webp", blobType: "image/webp", },
//      { extension: "webp", blobType: "image/webp", },
        { extension: "jpg" , blobType: "image/jpg" , },
//      { extension: "jpg" , blobType: "image/jpg" , },
    ] as const;
//  ] as const;
    type VideoFormat = typeof videoFormats[number];
//  type VideoFormat = typeof videoFormats[number];
    type ImageFormat = typeof imageFormats[number];
//  type ImageFormat = typeof imageFormats[number];


    let defaultFont = $state<p5.Font>(null!);
//  let defaultFont = $state<p5.Font>(null!);
    //  let defaultFont = $state<p5.Font>();
//  //  let defaultFont = $state<p5.Font>();
    let canvasBG = $state<HTMLElement>(null!);
//  let canvasBG = $state<HTMLElement>(null!);
    let canvas = $state<HTMLElement>(null!);
//  let canvas = $state<HTMLElement>(null!);
    let canvasInstance = $state<p5>(null!);
//  let canvasInstance = $state<p5>(null!);
    let bufferInstance = $state<p5.Graphics>(null!);
//  let bufferInstance = $state<p5.Graphics>(null!);
    let bgURLs: string[] = [
//  let bgURLs: string[] = [
        "/shadertoy/bg1.1.glsl",
//      "/shadertoy/bg1.1.glsl",
        "/shadertoy/bg2.1.glsl",
//      "/shadertoy/bg2.1.glsl",
        "/shadertoy/bg2.2.glsl",
//      "/shadertoy/bg2.2.glsl",
        "/shadertoy/bg2.3.glsl",
//      "/shadertoy/bg2.3.glsl",
        "/shadertoy/bg2.4.glsl",
//      "/shadertoy/bg2.4.glsl",
        "/shadertoy/bg3.1.glsl",
//      "/shadertoy/bg3.1.glsl",
        "/shadertoy/bg4.1.glsl",
//      "/shadertoy/bg4.1.glsl",
        "/shadertoy/bg5.1.glsl",
//      "/shadertoy/bg5.1.glsl",
        "/shadertoy/bg6.1.glsl",
//      "/shadertoy/bg6.1.glsl",
        "/shadertoy/bg7.1.glsl",
//      "/shadertoy/bg7.1.glsl",
        "/shadertoy/bg8.1.glsl",
//      "/shadertoy/bg8.1.glsl",
        "/shadertoy/bg9.1.glsl",
//      "/shadertoy/bg9.1.glsl",
        "/shadertoy/bg11.1.glsl",
//      "/shadertoy/bg11.1.glsl",
        "/shadertoy/bg12.1.glsl",
//      "/shadertoy/bg12.1.glsl",
        "/shadertoy/bg13.1.glsl",
//      "/shadertoy/bg13.1.glsl",
    ];
//  ];
    let input = $state<HTMLInputElement>(null!);
//  let input = $state<HTMLInputElement>(null!);
    //  let input = $state<HTMLInputElement>();
//  //  let input = $state<HTMLInputElement>();
    let fps = $state(120);
//  let fps = $state(120);
    let downloadStream = $state<MediaStream>(null!);
//  let downloadStream = $state<MediaStream>(null!);
    let downloadStreamWebCam = $state<MediaStream>(null!);
//  let downloadStreamWebCam = $state<MediaStream>(null!);
    let videoStream = $state<MediaStream>(null!);
//  let videoStream = $state<MediaStream>(null!);
    let audioStream = $state<MediaStream>(null!);
//  let audioStream = $state<MediaStream>(null!);
    let mediaRecorder = $state<MediaRecorder>(null!);
//  let mediaRecorder = $state<MediaRecorder>(null!);
    let mediaRecorderWebCam = $state<MediaRecorder>(null!);
//  let mediaRecorderWebCam = $state<MediaRecorder>(null!);
    let video_FileBLOB = $state<string>(null!);
//  let video_FileBLOB = $state<string>(null!);
    let image_FileBLOB = $state<string>(null!);
//  let image_FileBLOB = $state<string>(null!);
    let video = $state<p5.MediaElement>(null!);
//  let video = $state<p5.MediaElement>(null!);
    let image = $state<p5.MediaElement>(null!);
//  let image = $state<p5.MediaElement>(null!);
    let catchFirstTime = $state<boolean>(false);
//  let catchFirstTime = $state<boolean>(false);
    let startRecord = $state<boolean>(!false);
//  let startRecord = $state<boolean>(!false);
    let ceaseRecord = $state<boolean>(false);
//  let ceaseRecord = $state<boolean>(false);
    let fshotRecord = $state<boolean>(false);
//  let fshotRecord = $state<boolean>(false);
    let sshotRecord = $state<boolean>(false);
//  let sshotRecord = $state<boolean>(false);
    let graphicsObj = $state<p5.Graphics>();
//  let graphicsObj = $state<p5.Graphics>();
    let webcamCapture = $state<p5.Element>(null!);
//  let webcamCapture = $state<p5.Element>(null!);
    let imageFormatSelection = $state<HTMLSelectElement>(null!);
//  let imageFormatSelection = $state<HTMLSelectElement>(null!);
    let videoFormatSelection = $state<HTMLSelectElement>(null!);
//  let videoFormatSelection = $state<HTMLSelectElement>(null!);
    let videoProgressSlider_ = $state<HTMLProgressElement>(null!);
//  let videoProgressSlider_ = $state<HTMLProgressElement>(null!);
    let videoToShare = $state<Blob>();
//  let videoToShare = $state<Blob>();
    let imageToShare = $state<Blob>();
//  let imageToShare = $state<Blob>();
    let mode = $state<types.MODE>(types.MODE.IMAGE);
//  let mode = $state<types.MODE>(types.MODE.IMAGE);
    let modeCaptureImage = $state<types.MODE_CAPTURE_IMAGE>(types.MODE_CAPTURE_IMAGE.AS_IMAGE);
//  let modeCaptureImage = $state<types.MODE_CAPTURE_IMAGE>(types.MODE_CAPTURE_IMAGE.AS_IMAGE);
    let modeCAptureVideo = $state<types.MODE_CAPTURE_VIDEO>(types.MODE_CAPTURE_VIDEO.AS_VIDEO_FULLSHOT);
//  let modeCAptureVideo = $state<types.MODE_CAPTURE_VIDEO>(types.MODE_CAPTURE_VIDEO.AS_VIDEO_FULLSHOT);
    let videoIsPlaying = $state(false);
//  let videoIsPlaying = $state(false);
    let imageIsPlaying = $state(false);
//  let imageIsPlaying = $state(false);
    let AIInputPrompts = $state<HTMLInputElement>(null!);
//  let AIInputPrompts = $state<HTMLInputElement>(null!);
    let cachedSelectedIndex = $state(0);
//  let cachedSelectedIndex = $state(0);
    let draggableText = $state<types.DraggableText>(null!);
//  let draggableText = $state<types.DraggableText>(null!);
    let recording = $state(false);
//  let recording = $state(false);
    //  let recording: boolean = false;
//  //  let recording: boolean = false;
    let selectedCaptureOption = $state("Snapshot");
//  let selectedCaptureOption = $state("Snapshot");
    //  let selectedCaptureOption: string = "Snapshot";
//  //  let selectedCaptureOption: string = "Snapshot";
    let bigList = $state<HTMLDivElement>(null!);
//  let bigList = $state<HTMLDivElement>(null!);
    //  let bigList: HTMLDivElement = null!;
//  //  let bigList: HTMLDivElement = null!;
    let isLoading = $state(false);
//  let isLoading = $state(false);
    //  let isLoading: boolean = false;
//  //  let isLoading: boolean = false;

    const p5Logic = (p: p5): void => {
//  const p5Logic = (p: p5): void => {
        p.mousePressed = (e?: object): void => {
//      p.mousePressed = (e?: object): void => {
            for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//          for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                if (fragmentShaderSourceType________) {
//              if (fragmentShaderSourceType________) {
                    continue;
//                  continue;
                }
//              }
                if (!draggableText) {
//              if (!draggableText) {
                    continue;
//                  continue;
                }
//              }
                common.onMousePressed(draggableText, p);
//              common.onMousePressed(draggableText, p);
            }
//          }
        };
//      };
        p.mouseDragged = (e?: object): void => {
//      p.mouseDragged = (e?: object): void => {
            for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//          for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                if (fragmentShaderSourceType________) {
//              if (fragmentShaderSourceType________) {
                    continue;
//                  continue;
                }
//              }
                if (!draggableText) {
//              if (!draggableText) {
                    continue;
//                  continue;
                }
//              }
                common.startDragging(draggableText, p);
//              common.startDragging(draggableText, p);
            }
//          }
        };
//      };
        p.mouseReleased = (e?: object): void => {
//      p.mouseReleased = (e?: object): void => {
            for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//          for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                if (fragmentShaderSourceType________) {
//              if (fragmentShaderSourceType________) {
                    continue;
//                  continue;
                }
//              }
                if (!draggableText) {
//              if (!draggableText) {
                    continue;
//                  continue;
                }
//              }
                common.ceaseDragging(draggableText, p);
//              common.ceaseDragging(draggableText, p);
            }
//          }
        };
//      };
        p.setup = async (): Promise<void> => {
//      p.setup = async (): Promise<void> => {
            defaultFont = await p.loadFont(SFMonoRegularURL);
//          defaultFont = await p.loadFont(SFMonoRegularURL);
            /*
            draggableText.font = defaultFont;
//          draggableText.font = defaultFont;
            */
            p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: true, perPixelLighting: true, });
//          p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: true, perPixelLighting: true, });
            p.createCanvas( Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
//          p.createCanvas( Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                            Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
//                          Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
                            p.WEBGL );
//                          p.WEBGL );
            p.background(255);
//          p.background(255);
            p.imageMode(p.CENTER);
//          p.imageMode(p.CENTER);
            p.frameRate(fps);
//          p.frameRate(fps);
            p.disableFriendlyErrors = true;
//          p.disableFriendlyErrors = true;
    //EXPERIMENT
//  //EXPERIMENT
            p.noLights();
//          p.noLights();
            p.noDebugMode();
//          p.noDebugMode();
            p.noSmooth();
//          p.noSmooth();
    //EXPERIMENT
//  //EXPERIMENT
        };
//      };
        p.draw = (): void => {
//      p.draw = (): void => {
            p.background(255);
//          p.background(255);
            for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
//          for (let { fragmentShaderSourceType________, draggableText } of global.globalState.effectsUsedForFiltering) {
                if (fragmentShaderSourceType________) {
//              if (fragmentShaderSourceType________) {
                    continue;
//                  continue;
                }
//              }
                if (!draggableText) {
//              if (!draggableText) {
                    continue;
//                  continue;
                }
//              }
                common.display(draggableText, p);
//              common.display(draggableText, p);
            }
//          }
        };
//      };
    };
//  };

    svelte.onMount(async (): Promise<void> => {
//  svelte.onMount(async (): Promise<void> => {
        let bgShader: p5.Shader = null!;
//      let bgShader: p5.Shader = null!;
        let chosenBG: string = await loadAsset(bgURLs[Math.floor(Math.random() * 5)]);
//      let chosenBG: string = await loadAsset(bgURLs[Math.floor(Math.random() * 5)]);
        let bgCanvasInstance: p5 = new p5((p: p5): void => {
//      let bgCanvasInstance: p5 = new p5((p: p5): void => {
            p.setup = async (): Promise<void> => {
//          p.setup = async (): Promise<void> => {
                p.setAttributes({
//              p.setAttributes({
                    antialias: false,
//                  antialias: false,
                    alpha: false,
//                  alpha: false,
                    depth: false,
//                  depth: false,
                    stencil: false,
//                  stencil: false,
                    premultipliedAlpha: false,
//                  premultipliedAlpha: false,
                    preserveDrawingBuffer: false,
//                  preserveDrawingBuffer: false,
                    perPixelLighting: true,
//                  perPixelLighting: true,
                });
//              });
                p.createCanvas(window.innerWidth, window.innerHeight, p.WEBGL);
//              p.createCanvas(window.innerWidth, window.innerHeight, p.WEBGL);
                p.disableFriendlyErrors = true;
//              p.disableFriendlyErrors = true;
                p.noLights();
//              p.noLights();
                p.noDebugMode();
//              p.noDebugMode();
                p.noSmooth();
//              p.noSmooth();
                bgShader = p.createFilterShader(chosenBG);
//              bgShader = p.createFilterShader(chosenBG);
            };
//          };
            p.draw = (): void => {
//          p.draw = (): void => {
                bgShader.setUniform("time", p.millis() / 1000);
//              bgShader.setUniform("time", p.millis() / 1000);
                p.filter(bgShader);
//              p.filter(bgShader);
            };
//          };
        }, canvasBG);
//      }, canvasBG);
        canvasInstance = new p5(p5Logic, canvas);
//      canvasInstance = new p5(p5Logic, canvas);
        /*
        bufferInstance =
//      bufferInstance =
        canvasInstance.createGraphics(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
//      canvasInstance.createGraphics(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                                      Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
//                                    Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
        canvasInstance.WEBGL,        );
//      canvasInstance.WEBGL,        );
        */
        await ui("theme", "#000000");
//      await ui("theme", "#000000");
        await ui("mode", "dark");
//      await ui("mode", "dark");
    });
//  });

    const successCallback = (image_Instance: p5.Image): void => {
//  const successCallback = (image_Instance: p5.Image): void => {
        if (video) {
//      if (video) {
            video.remove();
//          video.remove();
        }
//      }
        let imageRatio: number = 1.0;
//      let imageRatio: number = 1.0;
        canvasInstance.resizeCanvas(image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
//      canvasInstance.resizeCanvas(image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
        image_Instance.resize      (image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
//      image_Instance.resize      (image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
        canvasInstance.draw = (): void => {
//      canvasInstance.draw = (): void => {
            canvasInstance.textureWrap("repeat");
//          canvasInstance.textureWrap("repeat");
            canvasInstance.image(image_Instance, 0.0, 0.0);
//          canvasInstance.image(image_Instance, 0.0, 0.0);
            for (let {  fragmentShaderSourceType________,
//          for (let {  fragmentShaderSourceType________,
                        fragmentShaderSourceCode________,
//                      fragmentShaderSourceCode________,
                        fragmentShader______GLSLUniforms,
//                      fragmentShader______GLSLUniforms,
                        fragmentShaderFiltering_Instance,
//                      fragmentShaderFiltering_Instance,
                        draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
//                      draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
                if (!fragmentShaderSourceType________) {
//              if (!fragmentShaderSourceType________) {
                    if (!draggableText) { continue; }
//                  if (!draggableText) { continue; }
                    common.display(draggableText, canvasInstance);
//                  common.display(draggableText, canvasInstance);
                    continue;
//                  continue;
                }
//              }
                if (!fragmentShaderSourceCode________) { continue; }
//              if (!fragmentShaderSourceCode________) { continue; }
                if (!fragmentShader______GLSLUniforms) { continue; }
//              if (!fragmentShader______GLSLUniforms) { continue; }
                if (!fragmentShaderFiltering_Instance) { continue; }
//              if (!fragmentShaderFiltering_Instance) { continue; }
                shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
//              shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
                if (fragmentShader______GLSLUniforms) {
//              if (fragmentShader______GLSLUniforms) {
                    for (let glslUniform of fragmentShader______GLSLUniforms) {
//                  for (let glslUniform of fragmentShader______GLSLUniforms) {
                        if (glslUniform.thisUniformType === "sampler2D"
//                      if (glslUniform.thisUniformType === "sampler2D"
                        ||  glslUniform.thisUniformType === "sampler3D") {
//                      ||  glslUniform.thisUniformType === "sampler3D") {
                            if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
//                          if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
                                fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
//                              fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
                            }
//                          }
                        } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
//                      } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
                            fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
//                          fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
                        }
//                      }
                    }
//                  }
                }
//              }
                canvasInstance.filter(fragmentShaderFiltering_Instance);
//              canvasInstance.filter(fragmentShaderFiltering_Instance);
            }
//          }
        };
//      };
        mode = types.MODE.IMAGE;
//      mode = types.MODE.IMAGE;
    };
//  };

    const failureCallback = (event_Instance: Event): void => {
//  const failureCallback = (event_Instance: Event): void => {
        if (canvas.children.length === 2) {
//      if (canvas.children.length === 2) {
            /*
            canvas.children[1].remove();
//          canvas.children[1].remove();
            canvas.children[2].remove();
//          canvas.children[2].remove();
            */
            if (video) { video.remove(); } // the same as the above line of code
//          if (video) { video.remove(); } // the same as the above line of code
        }
//      }
        if (input.files) {
//      if (input.files) {
            if (video_FileBLOB) { window.URL.revokeObjectURL(video_FileBLOB); }
//          if (video_FileBLOB) { window.URL.revokeObjectURL(video_FileBLOB); }
            video_FileBLOB  = window.URL.createObjectURL(input.files[0]);
//          video_FileBLOB  = window.URL.createObjectURL(input.files[0]);
            video = canvasInstance.createVideo(video_FileBLOB);
//          video = canvasInstance.createVideo(video_FileBLOB);
            video?.volume(1.0);
//          video?.volume(1.0);
            video?.hide();
//          video?.hide();
            video?.loop();
//          video?.loop();
            /*
            video?.play();
//          video?.play();
            */
            videoIsPlaying = true;
//          videoIsPlaying = true;
            imageIsPlaying = true;
//          imageIsPlaying = true;
            catchFirstTime =  false;
//          catchFirstTime =  false;
            startRecord    = !false;
//          startRecord    = !false;
            ceaseRecord    =  false;
//          ceaseRecord    =  false;
            /*
            canvasInstance.resizeCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
//          canvasInstance.resizeCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                                        Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
//                                      Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
                                       );
//                                     );
            */
            canvasInstance.resizeCanvas(video.width * 3.0 * DPR, video.height * 3.0 * DPR);
//          canvasInstance.resizeCanvas(video.width * 3.0 * DPR, video.height * 3.0 * DPR);
            canvasInstance.draw = (): void => {
//          canvasInstance.draw = (): void => {
                if (!catchFirstTime
//              if (!catchFirstTime
                &&  !isNaN(video.duration()))
//              &&  !isNaN(video.duration()))
                {
//              {
                    videoProgressSlider_.max = video.duration();
//                  videoProgressSlider_.max = video.duration();
                    catchFirstTime = true;
//                  catchFirstTime = true;
                }
//              }
                canvasInstance.textureWrap("repeat");
//              canvasInstance.textureWrap("repeat");
                /*
                canvasInstance.background(255);
//              canvasInstance.background(255);
                */
                canvasInstance.push();
//              canvasInstance.push();
                canvasInstance.imageMode(canvasInstance.CENTER);
//              canvasInstance.imageMode(canvasInstance.CENTER);
                canvasInstance.image(
//              canvasInstance.image(
                    video,
//                  video,
                    0.0,
//                  0.0,
                    0.0,
//                  0.0,
                    canvasInstance.width ,
//                  canvasInstance.width ,
                    canvasInstance.height,
//                  canvasInstance.height,
                    0.0,
//                  0.0,
                    0.0,
//                  0.0,
                    video.width,
//                  video.width,
                    video.height,
//                  video.height,
                    canvasInstance.COVER,
//                  canvasInstance.COVER,
                );
//              );
                canvasInstance.pop();
//              canvasInstance.pop();
                videoProgressSlider_.value = video.time();
//              videoProgressSlider_.value = video.time();
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
                        common.display(draggableText, canvasInstance);
//                      common.display(draggableText, canvasInstance);
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
                    shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
//                  shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
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
                    canvasInstance.filter(fragmentShaderFiltering_Instance);
//                  canvasInstance.filter(fragmentShaderFiltering_Instance);
                }
//              }
                if (!ceaseRecord
//              if (!ceaseRecord
                &&   fshotRecord
//              &&   fshotRecord
                &&  !isNaN           (video.duration())
//              &&  !isNaN           (video.duration())
                &&   video.time() === video.duration()) {
//              &&   video.time() === video.duration()) {
                    ceaseRecord = true;
//                  ceaseRecord = true;
                    fshotRecord = true;
//                  fshotRecord = true;
                    ceaseCaptureAsVideoFullshot();
//                  ceaseCaptureAsVideoFullshot();
                    recording = false;
//                  recording = false;
                };
//              };
            };
//          };
            mode = types.MODE.VIDEO;
//          mode = types.MODE.VIDEO;
        };
//      };
    };
//  };

    const onChange = async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => {
//  const onChange = async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => {
        const reader: FileReader = new FileReader();
//      const reader: FileReader = new FileReader();
        reader.addEventListener("load", async (): Promise<void> => {
//      reader.addEventListener("load", async (): Promise<void> => {
            if (typeof reader.result === "string") {
//          if (typeof reader.result === "string") {
                await canvasInstance.loadImage(reader.result, successCallback, failureCallback);
//              await canvasInstance.loadImage(reader.result, successCallback, failureCallback);
                /*
                console.log(reader.result);
//              console.log(reader.result);
                */
            }
//          }
        });
//      });
        reader.addEventListener("abort", async (): Promise<void> => {
//      reader.addEventListener("abort", async (): Promise<void> => {
        });
//      });
        reader.addEventListener("error", async (): Promise<void> => {
//      reader.addEventListener("error", async (): Promise<void> => {
        });
//      });
        let file: File | null = null;
//      let file: File | null = null;
        if (input.files && input.files.length >= 1)
//      if (input.files && input.files.length >= 1)
        {
//      {
            file = input.files[0];
//          file = input.files[0];
        }
//      }
        if (file) { reader.readAsDataURL(file); }
//      if (file) { reader.readAsDataURL(file); }
    };
//  };

    // video/webm; codecs=vp9
//  // video/webm; codecs=vp9
    // video/mp4; codecs=avc1
//  // video/mp4; codecs=avc1
    // video/mp4; codecs=hev1
//  // video/mp4; codecs=hev1
    // video/mp4; codecs=hvc1
//  // video/mp4; codecs=hvc1
    // video/mp4; codecs=mp4v
//  // video/mp4; codecs=mp4v

    // image/png;
//  // image/png;
    // image/jpeg;
//  // image/jpeg;
    // image/webp;
//  // image/webp;
    // image/jpg;
//  // image/jpg;

    // DeepAR SDK@@@
//  // DeepAR SDK@@@
    // DeepAR Beauty
//  // DeepAR Beauty

    const shaderSetNecessaryUniforms = (shader: p5.Shader): void => {
//  const shaderSetNecessaryUniforms = (shader: p5.Shader): void => {
        shader.setUniform("time", canvasInstance.millis() / 1000);
//      shader.setUniform("time", canvasInstance.millis() / 1000);
        shader.setUniform("canvasSize", [ canvasInstance.width, canvasInstance.height ]);
//      shader.setUniform("canvasSize", [ canvasInstance.width, canvasInstance.height ]);
        shader.setUniform("texelSize", [ 1.0 / (canvasInstance.width * canvasInstance.pixelDensity()), 1.0 / (canvasInstance.height * canvasInstance.pixelDensity()) ]);
//      shader.setUniform("texelSize", [ 1.0 / (canvasInstance.width * canvasInstance.pixelDensity()), 1.0 / (canvasInstance.height * canvasInstance.pixelDensity()) ]);
        /*
        shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
//      shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
        */
        shader.setUniform("mousePosition", [ canvasInstance.mouseX, canvasInstance.mouseY, canvasInstance.mouseIsPressed ? 1.0 : 0.0, canvasInstance.mouseIsPressed ? 1.0 : 0.0 ]);
//      shader.setUniform("mousePosition", [ canvasInstance.mouseX, canvasInstance.mouseY, canvasInstance.mouseIsPressed ? 1.0 : 0.0, canvasInstance.mouseIsPressed ? 1.0 : 0.0 ]);
        shader.setUniform("frameCount", canvasInstance.frameCount);
//      shader.setUniform("frameCount", canvasInstance.frameCount);
    };
//  };

    const startCaptureAsVideoFullshot = async (): Promise<void> => { // VIDEO: Y | IMAGE: N | WEBCAM: N
//  const startCaptureAsVideoFullshot = async (): Promise<void> => { // VIDEO: Y | IMAGE: N | WEBCAM: N
        fshotRecord = !false;
//      fshotRecord = !false;
        sshotRecord =  false;
//      sshotRecord =  false;
        if (video) {
//      if (video) {
            video.stop();
//          video.stop();
            video.noLoop();
//          video.noLoop();
            video.volume(1.0);
//          video.volume(1.0);
            video.play();
//          video.play();
        }
//      }
        let htmlCanvasElement: HTMLCanvasElement = canvas.children[0] as HTMLCanvasElement;
//      let htmlCanvasElement: HTMLCanvasElement = canvas.children[0] as HTMLCanvasElement;
        let videoElement: HTMLVideoElement = canvas.children[1] as HTMLVideoElement;
//      let videoElement: HTMLVideoElement = canvas.children[1] as HTMLVideoElement;
        let audioContext: AudioContext = new AudioContext();
//      let audioContext: AudioContext = new AudioContext();
        let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
//      let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
        let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
//      let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
        if (mode === types.MODE.VIDEO) {
//      if (mode === types.MODE.VIDEO) {
            let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
//          let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
            mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
//          mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
            mediaElementAudioSourceNode.connect(audioContext.destination);
//          mediaElementAudioSourceNode.connect(audioContext.destination);
        }
//      }
        downloadStream = null!;
//      downloadStream = null!;
        downloadStream = htmlCanvasElement.captureStream(fps);
//      downloadStream = htmlCanvasElement.captureStream(fps);
        if (mode === types.MODE.VIDEO) {
//      if (mode === types.MODE.VIDEO) {
            downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
//          downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
        }
//      }
        const recordedChunkes: BlobPart[] = [];
//      const recordedChunkes: BlobPart[] = [];
        const recordedOptions = { mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
//      const recordedOptions = { mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
        };
//      };
        mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
//      mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
        mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
//      mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
            if (blobEvent.data.size > 0) {
//          if (blobEvent.data.size > 0) {
                recordedChunkes.push(blobEvent.data);
//              recordedChunkes.push(blobEvent.data);
                const blob: Blob = new Blob(recordedChunkes,
//              const blob: Blob = new Blob(recordedChunkes,
                    {
//                  {
                        type: videoFormats[videoFormatSelection.selectedIndex].blobType,
//                      type: videoFormats[videoFormatSelection.selectedIndex].blobType,
                    },
//                  },
                );
//              );
                const url: string = URL.createObjectURL(blob);
//              const url: string = URL.createObjectURL(blob);
                const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
//              const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
                document.body.appendChild(anchor);
//              document.body.appendChild(anchor);
                anchor.href = url;
//              anchor.href = url;
                anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
//              anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
                anchor.click();
//              anchor.click();
                window.URL.revokeObjectURL(url);
//              window.URL.revokeObjectURL(url);
                videoToShare = blob;
//              videoToShare = blob;
                anchor.remove();
//              anchor.remove();
            };
//          };
        };
//      };
        mediaRecorder.start();
//      mediaRecorder.start();
    };
//  };
    const startCaptureAsVideoSnapshot = async (): Promise<void> => { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
//  const startCaptureAsVideoSnapshot = async (): Promise<void> => { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
        fshotRecord =  false;
//      fshotRecord =  false;
        sshotRecord = !false;
//      sshotRecord = !false;
        if (video) {
//      if (video) {
            /*
            video.stop();
//          video.stop();
            video.noLoop();
//          video.noLoop();
            */
            video.loop();
//          video.loop();
            video.volume(1.0);
//          video.volume(1.0);
            video.play();
//          video.play();
        }
//      }
        let htmlCanvasElement: HTMLCanvasElement = canvas.children[0] as HTMLCanvasElement;
//      let htmlCanvasElement: HTMLCanvasElement = canvas.children[0] as HTMLCanvasElement;
        let videoElement: HTMLVideoElement = canvas.children[1] as HTMLVideoElement;
//      let videoElement: HTMLVideoElement = canvas.children[1] as HTMLVideoElement;
        let audioContext: AudioContext = new AudioContext();
//      let audioContext: AudioContext = new AudioContext();
        let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
//      let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
        let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
//      let mediaStreamAudioDestination: MediaStream = mediaStreamAudioDestinationNode.stream;
        if (mode === types.MODE.VIDEO) {
//      if (mode === types.MODE.VIDEO) {
            let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
//          let mediaElementAudioSourceNode: MediaElementAudioSourceNode = audioContext.createMediaElementSource(videoElement);
            mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
//          mediaElementAudioSourceNode.connect(mediaStreamAudioDestinationNode);
            mediaElementAudioSourceNode.connect(audioContext.destination);
//          mediaElementAudioSourceNode.connect(audioContext.destination);
        }
//      }
        downloadStream = null!;
//      downloadStream = null!;
        downloadStream = htmlCanvasElement.captureStream(fps);
//      downloadStream = htmlCanvasElement.captureStream(fps);
        if (mode === types.MODE.VIDEO) {
//      if (mode === types.MODE.VIDEO) {
            downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
//          downloadStream.addTrack(mediaStreamAudioDestination.getAudioTracks()[0]);
        }
//      }
        const recordedChunkes: BlobPart[] = [];
//      const recordedChunkes: BlobPart[] = [];
        const recordedOptions = { mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
//      const recordedOptions = { mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
        };
//      };
        mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
//      mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
        mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
//      mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
            if (blobEvent.data.size > 0) {
//          if (blobEvent.data.size > 0) {
                recordedChunkes.push(blobEvent.data);
//              recordedChunkes.push(blobEvent.data);
                const blob: Blob = new Blob(recordedChunkes,
//              const blob: Blob = new Blob(recordedChunkes,
                    {
//                  {
                        type: videoFormats[videoFormatSelection.selectedIndex].blobType,
//                      type: videoFormats[videoFormatSelection.selectedIndex].blobType,
                    },
//                  },
                );
//              );
                const url: string = URL.createObjectURL(blob);
//              const url: string = URL.createObjectURL(blob);
                const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
//              const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
                document.body.appendChild(anchor);
//              document.body.appendChild(anchor);
                anchor.href = url;
//              anchor.href = url;
                anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
//              anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
                anchor.click();
//              anchor.click();
                window.URL.revokeObjectURL(url);
//              window.URL.revokeObjectURL(url);
                videoToShare = blob;
//              videoToShare = blob;
                anchor.remove();
//              anchor.remove();
            };
//          };
        };
//      };
        mediaRecorder.start();
//      mediaRecorder.start();
    };
//  };
    const startCaptureAsImage = async (): Promise<void> => { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
//  const startCaptureAsImage = async (): Promise<void> => { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
        canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
//      canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
    };
//  };
    const ceaseCaptureAsVideoFullshot = async (): Promise<void> => {
//  const ceaseCaptureAsVideoFullshot = async (): Promise<void> => {
        video?.stop();
//      video?.stop();
        mediaRecorder?.stop();
//      mediaRecorder?.stop();
        mediaRecorder = null!;
//      mediaRecorder = null!;
        mediaRecorderWebCam?.stop();
//      mediaRecorderWebCam?.stop();
        mediaRecorderWebCam = null!;
//      mediaRecorderWebCam = null!;
    };
//  };
    const ceaseCaptureAsVideoSnapshot = async (): Promise<void> => {
//  const ceaseCaptureAsVideoSnapshot = async (): Promise<void> => {
        /*
        video?.stop();
//      video?.stop();
        */
        mediaRecorder?.stop();
//      mediaRecorder?.stop();
        mediaRecorder = null!;
//      mediaRecorder = null!;
        mediaRecorderWebCam?.stop();
//      mediaRecorderWebCam?.stop();
        mediaRecorderWebCam = null!;
//      mediaRecorderWebCam = null!;
    };
//  };
    const ceaseCaptureAsImage = async (): Promise<void> => {
//  const ceaseCaptureAsImage = async (): Promise<void> => {
        canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
//      canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
    };
//  };

    const startWebCam = async(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): Promise<void> => {
//  const startWebCam = async(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): Promise<void> => {
        webcamCapture = canvasInstance.createCapture({ video: { mandatory: { minWidth: 1280, minHeight: 720, }, optional: [{ maxFrameRate: 120, }] }, audio: true, });
//      webcamCapture = canvasInstance.createCapture({ video: { mandatory: { minWidth: 1280, minHeight: 720, }, optional: [{ maxFrameRate: 120, }] }, audio: true, });
        canvasInstance.resizeCanvas(1280 * 2 / 3, 720 * 2 / 3);
//      canvasInstance.resizeCanvas(1280 * 2 / 3, 720 * 2 / 3);
        /*
        canvasInstance.resizeCanvas(DEFAULT_CANVAS_SIZE.WIDTH_, DEFAULT_CANVAS_SIZE.HEIGHT);
//      canvasInstance.resizeCanvas(DEFAULT_CANVAS_SIZE.WIDTH_, DEFAULT_CANVAS_SIZE.HEIGHT);
        */
        webcamCapture.size(canvasInstance.width, canvasInstance.height);
//      webcamCapture.size(canvasInstance.width, canvasInstance.height);
        webcamCapture.hide();
//      webcamCapture.hide();
        canvasInstance.draw = (): void => {
//      canvasInstance.draw = (): void => {
            canvasInstance.textureWrap("repeat");
//          canvasInstance.textureWrap("repeat");
            canvasInstance.image(webcamCapture, 0.0, 0.0);
//          canvasInstance.image(webcamCapture, 0.0, 0.0);
            for (let {  fragmentShaderSourceType________,
//          for (let {  fragmentShaderSourceType________,
                        fragmentShaderSourceCode________,
//                      fragmentShaderSourceCode________,
                        fragmentShader______GLSLUniforms,
//                      fragmentShader______GLSLUniforms,
                        fragmentShaderFiltering_Instance,
//                      fragmentShaderFiltering_Instance,
                        draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
//                      draggableText                   ,  } of global.globalState.effectsUsedForFiltering) {
                if (!fragmentShaderSourceType________) {
//              if (!fragmentShaderSourceType________) {
                    if (!draggableText) { continue; }
//                  if (!draggableText) { continue; }
                    common.display(draggableText, canvasInstance);
//                  common.display(draggableText, canvasInstance);
                    continue;
//                  continue;
                }
//              }
                if (!fragmentShaderSourceCode________) { continue; }
//              if (!fragmentShaderSourceCode________) { continue; }
                if (!fragmentShader______GLSLUniforms) { continue; }
//              if (!fragmentShader______GLSLUniforms) { continue; }
                if (!fragmentShaderFiltering_Instance) { continue; }
//              if (!fragmentShaderFiltering_Instance) { continue; }
                shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
//              shaderSetNecessaryUniforms(fragmentShaderFiltering_Instance);
                if (fragmentShader______GLSLUniforms) {
//              if (fragmentShader______GLSLUniforms) {
                    for (let glslUniform of fragmentShader______GLSLUniforms) {
//                  for (let glslUniform of fragmentShader______GLSLUniforms) {
                        if (glslUniform.thisUniformType === "sampler2D"
//                      if (glslUniform.thisUniformType === "sampler2D"
                        ||  glslUniform.thisUniformType === "sampler3D") {
//                      ||  glslUniform.thisUniformType === "sampler3D") {
                            if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
//                          if (glslUniform.thisUniformName && glslUniform.thisUniformSampler2DImg) {
                                fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
//                              fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
                            }
//                          }
                        } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
//                      } else if (glslUniform.thisUniformName && glslUniform.thisUniformDefaultValue) {
                            fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
//                          fragmentShaderFiltering_Instance.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
                        }
//                      }
                    }
//                  }
                }
//              }
                canvasInstance.filter(fragmentShaderFiltering_Instance);
//              canvasInstance.filter(fragmentShaderFiltering_Instance);
            }
//          }
        };
//      };
        mode = types.MODE.WEBCAM;
//      mode = types.MODE.WEBCAM;
    };
//  };

    const ceaseWebCam = (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): void => {
//  const ceaseWebCam = (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }): void => {
        mediaRecorder?.stop();
//      mediaRecorder?.stop();
        mediaRecorder = null!;
//      mediaRecorder = null!;
        mediaRecorderWebCam?.stop();
//      mediaRecorderWebCam?.stop();
        mediaRecorderWebCam = null!;
//      mediaRecorderWebCam = null!;
        webcamCapture.remove();
//      webcamCapture.remove();
        webcamCapture = null!;
//      webcamCapture = null!;
        canvasInstance.draw = (): void => {
//      canvasInstance.draw = (): void => {
            canvasInstance.background(255);
//          canvasInstance.background(255);
        };
//      };
    };
//  };

    //sbs_-_noise_texture_pack_-_128x128
//  //sbs_-_noise_texture_pack_-_128x128
    //  128x128
//  //  128x128
    //sbs_-_noise_texture_pack_-_256x256
//  //sbs_-_noise_texture_pack_-_256x256
    //  256x256
//  //  256x256
    //sbs_-_noise_texture_pack_-_512x512
//  //sbs_-_noise_texture_pack_-_512x512
    //  512x512
//  //  512x512

    //Cracks       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Cracks       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Craters      (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Craters      (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Gabor        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Gabor        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Grainy       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Grainy       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Manifold     (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Manifold     (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Marble       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Marble       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Melt         (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Melt         (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Milky        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Milky        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Perlin       (128x128: 1 - 24) (256x256: 1 - 24) (512x512: 1 - 24) random
//  //Perlin       (128x128: 1 - 24) (256x256: 1 - 24) (512x512: 1 - 24) random
    //Spokes       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Spokes       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Streak       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Streak       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Super Noise  (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Super Noise  (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Super Perlin (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Super Perlin (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Swirl        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Swirl        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Techno       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Techno       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Turbulence   (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Turbulence   (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Vein         (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Vein         (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
    //Voronoi      (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//  //Voronoi      (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random

    window.addEventListener("keydown", async (e: KeyboardEvent): Promise<void> => {
//  window.addEventListener("keydown", async (e: KeyboardEvent): Promise<void> => {
        if (e.ctrlKey && e.key === "z") {
//      if (e.ctrlKey && e.key === "z") {
            await common.onUndoActionExecuted();
//          await common.onUndoActionExecuted();
            console.log("undo");
//          console.log("undo");
        }
//      }
        else
//      else
        if (e.ctrlKey && e.key === "y") {
//      if (e.ctrlKey && e.key === "y") {
            await common.onRedoActionExecuted();
//          await common.onRedoActionExecuted();
            console.log("redo");
//          console.log("redo");
        }
//      }
    });
//  });

    svelte.onMount(async (): Promise<void> => {
//  svelte.onMount(async (): Promise<void> => {
        global.globalState.texturesNoise     = [... global.globalState.texturesNoise    , ... await common.fetchAllTextures_Noise    (               )].sort();
//      global.globalState.texturesNoise     = [... global.globalState.texturesNoise    , ... await common.fetchAllTextures_Noise    (               )].sort();
        global.globalState.texturesBayer     = [... global.globalState.texturesBayer    , ... await common.fetchAllTextures_Bayer    (               )].sort();
//      global.globalState.texturesBayer     = [... global.globalState.texturesBayer    , ... await common.fetchAllTextures_Bayer    (               )].sort();
        global.globalState.texturesPalette   = [... global.globalState.texturesPalette  , ... await common.fetchAllTextures_Palette  (global.supabase)].sort();
//      global.globalState.texturesPalette   = [... global.globalState.texturesPalette  , ... await common.fetchAllTextures_Palette  (global.supabase)].sort();
        global.globalState.texturesPencil_   = [... global.globalState.texturesPencil_  , ... await common.fetchAllTextures_Pencil_  (global.supabase)].sort();
//      global.globalState.texturesPencil_   = [... global.globalState.texturesPencil_  , ... await common.fetchAllTextures_Pencil_  (global.supabase)].sort();
        global.globalState.texturesASCII     = [... global.globalState.texturesASCII    , ... await common.fetchAllTextures_ASCII    (global.supabase)].sort();
//      global.globalState.texturesASCII     = [... global.globalState.texturesASCII    , ... await common.fetchAllTextures_ASCII    (global.supabase)].sort();
        global.globalState.texturesTiled     = [... global.globalState.texturesTiled    , ... await common.fetchAllTextures_Tiled    (global.supabase)].sort();
//      global.globalState.texturesTiled     = [... global.globalState.texturesTiled    , ... await common.fetchAllTextures_Tiled    (global.supabase)].sort();
        global.globalState.texturesShaderToy = [... global.globalState.texturesShaderToy, ... await common.fetchAllTextures_ShaderToy(global.supabase)].sort();
//      global.globalState.texturesShaderToy = [... global.globalState.texturesShaderToy, ... await common.fetchAllTextures_ShaderToy(global.supabase)].sort();
        global.globalState.customFonts = [... global.globalState.customFonts, ... await common.fetchAllFonts_TTF_ITCHIO(global.supabase), ... await common.fetchAllFonts_OTF_ITCHIO(global.supabase)].sort();
//      global.globalState.customFonts = [... global.globalState.customFonts, ... await common.fetchAllFonts_TTF_ITCHIO(global.supabase), ... await common.fetchAllFonts_OTF_ITCHIO(global.supabase)].sort();
    });
//  });

    //imgur video/image
//  //imgur video/image
    //Giphy gif@@/gif@@
//  //Giphy gif@@/gif@@

    //PREVIEW
//  //PREVIEW
    //IMAGE
//  //IMAGE
    //VIDEO
//  //VIDEO
    //GIF
//  //GIF

    const loadAsset = async(assetPath: string): Promise<string> => {
//  const loadAsset = async(assetPath: string): Promise<string> => {
        return (await fetch(assetPath)).text();
//      return (await fetch(assetPath)).text();
    };
//  };

    svelte.onDestroy(async (): Promise<void> => {
//  svelte.onDestroy(async (): Promise<void> => {
        canvasInstance.remove();
//      canvasInstance.remove();
    });
//  });

    const handleUpdate = (updatedUniforms: types.GLSLUniforms): void => {
//  const handleUpdate = (updatedUniforms: types.GLSLUniforms): void => {
    };
//  };

    const handleCaptureAsVideo = async(): Promise<void> => {
//  const handleCaptureAsVideo = async(): Promise<void> => {
        if (recording === false) {
//      if (recording === false) {
            recording = true;
//          recording = true;
            if (selectedCaptureOption === "Snapshot") {
//          if (selectedCaptureOption === "Snapshot") {
                await startCaptureAsVideoSnapshot();
//              await startCaptureAsVideoSnapshot();
            }
//          }
            else
//          else
            if (selectedCaptureOption === "Fullshot") {
//          if (selectedCaptureOption === "Fullshot") {
                await startCaptureAsVideoFullshot();
//              await startCaptureAsVideoFullshot();
            }
//          }
        }
//      }
        else {
//      else {
            recording = false;
//          recording = false;
            if (selectedCaptureOption === "Snapshot") {
//          if (selectedCaptureOption === "Snapshot") {
                await ceaseCaptureAsVideoSnapshot();
//              await ceaseCaptureAsVideoSnapshot();
            }
//          }
            else
//          else
            if (selectedCaptureOption === "Fullshot") {
//          if (selectedCaptureOption === "Fullshot") {
                await ceaseCaptureAsVideoFullshot();
//              await ceaseCaptureAsVideoFullshot();
            }
//          }
        }
//      }
    };
//  };

    const toggleWebCam = (e: Event & { currentTarget: EventTarget & HTMLInputElement }): void => {
//  const toggleWebCam = (e: Event & { currentTarget: EventTarget & HTMLInputElement }): void => {
        const fakeMouseEvent: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement } = new MouseEvent("click", { bubbles: true, cancelable: true, }) as MouseEvent & { currentTarget: EventTarget & HTMLButtonElement };
//      const fakeMouseEvent: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement } = new MouseEvent("click", { bubbles: true, cancelable: true, }) as MouseEvent & { currentTarget: EventTarget & HTMLButtonElement };
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        if (ele.checked) {
//      if (ele.checked) {
            startWebCam(fakeMouseEvent);
//          startWebCam(fakeMouseEvent);
        }
//      }
        else {
//      else {
            ceaseWebCam(fakeMouseEvent);
//          ceaseWebCam(fakeMouseEvent);
        }
//      }
    };
//  };

    const handleStartCaptureAsImage = async (e: MouseEvent): Promise<void> => {
//  const handleStartCaptureAsImage = async (e: MouseEvent): Promise<void> => {
        await startCaptureAsImage();
//      await startCaptureAsImage();
    };
//  };

    const handleVideoToggle = async (e: MouseEvent): Promise<void> => {
//  const handleVideoToggle = async (e: MouseEvent): Promise<void> => {
        await handleCaptureAsVideo();
//      await handleCaptureAsVideo();
    };
//  };

    const handleShare = async (e: MouseEvent): Promise<void> => {
//  const handleShare = async (e: MouseEvent): Promise<void> => {
        if (mode === types.MODE.IMAGE) {
//      if (mode === types.MODE.IMAGE) {
            await common.shareImage(canvas.children[0] as HTMLCanvasElement);
//          await common.shareImage(canvas.children[0] as HTMLCanvasElement);
        }
//      }
        else
//      else
        if (mode === types.MODE.VIDEO && videoToShare) {
//      if (mode === types.MODE.VIDEO && videoToShare) {
            await common.shareVideo(videoToShare, canvas.children[0] as HTMLCanvasElement);
//          await common.shareVideo(videoToShare, canvas.children[0] as HTMLCanvasElement);
        }
//      }
        else
//      else
        if (mode === types.MODE.WEBCAM && videoToShare) {
//      if (mode === types.MODE.WEBCAM && videoToShare) {
            await common.shareWebcam(videoToShare, canvas.children[0] as HTMLCanvasElement);
//          await common.shareWebcam(videoToShare, canvas.children[0] as HTMLCanvasElement);
        }
//      }
    };
//  };

    const handleAddEffectNI = async (e: MouseEvent): Promise<void> => {
//  const handleAddEffectNI = async (e: MouseEvent): Promise<void> => {
        global.globalState.effectsUsedForFiltering = [ ...
//      global.globalState.effectsUsedForFiltering = [ ...
            global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
//          global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
                                                        ,   fragmentShaderSourceCode________: null
//                                                      ,   fragmentShaderSourceCode________: null
                                                        ,   fragmentShader______GLSLUniforms: null
//                                                      ,   fragmentShader______GLSLUniforms: null
                                                        ,   fragmentShaderFiltering_Instance: null
//                                                      ,   fragmentShaderFiltering_Instance: null
                                                        ,   fragmentShader_HTMLSelectElement: null
//                                                      ,   fragmentShader_HTMLSelectElement: null
                                                        ,   draggableText                   : null
//                                                      ,   draggableText                   : null
                                                        , }
//                                                      , }
        ];
//      ];
        global.globalState.editorSnapshotsUndoStack.push({
//      global.globalState.editorSnapshotsUndoStack.push({
            undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                global.globalState.effectsUsedForFiltering.pop();
//              global.globalState.effectsUsedForFiltering.pop();
                /*
                global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//              global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                */
            }
//          }
            ,
//          ,
            redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                global.globalState.effectsUsedForFiltering = [ ...
//              global.globalState.effectsUsedForFiltering = [ ...
                    global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
//                  global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "NI"
                                                                ,   fragmentShaderSourceCode________: null
//                                                              ,   fragmentShaderSourceCode________: null
                                                                ,   fragmentShader______GLSLUniforms: null
//                                                              ,   fragmentShader______GLSLUniforms: null
                                                                ,   fragmentShaderFiltering_Instance: null
//                                                              ,   fragmentShaderFiltering_Instance: null
                                                                ,   fragmentShader_HTMLSelectElement: null
//                                                              ,   fragmentShader_HTMLSelectElement: null
                                                                ,   draggableText                   : null
//                                                              ,   draggableText                   : null
                                                                , }
//                                                              , }
                ];
//              ];
            }
//          }
            ,
//          ,
            dynamicStorage: null
//          dynamicStorage: null
            ,
//          ,
        });
//      });

        await svelte.tick();
//      await svelte.tick();
        bigList.scroll({ top: bigList.scrollHeight, behavior: "smooth", });
//      bigList.scroll({ top: bigList.scrollHeight, behavior: "smooth", });

        await common.makeNewSnackbarSuccess(`A new NI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
//      await common.makeNewSnackbarSuccess(`A new NI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
    };
//  };

    const handleAddEffectAI = async (e: MouseEvent): Promise<void> => {
//  const handleAddEffectAI = async (e: MouseEvent): Promise<void> => {
        global.globalState.effectsUsedForFiltering = [ ...
//      global.globalState.effectsUsedForFiltering = [ ...
            global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
//          global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
                                                        ,   fragmentShaderSourceCode________: null
//                                                      ,   fragmentShaderSourceCode________: null
                                                        ,   fragmentShader______GLSLUniforms: null
//                                                      ,   fragmentShader______GLSLUniforms: null
                                                        ,   fragmentShaderFiltering_Instance: null
//                                                      ,   fragmentShaderFiltering_Instance: null
                                                        ,   fragmentShader_HTMLSelectElement: null
//                                                      ,   fragmentShader_HTMLSelectElement: null
                                                        ,   draggableText                   : null
//                                                      ,   draggableText                   : null
                                                        , }
//                                                      , }
        ];
//      ];
        global.globalState.editorSnapshotsUndoStack.push({
//      global.globalState.editorSnapshotsUndoStack.push({
            undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                global.globalState.effectsUsedForFiltering.pop();
//              global.globalState.effectsUsedForFiltering.pop();
                /*
                global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//              global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                */
            }
//          }
            ,
//          ,
            redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                global.globalState.effectsUsedForFiltering = [ ...
//              global.globalState.effectsUsedForFiltering = [ ...
                    global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
//                  global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: "AI"
                                                                ,   fragmentShaderSourceCode________: null
//                                                              ,   fragmentShaderSourceCode________: null
                                                                ,   fragmentShader______GLSLUniforms: null
//                                                              ,   fragmentShader______GLSLUniforms: null
                                                                ,   fragmentShaderFiltering_Instance: null
//                                                              ,   fragmentShaderFiltering_Instance: null
                                                                ,   fragmentShader_HTMLSelectElement: null
//                                                              ,   fragmentShader_HTMLSelectElement: null
                                                                ,   draggableText                   : null
//                                                              ,   draggableText                   : null
                                                                , }
//                                                              , }
                ];
//              ];
            }
//          }
            ,
//          ,
            dynamicStorage: null
//          dynamicStorage: null
            ,
//          ,
        });
//      });

        await svelte.tick();
//      await svelte.tick();
        bigList.scroll({ top: bigList.scrollHeight, behavior: "smooth", });
//      bigList.scroll({ top: bigList.scrollHeight, behavior: "smooth", });

        await common.makeNewSnackbarSuccess(`A new AI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
//      await common.makeNewSnackbarSuccess(`A new AI effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
    };
//  };

    const handleInsertText = async (e: MouseEvent): Promise<void> => {
//  const handleInsertText = async (e: MouseEvent): Promise<void> => {
        global.globalState.effectsUsedForFiltering = [ ...
//      global.globalState.effectsUsedForFiltering = [ ...
            global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
//          global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
                                                        ,   fragmentShaderSourceCode________: null
//                                                      ,   fragmentShaderSourceCode________: null
                                                        ,   fragmentShader______GLSLUniforms: null
//                                                      ,   fragmentShader______GLSLUniforms: null
                                                        ,   fragmentShaderFiltering_Instance: null
//                                                      ,   fragmentShaderFiltering_Instance: null
                                                        ,   fragmentShader_HTMLSelectElement: null
//                                                      ,   fragmentShader_HTMLSelectElement: null
                                                        ,   draggableText                   : {
//                                                      ,   draggableText                   : {
                                                                colorFilling: { r: 0, g: 0, b: 0, a: 255 },
//                                                              colorFilling: { r: 0, g: 0, b: 0, a: 255 },
                                                                colorOutline: { r: 0, g: 0, b: 0, a: 255 },
//                                                              colorOutline: { r: 0, g: 0, b: 0, a: 255 },
                                                                fontSize    : 24                          ,
//                                                              fontSize    : 24                          ,
                                                                contents    : "Text"                      ,
//                                                              contents    : "Text"                      ,
                                                                alignHOption: "center"                    ,
//                                                              alignHOption: "center"                    ,
                                                                alignVOption: "center"                    ,
//                                                              alignVOption: "center"                    ,
                                                                font        : defaultFont!                ,
//                                                              font        : defaultFont!                ,
                                                                stylesOption: "normal"                    ,
//                                                              stylesOption: "normal"                    ,
                                                                positionX   : 0                           ,
//                                                              positionX   : 0                           ,
                                                                positionY   : 0                           ,
//                                                              positionY   : 0                           ,
                                                                dimensionW  : 24 * 4                      ,
//                                                              dimensionW  : 24 * 4                      ,
                                                                dimensionH  : 24 * 1                      ,
//                                                              dimensionH  : 24 * 1                      ,
                                                                isDragging  : false                       ,
//                                                              isDragging  : false                       ,
                                                                offsetX     : 0                           ,
//                                                              offsetX     : 0                           ,
                                                                offsetY     : 0                           ,
//                                                              offsetY     : 0                           ,
                                                                spacings    : 24                          ,
//                                                              spacings    : 24                          ,
                                                                wrapMode    : null!                       ,
//                                                              wrapMode    : null!                       ,
                                                            }
//                                                          }
                                                        , }
//                                                      , }
        ];
//      ];


        global.globalState.editorSnapshotsUndoStack.push({
//      global.globalState.editorSnapshotsUndoStack.push({
            undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          undo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                global.globalState.effectsUsedForFiltering.pop();
//              global.globalState.effectsUsedForFiltering.pop();
                /*
                global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//              global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
                */
            }
//          }
            ,
//          ,
            redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//          redo: async (dynamicStorage: Map<string, any> | null): Promise<void> => {
                global.globalState.effectsUsedForFiltering = [ ...
//              global.globalState.effectsUsedForFiltering = [ ...
                    global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
//                  global.globalState.effectsUsedForFiltering  , { fragmentShaderSourceType________: null
                                                                ,   fragmentShaderSourceCode________: null
//                                                              ,   fragmentShaderSourceCode________: null
                                                                ,   fragmentShader______GLSLUniforms: null
//                                                              ,   fragmentShader______GLSLUniforms: null
                                                                ,   fragmentShaderFiltering_Instance: null
//                                                              ,   fragmentShaderFiltering_Instance: null
                                                                ,   fragmentShader_HTMLSelectElement: null
//                                                              ,   fragmentShader_HTMLSelectElement: null
                                                                ,   draggableText                   : {
//                                                              ,   draggableText                   : {
                                                                        colorFilling: { r: 0, g: 0, b: 0, a: 255 },
//                                                                      colorFilling: { r: 0, g: 0, b: 0, a: 255 },
                                                                        colorOutline: { r: 0, g: 0, b: 0, a: 255 },
//                                                                      colorOutline: { r: 0, g: 0, b: 0, a: 255 },
                                                                        fontSize    : 24                          ,
//                                                                      fontSize    : 24                          ,
                                                                        contents    : "Text"                      ,
//                                                                      contents    : "Text"                      ,
                                                                        alignHOption: "center"                    ,
//                                                                      alignHOption: "center"                    ,
                                                                        alignVOption: "center"                    ,
//                                                                      alignVOption: "center"                    ,
                                                                        font        : defaultFont!                ,
//                                                                      font        : defaultFont!                ,
                                                                        stylesOption: "normal"                    ,
//                                                                      stylesOption: "normal"                    ,
                                                                        positionX   : 0                           ,
//                                                                      positionX   : 0                           ,
                                                                        positionY   : 0                           ,
//                                                                      positionY   : 0                           ,
                                                                        dimensionW  : 24 * 4                      ,
//                                                                      dimensionW  : 24 * 4                      ,
                                                                        dimensionH  : 24 * 1                      ,
//                                                                      dimensionH  : 24 * 1                      ,
                                                                        isDragging  : false                       ,
//                                                                      isDragging  : false                       ,
                                                                        offsetX     : 0                           ,
//                                                                      offsetX     : 0                           ,
                                                                        offsetY     : 0                           ,
//                                                                      offsetY     : 0                           ,
                                                                        spacings    : 24                          ,
//                                                                      spacings    : 24                          ,
                                                                        wrapMode    : null!                       ,
//                                                                      wrapMode    : null!                       ,
                                                                    }
//                                                                  }
                                                                , }
//                                                              , }
                ];
//              ];
            }
//          }
            ,
//          ,
            dynamicStorage: null
//          dynamicStorage: null
            ,
//          ,
        });
//      });

        await svelte.tick();
//      await svelte.tick();
        bigList.scroll({ top: bigList.scrollHeight, behavior: "smooth", });
//      bigList.scroll({ top: bigList.scrollHeight, behavior: "smooth", });

        await common.makeNewSnackbarSuccess(`A new text effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
//      await common.makeNewSnackbarSuccess(`A new text effect has been added - ${global.globalState.effectsUsedForFiltering.length} so far`);
    };
//  };

    const handleEffectNIChange = async (e: Event & { currentTarget: EventTarget & HTMLSelectElement }, effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> => {
//  const handleEffectNIChange = async (e: Event & { currentTarget: EventTarget & HTMLSelectElement }, effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> => {
        const ele: HTMLSelectElement = e.target as HTMLSelectElement;
//      const ele: HTMLSelectElement = e.target as HTMLSelectElement;
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
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
            effect.fragmentShaderSourceType________ = dynamicStorage?.get("undoFragmentShaderSourceType________");
//          effect.fragmentShaderSourceType________ = dynamicStorage?.get("undoFragmentShaderSourceType________");
            effect.fragmentShaderSourceCode________ = dynamicStorage?.get("undoFragmentShaderSourceCode________");
//          effect.fragmentShaderSourceCode________ = dynamicStorage?.get("undoFragmentShaderSourceCode________");
            effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("undoFragmentShader______GLSLUniforms");
//          effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("undoFragmentShader______GLSLUniforms");
            effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("undoFragmentShaderFiltering_Instance");
//          effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("undoFragmentShaderFiltering_Instance");
            effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("undoCachedSelectedIndex");
//          effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("undoCachedSelectedIndex");
        };
//      };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
            effect.fragmentShaderSourceType________ = dynamicStorage?.get("redoFragmentShaderSourceType________");
//          effect.fragmentShaderSourceType________ = dynamicStorage?.get("redoFragmentShaderSourceType________");
            effect.fragmentShaderSourceCode________ = dynamicStorage?.get("redoFragmentShaderSourceCode________");
//          effect.fragmentShaderSourceCode________ = dynamicStorage?.get("redoFragmentShaderSourceCode________");
            effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("redoFragmentShader______GLSLUniforms");
//          effect.fragmentShader______GLSLUniforms = dynamicStorage?.get("redoFragmentShader______GLSLUniforms");
            effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("redoFragmentShaderFiltering_Instance");
//          effect.fragmentShaderFiltering_Instance = dynamicStorage?.get("redoFragmentShaderFiltering_Instance");
            effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("redoCachedSelectedIndex");
//          effect.fragmentShader_HTMLSelectElement!.selectedIndex! = dynamicStorage?.get("redoCachedSelectedIndex");
        };
//      };
        editorSnapshot.dynamicStorage = new Map<string, any>();
//      editorSnapshot.dynamicStorage = new Map<string, any>();
        editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
//      editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
        editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
//      editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
        editorSnapshot.dynamicStorage.set("undoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
//      editorSnapshot.dynamicStorage.set("undoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
        editorSnapshot.dynamicStorage.set("undoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
//      editorSnapshot.dynamicStorage.set("undoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
        editorSnapshot.dynamicStorage.set("undoCachedSelectedIndex", cachedSelectedIndex);
//      editorSnapshot.dynamicStorage.set("undoCachedSelectedIndex", cachedSelectedIndex);
        cachedSelectedIndex = ele.selectedIndex;
//      cachedSelectedIndex = ele.selectedIndex;
        let shaderName = ele.options[ele.selectedIndex].value;
//      let shaderName = ele.options[ele.selectedIndex].value;
        if (shaderName === "none") {
//      if (shaderName === "none") {
            console.log(`Shader name: ${shaderName}`);
//          console.log(`Shader name: ${shaderName}`);
            effect.fragmentShaderSourceCode________ = null;
//          effect.fragmentShaderSourceCode________ = null;
            effect.fragmentShader______GLSLUniforms = null;
//          effect.fragmentShader______GLSLUniforms = null;
            effect.fragmentShaderFiltering_Instance = null;
//          effect.fragmentShaderFiltering_Instance = null;
            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
//          editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
//          editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
            editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
//          editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
            editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
//          editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
            editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", cachedSelectedIndex);
//          editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", cachedSelectedIndex);
        }
//      }
        else {
//      else {
            console.log(`Shader name: ${shaderName}`);
//          console.log(`Shader name: ${shaderName}`);
            let shaderPath = common.Shaders.get(shaderName);
//          let shaderPath = common.Shaders.get(shaderName);
            if (!shaderPath) {
//          if (!shaderPath) {
                console.log(`Shader path: ${shaderPath} not exist`);
//              console.log(`Shader path: ${shaderPath} not exist`);
                return;
//              return;
            }
//          }
            const shaderRawSourceCode = await loadAsset(shaderPath);
//          const shaderRawSourceCode = await loadAsset(shaderPath);
            if (shaderName.toLowerCase()
//          if (shaderName.toLowerCase()
                                .trim().includes("lygia")) {
//                              .trim().includes("lygia")) {
                effect.fragmentShaderSourceCode________ = await lygia.resolveLygiaAsync(shaderRawSourceCode);
//              effect.fragmentShaderSourceCode________ = await lygia.resolveLygiaAsync(shaderRawSourceCode);
                if (shaderName.includes("LYGIA ColorDitherTriangleNoise")) {
//              if (shaderName.includes("LYGIA ColorDitherTriangleNoise")) {
                    effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll("HIGHP", "     ", );
//                  effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll("HIGHP", "     ", );
                }
//              }
                else
//              else
                if (shaderName.includes("LYGIA FilterJointBilateral")) {
//              if (shaderName.includes("LYGIA FilterJointBilateral")) {
                    effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll(/\bsample\b/g, "samples", );
//                  effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.replaceAll(/\bsample\b/g, "samples", );
                }
//              }
            }
//          }
            else {
//          else {
                effect.fragmentShaderSourceCode________ = shaderRawSourceCode;
//              effect.fragmentShaderSourceCode________ = shaderRawSourceCode;
            }
//          }
            if (effect.fragmentShaderSourceCode________.charAt(0) === "-") {
//          if (effect.fragmentShaderSourceCode________.charAt(0) === "-") {
                effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.substring(1);
//              effect.fragmentShaderSourceCode________ = effect.fragmentShaderSourceCode________.substring(1);
            }
//          }
            console.log($state.snapshot(effect.fragmentShaderSourceCode________));
//          console.log($state.snapshot(effect.fragmentShaderSourceCode________));
            effect.fragmentShader______GLSLUniforms = await common.fetchShaderMetadata(shaderPath); // common.parseGLSL(effect.fragmentShaderSourceCode________);
//          effect.fragmentShader______GLSLUniforms = await common.fetchShaderMetadata(shaderPath); // common.parseGLSL(effect.fragmentShaderSourceCode________);
            console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
//          console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
            effect.fragmentShaderFiltering_Instance = canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________);
//          effect.fragmentShaderFiltering_Instance = canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________);
            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
//          editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", effect.fragmentShaderSourceType________);
            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
//          editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", effect.fragmentShaderSourceCode________);
            editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
//          editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", effect.fragmentShader______GLSLUniforms);
            editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
//          editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", effect.fragmentShaderFiltering_Instance);
            editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", cachedSelectedIndex);
//          editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex", cachedSelectedIndex);
        }
//      }
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    };
//  };

    const handleRemoveEffect = async (effectIndex: number, type: string): Promise<void> => {
//  const handleRemoveEffect = async (effectIndex: number, type: string): Promise<void> => {
        global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering.filter((otherEffect: types.EffectUsedForFiltering, otherEffectIndex: number): boolean => otherEffectIndex !== effectIndex);
//      global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering.filter((otherEffect: types.EffectUsedForFiltering, otherEffectIndex: number): boolean => otherEffectIndex !== effectIndex);
        await svelte.tick();
//      await svelte.tick();
        await common.makeNewSnackbarFailure(`An old ${type} effect has been removed - ${global.globalState.effectsUsedForFiltering.length} left`);
//      await common.makeNewSnackbarFailure(`An old ${type} effect has been removed - ${global.globalState.effectsUsedForFiltering.length} left`);
    };
//  };

    const handleAskAI = async (effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> => {
//  const handleAskAI = async (effect: types.EffectUsedForFiltering, effectIndex: number): Promise<void> => {
        try
//      try
        {
//      {
            isLoading =  true;
//          isLoading =  true;
            effect.fragmentShaderSourceCode________=`#version 300 es\n` + (await (await ai.promptShader(AIInputPrompts!.value.split(";"))).text()).split("#version 300 es")[1].split("\n").slice(+1 , -1).join("\n").replaceAll("`", "");
//          effect.fragmentShaderSourceCode________=`#version 300 es\n` + (await (await ai.promptShader(AIInputPrompts!.value.split(";"))).text()).split("#version 300 es")[1].split("\n").slice(+1 , -1).join("\n").replaceAll("`", "");
            isLoading = !true;
//          isLoading = !true;
            console.log($state.snapshot(effect.fragmentShaderSourceCode________));
//          console.log($state.snapshot(effect.fragmentShaderSourceCode________));
            effect.fragmentShader______GLSLUniforms = common.parseGLSL(effect.fragmentShaderSourceCode________!);
//          effect.fragmentShader______GLSLUniforms = common.parseGLSL(effect.fragmentShaderSourceCode________!);
            console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
//          console.log($state.snapshot(effect.fragmentShader______GLSLUniforms));
            effect.fragmentShaderFiltering_Instance = canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________!);
//          effect.fragmentShaderFiltering_Instance = canvasInstance.createFilterShader(effect.fragmentShaderSourceCode________!);
        }
//      }
        catch (err: unknown)
//      catch (err: unknown)
        {
//      {
            await common.makeNewSnackbarFailure("LLM generate effect wrong. Please try again!");
//          await common.makeNewSnackbarFailure("LLM generate effect wrong. Please try again!");
        }
//      }
    };
//  };

    const handleMoveEffectUp = async (effectIndex: number): Promise<void> => {
//  const handleMoveEffectUp = async (effectIndex: number): Promise<void> => {
        let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//      let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
        let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//      let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
        let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
//      let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
        global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex - 1];
//      global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex - 1];
        global.globalState.effectsUsedForFiltering[effectIndex - 1] = temp;
//      global.globalState.effectsUsedForFiltering[effectIndex - 1] = temp;
        if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
//      if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
            global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//          global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
        }
//      }
        if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//      if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
            global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
//          global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
        }
//      }
        /*
        global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//      global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
        */
        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
            let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
            let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
            let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex - 1];
//          let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex - 1];
            global.globalState.effectsUsedForFiltering[effectIndex - 1] = global.globalState.effectsUsedForFiltering[effectIndex];
//          global.globalState.effectsUsedForFiltering[effectIndex - 1] = global.globalState.effectsUsedForFiltering[effectIndex];
            global.globalState.effectsUsedForFiltering[effectIndex] = temp;
//          global.globalState.effectsUsedForFiltering[effectIndex] = temp;
            if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
            }
//          }
            if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
            }
//          }
            /*
            global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//          global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
            */
        };
//      };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
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
        };
//      };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    };
//  };

    const handleMoveEffectDown = async (effectIndex: number): Promise<void> => {
//  const handleMoveEffectDown = async (effectIndex: number): Promise<void> => {
        let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//      let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
        let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//      let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
        let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
//      let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex];
        global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex + 1];
//      global.globalState.effectsUsedForFiltering[effectIndex] = global.globalState.effectsUsedForFiltering[effectIndex + 1];
        global.globalState.effectsUsedForFiltering[effectIndex + 1] = temp;
//      global.globalState.effectsUsedForFiltering[effectIndex + 1] = temp;
        if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
//      if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
            global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
//          global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
        }
//      }
        if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//      if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
            global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index1 as number;
//          global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index1 as number;
        }
//      }
        /*
        global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//      global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
        */
        let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: types.EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
            let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index1: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
            let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
//          let index2: number | undefined = global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement?.selectedIndex;
            let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex + 1];
//          let temp: types.EffectUsedForFiltering = global.globalState.effectsUsedForFiltering[effectIndex + 1];
            global.globalState.effectsUsedForFiltering[effectIndex + 1] = global.globalState.effectsUsedForFiltering[effectIndex];
//          global.globalState.effectsUsedForFiltering[effectIndex + 1] = global.globalState.effectsUsedForFiltering[effectIndex];
            global.globalState.effectsUsedForFiltering[effectIndex] = temp;
//          global.globalState.effectsUsedForFiltering[effectIndex] = temp;
            if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index2 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex].fragmentShader_HTMLSelectElement.selectedIndex = index2 as number;
            }
//          }
            if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
//          if (global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
                global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
//              global.globalState.effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
            }
//          }
            /*
            global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
//          global.globalState.effectsUsedForFiltering = global.globalState.effectsUsedForFiltering;
            */
        };
//      };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
//      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null): Promise<void> => {
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
        };
//      };
        global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
//      global.globalState.editorSnapshotsUndoStack.push(editorSnapshot);
    };
//  };

    const handleVideoRewind = async (): Promise<void> => {
//  const handleVideoRewind = async (): Promise<void> => {
        video?.time(video?.time() - 10);
//      video?.time(video?.time() - 10);
    };
//  };

    const handleVideoPlayPause = async (): Promise<void> => {
//  const handleVideoPlayPause = async (): Promise<void> => {
        if (!videoIsPlaying) { video?.play(); } else { video?.pause(); }
//      if (!videoIsPlaying) { video?.play(); } else { video?.pause(); }
        videoIsPlaying = !videoIsPlaying;
//      videoIsPlaying = !videoIsPlaying;
    };
//  };

    const handleVideoForward = async (): Promise<void> => {
//  const handleVideoForward = async (): Promise<void> => {
        video?.time(video?.time() + 10);
//      video?.time(video?.time() + 10);
    };
//  };

    const handleVideoVolumeChange = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> => {
//  const handleVideoVolumeChange = async (e: Event & { currentTarget: EventTarget & HTMLInputElement }): Promise<void> => {
        const ele: HTMLInputElement = e.target as HTMLInputElement;
//      const ele: HTMLInputElement = e.target as HTMLInputElement;
        video?.volume(ele.valueAsNumber);
//      video?.volume(ele.valueAsNumber);
    };
//  };

    const handleUndo = async (): Promise<void> => {
//  const handleUndo = async (): Promise<void> => {
        await common.onUndoActionExecuted();
//      await common.onUndoActionExecuted();
    };
//  };

    const handleRedo = async (): Promise<void> => {
//  const handleRedo = async (): Promise<void> => {
        await common.onRedoActionExecuted();
//      await common.onRedoActionExecuted();
    };
//  };

</script>

<!--<div bind:this={canvasBG} style:position="absolute" style:z-index="0" style:pointer-events="none"></div>-->
    <div bind:this={canvasBG} style:position="absolute" style:z-index="0" style:pointer-events="none"></div>
<!--<div bind:this={canvasBG} style:position="absolute" style:z-index="0" style:pointer-events="none"></div>-->
<!--<DraggableTextComponent bind:canvasInstance={canvasInstance} bind:draggableText={draggableText}></DraggableTextComponent>-->
<!--<DraggableTextComponent bind:canvasInstance={canvasInstance} bind:draggableText={draggableText}></DraggableTextComponent>-->
<!--<DraggableTextComponent bind:canvasInstance={canvasInstance} bind:draggableText={draggableText}></DraggableTextComponent>-->
<MouseCursor></MouseCursor>
<main>
    <div class="container">
    <!--<div class="headerContainer"></div>-->
    <!--<div class="headerContainer"></div>-->
        <div class="topBarContainer small-padding">
            <div class="row">
            <!--<button class="slow-ripple large-elevate margin grey10 white-text"><i class="fa-solid fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={input} onchange={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>-->
                <button class="slow-ripple large-elevate margin grey10 white-text"><i class="fa-solid fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={input} onchange={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>
            <!--<button class="slow-ripple large-elevate margin grey10 white-text"><i class="fa-solid fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={input} onchange={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>-->
                <div class="field middle-align">
                    <nav>
                    <!--<div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>-->
                        <div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>
                    <!--<div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>-->
                        <label class="switch icon">
                            <input class="" type="checkbox" onchange={toggleWebCam}>
                            <span>
                                <i class="white-text deep-orange">Videocam_Off</i>
                                <i class="white-text deep-orange">Videocam_On </i>
                            </span>
                        </label>
                    </nav>
                </div>
            </div>
        <!--<h3 style="font-style: italic; text-shadow: 0 0 3px;" class="white-text slow-ripple large-elevate small-padding">Visual Filter Editor</h3>-->
            <h3 style="font-style: italic; text-shadow: 0 0 3px;" class="white-text slow-ripple large-elevate small-padding">Visual Filter Editor</h3>
        <!--<h3 style="font-style: italic; text-shadow: 0 0 3px;" class="white-text slow-ripple large-elevate small-padding">Visual Filter Editor</h3>-->
        <!--<button class="slow-ripple large-elevate" onclick={startWebCam}>START WEB CAM</button>
            <button class="slow-ripple large-elevate" onclick={ceaseWebCam}>CEASE WEB CAM</button>-->
            <div class="horizontal">
            <!--<button class="slow-ripple large-elevate margin deep-orange white-text" data-ui="#a"><i class="fas fa-arrow-down white-text"></i><span>Save</span></button>-->
                <button class="slow-ripple large-elevate margin deep-orange white-text" data-ui="#a"><i class="fas fa-arrow-down white-text"></i><span>Save</span></button>
            <!--<button class="slow-ripple large-elevate margin deep-orange white-text" data-ui="#a"><i class="fas fa-arrow-down white-text"></i><span>Save</span></button>-->
            <!--<div class="overlay large-blur"></div>-->
                <div class="overlay large-blur"></div>
            <!--<div class="overlay large-blur"></div>-->
                <dialog class="left small-blur dialogSide" id="a">
                    <!-- svelte-ignore a11y_consider_explicit_label -->
                    <!-- svelte-ignore a11y_consider_explicit_label -->
                <!--<div class="max right-align"><button class="slow-ripple transparent circle left-round top-round right large-elevate white-text grey10" data-ui="#a"><i class="fas fa-xmark white-text"></i></button></div>-->
                    <div class="max right-align"><button class="slow-ripple transparent circle left-round top-round right large-elevate white-text grey10" data-ui="#a"><i class="fas fa-xmark white-text"></i></button></div>
                <!--<div class="max right-align"><button class="slow-ripple transparent circle left-round top-round right large-elevate white-text grey10" data-ui="#a"><i class="fas fa-xmark white-text"></i></button></div>-->
                    <div class="column max small-padding">
                        <div class="column">
                            <h6  class="                         white-text                          ">Save as image</h6>
                            <div class="field label suffix round white-text large-elevate slow-ripple">
                                <select bind:this={imageFormatSelection}>
                                    {#each imageFormats as imageFormat (imageFormat)}
                                        <option class="grey10 white-text">
                                            {imageFormat.extension}
                                        </option>
                                    {/each}
                                </select>
                                <!-- svelte-ignore a11y_label_has_associated_control -->
                                <!-- svelte-ignore a11y_label_has_associated_control -->
                            <!--<label>Image Format</label>-->
                                <label>Image Format</label>
                            <!--<label>Image Format</label>-->
                            <!--<i class="fas fa-chevron-down"></i>-->
                                <i class="fas fa-chevron-down"></i>
                            <!--<i class="fas fa-chevron-down"></i>-->
                            </div>
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                        <!--<button class="slow-ripple center large-elevate deep-orange white-text" onclick={handleStartCaptureAsImage}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate blue white-text slow-ripple medium-space" style:text-align="center"><span class="white-text">Save current frame</span></div></button>-->
                            <button class="slow-ripple center large-elevate deep-orange white-text" onclick={handleStartCaptureAsImage}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate blue white-text slow-ripple medium-space" style:text-align="center"><span class="white-text">Save current frame</span></div></button>
                        <!--<button class="slow-ripple center large-elevate deep-orange white-text" onclick={handleStartCaptureAsImage}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate blue white-text slow-ripple medium-space" style:text-align="center"><span class="white-text">Save current frame</span></div></button>-->
                            <!--Đang render image/video trên canvas -> capture frame hình hiện tại-->
                            <!--Đang render image/video trên canvas -> capture frame hình hiện tại-->
                        </div>
                        <div class="medium-space"></div>
                        <div class="column">
                            <h6  class="                         white-text                          ">Save as video</h6>
                            <div class="field label suffix round white-text large-elevate slow-ripple">
                                <select bind:this={videoFormatSelection}>
                                    {#each videoFormats as videoFormat (videoFormat)}
                                        <option class="grey10 white-text">
                                            {videoFormat.mimeType}
                                        </option>
                                    {/each}
                                </select>
                                <!-- svelte-ignore a11y_label_has_associated_control -->
                                <!-- svelte-ignore a11y_label_has_associated_control -->
                            <!--<label>Video Format</label>-->
                                <label>Video Format</label>
                            <!--<label>Video Format</label>-->
                            <!--<i class="fas fa-chevron-down"></i>-->
                                <i class="fas fa-chevron-down"></i>
                            <!--<i class="fas fa-chevron-down"></i>-->
                            </div>
                            <div class="row center-align">
                                <div class="middle-align field">
                                    <nav>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round blue white-text large-elevate slow-ripple top-round right-round medium-space" style:text-align="center"><span class="white-text">Save frames (ACut)</span></div></label>-->
                                        <label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round blue white-text large-elevate slow-ripple top-round right-round medium-space" style:text-align="center"><span class="white-text">Save frames (ACut)</span></div></label>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round blue white-text large-elevate slow-ripple top-round right-round medium-space" style:text-align="center"><span class="white-text">Save frames (ACut)</span></div></label>-->
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round blue white-text large-elevate slow-ripple top-round  left-round medium-space" style:text-align="center"><span class="white-text">Save frames (Full)</span></div></label>-->
                                        <label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round blue white-text large-elevate slow-ripple top-round  left-round medium-space" style:text-align="center"><span class="white-text">Save frames (Full)</span></div></label>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round blue white-text large-elevate slow-ripple top-round  left-round medium-space" style:text-align="center"><span class="white-text">Save frames (Full)</span></div></label>-->
                                    </nav>
                                </div>
                            </div>
                            <div class="middle-align row">
                                <button class="slow-ripple large-elevate deep-orange white-text" onclick={handleVideoToggle}>
                                    {#if !recording}
                                    <!--<i class="fa-solid fa-bolt  white-text"></i>-->
                                        <i class="fa-solid fa-bolt  white-text"></i>
                                    <!--<i class="fa-solid fa-bolt  white-text"></i>-->
                                    <!--<span>Start</span>-->
                                        <span>Start</span>
                                    <!--<span>Start</span>-->
                                    {:else}
                                    <!--<i class="fa-solid fa-pause white-text"></i>-->
                                        <i class="fa-solid fa-pause white-text"></i>
                                    <!--<i class="fa-solid fa-pause white-text"></i>-->
                                    <!--<span>Stop </span>-->
                                        <span>Stop </span>
                                    <!--<span>Stop </span>-->
                                    {/if}
                                </button>
                                {#if recording}
                                    <div>
                                    <!--<i class="fa-solid fa-record-vinyl white-text"></i>-->
                                        <i class="fa-solid fa-record-vinyl white-text"></i>
                                    <!--<i class="fa-solid fa-record-vinyl white-text"></i>-->
                                    <!--<span>Recording...</span>-->
                                        <span>Recording...</span>
                                    <!--<span>Recording...</span>-->
                                    </div>
                                {/if}
                            </div>
                        </div>
                        <!-- <button class="slow-ripple large-elevate" onclick={async (e) => { await startCaptureAsVideoSnapshot(); }}>START SAVE AS VIDEO SNAPSHOT</button> -->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc bắt đầu click button này thành 1 video (cần phải click button cạnh bên để ngừng)-->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc bắt đầu click button này thành 1 video (cần phải click button cạnh bên để ngừng)-->
                        <!-- <button class="slow-ripple large-elevate" onclick={async (e) => { await ceaseCaptureAsVideoSnapshot(); }}>CEASE SAVE AS VIDEO SNAPSHOT</button> -->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình                                    thành 1 video (                                       )-->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình                                    thành 1 video (                                       )-->
                        <!-- <button class="slow-ripple large-elevate" onclick={async (e) => { await startCaptureAsVideoFullshot(); }}>START SAVE AS VIDEO FULLSHOT</button> -->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (không cần phải click button cạnh bên để ngừng - sẽ được tự động ngừng trong trường hợp canvas đang render video & cần phải click button cạnh bên để ngừng - trong trường hợp canvas đang render image)-->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (không cần phải click button cạnh bên để ngừng - sẽ được tự động ngừng trong trường hợp canvas đang render video & cần phải click button cạnh bên để ngừng - trong trường hợp canvas đang render image)-->
                        <!-- <button class="slow-ripple large-elevate" onclick={async (e) => { await ceaseCaptureAsVideoFullshot(); }}>CEASE SAVE AS VIDEO FULLSHOT</button> -->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (                                                                                                                                                                                                     )-->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (                                                                                                                                                                                                     )-->
                    </div>
                </dialog>
                <button class="slow-ripple large-elevate margin deep-orange" onclick={handleShare}>
                <!--<i class="fas fa-share white-text"></i>-->
                    <i class="fas fa-share white-text"></i>
                <!--<i class="fas fa-share white-text"></i>-->
                <!--<span class="white-text">Share</span>-->
                    <span class="white-text">Share</span>
                <!--<span class="white-text">Share</span>-->
                </button>
            </div>
        </div>
        <div         class="mainBarContainer  ">
            <div     class="sideBarContainer  ">
                <div class="grid small-padding">
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                    <div class="s12 m12 l6">
                        <button class="slow-ripple responsive large-elevate deep-orange white-text" onclick={handleAddEffectNI}>
                            <!--<i class="fas fa-plus white-text"></i>-->
                                <i class="fas fa-plus white-text"></i>
                            <!--<i class="fas fa-plus white-text"></i>-->
                            <!--<span class="white-text">Add Effect NI</span>-->
                                <span class="white-text">Add Effect NI</span>
                            <!--<span class="white-text">Add Effect NI</span>-->
                        </button>
                    </div>
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                    <!--Thêm effect có sẵn-->
                    <!--Thêm effect có sẵn-->
                    <!--Thêm effect có sẵn-->
                    <div class="s12 m12 l6">
                        <button class="slow-ripple responsive large-elevate deep-orange white-text" onclick={handleAddEffectAI}>
                            <!--<i class="fas fa-plus white-text"></i>-->
                                <i class="fas fa-plus white-text"></i>
                            <!--<i class="fas fa-plus white-text"></i>-->
                            <!--<span class="white-text">Add Effect AI</span>-->
                                <span class="white-text">Add Effect AI</span>
                            <!--<span class="white-text">Add Effect AI</span>-->
                        </button>
                    </div>
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                    <!--Thêm effect gen bởi AI-->
                    <!--Thêm effect gen bởi AI-->
                    <!--Thêm effect gen bởi AI-->
                    <div class="s12 m12 l6">
                        <button class="slow-ripple responsive large-elevate grey10 align-center white-text" onclick={handleInsertText}>
                        <!--<i class="fas fa-plus white-text"></i>-->
                        <!--<i class="fas fa-plus white-text"></i>-->
                        <!--<i class="fas fa-plus white-text"></i>-->
                        <!--<span class="white-text">Insert Text</span>-->
                            <span class="white-text">Insert Text</span>
                        <!--<span class="white-text">Insert Text</span>-->
                        </button>
                    </div>
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                </div>
                <div class="effectContainer margin" bind:this={bigList}>
                    {#each global.globalState.effectsUsedForFiltering as effect, effectIndex}
                    <!--<div class="tiny-space"></div>-->
                        <div class="tiny-space"></div>
                    <!--<div class="tiny-space"></div>-->
                    <!--<div class="medium-padding" in:t.fade out:t.blur>-->
                        <div class="medium-padding" in:t.fade out:t.blur>
                    <!--<div class="medium-padding" in:t.fade out:t.blur>-->
                        {#if effect.fragmentShaderSourceType________ === "NI"}
                            <div class="row">
                                <div class="field label suffix round max large-elevate white-text slow-ripple">
                                <!--<select bind:this={effect.fragmentShader_HTMLSelectElement}></select>-->
                                <!--<select bind:this={effect.fragmentShader_HTMLSelectElement}></select>-->
                                <!--<select bind:this={effect.fragmentShader_HTMLSelectElement}></select>-->
                                    <select bind:this={effect.fragmentShader_HTMLSelectElement} onchange={async (e) => await handleEffectNIChange(e, effect, effectIndex)}>
                                        {#each ["none", ...[...common.Shaders.keys()].sort()] as shaderName (shaderName)}
                                            <option class="grey10 white-text">
                                                {shaderName}
                                            </option>
                                        {/each}
                                    </select>
                                    <!-- svelte-ignore a11y_label_has_associated_control -->
                                    <!-- svelte-ignore a11y_label_has_associated_control -->
                                <!--<label>Choose your effects</label>-->
                                    <label>Choose your effects</label>
                                <!--<label>Choose your effects</label>-->
                                <!--<i class="fas fa-chevron-down"></i>-->
                                    <i class="fas fa-chevron-down"></i>
                                <!--<i class="fas fa-chevron-down"></i>-->
                                </div>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                {#if effect.fragmentShader______GLSLUniforms !== null  }
                                {#if effect.fragmentShader______GLSLUniforms.length > 0}
                                    <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#b${effectIndex}`}><i class="fa-solid fa-wand-magic-sparkles white-text"></i></button>-->
                                        <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#b${effectIndex}`}><i class="fa-solid fa-wand-magic-sparkles white-text"></i></button>
                                    <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#b${effectIndex}`}><i class="fa-solid fa-wand-magic-sparkles white-text"></i></button>-->
                                {/if}
                                {/if}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "NI")}><i class="fa-solid fa-ban white-text"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "NI")}><i class="fa-solid fa-ban white-text"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "NI")}><i class="fa-solid fa-ban white-text"></i></button>-->
                            </div>
                        <!--<div class="overlay large-blur"></div>-->
                            <div class="overlay large-blur"></div>
                        <!--<div class="overlay large-blur"></div>-->
                            <dialog  class="    responsive dialog blur" id={`b${String(effectIndex)}`}>
                                <div class="row responsive            "                               >
                                    <h6>Customize your effect</h6>
                                    <div class="max  right-align">
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <button class="transparent circle right large-elevate" data-ui={`#b${effectIndex}`}><i class="fas fa-xmark"></i></button>
                                    </div>
                                </div>
                            <!--<div class="medium-space"></div>-->
                                <div class="medium-space"></div>
                            <!--<div class="medium-space"></div>-->
                                {#if effect.fragmentShader______GLSLUniforms}
                                    <GlslUniform
                                        bind:canvasInstance={canvasInstance}
                                        bind:uniforms={effect.fragmentShader______GLSLUniforms}
                                        onUpdate={handleUpdate}>
                                    </GlslUniform>
                                {/if}
                            </dialog>
                        {/if}
                        {#if effect.fragmentShaderSourceType________ === "AI"}
                            <div class="row">
                            <!--<div class="max medium-padding round"><span>Effect {effectIndex} by AI</span></div>-->
                                <div class="max medium-padding round"><span>Effect {effectIndex} by AI</span></div>
                            <!--<div class="max medium-padding round"><span>Effect {effectIndex} by AI</span></div>-->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#c${effectIndex}`}><i class="fa-solid fa-wand-magic-sparkles white-text"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#c${effectIndex}`}><i class="fa-solid fa-wand-magic-sparkles white-text"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#c${effectIndex}`}><i class="fa-solid fa-wand-magic-sparkles white-text"></i></button>-->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "AI")}><i class="fa-solid fa-ban white-text"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "AI")}><i class="fa-solid fa-ban white-text"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "AI")}><i class="fa-solid fa-ban white-text"></i></button>-->
                            </div>
                        <!--<div class="overlay large-blur"></div>-->
                            <div class="overlay large-blur"></div>
                        <!--<div class="overlay large-blur"></div>-->
                            <dialog class="responsive dialog blur" id={`c${effectIndex}`}>
                                {#if isLoading}
                                <!--<progress class="circle large" transition:t.fade></progress>-->
                                    <progress class="circle large" transition:t.fade></progress>
                                <!--<progress class="circle large" transition:t.fade></progress>-->
                                {/if}
                                <div class="row responsive">
                                    <h6>Ask AI for a new effect</h6>
                                    <div class="max right-align">
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <button class="transparent circle right large-elevate" data-ui={`#c${effectIndex}`}><i class="fas fa-xmark"></i></button>
                                    </div>
                                </div>
                            <!--<div class="medium-space"></div>-->
                                <div class="medium-space"></div>
                            <!--<div class="medium-space"></div>-->
                                <div class="row">
                                    <div class="field round label max suffix white-text large-elevate slow-ripple">
                                        <input type="text" bind:this={AIInputPrompts}>
                                        <!-- svelte-ignore a11y_label_has_associated_control -->
                                        <!-- svelte-ignore a11y_label_has_associated_control -->
                                    <!--<label>Describe the effect you want</label>-->
                                        <label>Describe the effect you want</label>
                                    <!--<label>Describe the effect you want</label>-->
                                    </div>
                                    <!-- svelte-ignore a11y_consider_explicit_label -->
                                    <!-- svelte-ignore a11y_consider_explicit_label -->
                                    <button class="slow-ripple circle top-round right-round large-elevate deep-orange white-text" onclick={async (e) => await handleAskAI(effect, effectIndex)}>
                                    <!--<i class="fas fa-paper-plane white-text"></i>-->
                                        <i class="fas fa-paper-plane white-text"></i>
                                    <!--<i class="fas fa-paper-plane white-text"></i>-->
                                    </button>
                                </div>
                            <!--<div class="space"></div>-->
                                <div class="space"></div>
                            <!--<div class="space"></div>-->
                                {#if effect.fragmentShader______GLSLUniforms}
                                    <GlslUniform
                                        bind:canvasInstance={canvasInstance}
                                        bind:uniforms={effect.fragmentShader______GLSLUniforms}
                                        onUpdate={handleUpdate}>
                                    </GlslUniform>
                                {/if}
                            </dialog>
                        {/if}
                        {#if !effect.fragmentShaderSourceType________}
                            <div class="row">
                                <div class="max medium-padding"><span>Caption: {effect.draggableText?.contents ?? ""}</span></div>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#d${effectIndex}`}><i class="fa-solid fa-pen"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#d${effectIndex}`}><i class="fa-solid fa-pen"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" data-ui={`#d${effectIndex}`}><i class="fa-solid fa-pen"></i></button>-->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "text")}><i class="fa-solid fa-ban white-text"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "text")}><i class="fa-solid fa-ban white-text"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await handleRemoveEffect(effectIndex, "text")}><i class="fa-solid fa-ban white-text"></i></button>-->
                            </div>
                        <!--<div class="overlay large-blur"></div>-->
                            <div class="overlay large-blur"></div>
                        <!--<div class="overlay large-blur"></div>-->
                            <dialog  class="    responsive dialog blur" id={`d${String(effectIndex)}`}>
                                <div class="row responsive            "                               >
                                    <h6>Customize your texts</h6>
                                    <div class="max right-align">
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <button class="transparent circle right large-elevate" data-ui={`#d${effectIndex}`}><i class="fas fa-xmark"></i></button>
                                    </div>
                                </div>
                            <!--<div class="medium-space"></div>-->
                                <div class="medium-space"></div>
                            <!--<div class="medium-space"></div>-->
                            <!--<DraggableTextComponent bind:canvasInstance={canvasInstance} bind:draggableText={effect.draggableText!}></DraggableTextComponent>-->
                                <DraggableTextComponent bind:canvasInstance={canvasInstance} bind:draggableText={effect.draggableText!}></DraggableTextComponent>
                            <!--<DraggableTextComponent bind:canvasInstance={canvasInstance} bind:draggableText={effect.draggableText!}></DraggableTextComponent>-->
                            </dialog>
                        {/if}
                        <div class="row max">
                            {#if effectIndex > 0}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await handleMoveEffectUp(effectIndex)}>
                                <!--<i class="fa-solid fa-chevron-up white-text"></i>-->
                                    <i class="fa-solid fa-chevron-up white-text"></i>
                                <!--<i class="fa-solid fa-chevron-up white-text"></i>-->
                                </button>
                            {/if}
                            {#if effectIndex < global.globalState.effectsUsedForFiltering.length - 1}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await handleMoveEffectDown(effectIndex)}>
                                <!--<i class="fa-solid fa-chevron-down white-text"></i>-->
                                    <i class="fa-solid fa-chevron-down white-text"></i>
                                <!--<i class="fa-solid fa-chevron-down white-text"></i>-->
                                </button>
                            {/if}
                        </div>
                    </div>
                <!--<hr class="large white" style:height="3px" style:box-shadow="0 0 3px" in:t.fade out:t.blur>-->
                    <hr class="large white" style:height="3px" style:box-shadow="0 0 3px" in:t.fade out:t.blur>
                <!--<hr class="large white" style:height="3px" style:box-shadow="0 0 3px" in:t.fade out:t.blur>-->
                    {/each}
                </div>
            </div>
            <div     class="canvasContainer                ">
                <div class="canvasToolBoxes   small-padding">
                    <!--Dành cho canvas đang render video-->
                    <!--Dành cho canvas đang render video-->
                <!--<div class="row">-->
                    <div class="row">
                <!--<div class="row">-->
                        {#if mode === types.MODE.VIDEO}
                            <div class="column">
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" style="margin-left: 5px;" onclick={handleVideoRewind}>-->
                                <button class="slow-ripple square large-elevate blue white-text margin" style="margin-left: 5px;" onclick={handleVideoRewind}>
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" style="margin-left: 5px;" onclick={handleVideoRewind}>-->
                                <!--<i class="fas fa-backward white-text"></i>-->
                                    <i class="fas fa-backward white-text"></i>
                                <!--<i class="fas fa-backward white-text"></i>-->
                                </button>
                            <!--<button class="slow-ripple square large-elevate grey10 white-text margin" onclick={handleVideoPlayPause}>-->
                                <button class="slow-ripple square large-elevate grey10 white-text margin" onclick={handleVideoPlayPause}>
                            <!--<button class="slow-ripple square large-elevate grey10 white-text margin" onclick={handleVideoPlayPause}>-->
                                    {#if videoIsPlaying}
                                    <!--<i class="fas fa-pause white-text"></i>-->
                                        <i class="fas fa-pause white-text"></i>
                                    <!--<i class="fas fa-pause white-text"></i>-->
                                    {:else}
                                    <!--<i class="fas fa-play white-text"></i>-->
                                        <i class="fas fa-play white-text"></i>
                                    <!--<i class="fas fa-play white-text"></i>-->
                                    {/if}
                                </button>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" onclick={handleVideoForward}>-->
                                <button class="slow-ripple square large-elevate blue white-text margin" onclick={handleVideoForward}>
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" onclick={handleVideoForward}>-->
                                <!--<i class="fas fa-forward white-text"></i>-->
                                    <i class="fas fa-forward white-text"></i>
                                <!--<i class="fas fa-forward white-text"></i>-->
                                </button>
                                <progress value="0" max="100" class="white-text blue large-elevate" bind:this={videoProgressSlider_}></progress>
                            </div>
                            <nav class="no-space">
                            <!--<i class="fas fa-volume-off padding-tiny white-text"></i>-->
                                <i class="fas fa-volume-off padding-tiny white-text"></i>
                            <!--<i class="fas fa-volume-off padding-tiny white-text"></i>-->
                                <label class="slider medium">
                                    <input type="range" value="1.0" min="0.0" max="1.0"
                                        step="0.010"
                                        oninput={handleVideoVolumeChange}>
                                <!--<span class=""></span>-->
                                    <span class=""></span>
                                <!--<span class=""></span>-->
                                <!--<div  class="tooltip blue white-text"></div>-->
                                    <div  class="tooltip blue white-text"></div>
                                <!--<div  class="tooltip blue white-text"></div>-->
                                </label>
                            <!--<i class="fas fa-volume-high padding-tiny white-text"></i>-->
                                <i class="fas fa-volume-high padding-tiny white-text"></i>
                            <!--<i class="fas fa-volume-high padding-tiny white-text"></i>-->
                            </nav>
                        {/if}
                    </div>
                    <!--Dành cho canvas đang render video-->
                    <!--Dành cho canvas đang render video-->
                    <div>
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={handleUndo}><i class="fa-solid fa-arrow-rotate-left  white-text"></i><span>Undo</span></button>-->
                        <button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={handleUndo}><i class="fa-solid fa-arrow-rotate-left  white-text"></i><span>Undo</span></button>
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={handleUndo}><i class="fa-solid fa-arrow-rotate-left  white-text"></i><span>Undo</span></button>-->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={handleRedo}><i class="fa-solid fa-arrow-rotate-right white-text"></i><span>Redo</span></button>-->
                        <button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={handleRedo}><i class="fa-solid fa-arrow-rotate-right white-text"></i><span>Redo</span></button>
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={handleRedo}><i class="fa-solid fa-arrow-rotate-right white-text"></i><span>Redo</span></button>-->
                    </div>
                </div>
                <div class="canvas">
                <!--<div bind:this={canvas} onchange={async (e) => { console.log("change"); }}></div>-->
                    <div bind:this={canvas} onchange={async (e) => { console.log("change"); }}></div>
                <!--<div bind:this={canvas} onchange={async (e) => { console.log("change"); }}></div>-->
                </div>
            </div>
        </div>
    <!--<div class="footerContainer"></div>-->
    <!--<div class="footerContainer"></div>-->
    <!--<div class="footerContainer"></div>-->
    </div>
<!--<div><button class="slow-ripple large-elevate" onclick={async (e) => { const res = await promptShader(); console.log(await res.text()); }}>AI</button></div>-->
<!--<div><button class="slow-ripple large-elevate" onclick={async (e) => { const res = await promptShader(); console.log(await res.text()); }}>AI</button></div>-->
<!--<div><button class="slow-ripple large-elevate" onclick={async (e) => { const res = await promptShader(); console.log(await res.text()); }}>AI</button></div>-->
    <SnackbarSuccess></SnackbarSuccess>
    <SnackbarFailure></SnackbarFailure>
</main>

<style>

    i        { text-shadow: 0 0 3px; }
    i        { text-shadow: 0 0 3px; }
    h6       { text-shadow: 0 0 3px; }
    h6       { text-shadow: 0 0 3px; }
    span     { text-shadow: 0 0 3px; }
    span     { text-shadow: 0 0 3px; }
    label    { text-shadow: 0 0 3px; }
    label    { text-shadow: 0 0 3px; }
    input    { text-shadow: 0 0 3px; }
    input    { text-shadow: 0 0 3px; }
    select   { text-shadow: 0 0 3px; }
    select   { text-shadow: 0 0 3px; }
    option   { text-shadow: 0 0 3px; }
    option   { text-shadow: 0 0 3px; }
    progress { text-shadow: 0 0 3px; }
    progress { text-shadow: 0 0 3px; }

    main { overflow-x: auto; overflow-y: auto; scroll-behavior: smooth; width: 100vw; height: 100vh; }
    main { overflow-x: auto; overflow-y: auto; scroll-behavior: smooth; width: 100vw; height: 100vh; }
    *    {                                     scroll-behavior: smooth;                              }
    *    {                                     scroll-behavior: smooth;                              }
    @font-face { font-family: 'SF Mono Regular'; font-weight: normal; font-style: normal; src: url('./assets/fonts/SF-Mono-Regular.otf') format('opentype'); }
    @font-face { font-family: 'SF Mono Regular'; font-weight: normal; font-style: normal; src: url('./assets/fonts/SF-Mono-Regular.otf') format('opentype'); }
    *          { font-family: 'SF Mono Regular', 'fontawesome'; }
    *          { font-family: 'SF Mono Regular', 'fontawesome'; }

    .container        { width: 100vw; height: 100vh; position: relative; display: flex; flex-direction: column;                                                                                        }
    .container        { width: 100vw; height: 100vh; position: relative; display: flex; flex-direction: column;                                                                                        }
    /*
    .headerContainer  { width: 100% ;                                                                                                                                                                  }
    .headerContainer  { width: 100% ;                                                                                                                                                                  }
    .footerContainer  { width: 100% ;                                                                                                                                                                  }
    .footerContainer  { width: 100% ;                                                                                                                                                                  }
    */
    .topBarContainer  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between;                                                        }
    .topBarContainer  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between;                                                        }
    .mainBarContainer { width: 100% ; height: 100% ;                     display: flex; flex-direction: row   ;                                                                                        }
    .mainBarContainer { width: 100% ; height: 100% ;                     display: flex; flex-direction: row   ;                                                                                        }
    .sideBarContainer { width: 030% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }
    .sideBarContainer { width: 030% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }
    .canvasContainer  { width: 070% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }
    .canvasContainer  { width: 070% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }
    .canvasToolBoxes  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between; align-items: center;                                   }
    .canvasToolBoxes  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between; align-items: center;                                   }
    .canvas           { width: 100% ;                                                                                                                                overflow  : auto;                 }
    .canvas           { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: center       ; align-items: center; overflow  : auto; flex-grow: 1;   }
    .dialog           { width: 050% ;                                                                                                                                                                  }
    .dialog           { width: 050% ;                                                                                                                                                                  }
    .effectContainer  {               height: 100% ;                                                                                                                 overflow  : auto;                 }
    .effectContainer  {               height: 100% ;                                                                                                                 overflow  : auto;                 }
    .dialogSide       { width: 030% ;                                                                                                                                                                  }
    .dialogSide       { width: 030% ;                                                                                                                                                                  }
    .toolTip          { width: 200px;                                                                                                                                                                  }
    .toolTip          { width: 200px;                                                                                                                                                                  }

    .switch > input:checked + span:after { border: none; background-color: #222222           ;                          box-shadow: 0 0 10px #222222;                               }
    .switch > input:checked + span:after { border: none; background-color: #222222           ;                          box-shadow: 0 0 10px #222222;                               }
    .switch >                 span:after {                   border-color: #222222 !important; background: #ffffff22; box-shadow: 0 0 10px #222222; border-width: 3px !important; }
    .switch >                 span:after {                   border-color: #222222 !important; background: #ffffff22; box-shadow: 0 0 10px #222222; border-width: 3px !important; }

</style>
