
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

    const p5Logic = (p: p5) => {
          p.setup = (     ) => {
            p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: false, perPixelLighting: true, });
//          p.setAttributes({ antialias: false, alpha: false, depth: false, stencil: false, premultipliedAlpha: false, preserveDrawingBuffer: false, perPixelLighting: true, });
            p.createCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
                           Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
                              p.WEBGL);
            p.background(  255   );
            p.imageMode (p.CENTER);
            p.frameRate (  fps   );
            p.disableFriendlyErrors = true;
//          p.disableFriendlyErrors = true;

        };

        p.draw = () => {
        p.background( 255 );
            
        };
    };

    let canvas        : HTMLElement;
    let canvasInstance: p5         ;
    let bufferInstance: p5.Graphics;
    
    onMount(async ()  : Promise<void> => {
    
        canvasInstance = new p5(p5Logic, canvas);
//      bufferInstance =
//      canvasInstance.createGraphics(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH_ * DPR),
//                                    Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR),
//      canvasInstance.WEBGL,        );
            await ui("theme", "#009688");
            await ui("theme", "#009688");
    });

    const successCallback = (image_Instance: p5.Image): void => {
        if (video) {
            video.remove();
        }
        let imageRatio    = 0.3                       ;
        canvasInstance.resizeCanvas(image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
        image_Instance.resize      (image_Instance.width * imageRatio * DPR, image_Instance.height * imageRatio * DPR);
        canvasInstance.  draw = () => {
//------------------------------//
            canvasInstance.textureWrap("repeat");
            canvasInstance.
            image                   (
            image_Instance, 0.0, 0.0)           ;


            for (let { fragmentShaderSourceCode________,
                       fragmentShader______GLSLUniforms,
                       fragmentShaderFiltering_Instance, } of $effectsUsedForFiltering) {
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

            for (let { fragmentShaderSourceCode________,
                       fragmentShader______GLSLUniforms,
                       fragmentShaderFiltering_Instance, } of $effectsUsedForFiltering) {
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
                };
//------------------------------//
            };
            mode = MODE.VIDEO;
            mode = MODE.VIDEO;
        };
    };


    let input: HTMLInputElement;
//  let input: HTMLInputElement;
    const onChange = () => {
        const reader = new FileReader();
              reader.addEventListener("load", () => {
                    if (               typeof    reader.result === "string"               ) {
                        canvasInstance.loadImage(reader.result
                                      ,                       successCallback
                                      ,                       failureCallback
                                      ,         );
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
            for (let { fragmentShaderSourceCode________,
                       fragmentShader______GLSLUniforms,
                       fragmentShaderFiltering_Instance, } of $effectsUsedForFiltering) {
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
import { texturesNoise              } from "./global";
import { texturesBayer              } from "./global";
import { texturesPalette            } from "./global";
import { texturesPencil_            } from "./global";
import { texturesASCII              } from "./global";
import { texturesTiled              } from "./global";
import { texturesShaderToy          } from "./global";
import { effectsUsedForFiltering    } from "./global";
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



const handleUpdate = (updatedUniforms: GLSLUniforms): void => {
};

let videoIsPlaying: boolean = false ;
let imageIsPlaying: boolean = false ;
let AIInputPrompts: HTMLInputElement;
let cachedSelectedIndex:
    number                  =   0   ;

    import MouseCursor from "./MouseCursor.svelte";
//  import MouseCursor from "./MouseCursor.svelte";
</script>

<MouseCursor> </MouseCursor>
<main>
    <div class="container">
        <div class="headerContainer grey-border border">
            
        </div>
        <div class="topBarContainer small-padding grey-border border">
            <div class="row">
                <button class="slow-ripple">
                    <i class="fas fa-paperclip"></i>
                    <span>Load Image Or Video</span>
                    <input bind:this={input} on:change={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" />
                </button>
                <div class="field middle-align">
                    <nav>
                        <div class="max">
                            <span>Webcam</span>
                        </div>
                        <label class="switch icon">
                            <input type="checkbox" on:change={(event) => {
                                const input =event.target as HTMLInputElement;
                                const button = document.createElement("button"); 
                                button.type = "button";
                                const fakeEvent = new MouseEvent("click", {
                                    bubbles: true,
                                    cancelable: true,
                                }) as MouseEvent & { currentTarget: EventTarget & HTMLButtonElement };

                                //fakeEvent.currentTarget = button;
                                if (input.checked){
                                    startWebCam(fakeEvent);
                                }
                                else{
                                    ceaseWebCam(fakeEvent);
                                }
                            }}>
                            <span>
                                <i>Videocam_Off</i>
                                <i>Videocam</i>
                            </span>
                        </label>
                    </nav>
                  </div>
                
            </div>
            
            <button class="slow-ripple" on:click={startWebCam}>START WEB CAM</button><!--Giống START SAVE AS VIDEO SNAPSHOT nhưng dành riêng cho sử dụng webcam-->
            <button class="slow-ripple" on:click={ceaseWebCam}>STOP@ WEB CAM</button><!--Giống CEASE SAVE AS VIDEO SNAPSHOT nhưng dành riêng cho sử dụng webcam-->
            <div class="column">
                <button data-ui="#a">
                    <i class="fas fa-download"></i>
                    <span>Save</span>
                </button>
                <dialog class="left" id="a">
                    <div class="field label suffix round border">
                        <select bind:this={imageFormatSelection}>
                            {#each         imageFormats as
                                           imageFormat
                                          (imageFormat)
                            }
                                  <option>{imageFormat.extension}</option>
                            {/each}
                        </select>
                <!-- svelte-ignore a11y-label-has-associated-control -->
                <!-- svelte-ignore a11y-label-has-associated-control -->
                        <label>Image Format</label>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                
                    <div class="field label suffix round border">
                        <select bind:this={videoFormatSelection}>
                            {#each         videoFormats as
                                           videoFormat
                                          (videoFormat)
                            }
                                  <option>{videoFormat.mimeType }</option>
                            {/each}
                        </select>
                <!-- svelte-ignore a11y-label-has-associated-control -->
                <!-- svelte-ignore a11y-label-has-associated-control -->
                        <label>Video Format</label>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div>
                        <button class="slow-ripple" on:click={async (e) => { await startCaptureAsImage        (); }}>START SAVE AS IMAGE         </button><!--Đang render image/video trên canvas -> capture frame hình hiện tại-->
                    </div>
                    <div class="space"></div>
                    <div>
                        <button class="slow-ripple" on:click={async (e) => { await startCaptureAsVideoSnapshot(); }}>START SAVE AS VIDEO SNAPSHOT</button><!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc bắt đầu click button này thành 1 video (cần phải click button cạnh bên để ngừng)-->
                        <button class="slow-ripple" on:click={async (e) => { await ceaseCaptureAsVideoSnapshot(); }}>CEASE SAVE AS VIDEO SNAPSHOT</button><!--Đang render image/video trên canvas -> kết thúc capture các frame hình                                    thành 1 video (                                       )-->
                    </div>
                    <div class="space"></div>
                    <div>
                        <button class="slow-ripple" on:click={async (e) => { await startCaptureAsVideoFullshot(); }}>START SAVE AS VIDEO FULLSHOT</button><!--Đang render image/video trên canvas -> bắt @đầu capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (không cần phải click button cạnh bên để ngừng - sẽ được tự động ngừng trong trường hợp canvas đang render video & cần phải click button cạnh bên để ngừng - trong trường hợp canvas đang render image)-->
                        <button class="slow-ripple" on:click={async (e) => { await ceaseCaptureAsVideoFullshot(); }}>CEASE SAVE AS VIDEO FULLSHOT</button><!--Đang render image/video trên canvas -> kết thúc capture các frame hình kể từ lúc ban đầu (giây thứ 0) của image/video thành 1 video (                                                                                                                                                                                                     )-->
                    </div>
                </dialog>
                <button
                    on:click = {async() => {
                        if (mode === MODE.IMAGE){
                            await shareImage (              canvas.children[0] as HTMLCanvasElement);
                        }
                        else if (mode === MODE.VIDEO) {
                            await shareVideo (videoToShare, canvas.children[0] as HTMLCanvasElement);
                        }
                        else {
                            await shareWebcam(videoToShare, canvas.children[0] as HTMLCanvasElement);
                        }
                    }}>
                    <i class="fas fa-share"></i>
                    <span>Share</span>
                </button>
            </div>
        </div>
        <div class="mainContainer grey-border border">
            <div class="sideBarContainer grey-border border">
                <div class="small-padding center-align">
                    <button class="slow-ripple" 
                        on:click={async (e) => {
                            $effectsUsedForFiltering = [ ...
                            $effectsUsedForFiltering , { fragmentShaderSourceType________: "NI"
                                                    ,   fragmentShaderSourceCode________: null
                                                    ,   fragmentShader______GLSLUniforms: null
                                                    ,   fragmentShaderFiltering_Instance: null
                                                    ,   fragmentShader_HTMLSelectElement: null
                                                    , }
                                                    ];
                            editorSnapshotsUndoStack.push({
                                undo: async (dynamicStorage: Map<string, any> | null) => {
                            $effectsUsedForFiltering.pop();
                            $effectsUsedForFiltering = $effectsUsedForFiltering;
                            console.log("call");
                                }
                                ,
                                redo: async (dynamicStorage: Map<string, any> | null) => {
                            $effectsUsedForFiltering = [ ...
                            $effectsUsedForFiltering , { fragmentShaderSourceType________: "NI"
                                                    ,   fragmentShaderSourceCode________: null
                                                    ,   fragmentShader______GLSLUniforms: null
                                                    ,   fragmentShaderFiltering_Instance: null
                                                    ,   fragmentShader_HTMLSelectElement: null
                                                    , }
                                                    ];
                                }
                                ,
                                dynamicStorage: null
                                ,
                            });
                        }}>
                        <i class="fas fa-plus"></i>
                        <span>Add Effect NI</span>
                    </button><!--Thêm effect @có sẵn @@-->
                    <button class="slow-ripple" 
                        on:click={async (e) => {
                            $effectsUsedForFiltering = [ ...
                            $effectsUsedForFiltering , { fragmentShaderSourceType________: "AI"
                                                    ,   fragmentShaderSourceCode________: null
                                                    ,   fragmentShader______GLSLUniforms: null
                                                    ,   fragmentShaderFiltering_Instance: null
                                                    ,   fragmentShader_HTMLSelectElement: null
                                                    , }
                                                    ];
                            editorSnapshotsUndoStack.push({
                                undo: async (dynamicStorage: Map<string, any> | null) => {
                            $effectsUsedForFiltering.pop();
                            $effectsUsedForFiltering = $effectsUsedForFiltering;
                            console.log("call");
                                }
                                ,
                                redo: async (dynamicStorage: Map<string, any> | null) => {
                            $effectsUsedForFiltering = [ ...
                            $effectsUsedForFiltering , { fragmentShaderSourceType________: "AI"
                                                    ,   fragmentShaderSourceCode________: null
                                                    ,   fragmentShader______GLSLUniforms: null
                                                    ,   fragmentShaderFiltering_Instance: null
                                                    ,   fragmentShader_HTMLSelectElement: null
                                                    , }
                                                    ];
                                }
                                ,
                                dynamicStorage: null
                                ,
                            });
                        }}>
                        <i class="fas fa-plus"></i>
                        <span>Add Effect AI</span>
                    </button><!--Thêm effect gen bởi AI-->
                </div>
                <div class="small-padding effectContainer">
                    {#each $effectsUsedForFiltering as {
                           fragmentShaderSourceType________
                     ,     fragmentShaderSourceCode________
                     ,     fragmentShader______GLSLUniforms
                     ,     fragmentShaderFiltering_Instance
                     ,     fragmentShader_HTMLSelectElement
                     ,
                                                       }
                     ,      effectIndex
                    }
                        {#if fragmentShaderSourceType________ ===  "NI"}
                            <div class="row">
                                <div class="field label suffix round border max ">
                                    <select
                                        bind:this={fragmentShader_HTMLSelectElement}
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
                                        let shaderName  =    e.currentTarget.options      [
                                                            e.currentTarget.selectedIndex].value;
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
                                            fragmentShader______GLSLUniforms = parseGLSL(fragmentShaderSourceCode________);
                                            console.log(fragmentShader______GLSLUniforms);
                                            fragmentShaderFiltering_Instance = (canvasInstance as any).createFilterShader(fragmentShaderSourceCode________);
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
                            <!--    <label>Choose your effects</label>       -->
                                    <i class="fas fa-chevron-down"></i>
                            <!--    <i class="fas fa-chevron-down"></i> -->
                                </div>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple circle" data-ui={`#b${effectIndex}`}>
                                    <i class="fas fa-pen"></i>
                                </button>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple circle" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); }}>
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                            <dialog id={`b${String(effectIndex)}`}>
                                <GlslUniform uniforms={fragmentShader______GLSLUniforms ?? []} onUpdate={handleUpdate} canvasInstance={
                                                                                                                    canvasInstance }></GlslUniform>
                            </dialog>
                        {/if}
                        {#if fragmentShaderSourceType________ ===  "AI"}
                            <div class="row">
                                <div class="max medium-padding">
                                    <span>Effect {effectIndex} by AI</span>
                                </div>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple circle" data-ui={`#c${effectIndex}`}>
                                    <i class="fas fa-pen"></i>
                                </button>
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <button class="slow-ripple circle" on:click={async (e) => { $effectsUsedForFiltering = $effectsUsedForFiltering.filter((otherEffect, otherEffectIndex) => otherEffectIndex !== effectIndex); }}>
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                            <dialog class="dialog" id={`c${effectIndex}`}>
                                <div class="row">
                                    <div class="field border round label max">
                                        <input type="text" bind:this={AIInputPrompts}>
                                        <!-- svelte-ignore a11y_label_has_associated_control -->
                                        <label>Ask me for a new effect</label>
                                    </div>
                                    <!-- svelte-ignore a11y_consider_explicit_label -->
                                    <button class="slow-ripple circle" on:click={async (e)=>{
                                        fragmentShaderSourceCode________=(await (await promptShader(AIInputPrompts.value.split(";"))).text()).split("\n").slice(+1 , -1).join("\n");
                                        console.log(fragmentShaderSourceCode________);
                                        fragmentShader______GLSLUniforms = parseGLSL(fragmentShaderSourceCode________);
                                        console.log(fragmentShader______GLSLUniforms);
                                        fragmentShaderFiltering_Instance = (canvasInstance as any).createFilterShader(fragmentShaderSourceCode________);
                                    }}>
                                        <i class="fas fa-paper-plane"></i>
                                    </button>
                                </div>
                                <GlslUniform uniforms={fragmentShader______GLSLUniforms ?? []} onUpdate={handleUpdate} canvasInstance={
                                                                                                                    canvasInstance }></GlslUniform>
                            </dialog>
                        {/if}
                    {/each}
                </div>
            </div>
            <div class="canvasContainer grey-border border">
                <div class="canvasTool grey-border border small-padding">
                    <!--Dành cho canvas đang render video-->
                    <div class="row">
                        {#if mode === MODE.VIDEO}
                        <div class="column">
                            <button class="slow-ripple circle" on:click={async (e) => { if (!videoIsPlaying) { video?.play(); } else { video?.pause(); }
                                                                                                videoIsPlaying =
                                                                                            !videoIsPlaying ;
                            }}>
                                {#if videoIsPlaying}
                                    <i class="fas fa-pause"></i>
                                {:else} 
                                    <i class="fas fa-play "></i>
                                {/if}
                            </button>
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                            <button class="slow-ripple circle" on:click={async (e) => {
                                    video?.time(video?.time() - 10);
                    //              video?.time(video?.time() - 10);
                            }}>
                                <i  class="fas fa-backward"></i>
                            </button>
                            <!-- svelte-ignore a11y_consider_explicit_label -->
                            <button class="slow-ripple circle" on:click={async (e) => {
                                    video?.time(video?.time() + 10);
                    //              video?.time(video?.time() + 10);
                            }}>
                                <i  class="fas fa-forward "></i>
                            </button>
                            <progress value="0" max="100" class="light-green-text" bind:this={videoProgressSlider_}></progress>
                        </div>
                        
                        <nav   class="no-space                            ">
                            <i class="fas fa-volume-off padding-tiny"></i>
                            <label                class="slider
                                                        medium           ">
                                <input type="range" value="1.0" min="0.0"
                                                                max="1.0"
                                        step="0.010" on:input={async (e) => {
                                                        video?.volume(e.currentTarget.valueAsNumber);
                    //                                   video?.volume(e.currentTarget.valueAsNumber);
                                }}>
                                <span class="       "></span>
                                <div  class="tooltip"></div >
                            </label>
                            <i class="fas fa-volume-high padding-tiny"></i>
                        </nav>
                        {/if}
                    </div>
                    <!--Dành cho canvas đang render video-->
                    <div>
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <button class="slow-ripple circle extend" on:click={async (e) => { await onUndoActionExecuted(); }}>
                            <i class="fas fa-arrow-rotate-left "></i>
                            <span>Undo</span>
                        </button>
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <button class="slow-ripple circle extend" on:click={async (e) => { await onRedoActionExecuted(); }}>
                            <i class="fas fa-arrow-rotate-right"></i>
                            <span>Redo</span>
                        </button>
                    </div>
                </div>
                <div class="canvas grey-border border">
                    <div bind:this={canvas} on:change={async (e) => { console.log("change"); }}></div>
                    <!--<div bind:this={canvas} on:change={async (e) => { console.log("change"); }}></div>-->
                </div>
            </div>
            
        </div>
        <div class="footerContainer grey-border border">
                
        </div>
    </div>
    <!-- <div>
        <button class="slow-ripple" on:click={async() => {
        const   res = await promptShader();
        console.log(  await res.text()   );
        }}>AI</button>
    </div> -->
</main>

<style>
    main { overflow-x: visible; scroll-behavior: smooth; }
    *    {                      scroll-behavior: smooth; }
    @font-face {
     font-family:            'SF Mono Regular'                                       ;
     font-weight: normal;
     font-style : normal;
     src: url('./assets/fonts/SF-Mono-Regular.otf') format('opentype')               ;
    }

    *    {
     font-family:            'SF Mono Regular'                        , 'fontawesome';
    }
    .container {
        width: 100vw;
        height: 100vh;
        position: relative;
        display: flex;
        flex-direction: column;
    }
    .headerContainer {
        width: 100%;
    }
    .footerContainer {
        width: 100%;
    }
    .topBarContainer {
        width: 100%;
        justify-content: space-between;
        display: flex;
        flex-direction: row;
    }
    .mainContainer {
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: row;
    }
    .sideBarContainer {
        width: 30%;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .canvasContainer {
        width: 70%;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .canvasTool {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
    }
    .canvas {
        width: 100%;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        overflow: scroll;
        flex-grow: 1;
    }
    .dialog {
        width: 70%;
    }
    .effectContainer{
        overflow-y: scroll;
        height: 100%;
    }
</style>



























