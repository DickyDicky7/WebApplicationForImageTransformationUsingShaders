
<script lang="ts">

import { promptShader } from "./a.i.effects";
import { /*--------*/ } from "./a.i.effects";
import          "beercss"       ;
import "material-dynamic-colors";
import { shareImage  } from "./common";
import { shareVideo  } from "./common";
import { shareWebcam } from "./common";
import { parseGLSL   } from "./common";
import   p5            from   "p5"    ;
import {   onMount   } from   "svelte";

    


    const DEFAULT_CANVAS_SIZE = { WIDTH_: 500,
                                  HEIGHT: 500,
                                }            ;
    const DPR = window.devicePixelRatio || 1 ;
//  const DPR = window.devicePixelRatio || 2 ;

    import type { DraggableText  } from "./types" ;
//  import type { DraggableText  } from "./types" ;
    import      { display        } from "./common";
//  import      { display        } from "./common";
    import      { onMousePressed } from "./common";
//  import      { onMousePressed } from "./common";
    import      { startDragging  } from "./common";
//  import      { startDragging  } from "./common";
    import      { ceaseDragging  } from "./common";
//  import      { ceaseDragging  } from "./common";

    let defaultFont: p5.Font;
//  let defaultFont: p5.Font;

    import SFMonoRegularURL from "./assets/fonts/SF-Mono-Regular.otf";
//  import SFMonoRegularURL from "./assets/fonts/SF-Mono-Regular.otf";

    const p5Logic = (p: p5) => {
          p.mousePressed  = (e?: object): void => {
//        onMousePressed (draggableText, p);
          for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
//        for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
          onMousePressed (draggableText, p);
          }
          };
          p.mouseDragged  = (e?: object): void => {
//          startDragging(draggableText, p);
          for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
//        for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
            startDragging(draggableText, p);
          }
          };
          p.mouseReleased = (e?: object): void => {
//          ceaseDragging(draggableText, p);
          for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
//        for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
            ceaseDragging(draggableText, p);
          }
          };
          p.preload = (): void => {
            defaultFont = p.loadFont(SFMonoRegularURL);
//          defaultFont = p.loadFont(SFMonoRegularURL);
          };
          p.setup   = (): void => {
//          draggableText.font = defaultFont;
//          draggableText.font = defaultFont;
            p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: true, perPixelLighting: true, });
//          p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: true, perPixelLighting: true, });
            p.createCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                           Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
                              p.WEBGL);
            p.background(  255   );
            p.imageMode (p.CENTER);
            p.frameRate (  fps   );
            p.disableFriendlyErrors = true;
//          p.disableFriendlyErrors = true;
//EXPERIMENT
            p.noLights   ();
            p.noDebugMode();
            p.noSmooth   ();
//EXPERIMENT


        };

        p.draw = () => {
        p.background( 255 );
//      display(draggableText, p);
//      display(draggableText, p);
        for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
//      for (let { fragmentShaderSourceType________, draggableText } of $effectsUsedForFiltering) { if (fragmentShaderSourceType________) continue; if (!draggableText) continue;
        display(draggableText, p);
        }
        };
    };
    
    let canvasBG      : HTMLElement;
    let canvas        : HTMLElement;
    let canvasInstance: p5         ;
    let bufferInstance: p5.Graphics;
    
    import bg1_1  from "./shadertoys/bg1.1.glsl?raw";
    import bg2_1  from "./shadertoys/bg2.1.glsl?raw";
    import bg2_2  from "./shadertoys/bg2.2.glsl?raw";
    import bg2_3  from "./shadertoys/bg2.3.glsl?raw";
    import bg2_4  from "./shadertoys/bg2.4.glsl?raw";
    import bg3_1  from "./shadertoys/bg3.1.glsl?raw";
    import bg4_1  from "./shadertoys/bg4.1.glsl?raw";
    import bg5_1  from "./shadertoys/bg5.1.glsl?raw";
    import bg6_1  from "./shadertoys/bg6.1.glsl?raw";
    import bg7_1  from "./shadertoys/bg7.1.glsl?raw";
    import bg8_1  from "./shadertoys/bg8.1.glsl?raw";
    import bg9_1  from "./shadertoys/bg9.1.glsl?raw";
    import bg11_1 from "./shadertoys/bg11.1.glsl?raw";
    import bg12_1 from "./shadertoys/bg12.1.glsl?raw";
    import bg13_1 from "./shadertoys/bg13.1.glsl?raw";
    let bgs: string[] = [ bg1_1
                      ,   bg2_1
                      ,   bg2_2
                      ,   bg2_3
                      ,   bg2_4
                      ,   bg3_1
                      ,   bg4_1
                      ,   bg5_1
                      ,   bg6_1
                      ,   bg7_1
                      ,   bg8_1
                      ,   bg9_1
                      ,   bg11_1
                      ,   bg12_1
                      ,   bg13_1
                      , ];

    onMount(async ()  : Promise<void> => {

//      let bgShader: any = null!; let bgCanvasInstance: p5 = new p5((p: p5) => { p.setup = () => { p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: false, perPixelLighting: true, }); p.createCanvas(window.innerWidth, window.innerHeight, p.WEBGL); p.disableFriendlyErrors = true; p.noLights(); p.noDebugMode(); p.noSmooth(); bgShader = (p as any).createFilterShader(bgs[Math.floor(Math.random() * 5)]); }; p.draw = () => { bgShader.setUniform("time", p.millis() / 1000); p.filter(bgShader); }; }, canvasBG);
        let bgShader: any = null!; let bgCanvasInstance: p5 = new p5((p: p5) => { p.setup = () => { p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: false, perPixelLighting: true, }); p.createCanvas(window.innerWidth, window.innerHeight, p.WEBGL); p.disableFriendlyErrors = true; p.noLights(); p.noDebugMode(); p.noSmooth(); bgShader = (p as any).createFilterShader(bgs[Math.floor(Math.random() * 5)]); }; p.draw = () => { bgShader.setUniform("time", p.millis() / 1000); p.filter(bgShader); }; }, canvasBG);
//      let bgShader: any = null!; let bgCanvasInstance: p5 = new p5((p: p5) => { p.setup = () => { p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: false, perPixelLighting: true, }); p.createCanvas(window.innerWidth, window.innerHeight, p.WEBGL); p.disableFriendlyErrors = true; p.noLights(); p.noDebugMode(); p.noSmooth(); bgShader = (p as any).createFilterShader(bgs[Math.floor(Math.random() * 5)]); }; p.draw = () => { bgShader.setUniform("time", p.millis() / 1000); p.filter(bgShader); }; }, canvasBG);

        canvasInstance = new p5(p5Logic, canvas);
//      bufferInstance =
//      canvasInstance.createGraphics(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
//                                    Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
//      canvasInstance.WEBGL,        );
            await ui("theme", "#000000");
            await ui("theme", "#000000");
//          await ui("mode" , "dark"   );
            await ui("mode" , "dark"   );
