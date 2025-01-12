<!-- svelte-ignore a11y-label-has-associated-control -->
<!-- svelte-ignore a11y-label-has-associated-control -->
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
        let imageRatio    = 1.0                       ;
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
          shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
//        shader.setUniform("mousePosition", [ 0.0, 0.0, 0.0, 0.0 ]);
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
onMount(    async () => {
    for(let shaderPath of Shaders.values()) {
        if (shaderPath
                .includes("./lib/")) {
            await import (`./lib/${shaderPath
                .replace ("./lib/"   , "")
                .replace (".glsl?raw", "")
                          }.glsl?raw`);
        }
        else
        if (shaderPath
                .includes("./shadertoys/")) {
            await import (`./shadertoys/${shaderPath
                .replace ("./shadertoys/", "")
                .replace (".glsl?raw"    , "")
                          }.glsl?raw`);
        }
        else
        if (shaderPath
                .includes("./lygia/")) {
            await import (`./lygia/${shaderPath
                .replace ("./lygia/" , "")
                .replace (".glsl?raw", "")
                          }.glsl?raw`);
        }
    }
});

const  loadAsset = async       (assetPath: string): Promise<string> => {
    const  asset = await import(assetPath        );
    return asset.default;
}



import        GLSLUniform          from "./GLSLUniform.svelte";
import      { MODE               } from "./types";
import      { MODE_CAPTURE_IMAGE } from "./types";
import      { MODE_CAPTURE_VIDEO } from "./types";
import type { GLSLUniformValue   } from "./types";
import type { GLSLUniforms       } from "./types";
import type { GLSLUniform_       } from "./types";
import        GlslUniform          from "./GLSLUniform.svelte";



const handleUpdate = (updatedUniforms: GLSLUniforms): void => {
};

let videoIsPlaying: boolean = false ;
let imageIsPlaying: boolean = false ;
let AIInputPrompts: HTMLInputElement;

</script>

