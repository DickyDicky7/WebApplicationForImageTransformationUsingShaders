<!-- svelte-ignore a11y-label-has-associated-control -->

<script lang="ts">


    import          "beercss"       ;
    import "material-dynamic-colors";

    import   p5        from "p5";
    import { onMount } from "svelte";

    console.log(import.meta.env.VITE_KEY001);
    import * as Beauty from "@deepar/beauty"
    import * as deepar from "deepar";

    // (async function() {
    //   const deepAR = await deepar.initialize({
    //     licenseKey: 'your_license_key_here',
    //     previewElement: document.querySelector('#deepar-div'),
    //     effect: 'https://cdn.jsdelivr.net/npm/deepar/effects/aviators'
    //   });
    // })();

    const DEFAULT_CANVAS_SIZE = { WIDTH: 500, HEIGHT: 500 };
    const DPR = window.devicePixelRatio || 1;
let i: p5.Image;
    const p5Logic = (p: p5) => {
          p.setup = (     ) => {
            p.createCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH * DPR), Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR), p.WEBGL);
            p.background( 255 );
            p.imageMode(p.CENTER);
            p.frameRate(  fps   );
            i = p.loadImage(data.publicUrl);
             noiseT1 = p.loadImage("./src/noise.png");
            noiseT2 = p.loadImage("./download.png");
            gradient = p.loadImage("./sunset-red-8x.png");
            ascii_tex = p.loadImage("./ascii.png");
            tile = p.loadImage("./Texturelabs_MonitorPatterns_page_01.png");
            bayer = p.loadImage("./bayer16tile8.png");
            u_bgTexture = p.loadImage("./parchment.jpg");
            u_patternTexture = p.loadImage("./pencil.jpg");
        };

        p.draw = () => {
            p.background( 255 );
            p.image(i,0,0)
        };
    };

    let canvas        : HTMLElement;
    let canvasInstance:          p5;
    
    onMount(async ()  : Promise<void> => {
    console.log("on mount");
        canvasInstance = new p5(p5Logic, canvas);
        await ui("theme", "#009688")
        
    });

    let noiseT1:p5.Image;
    let noiseT2:p5.Image;
    let gradient:p5.Image;
    let ascii_tex:p5.Image;
    let tile:p5.Image;
    let bayer:p5.Image;
    let u_bgTexture:p5.Image;
    let u_patternTexture:p5.Image;
    const successCallback = (imageD: p5.Image): void => {
        let imageRatio = 0.5;
        canvasInstance.resizeCanvas(imageD.width * imageRatio * DPR, imageD.height * imageRatio * DPR);
        imageD        .resize      (imageD.width * imageRatio * DPR, imageD.height * imageRatio * DPR);
        canvasInstance.draw  = () => {

            canvasInstance.textureWrap("repeat");
            let     filterShader = (canvasInstance as any)
         .createFilterShader                         (imageFragmentShaderSourceCode);
         shaderSetNecessaryUniforms(filterShader);
        filterShader.setUniform("tex1", noiseT1)
        filterShader.setUniform("tex2", noiseT2)
        filterShader.setUniform("gradient", gradient);
        filterShader.setUniform("pallete0", gradient);
        filterShader.setUniform("pallete0Size", [gradient.width, gradient.height]);
        filterShader.setUniform("ascii_tex", ascii_tex);
        filterShader.setUniform("tiledtexture", tile);
        filterShader.setUniform("bayer", bayer);
        filterShader.setUniform("bayer0", bayer);
        filterShader.setUniform("bayer0Size", [bayer.width, bayer.height]);
        filterShader.setUniform("u_bgTexture", u_bgTexture); //switchable
        filterShader.setUniform("u_patternTexture", u_patternTexture); ////switchable
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
                warp.setUniform("tex1", noiseT1);
                warp.setUniform("tex2", noiseT2);
                warp.setUniform("gradient", gradient);
                warp.setUniform("pallete0", gradient);
                warp.setUniform("pallete0Size", [gradient.width, gradient.height]);
                warp.setUniform("ascii_tex", ascii_tex);
                warp.setUniform("tiledtexture", tile);
                warp.setUniform("bayer",bayer);
                warp.setUniform("bayer0",bayer);
                warp.setUniform("bayer0Size", [bayer.width, bayer.height]);
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
        precision highp float;

        uniform sampler2D tex0;
        varying vec2 vTexCoord;

        vec2 zoom(vec2 coord, float amount) {
                  vec2 relativeToCenter  = coord - 0.5;
                       relativeToCenter /= amount;      //     Zoom in
            return     relativeToCenter          + 0.5; // Put back into absolute coordinates
        }

        void main() {
            // Get each@ color channel@ using coordinates with@@@@ different amounts
            // of@ zooms to@@@ displace the@@ colors@@@@@ slightly
            gl_FragColor = vec4(
                texture2D(tex0,      vTexCoord       ).r,
                texture2D(tex0, zoom(vTexCoord, 1.05)).g,
                texture2D(tex0, zoom(vTexCoord, 1.10)).b,
                texture2D(tex0,      vTexCoord       ).a
            );
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
    shader.setUniform("tex1Size", [noiseT1.width,noiseT1.height]);
    shader.setUniform("tex2Size", [noiseT2.width,noiseT2.height]);
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

//         const deepAR = await deepar.initialize({
//   licenseKey: 'd936878d07a3b05ef50fb9559398728d37f73663965c3754c84a998bc35e4ab18d1d6b164bbc6af4', 
//   canvas: canvas.children[0]  as HTMLCanvasElement,
//   effect: '../Pixel Heart Particles/8bitHearts.deepar',
// });

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

    let anch: HTMLAnchorElement;

    const y = ()=> {
    let canvasElement = canvas.children[0] as HTMLCanvasElement;
    canvasElement.toBlob(b => {
        anch.href=URL.createObjectURL(b as Blob)
        navigator.share({
            title: "MDN",
  text: "Learn web development on MDN!",
  url: data.publicUrl,
//   files: [new File([b as Blob], "image.png", { type: "image/png", })],
        })
    }, "image/png", 1.0);
    // console.log(anch.href);
}

import { f } from "./a.i.effects";
import { g } from "./a.i.effects";

import { createClient } from '@supabase/supabase-js'
const supabase = createClient(import.meta.env.VITE_SUPABASE_URL
, import.meta.env.VITE_SUPABASE_KEY_PUB);

const {data}=supabase.storage.from("noise_textures").getPublicUrl("sbs_-_noise_texture_pack_-_128x128/128x128/Cracks/Cracks 10 - 128x128.png")
console.log(data);


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

// import imgur from "imgur";
// const client = new imgur({ clientId: import.meta.env.VITE_CLIENT_ID____ });
import { ImgurClient } from 'imgur';

const client = new ImgurClient({ clientId: import.meta.env.VITE_CLIENT_ID____ });

const shareImage = async () => {
    let canvasElement = canvas.children[0] as HTMLCanvasElement;
    const res = await client.upload({
        image: canvasElement.toDataURL("image/png",1.0).split(',')[1],
        type: "base64",
        name: "abc.png",
        title: "hello",
        description: "desc",
        disable_audio: "1",
    });
    console.log(res.data);
    window.navigator.share({
            title: "MDN",
  text: "Learn web development on MDN!",
  url: res.data.link,
//   files: [new File([b as Blob], "image.png", { type: "image/png", })],
        })
}


function blobToBase64(blob:Blob): Promise<string> {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        
        reader.onloadend = () => {
            if (reader.result) {
                // Split to remove the data URL prefix and get only the base64 part
                resolve((reader.result as string).split(",")[1]);
            } else {
                reject(new Error("FileReader result is null"));
            }
        };

        reader.onerror = () => reject(new Error("Failed to read the Blob as Data URL"));
        reader.readAsDataURL(blob); // This will start reading the blob as a Data URL
    });
}

let videoToShare: Blob;
const shareVideo = async () => {
    let canvasElement = canvas.children[0] as HTMLCanvasElement;
    const res = await client.upload({
        image: await blobToBase64(videoToShare),
        type: "base64",
        name: "abc",
        title: "hello",
        description: "desc",
        disable_audio: "1",
    });
    console.log(res.data);
    window.navigator.share({
            title: "MDN",
  text: "Learn web development on MDN!",
  url: res.data.link,
//   files: [new File([b as Blob], "image.png", { type: "image/png", })],
        })
}

const shareWebcam = async () => {

}

enum MODE
{
    IMAGE,
    VIDEO,
    WEBCAM,
};

let mode:MODE = MODE.IMAGE;

//PREVIEW
//IMAGE
//VIDEO
//GIF 

for (let i: number = 1; i <= 7; i++)
{
    import(`./lib/${i}.glsl?raw`);
}
// import glslString from "./lib/1.glsl?raw";
// console.log(glslString);

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
import type { GLSLUniformValue,
    GLSLUniforms,} from "./types";

// Example uniforms
let uniforms: GLSLUniforms = {
    uTime: 1.0,
    uBool: true,
    uResolution: [800, 600],
    uMouse: [0.5, 0.5],
    uTransform: [1, 0, 0, 0, 1, 0, 0, 0, 1], // mat3 example
    uSampler: data.publicUrl,
    uIntensity: 5, // int
    uColor: [1.0, 0.5, 0.2, 1.0], // vec4
  };

  // Handle updates to uniforms
  const handleUpdate = (updatedUniforms: GLSLUniforms): void => {
    uniforms = updatedUniforms;
    console.log("Updated uniforms:", uniforms);
  };

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
        <i>arrow_drop_down</i>
    </div>

    <div class="field label suffix round border">
        <select bind:this={videoFormatSelection}>
          {#each videoFormats as videoFormat (videoFormat)}
            <option>{videoFormat.mimeType}</option>            
          {/each}
        </select>
        <label>Video Format</label>
        <i>arrow_drop_down</i>
    </div>

<a bind:this={anch}>download</a>
<button on:click={y}>noise</button>

<button on:click={async() => {
const res = await f();
console.log(await res.text())
}}>AI 1</button>

<button on:click={async() => {
const res = await g();
console.log(await res.text())
}}>AI 2</button>

<button on:click={async () => {
    eval(`canvasInstance.draw = () => { canvasInstance.background(255,0,0); };`)
}}>FUNC</button>

<button on:click={async () => {
    imageFragmentShaderSourceCode = videoFragmentShaderSourceCode;
}}>CHANGE EFFECT IMAGE</button>

<button on:click={async () => {
    videoFragmentShaderSourceCode = imageFragmentShaderSourceCode;
}}>CHANGE EFFECT VIDEO</button>

<button on:click={shareImage} disabled={mode !== MODE.IMAGE}>SHARE IMAGE</button>
<button on:click={shareVideo} disabled={mode !== MODE.VIDEO}>SHARE VIDEO</button>
<button on:click={shareWebcam} disabled={mode !== MODE.WEBCAM}>SHARE WEBCAM</button>

<A/>

<div class="field label suffix round border">
    <select on:change={async (e) => {
        let assetPath=e.currentTarget.options[e.currentTarget.selectedIndex].value;
        if (assetPath==="none") console.log("Choose nothing");
        else {
            console.log(assetPath)
            const shaderSrc = await loadAsset(`./lib/${assetPath}`);
            imageFragmentShaderSourceCode = shaderSrc;
        }
        }}>
      {#each ["none", ... Array.from({ length: 7 }, (value, index) => `${index + 1}.glsl?raw`)] as index (index)}
        <option>{index}</option>            
      {/each}
    </select>
    <label>Choose your effects</label>
    <i>arrow_drop_down</i>
</div>

<GLSLUniform uniforms={uniforms} onUpdate={handleUpdate} />

</main>

<style>
    main {
        overflow-x: visible;
        scroll-behavior: smooth;
    }
    * {
  scroll-behavior: smooth;
}
</style>