//          await ui("mode" , "dark"   );
    });

    const successCallback = (image_Instance: p5.Image): void => {
        if (video) {
            video.remove();
        }
        let imageRatio    = 1.0                       ;
        canvasInstance.resizeCanvas(image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
        image_Instance.resize      (image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
        canvasInstance.  draw = () => {
//------------------------------//
            canvasInstance.textureWrap("repeat");
            canvasInstance.
            image                   (
            image_Instance, 0.0, 0.0)           ;


            for (let { fragmentShaderSourceType________,
                       fragmentShaderSourceCode________,
                       fragmentShader______GLSLUniforms,
                       fragmentShaderFiltering_Instance,
                       draggableText                   , } of $effectsUsedForFiltering) {
                if   (!fragmentShaderSourceType________) {
                if   (!draggableText) { continue; }
//              if   (!draggableText) { continue; }
                    display(draggableText, canvasInstance);
//                  display(draggableText, canvasInstance);
                    continue;
//                  continue;
                }
                if   (!fragmentShaderSourceCode________) continue;
                if   (!fragmentShader______GLSLUniforms) continue;
                if   (!fragmentShaderFiltering_Instance) continue;
                       shaderSetNecessaryUniforms      (
                       fragmentShaderFiltering_Instance);

                if   (                      fragmentShader______GLSLUniforms) {
                    for (let glslUniform of fragmentShader______GLSLUniforms) {
                         if (glslUniform.thisUniformType === "sampler2D"
                         ||  glslUniform.thisUniformType === "sampler3D")     {
                            if
                            (glslUniform.thisUniformSampler2DImg) {
                                fragmentShaderFiltering_Instance.setUniform(
                             glslUniform.thisUniformName        ,
                             glslUniform.thisUniformSampler2DImg,          );
                            }
                        } else                                                {
                                fragmentShaderFiltering_Instance.setUniform(
                             glslUniform.thisUniformName        ,
                             glslUniform.thisUniformDefaultValue,          );
                        }
                    }
                }
                canvasInstance.filter(fragmentShaderFiltering_Instance);
            }
//------------------------------//
        };
        mode = MODE.IMAGE;
        mode = MODE.IMAGE;
    };


    const failureCallback = (event_Instance:    Event): void => {
        if (canvas.children   .length === 2) {
//          canvas.children[1].remove();
//          canvas.children[2].remove();
//      if (video) { video.remove(); } // the same as the above line of code
        if (video) { video.remove(); } // the same as the above line of code
//      if (video) { video.remove(); } // the same as the above line of code
        }
        if (    input.files    !== null) {
            if (video_FileBLOB !== null) { window.URL.revokeObjectURL(video_FileBLOB); }
                video_FileBLOB  =          window.URL.createObjectURL(input.files[0]);
            video = canvasInstance.createVideo(video_FileBLOB);
//          video = canvasInstance.createVideo(video_FileBLOB);
            video?.volume(1.0);
            video?.hide  (   );
            video?.loop  (   );
//          video?.play  (   );
            videoIsPlaying = true;
            imageIsPlaying = true;
            catchFirstTime =  false;
            startRecord    = !false;
            ceaseRecord    =  false;
            canvasInstance.resizeCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                                        Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
                                       );
            canvasInstance.draw = () => {
//------------------------------//
                if (!      catchFirstTime
                &&  !isNaN(video.duration()))
                {
                           videoProgressSlider_.max =
                           video.duration()         ; 
                           catchFirstTime = true    ;
//                         catchFirstTime = true    ;
                }

                canvasInstance.textureWrap("repeat");
//              canvasInstance.textureWrap("repeat");
//              canvasInstance.background(255);
//              canvasInstance.background(255);
                canvasInstance.push();
                canvasInstance.imageMode(canvasInstance.CENTER);
                canvasInstance.image    (
                               video     ,
                    0.0,
                    0.0,
                    canvasInstance.width ,
                    canvasInstance.height,
                    0.0,
                    0.0,
                             video.width ,
                             video.height,
                    canvasInstance.COVER ,
                );
                canvasInstance.pop();

                videoProgressSlider_.value = video.time();
//              videoProgressSlider_.value = video.time();
//              videoProgressSlider_.value = video.time();

            for (let { fragmentShaderSourceType________,
                       fragmentShaderSourceCode________,
                       fragmentShader______GLSLUniforms,
                       fragmentShaderFiltering_Instance,
                       draggableText                   , } of $effectsUsedForFiltering) {
                if   (!fragmentShaderSourceType________) {
                if   (!draggableText) { continue; }
//              if   (!draggableText) { continue; }
                    display(draggableText, canvasInstance);
//                  display(draggableText, canvasInstance);
                    continue;
//                  continue;
                }
                if   (!fragmentShaderSourceCode________) continue;
                if   (!fragmentShader______GLSLUniforms) continue;
                if   (!fragmentShaderFiltering_Instance) continue;
                       shaderSetNecessaryUniforms      (
                       fragmentShaderFiltering_Instance);

                if   (                      fragmentShader______GLSLUniforms) {
                    for (let glslUniform of fragmentShader______GLSLUniforms) {
                         if (glslUniform.thisUniformType === "sampler2D"
                         ||  glslUniform.thisUniformType === "sampler3D")     {
                            if
                            (glslUniform.thisUniformSampler2DImg) {
                                fragmentShaderFiltering_Instance.setUniform(
                             glslUniform.thisUniformName        ,
                             glslUniform.thisUniformSampler2DImg,          );
                            }
                        } else                                                {
                                fragmentShaderFiltering_Instance.setUniform(
                             glslUniform.thisUniformName        ,
                             glslUniform.thisUniformDefaultValue,          );
                        }
                    }
                }
                canvasInstance.filter(fragmentShaderFiltering_Instance);
            }


                if (!ceaseRecord
                &&   fshotRecord
                &&  !isNaN           (video.duration())
                &&   video.time() === video.duration()) {
                     ceaseRecord = true;
                     fshotRecord = true;
                     ceaseCaptureAsVideoFullshot();
                     recording   = false;
//                   recording   = false;
                };
//------------------------------//
            };
            mode = MODE.VIDEO;
            mode = MODE.VIDEO;
        };
    };


    let input: HTMLInputElement;
//  let input: HTMLInputElement;
    const onChange = async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => { const reader = new FileReader(); reader.addEventListener("load", () => { if (typeof reader.result === "string") { canvasInstance.loadImage(reader.result, successCallback, failureCallback,);
//  const onChange = async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }): Promise<void> => { const reader = new FileReader(); reader.addEventListener("load", () => { if (typeof reader.result === "string") { canvasInstance.loadImage(reader.result, successCallback, failureCallback,);
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
    };

    let fps: number = 120;
    let downloadStream      : MediaStream = null!;
    let downloadStreamWebCam: MediaStream = null!;
    let    videoStream: MediaStream = null!;
    let    audioStream: MediaStream = null!;
    let  mediaRecorder      : MediaRecorder = null!;
    let  mediaRecorderWebCam: MediaRecorder = null!;
    let video_FileBLOB: string = null!;
    let image_FileBLOB: string = null!;
    let video: p5.MediaElement = null!;
    let image: p5.MediaElement = null!;
    let catchFirstTime: boolean =  false;
    let startRecord   : boolean = !false;
    let ceaseRecord   : boolean =  false;
    let fshotRecord   : boolean =  false;
    let sshotRecord   : boolean =  false;
    let graphicsObj   : p5.Graphics     ;

import { resolveLygiaAsync } from "./lygia";
import { resolveLygia      } from "./lygia";


    const videoFormats = [
        { mimeType: "video/webm; codecs=vp9", extension: "webm", blobType: "video/webm", },
        { mimeType: "video/mp4; codecs=avc1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=hev1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=hvc1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=mp4v", extension: "mp4" , blobType: "video/mp4" , },
    ] as const;
    const imageFormats = [
        { extension: "png" , blobType: "image/png" , },
        { extension: "jpeg", blobType: "image/jpeg", },
        { extension: "webp", blobType: "image/webp", },
        { extension: "jpg" , blobType: "image/jpg" , },
    ] as const;
    type VideoFormat = typeof videoFormats[number];
    type ImageFormat = typeof imageFormats[number];
// video/webm; codecs=vp9
// video/mp4; codecs=avc1
// video/mp4; codecs=hev1
// video/mp4; codecs=hvc1
// video/mp4; codecs=mp4v

// image/png;
// image/jpeg;
// image/webp;
// image/jpg;

// DeepAR SDK@@@
// DeepAR Beauty

    const shaderSetNecessaryUniforms = (
          shader: any                  ) => {
          shader.setUniform("time", canvasInstance.millis() / 1000);
//        shader.setUniform("time", canvasInstance.millis() / 1000);
          shader.setUniform("canvasSize", [ canvasInstance.width, canvasInstance.height ]);
//        shader.setUniform("canvasSize", [ canvasInstance.width, canvasInstance.height ]);
          shader.setUniform("texelSize", [ 1.0 / (canvasInstance.width * canvasInstance.pixelDensity()), 1.0 / (canvasInstance.height * canvasInstance.pixelDensity()) ]);
//        shader.setUniform("texelSize", [ 1.0 / (canvasInstance.width * canvasInstance.pixelDensity()), 1.0 / (canvasInstance.height * canvasInstance.pixelDensity()) ]);
//        shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
//        shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
          shader.setUniform("mousePosition", [ canvasInstance.mouseX, canvasInstance.mouseY, canvasInstance.mouseIsPressed ? 1.0 : 0.0, canvasInstance.mouseIsPressed ? 1.0 : 0.0 ]);
//        shader.setUniform("mousePosition", [ canvasInstance.mouseX, canvasInstance.mouseY, canvasInstance.mouseIsPressed ? 1.0 : 0.0, canvasInstance.mouseIsPressed ? 1.0 : 0.0 ]);
          shader.setUniform("frameCount", canvasInstance.frameCount);
//        shader.setUniform("frameCount", canvasInstance.frameCount);
    };

    const startCaptureAsVideoFullshot = async() => { // VIDEO: Y | IMAGE: N | WEBCAM: N
        fshotRecord = !false;
        sshotRecord =  false;
        if (video) {
            video.  stop(   );
            video.noLoop(   );
            video.volume(1.0);
            video.  play(   );
        }
        let htmlCanvasElement:
            HTMLCanvasElement                   = canvas.children[0] as
            HTMLCanvasElement;

        let      videoElement: HTMLVideoElement = canvas.children[1] as 
                               HTMLVideoElement  ;
        let      audioContext:     AudioContext =
        new                        AudioContext();
        let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
        let mediaStreamAudioDestination    : MediaStream                     =
            mediaStreamAudioDestinationNode.      stream                                                                  ;
        if (mode === MODE.VIDEO) {
        let mediaElementAudioSourceNode:
            MediaElementAudioSourceNode=        audioContext.createMediaElementSource(videoElement);
            mediaElementAudioSourceNode.connect(
            mediaStreamAudioDestinationNode    );
            mediaElementAudioSourceNode.connect(audioContext.destination/************************/);
        }


        downloadStream = null!                  ;
        downloadStream =
            htmlCanvasElement.captureStream(fps);
        if (mode === MODE.VIDEO) {
        downloadStream       .addTrack     (mediaStreamAudioDestination.getAudioTracks()[0]);
//      downloadStream       .addTrack     (mediaStreamAudioDestination.getAudioTracks()[0]);
//      downloadStream       .addTrack     (mediaStreamAudioDestination.getAudioTracks()[0]);
        }
        const recordedChunkes:     BlobPart[   ]
                             =             [   ];
        const recordedOptions= { mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
//                               mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
//                               mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
                               };
        mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
//      mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
        mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
//      mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
            if (                     blobEvent.data.size > 0) {
                recordedChunkes.push(blobEvent.data         ) ;
                const                blob    =  new Blob    (
                recordedChunkes
                ,
                    {
//                      type: videoFormats[videoFormatSelection.selectedIndex].blobType,
                        type: videoFormats[videoFormatSelection.selectedIndex].blobType,
//                      type: videoFormats[videoFormatSelection.selectedIndex].blobType,
                    }
                ,
                );
                const url = URL.createObjectURL(blob);
//              const url = URL.createObjectURL(blob);
                const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
//              const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
                document.body.appendChild(anchor);
//              document.body.appendChild(anchor);
                anchor.href     = url;
//              anchor.href     = url;
                anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
//              anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
                anchor.click();
//              anchor.click();
                window.URL.revokeObjectURL(url);
//              window.URL.revokeObjectURL(url);
                videoToShare = blob;
//              videoToShare = blob;
                anchor.          remove   (   );
//              anchor.          remove   (   );
            };
        };
        mediaRecorder.start();
//      mediaRecorder.start();
    };
    const startCaptureAsVideoSnapshot = async() => { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
        fshotRecord =  false;
        sshotRecord = !false;
        if (video) {
//          video.  stop(   );
//          video.noLoop(   );
            video.  loop(   );
            video.volume(1.0);
            video.  play(   );
        }
        let htmlCanvasElement:
            HTMLCanvasElement                   = canvas.children[0] as
            HTMLCanvasElement;

        let      videoElement: HTMLVideoElement = canvas.children[1] as 
                               HTMLVideoElement  ;
        let      audioContext:     AudioContext =
        new                        AudioContext();
        let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
        let mediaStreamAudioDestination    : MediaStream                     =
            mediaStreamAudioDestinationNode.      stream                                                                  ;
        if (mode === MODE.VIDEO) {
        let mediaElementAudioSourceNode:
            MediaElementAudioSourceNode=        audioContext.createMediaElementSource(videoElement);
            mediaElementAudioSourceNode.connect(
            mediaStreamAudioDestinationNode    );
            mediaElementAudioSourceNode.connect(audioContext.destination/************************/);
        }


        downloadStream = null!                  ;
        downloadStream =
            htmlCanvasElement.captureStream(fps);
        if (mode === MODE.VIDEO) {
        downloadStream       .addTrack     (mediaStreamAudioDestination.getAudioTracks()[0]);
//      downloadStream       .addTrack     (mediaStreamAudioDestination.getAudioTracks()[0]);
//      downloadStream       .addTrack     (mediaStreamAudioDestination.getAudioTracks()[0]);
        }
        const recordedChunkes:     BlobPart[   ]
                             =             [   ];
        const recordedOptions= { mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
//                               mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
//                               mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType,
                               };
        mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
//      mediaRecorder = new MediaRecorder(downloadStream, recordedOptions);
        mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
//      mediaRecorder.ondataavailable = async (blobEvent: BlobEvent): Promise<void> => {
            if (                     blobEvent.data.size > 0) {
                recordedChunkes.push(blobEvent.data         ) ;
                const                blob    =  new Blob    (
                recordedChunkes
                ,
                    {
//                      type: videoFormats[videoFormatSelection.selectedIndex].blobType,
                        type: videoFormats[videoFormatSelection.selectedIndex].blobType,
//                      type: videoFormats[videoFormatSelection.selectedIndex].blobType,
                    }
                ,
                );
                const url = URL.createObjectURL(blob);
//              const url = URL.createObjectURL(blob);
                const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
//              const anchor: HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
                document.body.appendChild(anchor);
//              document.body.appendChild(anchor);
                anchor.href     = url;
//              anchor.href     = url;
                anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
//              anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
                anchor.click();
//              anchor.click();
                window.URL.revokeObjectURL(url);
//              window.URL.revokeObjectURL(url);
                videoToShare = blob;
//              videoToShare = blob;
                anchor.          remove   (   );
//              anchor.          remove   (   );
            };
        };
        mediaRecorder.start();
//      mediaRecorder.start();
    };
    const startCaptureAsImage         = async() => { // VIDEO: Y | IMAGE: Y | WEBCAM: Y
        canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
//      canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
//      canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
    };
    const ceaseCaptureAsVideoFullshot = async() => {
                video      ?.stop();
        mediaRecorder      ?.stop();
        mediaRecorder       = null!;
        mediaRecorderWebCam?.stop();
        mediaRecorderWebCam = null!;
    };
    const ceaseCaptureAsVideoSnapshot = async() => {
//              video      ?.stop();
        mediaRecorder      ?.stop();
        mediaRecorder       = null!;
        mediaRecorderWebCam?.stop();
        mediaRecorderWebCam = null!;
    };
    const ceaseCaptureAsImage         = async() => {
        canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
//      canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
//      canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension);
    };

    const startWebCam = async(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
        webcamCapture = canvasInstance.createCapture({ video: { mandatory: { minWidth: 1280, minHeight: 720, }, optional: [{ maxFrameRate: 120, }] }, audio: true, });
//      webcamCapture = canvasInstance.createCapture({ video: { mandatory: { minWidth: 1280, minHeight: 720, }, optional: [{ maxFrameRate: 120, }] }, audio: true, });
        canvasInstance.resizeCanvas(1280 * 2 / 3, 720 * 2 / 3);
//      canvasInstance.resizeCanvas(1280 * 2 / 3, 720 * 2 / 3);
//      canvasInstance.resizeCanvas(DEFAULT_CANVAS_SIZE.WIDTH_, DEFAULT_CANVAS_SIZE.HEIGHT);
//      canvasInstance.resizeCanvas(DEFAULT_CANVAS_SIZE.WIDTH_, DEFAULT_CANVAS_SIZE.HEIGHT);
        webcamCapture .size(        canvasInstance     .width , canvasInstance     .height);
//      webcamCapture .size(        canvasInstance     .width , canvasInstance     .height);
        webcamCapture .hide(                                                              );
        canvasInstance.draw = () => {
//------------------------------//
        canvasInstance.textureWrap("repeat");
//      canvasInstance.textureWrap("mirror");        
//      canvasInstance.textureWrap("repeat");
        canvasInstance.
           image(      webcamCapture
                      , 0.0
                      , 0.0
                )     ;
            for (let { fragmentShaderSourceType________,
                       fragmentShaderSourceCode________,
                       fragmentShader______GLSLUniforms,
                       fragmentShaderFiltering_Instance,
                       draggableText                   , } of $effectsUsedForFiltering) {
                if   (!fragmentShaderSourceType________) {
                if   (!draggableText) { continue; }
//              if   (!draggableText) { continue; }
                    display(draggableText, canvasInstance);
//                  display(draggableText, canvasInstance);
                    continue;
//                  continue;
                }
                if   (!fragmentShaderSourceCode________) continue;
                if   (!fragmentShader______GLSLUniforms) continue;
                if   (!fragmentShaderFiltering_Instance) continue;
                       shaderSetNecessaryUniforms      (
                       fragmentShaderFiltering_Instance);

                if   (                      fragmentShader______GLSLUniforms) {
                    for (let glslUniform of fragmentShader______GLSLUniforms) {
                         if (glslUniform.thisUniformType === "sampler2D"
                         ||  glslUniform.thisUniformType === "sampler3D")     {
                            if
                            (glslUniform.thisUniformSampler2DImg) {
                                fragmentShaderFiltering_Instance.setUniform(
                             glslUniform.thisUniformName        ,
                             glslUniform.thisUniformSampler2DImg,          );
                            }
                        } else                                                {
                                fragmentShaderFiltering_Instance.setUniform(
                             glslUniform.thisUniformName        ,
                             glslUniform.thisUniformDefaultValue,          );
                        }
                    }
                }
                canvasInstance.filter(fragmentShaderFiltering_Instance);
            }
//------------------------------//
        };
        mode = MODE.WEBCAM;
        mode = MODE.WEBCAM;
    };

    const ceaseWebCam = (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
        mediaRecorder      ?.   stop();
        mediaRecorder       = null!;
        mediaRecorderWebCam?.   stop();
        mediaRecorderWebCam = null!;
        webcamCapture       . remove();
        webcamCapture       = null!;
        canvasInstance.draw = () => {
        canvasInstance.background(255);
        };
    };

    let webcamCapture       :        p5.Element;
    let imageFormatSelection: HTMLSelectElement;
    let videoFormatSelection: HTMLSelectElement;
    let videoProgressSlider_:
         HTMLProgressElement;










//sbs_-_noise_texture_pack_-_128x128
//  128x128
//sbs_-_noise_texture_pack_-_256x256
//  256x256
//sbs_-_noise_texture_pack_-_512x512
//  512x512

//Cracks       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Craters      (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Gabor        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Grainy       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Manifold     (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Marble       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Melt         (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Milky        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Perlin       (128x128: 1 - 24) (256x256: 1 - 24) (512x512: 1 - 24) random
//Spokes       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Streak       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Super Noise  (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Super Perlin (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Swirl        (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Techno       (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Turbulence   (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Vein         (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random
//Voronoi      (128x128: 1 - 14) (256x256: 1 - 14) (512x512: 1 - 14) random



import { supabase                   } from "./global";
import { fetchAllTextures_Noise     } from "./common";
import { fetchAllTextures_Bayer     } from "./common";
import { fetchAllTextures_Palette   } from "./common";
import { fetchAllTextures_Pencil_   } from "./common";
import { fetchAllTextures_ASCII     } from "./common";
import { fetchAllTextures_Tiled     } from "./common";
import { fetchAllTextures_ShaderToy } from "./common";
import { fetchAllFonts_TTF_ITCHIO   } from "./common";
import { fetchAllFonts_OTF_ITCHIO   } from "./common";
import { texturesNoise              } from "./global";
import { texturesBayer              } from "./global";
import { texturesPalette            } from "./global";
import { texturesPencil_            } from "./global";
import { texturesASCII              } from "./global";
import { texturesTiled              } from "./global";
import { texturesShaderToy          } from "./global";
import { effectsUsedForFiltering    } from "./global";
import { customFonts                } from "./global";
import { onUndoActionExecuted       } from "./common";
import { onRedoActionExecuted       } from "./common";
import { editorSnapshotsRedoStack   } from "./global";
import { editorSnapshotsUndoStack   } from "./global";

window.addEventListener("keydown", async (e: KeyboardEvent) => {
    if (e.ctrlKey && e.key === "z") {
        await onUndoActionExecuted();
        console.log("undo");
    }
    else
    if (e.ctrlKey && e.key === "y") {
        await onRedoActionExecuted();
        console.log("redo");
    }
});

onMount(async () => {
  $texturesNoise     = [... $texturesNoise    , ... await fetchAllTextures_Noise    (        )].sort();
  $texturesBayer     = [... $texturesBayer    , ... await fetchAllTextures_Bayer    (        )].sort();
  $texturesPalette   = [... $texturesPalette  , ... await fetchAllTextures_Palette  (supabase)].sort();
  $texturesPencil_   = [... $texturesPencil_  , ... await fetchAllTextures_Pencil_  (supabase)].sort();
  $texturesASCII     = [... $texturesASCII    , ... await fetchAllTextures_ASCII    (supabase)].sort();
  $texturesTiled     = [... $texturesTiled    , ... await fetchAllTextures_Tiled    (supabase)].sort();
  $texturesShaderToy = [... $texturesShaderToy, ... await fetchAllTextures_ShaderToy(supabase)].sort();
  $customFonts = [... $customFonts, ... await fetchAllFonts_TTF_ITCHIO(supabase), ... await fetchAllFonts_OTF_ITCHIO(supabase)].sort();//.map(customFont => { customFont.customFontFace = canvasInstance.loadFont(customFont.customFontPath); return customFont; });
//$customFonts = [... $customFonts, ... await fetchAllFonts_TTF_ITCHIO(supabase), ... await fetchAllFonts_OTF_ITCHIO(supabase)].sort();//.map(customFont => { customFont.customFontFace = canvasInstance.loadFont(customFont.customFontPath); return customFont; });
});


//imgur video/image
//Giphy gif@@/gif@@


let videoToShare: Blob;
let imageToShare: Blob;


let mode            : MODE               = MODE              .   IMAGE         ;
let modeCaptureImage: MODE_CAPTURE_IMAGE = MODE_CAPTURE_IMAGE.AS_IMAGE         ;
let modeCAptureVideo: MODE_CAPTURE_VIDEO = MODE_CAPTURE_VIDEO.AS_VIDEO_FULLSHOT;
//PREVIEW
//IMAGE
//VIDEO
//GIF

import {      Shaders    } from "./common";
import { type ShaderName } from "./common";
import { type ShaderPath } from "./common";
const shaderMaps: Map<string, any> = new Map();
onMount(    async () => {
    for(let shaderPath of Shaders.values()) {
        if (shaderPath
                .includes("./lib/")) {
            const moduleGLSL =
            await import (`./lib/${shaderPath
                .replace ("./lib/"   , "")
                .replace (".glsl?raw", "")
                          }.glsl?raw`);
            shaderMaps.set(
            shaderPath,
            moduleGLSL.
            default   ,   );
        }
        else
        if (shaderPath
                .includes("./shadertoys/")) {
            const moduleGLSL =
            await import (`./shadertoys/${shaderPath
                .replace ("./shadertoys/", "")
                .replace (".glsl?raw"    , "")
                          }.glsl?raw`);
            shaderMaps.set(
            shaderPath,
            moduleGLSL.
            default   ,   );
        }
        else
        if (shaderPath
                .includes("./lygia/")) {
            const moduleGLSL =
            await import (`./lygia/${shaderPath
                .replace ("./lygia/" , "")
                .replace (".glsl?raw", "")
                          }.glsl?raw`);
            shaderMaps.set(
            shaderPath,
            moduleGLSL.
            default   ,   );
        }
    }
});

const  loadAsset = async       (assetPath: string): Promise<string> => {
//  const  asset = await import(assetPath        );
//  return asset.default                          ;
    return shaderMaps.get(assetPath);
//  return shaderMaps.get(assetPath);
}



import        GLSLUniform          from "./GLSLUniform.svelte";
import      { MODE               } from "./types";
import      { MODE_CAPTURE_IMAGE } from "./types";
import      { MODE_CAPTURE_VIDEO } from "./types";
import type { GLSLUniformValue   } from "./types";
import type { EditorSnapshot     } from "./types";
import type { GLSLUniforms       } from "./types";
import type { GLSLUniform_       } from "./types";
import        GlslUniform          from "./GLSLUniform.svelte";

    import { onDestroy } from "svelte";
//  import { onDestroy } from "svelte";
    onDestroy(async() => { canvasInstance.remove(); });
//  onDestroy(async() => { canvasInstance.remove(); });

const handleUpdate = (updatedUniforms: GLSLUniforms): void => {
};

let videoIsPlaying: boolean = false ;
let imageIsPlaying: boolean = false ;
let AIInputPrompts: HTMLInputElement;
let cachedSelectedIndex:
    number                  =   0   ;

    import DraggableTextComponent from "./DraggableTextComponent.svelte";
//  import DraggableTextComponent from "./DraggableTextComponent.svelte";
let        draggableText:
           DraggableText;
    import MouseCursor from "./MouseCursor.svelte";
//  import MouseCursor from "./MouseCursor.svelte";

    let recording: boolean = false;
//  let recording: boolean = false;
    let selectedCaptureOption: string = "Snapshot";
//  let selectedCaptureOption: string = "Snapshot";
const handleCaptureAsVideo = async(): Promise<void> => {
    if (recording === false) {
        recording =   true ;
//      recording =   true ;
        if (selectedCaptureOption === "Snapshot") {
            await startCaptureAsVideoSnapshot();
        }
        else
        if (selectedCaptureOption === "Fullshot") {
            await startCaptureAsVideoFullshot();
        }
    }
    else                     {
        recording =   false;
//      recording =   false;
        if (selectedCaptureOption === "Snapshot") {
            await ceaseCaptureAsVideoSnapshot();
        }
        else
        if (selectedCaptureOption === "Fullshot") {
            await ceaseCaptureAsVideoFullshot();
        }
    }
}

    import          SnackbarSuccess         from "./SnackbarSuccess.svelte";
    import          SnackbarFailure         from "./SnackbarFailure.svelte";
    import {                successScript } from "./global"                ;
    import {                failureScript } from "./global"                ;
    import { makeNewSnackbarSuccess       } from "./common"                ;
    import { makeNewSnackbarFailure       } from "./common"                ;
</script>

<!--<div bind:this={canvasBG} style:position="absolute" style:z-index="-1" style:pointer-events="none"></div>-->
    <div bind:this={canvasBG} style:position="absolute" style:z-index="-1" style:pointer-events="none"></div>
<!--<div bind:this={canvasBG} style:position="absolute" style:z-index="-1" style:pointer-events="none"></div>-->
<!--<DraggableTextComponent canvasInstance={canvasInstance} bind:draggableText={draggableText}></DraggableTextComponent>-->
<!--<DraggableTextComponent canvasInstance={canvasInstance} bind:draggableText={draggableText}></DraggableTextComponent>-->
<MouseCursor> </MouseCursor>
<main>
    <div     class="      container                                 ">
    <!--<div class="headerContainer                "></div>-->
    <!--<div class="headerContainer                "></div>-->
        <div class="topBarContainer   small-padding">
            <div class="row">
                <button class=" slow-ripple large-elevate margin grey10"><i class="fas fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={input} on:change={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>
            <!--<button class=" slow-ripple large-elevate margin grey10"><i class="fas fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={input} on:change={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>-->
                <div    class="field middle-align">
                    <nav>
                    <!--<div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>-->
                        <div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>
                    <!--<div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>-->
                        <label     class="switch icon">
                            <input class="           " type="checkbox" on:change={(e) => {
                                const           fakeMouseEvent: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement } = new MouseEvent("click", { bubbles: true, cancelable: true, }) as MouseEvent & { currentTarget: EventTarget & HTMLButtonElement };
//                              const           fakeMouseEvent: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement } = new MouseEvent("click", { bubbles: true, cancelable: true, }) as MouseEvent & { currentTarget: EventTarget & HTMLButtonElement };
                                if (e.currentTarget.checked) {
                                    startWebCam(fakeMouseEvent);
                                }
                                else                         {
                                    ceaseWebCam(fakeMouseEvent);
                                }
                            }}>
                            <span>
                                <i class="white-text deep-orange">Videocam_Off</i>
                                <i class="white-text deep-orange">Videocam    </i>
                            </span>
                        </label>
                    </nav>
                </div>
            </div>
<!--        <button class="slow-ripple large-elevate" on:click={startWebCam}>START WEB CAM</button>
            <button class="slow-ripple large-elevate" on:click={ceaseWebCam}>STOP@ WEB CAM</button>        -->
            <div class="horizontal">
            <!--<button class="slow-ripple large-elevate margin deep-orange white-text" data-ui="#a"><i class="fas fa-download white-text"></i><span>Save</span></button>-->
                <button class="slow-ripple large-elevate margin deep-orange white-text" data-ui="#a"><i class="fas fa-download white-text"></i><span>Save</span></button>
            <!--<button class="slow-ripple large-elevate margin deep-orange white-text" data-ui="#a"><i class="fas fa-download white-text"></i><span>Save</span></button>-->
                <dialog class="left small-blur dialogSide" id="a">
                    <!-- svelte-ignore a11y_consider_explicit_label -->
                    <!-- svelte-ignore a11y_consider_explicit_label -->
                <!--<div class="max right-align"><button class="slow-ripple transparent circle left-round top-round right large-elevate white-text grey10" data-ui="#a"><i class="fas fa-xmark white-text"></i></button></div>-->
                    <div class="max right-align"><button class="slow-ripple transparent circle left-round top-round right large-elevate white-text grey10" data-ui="#a"><i class="fas fa-xmark white-text"></i></button></div>
                <!--<div class="max right-align"><button class="slow-ripple transparent circle left-round top-round right large-elevate white-text grey10" data-ui="#a"><i class="fas fa-xmark white-text"></i></button></div>-->
                    <div     class="column max small-padding">
                        <div class="column                  ">
                            <h6  class="                         white-text                          ">Save as image</h6>
                            <div class="field label suffix round white-text large-elevate slow-ripple">
                                <select bind:this={imageFormatSelection}>
                                    {#each         imageFormats as
                                                   imageFormat
                                                  (imageFormat)
                                    }
                                          <option>{imageFormat.extension}</option>
                                    {/each}
                                </select>
                            <!-- svelte-ignore  a11y-label-has-associated-control -->
                            <!-- svelte-ignore  a11y-label-has-associated-control -->
                            <!--<label>Image Format</label>-->
                                <label>Image Format</label>
                            <!--<label>Image Format</label>-->
                            <!--<i class="fas fa-chevron-down"></i>-->
                                <i class="fas fa-chevron-down"></i>
                            <!--<i class="fas fa-chevron-down"></i>-->
                            </div>
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                        <!--<button class="slow-ripple center large-elevate deep-orange white-text" on:click={async (e) => { await startCaptureAsImage(); }}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate white"><span class="grey10-text">Save the current frame</span></div></button>-->
                            <button class="slow-ripple center large-elevate deep-orange white-text" on:click={async (e) => { await startCaptureAsImage(); }}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate white"><span class="grey10-text">Save the current frame</span></div></button>
                        <!--<button class="slow-ripple center large-elevate deep-orange white-text" on:click={async (e) => { await startCaptureAsImage(); }}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate white"><span class="grey10-text">Save the current frame</span></div></button>-->
                            <!--Đang render image/video trên canvas -> capture frame hình hiện tại-->
                            <!--Đang render image/video trên canvas -> capture frame hình hiện tại-->
                        </div>
                        <div class="medium-space"></div>
                        <div class="column      ">
                            <h6  class="                   white-text                                ">Save as video</h6>
                            <div class="field label suffix round white-text large-elevate slow-ripple"> 
                                <select bind:this={videoFormatSelection}>
                                    {#each         videoFormats as
                                                   videoFormat
                                                  (videoFormat)
                                    }
                                          <option>{videoFormat.mimeType}</option>
                                    {/each}
                                </select>
                            <!-- svelte-ignore  a11y-label-has-associated-control -->
                            <!-- svelte-ignore  a11y-label-has-associated-control -->
                            <!--<label>Video Format</label>-->
                                <label>Video Format</label>
                            <!--<label>Video Format</label>-->
                            <!--<i class="fas fa-chevron-down"></i>-->
                                <i class="fas fa-chevron-down"></i>
                            <!--<i class="fas fa-chevron-down"></i>-->
                            </div>
                            <div     class="row   center-align">
                                <div class="field middle-align">
                                    <nav>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round"><span>Save the frames from when you press the start button until you press the stop button into a video.          </span></div></label>-->
                                        <label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round"><span>Save the frames from when you press the start button until you press the stop button into a video.          </span></div></label>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round"><span>Save the frames from when you press the start button until you press the stop button into a video.          </span></div></label>-->
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round"><span>For the image: it's the same as a snapshot.<br>For the video: Save the entire video with the applied effect.</span></div></label>-->
                                        <label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round"><span>For the image: it's the same as a snapshot.<br>For the video: Save the entire video with the applied effect.</span></div></label>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round"><span>For the image: it's the same as a snapshot.<br>For the video: Save the entire video with the applied effect.</span></div></label>-->
                                    </nav>
                                </div>
                            </div>
                            <div        class="row  middle-align                               "                                                          >
                                <button class="slow-ripple large-elevate deep-orange white-text" on:click={async (e) => { await handleCaptureAsVideo(); }}>
                                    {#if recording === false}
                                        <i class="fa-solid fa-bolt         white-text"></i>
                                    <!--<i class="fa-solid fa-bolt         white-text"></i>-->
                                        <span>Start</span>
                                    <!--<span>Start</span>                 -->
                                    {:else}
                                        <i class="fa-solid fa-pause        white-text"></i>
                                    <!--<i class="fa-solid fa-pause        white-text"></i>-->
                                        <span>Stop </span>
                                    <!--<span>Stop </span>                 -->
                                    {/if}
                                </button>
                                {#if recording === true}
                                    <div>
                                        <i class="fa-solid fa-record-vinyl white-text"></i>
                                    <!--<i class="fa-solid fa-record-vinyl white-text"></i>-->
                                        <span>Recording...</span>
                                    <!--<span>Recording...</span>          -->
                                    </div>
                                {/if}
                            </div>
                        </div>
                        <!-- <button class="slow-ripple large-elevate" on:click={async (e) => { await startCaptureAsVideoSnapshot(); }}>START SAVE AS VIDEO SNAPSHOT</button> -->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc bắt đầu click button này thành 1 video (cần phải click button cạnh bên để ngừng)-->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc bắt đầu click button này thành 1 video (cần phải click button cạnh bên để ngừng)-->
                        <!-- <button class="slow-ripple large-elevate" on:click={async (e) => { await ceaseCaptureAsVideoSnapshot(); }}>CEASE SAVE AS VIDEO SNAPSHOT</button> -->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình                                    thành 1 video (                                       )-->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình                                    thành 1 video (                                       )-->
                        <!-- <button class="slow-ripple large-elevate" on:click={async (e) => { await startCaptureAsVideoFullshot(); }}>START SAVE AS VIDEO FULLSHOT</button> -->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (không cần phải click button cạnh bên để ngừng - sẽ được tự động ngừng trong trường hợp canvas đang render video & cần phải click button cạnh bên để ngừng - trong trường hợp canvas đang render image)-->
                        <!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (không cần phải click button cạnh bên để ngừng - sẽ được tự động ngừng trong trường hợp canvas đang render video & cần phải click button cạnh bên để ngừng - trong trường hợp canvas đang render image)-->
                        <!-- <button class="slow-ripple large-elevate" on:click={async (e) => { await ceaseCaptureAsVideoFullshot(); }}>CEASE SAVE AS VIDEO FULLSHOT</button> -->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (                                                                                                                                                                                                     )-->
                        <!--Đang render image/video trên canvas -> kết thúc capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (                                                                                                                                                                                                     )-->
                    </div>
                </dialog>
                <button class="slow-ripple large-elevate margin deep-orange"
                     on:click={async (e) => {
                        if (mode === MODE.IMAGE ) {
                            await shareImage (/*imageToShare,*/ canvas.children[0] as HTMLCanvasElement);
//                          await shareImage (/*imageToShare,*/ canvas.children[0] as HTMLCanvasElement);
                        }
                        else
                        if (mode === MODE.VIDEO ) {
                            await shareVideo (  videoToShare,   canvas.children[0] as HTMLCanvasElement);
//                          await shareVideo (  videoToShare,   canvas.children[0] as HTMLCanvasElement);
                        }
                        else
                        if (mode === MODE.WEBCAM) {
                            await shareWebcam(  videoToShare,   canvas.children[0] as HTMLCanvasElement);
//                          await shareWebcam(  videoToShare,   canvas.children[0] as HTMLCanvasElement);
                        }
                }}>
                    <i    class="fas fa-share white-text"></i>
                <!--<i    class="fas fa-share white-text"></i>        -->
                    <span class="             white-text">Share</span>
                <!--<span class="             white-text">Share</span>-->
                </button>
            </div>
        </div>
        <div         class="mainBarContainer   ">
            <div     class="sideBarContainer   ">
                <div class="grid small-padding">
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                    <div class="s12 m12 l6">
                        <button class="slow-ripple responsive large-elevate deep-orange" 
                             on:click={async (e) => {
                                $effectsUsedForFiltering = [ ...
                                $effectsUsedForFiltering , { fragmentShaderSourceType________: "NI"
                                                         ,   fragmentShaderSourceCode________: null
                                                         ,   fragmentShader______GLSLUniforms: null
                                                         ,   fragmentShaderFiltering_Instance: null
                                                         ,   fragmentShader_HTMLSelectElement: null
                                                         ,   draggableText                   : null
//                                                       ,   draggableText                   : null
                                                         , }
                                                        ];
                                editorSnapshotsUndoStack.push({
                                    undo: async (dynamicStorage: Map<string, any> | null) => {
                                $effectsUsedForFiltering.pop();
//                              $effectsUsedForFiltering.pop();
                                $effectsUsedForFiltering = $effectsUsedForFiltering;
//                              $effectsUsedForFiltering = $effectsUsedForFiltering;
                                    }
                                    ,
                                    redo: async (dynamicStorage: Map<string, any> | null) => {
                                $effectsUsedForFiltering = [ ...
                                $effectsUsedForFiltering , { fragmentShaderSourceType________: "NI"
                                                         ,   fragmentShaderSourceCode________: null
                                                         ,   fragmentShader______GLSLUniforms: null
                                                         ,   fragmentShaderFiltering_Instance: null
                                                         ,   fragmentShader_HTMLSelectElement: null
                                                         ,   draggableText                   : null
//                                                       ,   draggableText                   : null
                                                         , }
                                                        ];
                                    }
                                    ,
                                    dynamicStorage: null
                                    ,
                                });

                                await makeNewSnackbarSuccess(`A new NI effect has been added - ${$effectsUsedForFiltering.length} so far`);
//                              await makeNewSnackbarFailure(`A new NI effect has been added - ${$effectsUsedForFiltering.length} so far`);
                            }}>
                            <!--<i class="fas fa-plus white-text"></i>-->
                                <i class="fas fa-plus white-text"></i>
                            <!--<i class="fas fa-plus white-text"></i>-->
                            <!--<span class="white-text">Add Effect NI</span> -->
                                <span class="white-text">Add Effect NI</span>
                            <!--<span class="white-text">Add Effect NI</span> -->
                        </button>
                    </div>
                    <!--<div class="space"></div> -->
                    <!--<div class="space"></div> -->
                    <!--<div class="space"></div> -->
                    <!--Thêm effect @có sẵn @@-->
                    <!--Thêm effect @có sẵn @@-->
                    <div class="s12 m12 l6">
                        <button class="slow-ripple responsive large-elevate deep-orange" 
                             on:click={async (e) => {
                                $effectsUsedForFiltering = [ ...
                                $effectsUsedForFiltering , { fragmentShaderSourceType________: "AI"
                                                         ,   fragmentShaderSourceCode________: null
                                                         ,   fragmentShader______GLSLUniforms: null
                                                         ,   fragmentShaderFiltering_Instance: null
                                                         ,   fragmentShader_HTMLSelectElement: null
                                                         ,   draggableText                   : null
//                                                       ,   draggableText                   : null
                                                         , }
                                                        ];
                                editorSnapshotsUndoStack.push({
                                    undo: async (dynamicStorage: Map<string, any> | null) => {
                                $effectsUsedForFiltering.pop();
//                              $effectsUsedForFiltering.pop();
                                $effectsUsedForFiltering = $effectsUsedForFiltering;
//                              $effectsUsedForFiltering = $effectsUsedForFiltering;
                                    }
                                    ,
                                    redo: async (dynamicStorage: Map<string, any> | null) => {
                                $effectsUsedForFiltering = [ ...
                                $effectsUsedForFiltering , { fragmentShaderSourceType________: "AI"
                                                         ,   fragmentShaderSourceCode________: null
                                                         ,   fragmentShader______GLSLUniforms: null
                                                         ,   fragmentShaderFiltering_Instance: null
                                                         ,   fragmentShader_HTMLSelectElement: null
                                                         ,   draggableText                   : null
//                                                       ,   draggableText                   : null
                                                         , }
                                                        ];
                                    }
                                    ,
                                    dynamicStorage: null
                                    ,
                                });

                                await makeNewSnackbarSuccess(`A new AI effect has been added - ${$effectsUsedForFiltering.length} so far`);
//                              await makeNewSnackbarFailure(`A new AI effect has been added - ${$effectsUsedForFiltering.length} so far`);
                            }}>
                            <!--<i class="fas fa-plus white-text"></i>-->
                                <i class="fas fa-plus white-text"></i>
                            <!--<i class="fas fa-plus white-text"></i>-->
                            <!--<span class="white-text">Add Effect AI</span> -->
                                <span class="white-text">Add Effect AI</span>
                            <!--<span class="white-text">Add Effect AI</span> -->
                        </button>
                    </div>
                <!--<div class="space"></div> -->
                <!--<div class="space"></div> -->
                <!--<div class="space"></div> -->
                    <!--Thêm effect gen bởi AI-->
                    <!--Thêm effect gen bởi AI-->
                    <div class="s12 m12 l6">
                        <button class="slow-ripple responsive large-elevate grey10 align-center"
                            on:click={async (e) => {
                            $effectsUsedForFiltering = [ ...
                            $effectsUsedForFiltering , { fragmentShaderSourceType________: null
                                                     ,   fragmentShaderSourceCode________: null
                                                     ,   fragmentShader______GLSLUniforms: null
                                                     ,   fragmentShaderFiltering_Instance: null
                                                     ,   fragmentShader_HTMLSelectElement: null
                                                     ,   draggableText                   : {
//                                                   ,   draggableText                   : {
                                                                                            colorFilling: { r: 0, g: 0, b: 0, a: 255 },
                                                                                            colorOutline: { r: 0, g: 0, b: 0, a: 255 },
                                                                                            fontSize    : 24                          ,
                                                                                            contents    : "Text"                      ,
                                                                                            alignHOption: "center"                    ,
                                                                                            alignVOption: "center"                    ,
                                                                                            font        : defaultFont                 ,
                                                                                            stylesOption: "normal"                    ,
                                                                                            positionX   : 0                           ,
                                                                                            positionY   : 0                           ,
                                                                                            dimensionW  : 24 * 4                      ,
                                                                                            dimensionH  : 24 * 1                      ,
                                                                                            isDragging  : false                       ,
                                                                                            offsetX     : 0                           ,
                                                                                            offsetY     : 0                           ,
                                                                                            spacings    : 24                          ,
                                                                                            wrapMode    : null!                       ,
//                                                                                         }
                                                                                           }
                                                     , }
                                                    ];


                            editorSnapshotsUndoStack.push({
                                undo: async (dynamicStorage: Map<string, any> | null) => {
                            $effectsUsedForFiltering.pop();
//                          $effectsUsedForFiltering.pop();
                            $effectsUsedForFiltering = $effectsUsedForFiltering;
//                          $effectsUsedForFiltering = $effectsUsedForFiltering;
                                }
                                ,
                                redo: async (dynamicStorage: Map<string, any> | null) => {
                            $effectsUsedForFiltering = [ ...
                            $effectsUsedForFiltering , { fragmentShaderSourceType________: null
                                                     ,   fragmentShaderSourceCode________: null
                                                     ,   fragmentShader______GLSLUniforms: null
                                                     ,   fragmentShaderFiltering_Instance: null
                                                     ,   fragmentShader_HTMLSelectElement: null
                                                     ,   draggableText                   : {
//                                                   ,   draggableText                   : {
                                                                                            colorFilling: { r: 0, g: 0, b: 0, a: 255 },
                                                                                            colorOutline: { r: 0, g: 0, b: 0, a: 255 },
                                                                                            fontSize    : 24                          ,
                                                                                            contents    : "Text"                      ,
                                                                                            alignHOption: "center"                    ,
                                                                                            alignVOption: "center"                    ,
                                                                                            font        : defaultFont                 ,
                                                                                            stylesOption: "normal"                    ,
                                                                                            positionX   : 0                           ,
                                                                                            positionY   : 0                           ,
                                                                                            dimensionW  : 24 * 4                      ,
                                                                                            dimensionH  : 24 * 1                      ,
                                                                                            isDragging  : false                       ,
                                                                                            offsetX     : 0                           ,
                                                                                            offsetY     : 0                           ,
                                                                                            spacings    : 24                          ,
                                                                                            wrapMode    : null!                       ,
//                                                                                         }
                                                                                           }
                                                     , }
                                                    ];
                                }
                                ,
                                dynamicStorage: null
                                ,
                            });


                            await makeNewSnackbarSuccess(`A new text effect has been added - ${$effectsUsedForFiltering.length} so far`);
//                          await makeNewSnackbarFailure(`A new text effect has been added - ${$effectsUsedForFiltering.length} so far`);
                        }}>
                        <!--<i class="fas fa-plus white-text"></i>-->
                        <!--<i class="fas fa-plus white-text"></i>-->
                        <!--<i class="fas fa-plus white-text"></i>-->
                        <!--<span class="white-text">Insert Text     </span> -->
                            <span class="white-text">Insert Text     </span>
                        <!--<span class="white-text">Insert Text     </span> -->                        
                        </button>
                    </div>
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                <!--<div class="space"></div>-->
                </div>
                <div class="effectContainer margin">
                    {#each $effectsUsedForFiltering as {
                           fragmentShaderSourceType________
                     ,     fragmentShaderSourceCode________
                     ,     fragmentShader______GLSLUniforms
                     ,     fragmentShaderFiltering_Instance
                     ,     fragmentShader_HTMLSelectElement
                     ,     draggableText
//                   ,     draggableText
                     ,
                                                       }
                     ,      effectIndex
                    }
                <!--<div class="tiny-space"></div>-->
                    <div class="tiny-space"></div>
                <!--<div class="tiny-space"></div>-->
                    <div class="medium-padding">            
                        {#if fragmentShaderSourceType________ ===  "NI"}
                            <div     class="                          row">
                                <div class="field label suffix round  max large-elevate white-text slow-ripple">
                                <!--<select bind:this={fragmentShader_HTMLSelectElement}></select>-->
                                <!--<select bind:this={fragmentShader_HTMLSelectElement}></select>-->
                                    <select bind:this={fragmentShader_HTMLSelectElement}
                                        on:change={async(e) => {
                                        let editorSnapshot: EditorSnapshot = {
                                            undo          : null,
                                            redo          : null,
                                            dynamicStorage: null,
                                        };
                                        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => {
                                            fragmentShaderSourceType________ = dynamicStorage?.get("undoFragmentShaderSourceType________");
                                            fragmentShaderSourceCode________ = dynamicStorage?.get("undoFragmentShaderSourceCode________");
                                            fragmentShader______GLSLUniforms = dynamicStorage?.get("undoFragmentShader______GLSLUniforms");
                                            fragmentShaderFiltering_Instance = dynamicStorage?.get("undoFragmentShaderFiltering_Instance");
                                            fragmentShader_HTMLSelectElement!
                                            .selectedIndex!                  = dynamicStorage?.get("undoCachedSelectedIndex");
                                        };
                                        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => {
                                            fragmentShaderSourceType________ = dynamicStorage?.get("redoFragmentShaderSourceType________");
                                            fragmentShaderSourceCode________ = dynamicStorage?.get("redoFragmentShaderSourceCode________");
                                            fragmentShader______GLSLUniforms = dynamicStorage?.get("redoFragmentShader______GLSLUniforms");
                                            fragmentShaderFiltering_Instance = dynamicStorage?.get("redoFragmentShaderFiltering_Instance");
                                            fragmentShader_HTMLSelectElement!
                                            .selectedIndex!                  = dynamicStorage?.get("redoCachedSelectedIndex");
                                        };
                                        editorSnapshot.dynamicStorage = new Map<string, any>();
                                        editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceType________", fragmentShaderSourceType________);
                                        editorSnapshot.dynamicStorage.set("undoFragmentShaderSourceCode________", fragmentShaderSourceCode________);
                                        editorSnapshot.dynamicStorage.set("undoFragmentShader______GLSLUniforms", fragmentShader______GLSLUniforms);
                                        editorSnapshot.dynamicStorage.set("undoFragmentShaderFiltering_Instance", fragmentShaderFiltering_Instance);
                                        editorSnapshot.dynamicStorage.set("undoCachedSelectedIndex"
                                                                     ,         cachedSelectedIndex);
                                                                               cachedSelectedIndex =
                                                            e.currentTarget.selectedIndex;
                                        let shaderName  =   e.currentTarget.options      [
                                                            e.currentTarget.selectedIndex].value ;
                                        if (shaderName ===            "none")             {
                                            console.log(`Shader name:   ${shaderName}          `);
                                            fragmentShaderSourceCode________ = null;
                                            fragmentShader______GLSLUniforms = null;
                                            fragmentShaderFiltering_Instance = null;
                                            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", fragmentShaderSourceType________);
                                            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", fragmentShaderSourceCode________);
                                            editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", fragmentShader______GLSLUniforms);
                                            editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", fragmentShaderFiltering_Instance);
                                            editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex"
                                                                         ,         cachedSelectedIndex);
                                        }
                                        else                                              {
                                            console.log(`Shader name:   ${shaderName}          `);
                                            let  shaderPath = Shaders.get(shaderName            );
                                            if (!shaderPath) {
                                            console.log(`Shader path:   ${shaderPath} not exist`);
                                                         return                                  ;
                                            }
                                            const                                                          shaderRawSourceCode = await loadAsset(shaderPath);
                                            if ( shaderName.toLowerCase()
                                                           .       trim().includes("lygia"))    {
                                                fragmentShaderSourceCode________ = await resolveLygiaAsync(shaderRawSourceCode);
                                                if (shaderName .includes("LYGIA ColorDitherTriangleNoise")) {
//                                              if (shaderName .includes("LYGIA ColorDitherTriangleNoise")) {
                                                    fragmentShaderSourceCode________ =
                                                    fragmentShaderSourceCode________.replaceAll("HIGHP"
                                                                                    ,           "     "
                                                                                    ,          );
                                                }
                                                else
                                                if (shaderName.includes("LYGIA FilterJointBilateral")) {
//                                              if (shaderName.includes("LYGIA FilterJointBilateral")) {
                                                    fragmentShaderSourceCode________ =
                                                    fragmentShaderSourceCode________.replaceAll(/\bsample\b/g                  
                                                                                    ,             "samples"
                                                                                    ,          );
                                                }
                                            }
                                            else                                                {
                                                fragmentShaderSourceCode________ =                         shaderRawSourceCode ;
                                            }
                                            if (fragmentShaderSourceCode________.charAt( 0 ) === "-") {
                                                fragmentShaderSourceCode________ =
                                                fragmentShaderSourceCode________.
                                                substring(1);
                                            }
                                            console.log(fragmentShaderSourceCode________);
                                            fragmentShader______GLSLUniforms =                                  parseGLSL(fragmentShaderSourceCode________);
//                                          fragmentShader______GLSLUniforms =                                  parseGLSL(fragmentShaderSourceCode________);
                                            console.log(fragmentShader______GLSLUniforms);
                                            fragmentShaderFiltering_Instance = (canvasInstance as any).createFilterShader(fragmentShaderSourceCode________);
//                                          fragmentShaderFiltering_Instance = (canvasInstance as any).createFilterShader(fragmentShaderSourceCode________);
                                            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceType________", fragmentShaderSourceType________);
                                            editorSnapshot.dynamicStorage.set("redoFragmentShaderSourceCode________", fragmentShaderSourceCode________);
                                            editorSnapshot.dynamicStorage.set("redoFragmentShader______GLSLUniforms", fragmentShader______GLSLUniforms);
                                            editorSnapshot.dynamicStorage.set("redoFragmentShaderFiltering_Instance", fragmentShaderFiltering_Instance);
                                            editorSnapshot.dynamicStorage.set("redoCachedSelectedIndex"
                                                                         ,         cachedSelectedIndex);
                                        }
                                        editorSnapshotsUndoStack.push(
                                        editorSnapshot               );
                                        }}>
                                        {#each [ "none" , ... [ ... Shaders.keys() ].sort() ] as shaderName
                                                                                                (shaderName)
                                        }
                                                                                        <option>{shaderName}</option>            
                                        {/each}
                                    </select>
                            <!-- svelte-ignore a11y-label-has-associated-control -->
                            <!-- svelte-ignore a11y-label-has-associated-control -->
                                    <label>Choose your effects</label>
                            <!--    <label>Choose your effects</label>           -->
                                    <i class="fas fa-chevron-down"></i>
                            <!--    <i class="fas fa-chevron-down"></i>          -->
                                </div>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                {#if fragmentShader______GLSLUniforms        !== null}
                                {#if fragmentShader______GLSLUniforms.length  >     0}
                                    <!--<button class="slow-ripple circle large-elevate" data-ui={`#b${effectIndex}`}><i class="fas fa-pen"></i></button>-->
                                        <button class="slow-ripple circle large-elevate" data-ui={`#b${effectIndex}`}><i class="fas fa-pen"></i></button>
                                    <!--<button class="slow-ripple circle large-elevate" data-ui={`#b${effectIndex}`}><i class="fas fa-pen"></i></button>-->
                                {/if}
                                {/if}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="margin slow-ripple large-elevate deep-orange white-text" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old NI effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fa-solid fa-ban"></i></button>-->
                                <button class="margin slow-ripple large-elevate deep-orange white-text" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old NI effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fa-solid fa-ban"></i></button>
                            <!--<button class="margin slow-ripple large-elevate deep-orange white-text" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old NI effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fa-solid fa-ban"></i></button>-->
                            </div>
                            <dialog  class="    responsive dialog blur" id={`b${String(effectIndex)}`}>
                                <div class="row responsive            "                               >
                                    <h6>Customize your effect</h6>
                                    <div        class="max right-align">
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <button class="transparent circle right large-elevate" data-ui={`#b${effectIndex}`}><i class="fas fa-xmark"></i></button>
                                    </div>
                                </div>
                            <!--<div class="medium-space"></div>-->
                                <div class="medium-space"></div>
                            <!--<div class="medium-space"></div>-->
                                <GlslUniform uniforms={fragmentShader______GLSLUniforms ?? []} onUpdate={handleUpdate} canvasInstance={
                                                                                                                       canvasInstance }></GlslUniform>
                            </dialog>
                        {/if}
                        {#if fragmentShaderSourceType________ ===  "AI"}
                            <div     class="row               ">
                            <!--<div class="max medium-padding"><span>Effect {effectIndex} by AI</span></div>-->
                                <div class="max medium-padding  round"><span>Effect {effectIndex} by AI</span></div>
                            <!--<div class="max medium-padding"><span>Effect {effectIndex} by AI</span></div>-->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple circle large-elevate" data-ui={`#c${effectIndex}`}><i class="fas fa-pen"></i></button>-->
                                <button class="slow-ripple circle large-elevate" data-ui={`#c${effectIndex}`}><i class="fas fa-pen"></i></button>
                            <!--<button class="slow-ripple circle large-elevate" data-ui={`#c${effectIndex}`}><i class="fas fa-pen"></i></button>-->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple circle large-elevate" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old AI effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fas fa-trash"></i></button>-->
                                <button class="slow-ripple circle large-elevate" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old AI effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fas fa-trash"></i></button>
                            <!--<button class="slow-ripple circle large-elevate" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old AI effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fas fa-trash"></i></button>-->
                            </div>
                            <dialog  class="    responsive dialog blur" id={`c${effectIndex}`}>
                                <div class="row responsive            "                       >
                                    <h6>  Ask AI for a new effect  </h6>
                                    <div        class="max right-align">
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <button class="transparent circle right large-elevate" data-ui={`#c${effectIndex}`}><i class="fas fa-xmark"></i></button>
                                    </div>
                                </div>
                            <!--<div     class="      medium-space          ">  </div>-->
                                <div     class="      medium-space          ">  </div>
                            <!--<div     class="      medium-space          ">  </div>-->
                                <div     class="                         row">
                                    <div class="field  round label max">
                                        <input type="text" bind:this={AIInputPrompts}>
                                        <!-- svelte-ignore a11y_label_has_associated_control -->
                                        <!-- svelte-ignore a11y_label_has_associated_control -->
                                    <!--<label>Describe the effect you want</label> -->
                                        <label>Describe the effect you want</label>
                                    <!--<label>Describe the effect you want</label> -->
                                    </div>
                                    <!-- svelte-ignore a11y_consider_explicit_label -->
                                    <!-- svelte-ignore a11y_consider_explicit_label -->
                                    <button class="slow-ripple circle large-elevate" on:click={async (e)=>{
                                        fragmentShaderSourceCode________=(await (await promptShader(AIInputPrompts.value.split(";"))).text()).split("\n").slice(+1 , -1).join("\n");
//                                      fragmentShaderSourceCode________=(await (await promptShader(AIInputPrompts.value.split(";"))).text()).split("\n").slice(+1 , -1).join("\n");
                                        console.log(fragmentShaderSourceCode________);
                                        fragmentShader______GLSLUniforms =                                  parseGLSL(fragmentShaderSourceCode________!);
//                                      fragmentShader______GLSLUniforms =                                  parseGLSL(fragmentShaderSourceCode________!);
                                        console.log(fragmentShader______GLSLUniforms);
                                        fragmentShaderFiltering_Instance = (canvasInstance as any).createFilterShader(fragmentShaderSourceCode________!);
//                                      fragmentShaderFiltering_Instance = (canvasInstance as any).createFilterShader(fragmentShaderSourceCode________!);
                                    }}>
                                    <!--<i class="fas fa-paper-plane"></i>-->
                                        <i class="fas fa-paper-plane"></i>
                                    <!--<i class="fas fa-paper-plane"></i>-->
                                    </button>
                                </div>
                            <!--<div class="space"></div>-->
                                <div class="space"></div>
                            <!--<div class="space"></div>-->
                                <GlslUniform uniforms={fragmentShader______GLSLUniforms ?? []} onUpdate={handleUpdate} canvasInstance={
                                                                                                                       canvasInstance }></GlslUniform>
                            </dialog>
                        {/if}
                        {#if !fragmentShaderSourceType________}
                            <div        class="row                ">
                                <div    class="max  medium-padding"><span>Caption: {draggableText?.contents ?? ""}</span></div>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple  circle large-elevate" data-ui={`#d${effectIndex}`}><i class="fas fa-pen"></i></button>-->
                                <button class="slow-ripple  circle large-elevate" data-ui={`#d${effectIndex}`}><i class="fas fa-pen"></i></button>
                            <!--<button class="slow-ripple  circle large-elevate" data-ui={`#d${effectIndex}`}><i class="fas fa-pen"></i></button>-->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple  circle large-elevate" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old text effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fas fa-trash"></i></button>-->
                                <button class="slow-ripple  circle large-elevate" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old text effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fas fa-trash"></i></button>
                            <!--<button class="slow-ripple  circle large-elevate" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); await makeNewSnackbarFailure(`An old text effect has been removed - ${$effectsUsedForFiltering.length} left`); }}><i class="fas fa-trash"></i></button>-->
                            </div>
                            <dialog  class="    responsive dialog blur" id={`d${String(effectIndex)}`}>
                                <div class="row responsive            "                               >
                                    <h6>Customize your text</h6>
                                    <div        class="max right-align">
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <!-- svelte-ignore a11y_consider_explicit_label -->
                                        <button class="transparent circle right large-elevate" data-ui={`#d${effectIndex}`}><i class="fas fa-xmark"></i></button>
                                    </div>
                                </div>
                            <!--<div class="medium-space"></div>-->
                                <div class="medium-space"></div>
                            <!--<div class="medium-space"></div>-->
                            <!--<DraggableTextComponent canvasInstance={canvasInstance} bind:draggableText={draggableText!}></DraggableTextComponent>-->
                                <DraggableTextComponent canvasInstance={canvasInstance} bind:draggableText={draggableText!}></DraggableTextComponent>
                            <!--<DraggableTextComponent canvasInstance={canvasInstance} bind:draggableText={draggableText!}></DraggableTextComponent>-->
                            </dialog>
                        {/if}
                        <div class="row max">
                            {#if effectIndex > 0}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple max large-elevate grey10"
                                     on:click={async (e) => {
                                    let index1: number | undefined = $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement?.selectedIndex;
                                    let index2: number | undefined = $effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                                    let temp                       = $effectsUsedForFiltering[effectIndex    ]                                                ;
                                    $effectsUsedForFiltering[effectIndex    ] =
                                    $effectsUsedForFiltering[effectIndex - 1] ;
                                    $effectsUsedForFiltering[effectIndex - 1] =
                                        temp                                  ;
                                    if ($effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
                                        $effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                                    }
                                    if ($effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement) {
                                        $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                                    }
                                    $effectsUsedForFiltering =
                                    $effectsUsedForFiltering ;


                                    
        //                          let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
                                    let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        //                          let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
                                    editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => {
                                        let index1: number | undefined = $effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let index2: number | undefined = $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let temp                       = $effectsUsedForFiltering[effectIndex - 1]                                                ;
                                        $effectsUsedForFiltering[effectIndex - 1] =
                                        $effectsUsedForFiltering[effectIndex    ] ;
                                        $effectsUsedForFiltering[effectIndex    ] =
                                            temp                                  ;
                                        if ($effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                                        }
                                        if ($effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                                        }
                                        $effectsUsedForFiltering =
                                        $effectsUsedForFiltering ;
                                    };
                                    editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => {
                                        let index1: number | undefined = $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let index2: number | undefined = $effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let temp                       = $effectsUsedForFiltering[effectIndex    ]                                                ;
                                        $effectsUsedForFiltering[effectIndex    ] =
                                        $effectsUsedForFiltering[effectIndex - 1] ;
                                        $effectsUsedForFiltering[effectIndex - 1] =
                                            temp                                  ;
                                        if ($effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex - 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                                        }
                                        if ($effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                                        }
                                        $effectsUsedForFiltering =
                                        $effectsUsedForFiltering ;
                                    };



        //                          editorSnapshotsUndoStack.push(editorSnapshot);
                                    editorSnapshotsUndoStack.push(editorSnapshot);
        //                          editorSnapshotsUndoStack.push(editorSnapshot);
                                }}>
                                <!--<i class="fa-solid fa-chevron-up  "></i>-->
                                    <i class="fa-solid fa-chevron-up  "></i>
                                <!--<i class="fa-solid fa-chevron-up  "></i>-->
                                </button>
                            {/if}
                            {#if effectIndex < $effectsUsedForFiltering.length - 1}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple max large-elevate grey10"
                                     on:click={async (e) => {
                                    let index1: number | undefined = $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement?.selectedIndex;
                                    let index2: number | undefined = $effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                                    let temp                       = $effectsUsedForFiltering[effectIndex    ]                                                ;
                                    $effectsUsedForFiltering[effectIndex    ] =
                                    $effectsUsedForFiltering[effectIndex + 1] ;
                                    $effectsUsedForFiltering[effectIndex + 1] =
                                        temp                                  ;
                                    if ($effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
                                        $effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                                    }
                                    if ($effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement) {
                                        $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                                    }
                                    $effectsUsedForFiltering =
                                    $effectsUsedForFiltering ;


                                    
        //                          let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
                                    let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        //                          let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
                                    editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => {
                                        let index1: number | undefined = $effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let index2: number | undefined = $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let temp                       = $effectsUsedForFiltering[effectIndex + 1]                                                ;
                                        $effectsUsedForFiltering[effectIndex + 1] =
                                        $effectsUsedForFiltering[effectIndex    ] ;
                                        $effectsUsedForFiltering[effectIndex    ] =
                                            temp                                  ;
                                        if ($effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                                        }
                                        if ($effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                                        }
                                        $effectsUsedForFiltering =
                                        $effectsUsedForFiltering ;
                                    };
                                    editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => {
                                        let index1: number | undefined = $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let index2: number | undefined = $effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement?.selectedIndex;
                                        let temp                       = $effectsUsedForFiltering[effectIndex    ]                                                ;
                                        $effectsUsedForFiltering[effectIndex    ] =
                                        $effectsUsedForFiltering[effectIndex + 1] ;
                                        $effectsUsedForFiltering[effectIndex + 1] =
                                            temp                                  ;
                                        if ($effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex + 1].fragmentShader_HTMLSelectElement!.selectedIndex = index2 as number;
                                        }
                                        if ($effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement) {
                                            $effectsUsedForFiltering[effectIndex    ].fragmentShader_HTMLSelectElement!.selectedIndex = index1 as number;
                                        }
                                        $effectsUsedForFiltering =
                                        $effectsUsedForFiltering ;
                                    };



        //                          editorSnapshotsUndoStack.push(editorSnapshot);
                                    editorSnapshotsUndoStack.push(editorSnapshot);
        //                          editorSnapshotsUndoStack.push(editorSnapshot);
                                }}>
                                <!--<i class="fa-solid fa-chevron-down"></i>-->
                                    <i class="fa-solid fa-chevron-down"></i>
                                <!--<i class="fa-solid fa-chevron-down"></i>-->                        
                                </button>
                            {/if}
                        </div>
                    </div>
                <!--<hr class="large white" style:height="3px" style:box-shadow="0 0 3px">-->
                    <hr class="large white" style:height="3px" style:box-shadow="0 0 3px">
                <!--<hr class="large white" style:height="3px" style:box-shadow="0 0 3px">-->
                    {/each}
                </div>
            </div>
            <div     class="canvasContainer                ">
                <div class="canvasToolBoxes   small-padding">
                    <!--Dành cho canvas đang render video-->
                    <!--Dành cho canvas đang render video-->
                <!--<div     class="row   ">-->
                    <div     class="row   ">
                <!--<div     class="row   ">-->
                        {#if mode === MODE.VIDEO}
                        <div class="column">
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                            <button class="slow-ripple circle large-elevate" on:click={async (e) => {
                                    video?.time(video?.time() - 10);
//                                  video?.time(video?.time() - 10);
                            }}>
                            <!--<i  class="fas fa-backward"></i>-->
                                <i  class="fas fa-backward"></i>
                            <!--<i  class="fas fa-backward"></i>-->
                            </button>
                            <button class="slow-ripple circle large-elevate" on:click={async (e) => { if (!videoIsPlaying) { video?.play(); } else { video?.pause(); }
                                                                                                           videoIsPlaying =
                                                                                                          !videoIsPlaying ;
                            }}>
                                {#if videoIsPlaying}
                                <!--<i class="fas fa-pause"></i>-->
                                    <i class="fas fa-pause"></i>
                                <!--<i class="fas fa-pause"></i>-->
                                {:else}
                                <!--<i class="fas fa-play "></i>-->
                                    <i class="fas fa-play "></i>
                                <!--<i class="fas fa-play "></i>-->
                                {/if}
                            </button>
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                            <button class="slow-ripple circle large-elevate" on:click={async (e) => {
                                    video?.time(video?.time() + 10);
//                                  video?.time(video?.time() + 10);
                            }}>
                            <!--<i  class="fas fa-forward "></i>-->
                                <i  class="fas fa-forward "></i>
                            <!--<i  class="fas fa-forward "></i>-->
                            </button>
                            <progress value="0" max="100" class="light-green-text" bind:this={videoProgressSlider_}></progress>
                        </div>
                        
                        <nav   class="no-space">
                        <!--<i class="fas fa-volume-off padding-tiny"></i>-->
                            <i class="fas fa-volume-off padding-tiny"></i>
                        <!--<i class="fas fa-volume-off padding-tiny"></i>-->
                            <label                     class="slider
                                                              medium       ">
                                <input type="range"    value="1.0" min="0.0"
                                                                   max="1.0"
                                       step="0.010" on:input={async (e) => {
                                                       video?.volume(e.currentTarget.valueAsNumber);
//                                                     video?.volume(e.currentTarget.valueAsNumber);
                                }}>
                            <!--<span class="       "></span>-->
                                <span class="       "></span>
                            <!--<span class="       "></span>-->
                            <!--<div  class="tooltip"></div >-->
                                <div  class="tooltip"></div >
                            <!--<div  class="tooltip"></div >-->
                            </label>
                        <!--<i class="fas fa-volume-high padding-tiny"></i>-->
                            <i class="fas fa-volume-high padding-tiny"></i>
                        <!--<i class="fas fa-volume-high padding-tiny"></i>-->
                        </nav>
                        {/if}
                    </div>
                    <!--Dành cho canvas đang render video-->
                    <!--Dành cho canvas đang render video-->
                    <div>
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <button class="slow-ripple circle extend large-elevate margin grey10 white-text" on:click={async (e) => { await onUndoActionExecuted(); }}><i class="fas fa-arrow-rotate-left "></i><span>Undo</span></button>
                    <!--<button class="slow-ripple circle extend large-elevate margin grey10 white-text" on:click={async (e) => { await onUndoActionExecuted(); }}><i class="fas fa-arrow-rotate-left "></i><span>Undo</span></button>
                    -->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <button class="slow-ripple circle extend large-elevate margin grey10 white-text" on:click={async (e) => { await onRedoActionExecuted(); }}><i class="fas fa-arrow-rotate-right"></i><span>Redo</span></button>
                    <!--<button class="slow-ripple circle extend large-elevate margin grey10 white-text" on:click={async (e) => { await onRedoActionExecuted(); }}><i class="fas fa-arrow-rotate-right"></i><span>Redo</span></button>-->
                    </div>
                </div>
                <div class="canvas  ">
                    <div bind:this={canvas} on:change={async (e) => { console.log("change"); }}></div>
                <!--<div bind:this={canvas} on:change={async (e) => { console.log("change"); }}></div>-->
                </div>
            </div>
            
        </div>
    <!--<div class="footerContainer  "></div>-->
    <!--<div class="footerContainer  "></div>-->
    </div>
<!--<div><button class="slow-ripple large-elevate" on:click={async (e) => { const res = await promptShader(); console.log(await res.text()); }}>AI</button></div>-->
<!--<div><button class="slow-ripple large-elevate" on:click={async (e) => { const res = await promptShader(); console.log(await res.text()); }}>AI</button></div>-->
    <SnackbarSuccess></SnackbarSuccess>
    <SnackbarFailure></SnackbarFailure>
</main>

<style>

    i      { text-shadow: 0 0 3px; }
    h6     { text-shadow: 0 0 3px; }
    span   { text-shadow: 0 0 3px; }
    label  { text-shadow: 0 0 3px; }
    select { text-shadow: 0 0 3px; }
    
    main { overflow-x: visible; overflow-y: hidden; scroll-behavior: smooth; }
    *    {                                          scroll-behavior: smooth; }
    @font-face {
     font-family:            'SF Mono Regular'                                       ;
     font-weight: normal;
     font-style : normal;
     src: url('./assets/fonts/SF-Mono-Regular.otf') format('opentype')               ;
    }

    *    {
     font-family:            'SF Mono Regular'                        , 'fontawesome';
    }
    .container        { width: 100vw; height: 100vh; position: relative; display: flex; flex-direction: column;                                                                                        }
/*  .container        { width: 100vw; height: 100vh; position: relative; display: flex; flex-direction: column;                                                                                        }  */
/*  .headerContainer  { width: 100% ;                                                                                                                                                                  }  */
/*  .headerContainer  { width: 100% ;                                                                                                                                                                  }  */
/*  .footerContainer  { width: 100% ;                                                                                                                                                                  }  */
/*  .footerContainer  { width: 100% ;                                                                                                                                                                  }  */
    .topBarContainer  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between;                                                        }
/*  .topBarContainer  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between;                                                        }  */
    .mainBarContainer { width: 100% ; height: 100% ;                     display: flex; flex-direction: row   ;                                                                                        }
/*  .mainBarContainer { width: 100% ; height: 100% ;                     display: flex; flex-direction: row   ;                                                                                        }  */
    .sideBarContainer { width: 030% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }
/*  .sideBarContainer { width: 030% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }  */
    .canvasContainer  { width: 070% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }
/*  .canvasContainer  { width: 070% ; height: 100% ;                     display: flex; flex-direction: column;                                                                                        }  */
    .canvasToolBoxes  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between; align-items: center;                                   }
/*  .canvasToolBoxes  { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: space-between; align-items: center;                                   }  */
    .canvas           { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: center       ; align-items: center; overflow  : scroll; flex-grow: 1; }
/*  .canvas           { width: 100% ;                                    display: flex; flex-direction: row   ; justify-content: center       ; align-items: center; overflow  : scroll; flex-grow: 1; }  */
    .dialog           { width: 050% ;                                                                                                                                                                  }
/*  .dialog           { width: 050% ;                                                                                                                                                                  }  */
    .effectContainer  {               height: 100% ;                                                                                                                 overflow-y: scroll;               }
/*  .effectContainer  {               height: 100% ;                                                                                                                 overflow-y: scroll;               }  */
    .dialogSide       { width: 030% ;                                                                                                                                                                  }
/*  .dialogSide       { width: 030% ;                                                                                                                                                                  }  */
    .toolTip          { width: 200px;                                                                                                                                                                  }
/*  .toolTip          { width: 200px;                                                                                                                                                                  }  */

.switch > input:checked + span:after { border: none; background-color: #222222           ;                          box-shadow: 0 0 10px #222222;                               }
.switch >                 span:after {                   border-color: #222222 !important; background: #ffffff22; box-shadow: 0 0 10px #222222; border-width: 3px !important; }

</style>



