<main    class="responsive">
    <div class="space     "></div>
    <form action="">
        <input bind:this={input} on:change={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" />
<!--    <input bind:this={input} on:change={onChange} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" />    -->
        <button class="slow-ripple">LOAD IMAGE OR VIDEO</button>
    </form>
    <div class="space"></div>
    <div bind:this={canvas} on:change={async (e) => { console.log("change"); }}></div>
<!--<div bind:this={canvas} on:change={async (e) => { console.log("change"); }}></div>
  -->
    <div class="space"></div>
    <div>
        <button class="slow-ripple" on:click={async (e) => { await startCaptureAsImage        (); }}>START SAVE AS IMAGE         </button>
    </div>
    <div class="space"></div>
    <div>
        <button class="slow-ripple" on:click={async (e) => { await startCaptureAsVideoSnapshot(); }}>START SAVE AS VIDEO SNAPSHOT</button>
        <button class="slow-ripple" on:click={async (e) => { await ceaseCaptureAsVideoSnapshot(); }}>CEASE SAVE AS VIDEO SNAPSHOT</button>    
    </div>
    <div class="space"></div>
    <div>
        <button class="slow-ripple" on:click={async (e) => { await startCaptureAsVideoFullshot(); }}>START SAVE AS VIDEO FULLSHOT</button>
        <button class="slow-ripple" on:click={async (e) => { await ceaseCaptureAsVideoFullshot(); }}>CEASE SAVE AS VIDEO FULLSHOT</button>    
    </div>
    <div class="space"></div>
    <div>
        <button class="slow-ripple" on:click={startWebCam}>START WEB CAM</button>
        <button class="slow-ripple" on:click={ceaseWebCam}>STOP@ WEB CAM</button>    
    </div>
    <div class="space"></div>
    <div>
        <button class="slow-ripple" on:click={async (e) => {
            $effectsUsedForFiltering = [ ...
            $effectsUsedForFiltering , { fragmentShaderSourceType________: "NI"
                                     ,   fragmentShaderSourceCode________: null
                                     ,   fragmentShader______GLSLUniforms: null
                                     ,   fragmentShaderFiltering_Instance: null
                                     , }
                                       ];
        }}>ADD EFFECT NI</button>
        <button class="slow-ripple" on:click={async (e) => {
            $effectsUsedForFiltering = [ ...
            $effectsUsedForFiltering , { fragmentShaderSourceType________: "AI"
                                     ,   fragmentShaderSourceCode________: null
                                     ,   fragmentShader______GLSLUniforms: null
                                     ,   fragmentShaderFiltering_Instance: null
                                     , }
                                       ];
        }}>ADD EFFECT AI</button>
    </div>
    <div class="space"></div>

    <div>
        <button class="slow-ripple extend square" on:click={async (e) => {
            if (!videoIsPlaying) {
                 video?.play();
            } else               {
                 video?.pause();
            }
            videoIsPlaying = !videoIsPlaying;
        }}>
            {#if videoIsPlaying}
            <i class="fa-solid fa-pause"></i>
                <span>Pause</span>
            {:else}
            <i class="fa-solid fa-play"></i>
                <span>Play</span>
                
            {/if}
        </button>
        <!-- svelte-ignore a11y_consider_explicit_label -->
        <button class="slow-ripple extend  square" on:click={async (e) => {
            video?.time(video?.time() - 10);
        }}>
            <i class="fa-solid fa-backward"></i>
            <span>Backward</span>
        </button>
        <!-- svelte-ignore a11y_consider_explicit_label -->
        <button class="slow-ripple extend  square" on:click={async (e) => {
            video?.time(video?.time() + 10);
        }}>
            <i class="fa-solid fa-forward"></i>
            <span>Forward</span>
        </button>
        <nav class="no-space">
            <i class="fa-solid fa-volume-high padding-tiny"></i>
            <label class="slider medium">
              <input type="range" value="1.0" min="0.0" max="1.0" step="0.01" on:input={async (e) => {
                video?.volume(e.currentTarget.valueAsNumber);
              }}>
              <span></span>
              <div class="tooltip"></div>
            </label>
            
          </nav>
        <progress value="0" max="100" class="light-green-text" bind:this={videoProgressSlider_}></progress>
    </div>


    <div class="field label suffix round border">
        <select bind:this={imageFormatSelection}>
          {#each imageFormats as imageFormat (imageFormat)}
            <option>{imageFormat.extension}</option>
          {/each}
        </select>
        <label>Image Format</label>
        <i class="fa-solid fa-chevron-down"></i>
    </div>

    <div class="field label suffix round border">
        <select bind:this={videoFormatSelection}>
          {#each videoFormats as videoFormat (videoFormat)}
            <option>{videoFormat.mimeType}</option>            
          {/each}
        </select>
        <label>Video Format</label>
        <i class="fa-solid fa-chevron-down"></i>
    </div>


    <div>
        <button on:click={async() => {
        const   res = await promptShader();
        console.log(  await res.text()   );
        }}>AI</button>
        <button on:click={async () => { await shareImage (              canvas.children[0] as HTMLCanvasElement); }} disabled={mode !== MODE.IMAGE }>SHARE IMAGE </button>
        <button on:click={async () => { await shareVideo (videoToShare, canvas.children[0] as HTMLCanvasElement); }} disabled={mode !== MODE.VIDEO }>SHARE VIDEO </button>
        <button on:click={async () => { await shareWebcam(videoToShare, canvas.children[0] as HTMLCanvasElement); }} disabled={mode !== MODE.WEBCAM}>SHARE WEBCAM</button>
    </div>
    <div class="space"></div>

    {#each $effectsUsedForFiltering as {
           fragmentShaderSourceType________
     ,     fragmentShaderSourceCode________
     ,     fragmentShader______GLSLUniforms
     ,     fragmentShaderFiltering_Instance
     ,
                                       }
    }
    {#if fragmentShaderSourceType________ ===  "NI"}
    <div class="field label suffix round border">
        <select on:change={async(e) => {
            let shaderName  =    e.currentTarget.options      [
                                 e.currentTarget.selectedIndex].value;
            if (shaderName ===            "none")             {
                console.log(`Shader name:   ${shaderName}          `);
                fragmentShaderSourceCode________ = null;
                fragmentShader______GLSLUniforms = null;
                fragmentShaderFiltering_Instance = null;
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
            }
        }}>
        {#each [ "none" , ... [ ... Shaders.keys() ].sort() ] as shaderName
                                                                (shaderName)
        }
                                                        <option>{shaderName}</option>            
        {/each}
        </select>
        <label>Choose your effects</label>
<!--    <label>Choose your effects</label>       -->
        <i class="fa-solid fa-chevron-down"></i>
<!--    <i class="fa-solid fa-chevron-down"></i> -->
    </div>
    
    <GlslUniform uniforms={fragmentShader______GLSLUniforms ?? []} onUpdate={handleUpdate} canvasInstance={
                                                                                           canvasInstance }></GlslUniform>
    {/if}
    {#if fragmentShaderSourceType________ ===  "AI"}
    <div class="field border">
        <input type="text" bind:this={AIInputPrompts}>
    </div>
    <button class="slow-ripple" on:click={async (e)=>{
        fragmentShaderSourceCode________=(await (await promptShader(AIInputPrompts.value.split(";"))).text()).split("\n").slice(+1 , -1).join("\n");
        console.log(fragmentShaderSourceCode________);
        fragmentShader______GLSLUniforms = parseGLSL(fragmentShaderSourceCode________);
        console.log(fragmentShader______GLSLUniforms);
        fragmentShaderFiltering_Instance = (canvasInstance as any).createFilterShader(fragmentShaderSourceCode________);
    }}>ASK AI</button>
    <GlslUniform uniforms={fragmentShader______GLSLUniforms ?? []} onUpdate={handleUpdate} canvasInstance={
                                                                                           canvasInstance }></GlslUniform>
    
    {/if}
    {/each}
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
</style>


