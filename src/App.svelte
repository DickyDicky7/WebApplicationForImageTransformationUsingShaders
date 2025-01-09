<!-- svelte-ignore a11y-label-has-associated-control -->

<script lang="ts">

import { promptShader } from "./a.i.effects";
    import          "beercss"       ;
    import "material-dynamic-colors";
import { shareImage } from "./common";
import { shareVideo } from "./common";
import { shareWebcam } from "./common";
import { parseGLSL } from "./common";
    import   p5        from "p5";
    import { onMount } from "svelte";

    


    const DEFAULT_CANVAS_SIZE = { WIDTH: 500, HEIGHT: 500 };
    const DPR = window.devicePixelRatio || 1;

    const p5Logic = (p: p5) => {
          p.setup = (     ) => {
            p.createCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH * DPR), Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR), p.WEBGL);
            p.background( 255 );
            p.imageMode(p.CENTER);
            p.frameRate(  fps   );
            
        };

        p.draw = () => {
            p.background( 255 );
            
        };
    };

    let canvas        : HTMLElement;
    let canvasInstance:          p5;
    
    onMount(async ()  : Promise<void> => {
    
        canvasInstance = new p5(p5Logic, canvas);
        await ui("theme", "#009688")
        
    });

    const successCallback = (imageD: p5.Image): void => {
        let imageRatio = 0.5;
        canvasInstance.resizeCanvas(imageD.width * imageRatio * DPR, imageD.height * imageRatio * DPR);
        imageD        .resize      (imageD.width * imageRatio * DPR, imageD.height * imageRatio * DPR);
        canvasInstance.draw  = () => {

            canvasInstance.textureWrap("repeat");
            let     filterShader = (canvasInstance as any)
         .createFilterShader                         (imageFragmentShaderSourceCode);
         shaderSetNecessaryUniforms(filterShader);

        if (currentGLSLUniforms) {
            for (let glslUniform of currentGLSLUniforms) {
                if (glslUniform.thisUniformType === "sampler2D") {
                    if (glslUniform.thisUniformSampler2DImg) {
                        filterShader.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
                    }
                } else {
                    filterShader.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
                }
            }
        }

        canvasInstance.       image(imageD, 0, 0);
        canvasInstance.filter(filterShader);
            
        };
        mode = MODE.IMAGE;
    };


    const failureCallback = (eventD:    Event): void => {
        if (canvas.children   .length === 2) {
//          canvas.children[1].remove();
        if (video) {video.remove();} // the same as the above line of code
        }
        if (input.files !== null) {
            if (videoFileBLOB !== null) { window.URL.revokeObjectURL(videoFileBLOB); }
                videoFileBLOB  =          window.URL.createObjectURL(             input.files[0]);
            video = canvasInstance.createVideo(videoFileBLOB);
            video .volume(1.0);
            video .hide  (   );
//          video .loop  (   );
            let warp = (canvasInstance as any).createFilterShader(videoFragmentShaderSourceCode);
            let startRecord: boolean = true ;
            let ceaseRecord: boolean = false;
            console.log("Assign");
            canvasInstance.resizeCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH * DPR), Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR));
            canvasInstance.draw = () => {
                canvasInstance.textureWrap("repeat");
                if (startRecord /*&& !isNaN(video.duration())*/) {
                    startRecord = false;
                    console.log("START");
                    let canvasElement = canvas.children[0]  as
                    HTMLCanvasElement;
                    let  videoElement = canvas.children[1]  as  HTMLVideoElement  ;
                    let  audioContext =                         new AudioContext();
                    let mediaStreamAudioDestinationNode: MediaStreamAudioDestinationNode = audioContext.createMediaStreamDestination();
                    let mediaStreamAudioDestination    : MediaStream                     =
                        mediaStreamAudioDestinationNode.stream;
                    let mediaElementAudioSourceNode:
                        MediaElementAudioSourceNode
                                                   =        audioContext.createMediaElementSource(videoElement);
                        mediaElementAudioSourceNode.connect(
                        mediaStreamAudioDestinationNode    );
                        mediaElementAudioSourceNode.connect(audioContext.destination                          );
                    downloadStream  = canvasElement.captureStream(fps);
                    downloadStream  . addTrack                         (
                        mediaStreamAudioDestination.getAudioTracks()[0]);
                    const recordedChunks: BlobPart[] = [];
                    const options = { mimeType: videoFormats                      [
                                                videoFormatSelection.selectedIndex]
                                    . mimeType
                                    };
                    mediaRecorder =                                                new MediaRecorder( downloadStream , options , );
                    mediaRecorder.     ondataavailable = (BLOBEvent: BlobEvent) => {
                          console.log("vidataavailable");
                        if (BLOBEvent.data.size > 0) {
                            recordedChunks.push(BLOBEvent.data);
                            //
                            const blob = new Blob(
                            recordedChunks,
                                {
                                    type: videoFormats[
                                          videoFormatSelection.selectedIndex].blobType,
                                },
                            );
                            const url =
                                URL.createObjectURL(blob);
                            const anchor:HTMLAnchorElement = document.createElement(
                                "a",
                            ) as HTMLAnchorElement;
                            document.body.appendChild(anchor);
                            // a.style = "display: none";
                            anchor.href = url;
                            anchor.download = `test_video_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
                            // anchor.download = `test_video_${new Date().toLocaleString()}.webm`;
                            anchor.click();
                            window.URL.revokeObjectURL(url);
                            videoToShare = blob;
                            anchor.remove();
                            //
                        }
                    };
                    mediaRecorder.start();
                    video.play();
                }
                
//              canvasInstance.background(255);
                canvasInstance.push();
                canvasInstance.imageMode(canvasInstance.CENTER);
                canvasInstance.image    (
                                video,
                    0,
                    0,
                    canvasInstance.width ,
                    canvasInstance.height,
                    0,
                    0,
                             video.width ,
                             video.height,
                    canvasInstance.COVER ,
                );
                canvasInstance.pop();
                let warp = (canvasInstance as any).createFilterShader(videoFragmentShaderSourceCode);
                shaderSetNecessaryUniforms(warp);

        if (currentGLSLUniforms) {
            for (let glslUniform of currentGLSLUniforms) {
                if (glslUniform.thisUniformType === "sampler2D") {
                    if (glslUniform.thisUniformSampler2DImg) {
                        warp.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformSampler2DImg);
                    }
                } else {
                    warp.setUniform(glslUniform.thisUniformName, glslUniform.thisUniformDefaultValue);
                }
            }
        }                

                canvasInstance.filter(warp);
                
                if (!ceaseRecord)                       {
                }
                if (!ceaseRecord
                &&  !isNaN           (video.duration())
                &&   video.time() === video.duration()) {
                     ceaseRecord = true;
                   console.log ( "STOP" );
                            video.stop();
                    mediaRecorder.stop();
                    mediaRecorder = null!;
                };
            };
            mode = MODE.VIDEO;
        };
    };


    let input: HTMLInputElement;
    const onChange = () => {
        const reader = new FileReader();
              reader.addEventListener("load", () => {
            if (                  typeof reader.result === "string") {
                canvasInstance.loadImage(reader.result  ,
                                        successCallback ,
                                        failureCallback);
                                        // console.log(reader.result)
            }
        });
        let file                  ;
        if (        input.files)
        {
            file  = input.files[0];
        }
        if (file != null) { reader.readAsDataURL(file); }
    };

    let fps: number = 120;
    let downloadStream      : MediaStream = null!;
    let downloadStreamWebCam: MediaStream = null!;
    let    videoStream: MediaStream = null!;
    let    audioStream: MediaStream = null!;
    let  mediaRecorder      : MediaRecorder = null!;
    let  mediaRecorderWebCam: MediaRecorder = null!;
    let  videoFileBLOB: string = null!;
    let  imageFileBLOB: string = null!;
    let video: p5.MediaElement = null!;
    let image: p5.MediaElement = null!;

    let imageFragmentShaderSourceCode: string = `
#version 100
    precision highp float;
   #include "lygia/color/vibrance.glsl"
        uniform sampler2D tex0;
        varying vec2 vTexCoord;
void main(){
    gl_FragColor = vibrance(texture2D(tex0, vTexCoord), 2.0);
}
    `;
    let videoFragmentShaderSourceCode: string = `

    `;
    /*
#version 100
    precision highp float;
   // #include "lygia/color/tonemap/aces.glsl"
        uniform sampler2D tex0;
        varying vec2 vTexCoord;
void main(){
    gl_FragColor = tonemapACES(texture2D(tex0, vTexCoord));
}
    */
// videoFragmentShaderSourceCode = resolveLygia(videoFragmentShaderSourceCode);
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
import {resolveLygiaAsync} from "./lygia"
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-ignore
import {resolveLygia} from "./lygia"
(async()=>{
    imageFragmentShaderSourceCode = await resolveLygiaAsync(imageFragmentShaderSourceCode)
})()

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

// DeepAR SDK
// DeepAR Beauty

    const shaderSetNecessaryUniforms = (shader: any) => {
        shader.setUniform("time"                     ,         canvasInstance.millis() / 1000                                                                                              );
        shader.setUniform(     "canvasSize"          , [       canvasInstance.width                                  ,        canvasInstance.height                                 ]);
        shader.setUniform(                "texelSize", [1.0 / (canvasInstance.width * canvasInstance.pixelDensity()) , 1.0 / (canvasInstance.height * canvasInstance.pixelDensity())]);
    shader.setUniform("mousePosition", [0.0,0.0,0.0,0.0])
    shader.setUniform("frameCount", canvasInstance.frameCount);

    }

        
    const startWebCam = async(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
        webcamCapture = canvasInstance.createCapture({
            video: {
             mandatory: {
                 minWidth: 500,
                 minHeight: 500
            },
            optional: [{ maxFrameRate: 120 }]
        },
            audio: true,
        });
        canvasInstance.resizeCanvas(DEFAULT_CANVAS_SIZE.WIDTH, DEFAULT_CANVAS_SIZE.HEIGHT);
        webcamCapture .size(canvasInstance.width, canvasInstance.height);
        webcamCapture .hide(                                           );

        let                    cve = canvas.children[0] as HTMLCanvasElement;
        downloadStreamWebCam = cve.captureStream(fps);
        const recordedChunks: BlobPart[] = [];
        const options = { mimeType: videoFormats[videoFormatSelection.selectedIndex].mimeType, };
        mediaRecorderWebCam = new MediaRecorder(downloadStreamWebCam, options);
        mediaRecorderWebCam.ondataavailable = async(BLOBEvent:BlobEvent): Promise<void> => {
            console.log("wcdataavailable");
            if (BLOBEvent.data.size > 0) {
                recordedChunks.push(BLOBEvent.data);
                const blob = new Blob(
                    recordedChunks,
                    {
                        type: videoFormats[videoFormatSelection.selectedIndex].blobType,
                    },
                );
                const url =URL.createObjectURL(blob);
                const anchor:HTMLAnchorElement = document.createElement("a") as HTMLAnchorElement;
                document.body.appendChild(anchor);
                anchor.href     =          url ;
                anchor.download = `test_webcam_${new Date().toLocaleString()}.${videoFormats[videoFormatSelection.selectedIndex].extension}`;
                anchor. click();
                window.URL.revokeObjectURL(url);
                anchor.remove();
            };
        };

        mediaRecorderWebCam.start();
        let filterShaderWebCam = (canvasInstance as any).createFilterShader(imageFragmentShaderSourceCode);


        canvasInstance.draw = () => {
        canvasInstance. image(            webcamCapture, 0, 0);
        shaderSetNecessaryUniforms(filterShaderWebCam);
        canvasInstance.filter(filterShaderWebCam             );
        };


        mode = MODE.WEBCAM;
    };

    const ceaseWebCam = (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
        mediaRecorderWebCam .   stop();
        mediaRecorderWebCam = null!;
        webcamCapture       . remove();
        webcamCapture       = null!;
        canvasInstance.draw = () => {
        canvasInstance.background(255);
        };
    };

    let webcamCapture: p5.Element;
    let imageFormatSelection: HTMLSelectElement;
    let videoFormatSelection: HTMLSelectElement;











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


import A from "./lib/A.svelte";

//GIF? (LATER IF THERE IS STILL TIME LEFT)
//imgur video/image
//Giphy? (LATER IF THERE IS STILL TIME LEFT)

import { supabase } from "./global";
import { fetchAllTextures_Noise } from "./common";
import { fetchAllTextures_BayerMatrix } from "./common";
import { fetchAllTextures_Palette } from "./common";
import { fetchAllTextures_Pencil } from "./common";
import { fetchAllTextures_ASCII } from "./common";
import { fetchAllTextures_Tiled } from "./common";
import { fetchAllTextures_ShaderToy } from "./common";
import { texturesNoise } from "./global";
import { texturesBayer } from "./global";
import { texturesPalette } from "./global";
import { texturesPencil } from "./global";
import { texturesASCII } from "./global";
import { texturesTiled } from "./global";
import { texturesShaderToy } from "./global";

onMount(async () => {




  $texturesNoise = [... $texturesNoise, ... await fetchAllTextures_Noise()];
  $texturesBayer = [... $texturesBayer, ... await fetchAllTextures_BayerMatrix()];
  $texturesPalette = [... $texturesPalette, ... await fetchAllTextures_Palette(supabase)];
  $texturesPencil = [... $texturesPencil, ... await fetchAllTextures_Pencil(supabase)];
  $texturesASCII = [... $texturesASCII, ... await fetchAllTextures_ASCII(supabase)];
  $texturesTiled = [... $texturesTiled, ... await fetchAllTextures_Tiled(supabase)];
  $texturesShaderToy = [... $texturesShaderToy, ... await fetchAllTextures_ShaderToy(supabase)];
});




let videoToShare: Blob;


// enum MODE
// {
//     IMAGE,
//     VIDEO,
//     WEBCAM,
// };


let mode:MODE = MODE.IMAGE;

//PREVIEW
//IMAGE
//VIDEO
//GIF 

import { Shaders, type ShaderName, type ShaderPath } from "./common";
// for (let i: number = 1; i <= 88; ++i)
// {
//     import(`./lib/${i}.glsl?raw`);
// }
// for (let i: number = 1; i <= 93; ++i)
// {
//     import(`./shadertoys/${i}.glsl?raw`);
// }
// import(`./lib/${"p5.1"}.glsl?raw`);
// import(`./lib/${"p5.2"}.glsl?raw`);
onMount(async() => {
    for(let shaderPath of Shaders.values()) {
        if (shaderPath.includes("./lib/")) {
            await import(`./lib/${shaderPath.replace("./lib/", "").replace(".glsl?raw", "")}.glsl?raw`);
        }
        else
        if (shaderPath.includes("./shadertoys/")) {
            await import(`./shadertoys/${shaderPath.replace("./shadertoys/", "").replace(".glsl?raw", "")}.glsl?raw`);
        }
        else
        if (shaderPath.includes("./lygia/")) {
            await import(`./lygia/${shaderPath.replace("./lygia/", "").replace(".glsl?raw", "")}.glsl?raw`);
        }
    }
});

const  loadAsset = async (assetPath: string): Promise<string> => {
    const  asset = await import(assetPath);
    return asset.default;
}


// https://www.npmjs.com/package/vite-plugin-glsl no need
// https://www.npmjs.com/package/glsl-shader-name
// https://www.npmjs.com/package/glsl-100-to-300
// https://www.npmjs.com/package/lygia use
// https://www.npmjs.com/package/@infra7/glsl use


//#version 300 es

import GLSLUniform from './GLSLUniform.svelte';
import {MODE} from "./types";
import type { GLSLUniformValue,
    GLSLUniforms, GLSLUniform_} from "./types";
    import GlslUniform from "./GLSLUniform.svelte";



  // Handle updates to uniforms
  const handleUpdate = (updatedUniforms: GLSLUniforms): void => {
    // uniforms = updatedUniforms;
    console.log("Updated uniforms:", updatedUniforms);
  };





let currentGLSLUniforms: GLSLUniforms;



</script>

<main class="responsive">
    <form action="">
        <input
            bind:this={input}
            on:change={onChange}
            type="file"
            accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm"
        />
        <button>LOAD IMAGE OR VIDEO</button>
    </form>
    <div bind:this={canvas} on:change={()=>{console.log("change")}}></div>
    <button on:click={async (e) => { canvasInstance.saveCanvas(`test_image_${new Date().toLocaleString()}`, imageFormats[imageFormatSelection.selectedIndex].extension); }}>SAVE IMAGE</button>
    <button on:click={async (e) => { mediaRecorder.stop(); }}>SAVE VIDEO</button>
    <button on:click={startWebCam}>START WEB CAM</button>
    <button on:click={ceaseWebCam}>STOP@ WEB CAM</button>

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



    <button on:click={async() => {
    const   res = await promptShader();
    console.log(  await res.text()   );
    }}>AI</button>
    <button on:click={async () => { await shareImage (              canvas.children[0] as HTMLCanvasElement); }} disabled={mode !== MODE.IMAGE }>SHARE IMAGE </button>
    <button on:click={async () => { await shareVideo (videoToShare, canvas.children[0] as HTMLCanvasElement); }} disabled={mode !== MODE.VIDEO }>SHARE VIDEO </button>
    <button on:click={async () => { await shareWebcam(videoToShare, canvas.children[0] as HTMLCanvasElement); }} disabled={mode !== MODE.WEBCAM}>SHARE WEBCAM</button>



<div class="field label suffix round border">
    <select on:change={async (e) => {
        let shaderName=e.currentTarget.options[e.currentTarget.selectedIndex].value;
        if (shaderName==="none") console.log("Choose nothing");
        else {
            console.log(shaderName);
            let shaderPath = Shaders.get(shaderName);
            if (!shaderPath) {
                console.log("fail");
                return;
            }
            const shaderSrc = await loadAsset(shaderPath);
            if (shaderName.toLowerCase().trim().includes("lygia"))
            {imageFragmentShaderSourceCode = await resolveLygiaAsync(shaderSrc);}
            else
            {imageFragmentShaderSourceCode = shaderSrc;}
            if (imageFragmentShaderSourceCode.charAt(0) === "-") {
                imageFragmentShaderSourceCode = imageFragmentShaderSourceCode.substring(1);
            }
            console.log(imageFragmentShaderSourceCode)
            currentGLSLUniforms = parseGLSL(imageFragmentShaderSourceCode);
            console.log(currentGLSLUniforms);
        }
        }}>
      {#each ["none", ... Shaders.keys()] as shaderName, shaderNameIndex (shaderName)}
        <option>{shaderName}</option>            
      {/each}
    </select>
    <label>Choose your effects</label>
    <i class="fa-solid fa-chevron-down"></i>
</div>

<GlslUniform uniforms={currentGLSLUniforms} onUpdate={handleUpdate} canvasInstance={canvasInstance}></GlslUniform>

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
