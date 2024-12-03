<script lang="ts">
    import Header from "./Header.svelte";
    import Footer from "./Footer.svelte";
    import TopBar from "./TopBar.svelte";
    import SideBar from "./SideBar.svelte";

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
        await ui("theme", "#006a60")
        
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

import { f } from "../a.i.effects";
import { g } from "../a.i.effects";

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


import A from "../lib/A.svelte";

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

import type { GLSLUniformValue,
    GLSLUniforms, GLSLUniform_} from "../types";

// Example uniforms
let uniforms: GLSLUniforms = [
    { thisUniformName: "a", thisUniformNameJustForDisplay: "a", thisUniformType: "float", thisUniformDefaultValue: 0.0   },
    { thisUniformName: "b", thisUniformNameJustForDisplay: "b", thisUniformType: "int"  , thisUniformDefaultValue: 0     },
    { thisUniformName: "c", thisUniformNameJustForDisplay: "c", thisUniformType: "bool" , thisUniformDefaultValue: false },    
    
    { thisUniformName: "d", thisUniformNameJustForDisplay: "d", thisUniformType: "vec2", thisUniformDefaultValue: [0.0, 0.0          ] },
    { thisUniformName: "e", thisUniformNameJustForDisplay: "e", thisUniformType: "vec3", thisUniformDefaultValue: [0.0, 0.0, 0.0     ] },
    { thisUniformName: "f", thisUniformNameJustForDisplay: "f", thisUniformType: "vec4", thisUniformDefaultValue: [0.0, 0.0, 0.0, 0.0] },
    
    { thisUniformName: "g", thisUniformNameJustForDisplay: "g", thisUniformType: "ivec2", thisUniformDefaultValue: [0, 0      ] },
    { thisUniformName: "h", thisUniformNameJustForDisplay: "h", thisUniformType: "ivec3", thisUniformDefaultValue: [0, 0, 0   ] },
    { thisUniformName: "i", thisUniformNameJustForDisplay: "i", thisUniformType: "ivec4", thisUniformDefaultValue: [0, 0, 0, 0] },
    
    { thisUniformName: "j", thisUniformNameJustForDisplay: "j", thisUniformType: "mat2", thisUniformDefaultValue: [0.0, 0.0,          
                                                                                                                   0.0, 0.0            ] },
    { thisUniformName: "k", thisUniformNameJustForDisplay: "k", thisUniformType: "mat3", thisUniformDefaultValue: [0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0       ] },
    { thisUniformName: "l", thisUniformNameJustForDisplay: "l", thisUniformType: "mat4", thisUniformDefaultValue: [0.0, 0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0, 0.0, 
                                                                                                                   0.0, 0.0, 0.0, 0.0,
                                                                                                                   0.0, 0.0, 0.0, 0.0  ] },
    
   
    { thisUniformName: "m", thisUniformNameJustForDisplay: "m", thisUniformType: "sampler2D", thisUniformDefaultValue: data.publicUrl   },
    { thisUniformName: "noise_m", thisUniformNameJustForDisplay: "noise_m", thisUniformType: "sampler2D", thisUniformDefaultValue: data.publicUrl   },
    { thisUniformName: "bayer_m", thisUniformNameJustForDisplay: "bayer_m", thisUniformType: "sampler2D", thisUniformDefaultValue: data.publicUrl   },
    { thisUniformName: "pallete_m", thisUniformNameJustForDisplay: "pallete_m", thisUniformType: "sampler2D", thisUniformDefaultValue: data.publicUrl   },
];

  // Handle updates to uniforms
  const handleUpdate = (updatedUniforms: GLSLUniforms): void => {
    uniforms = updatedUniforms;
    console.log("Updated uniforms:", uniforms);
  };


  function parseGLSL(glslCode: string): GLSLUniforms {
    const uniformRegex = /uniform\s+(\w+)\s+(\w+)\s*;\s*(\/\/\s*([\w.\-, ]+))?/g;
    const uniforms: GLSLUniforms = [];
    let match;

    while ((match = uniformRegex.exec(glslCode)) !== null) {
        const [, type, name, , defaultValueRaw] = match;

        //guard - filter
        //not editable - auto set internal
        if (name === "tex0"
        ||  name === "vTexCoord"
        ||  name === "fragColor"
        ||  name === "time"
        ||  name === "canvasSize"
        ||  name === "texelSize"
        ) {
            continue;
        }

        // Parse the default value based on type
        let parsedValue: GLSLUniformValue | null = null;
        if (defaultValueRaw) {
            const cleanedValue = defaultValueRaw.replace(/\s+/g, ""); // Remove spaces

            switch (type) {
                case "float":
                case "int":
                case "uint":
                    parsedValue = parseFloat(cleanedValue);
                    break;
                case "bool":
                    parsedValue = cleanedValue === "true";
                    break;
                case "vec2":
                case "vec3":
                case "vec4":
                case "ivec2":
                case "ivec3":
                case "ivec4":    
                case "uvec2":
                case "uvec3":
                case "uvec4":    
                case "mat2":
                case "mat3":
                case "mat4":
                    parsedValue = cleanedValue.split(",").map(v => parseFloat(v));
                    break;
                case "sampler2D":
                case "sampler3D":
                // case "samplerCube":
                    parsedValue = cleanedValue; // Use the raw string for sampler types
                    break;
                default:
                    parsedValue = null; // Unsupported type
                    // bvec2
                    // bvec3
                    // bvec4
                    // mat2x3
                    // mat2x4
                    // mat3x2
                    // mat3x4
                    // mat4x2
                    // mat4x3

                    // samplerCube 
                    // sampler2DArray 
                    // sampler2DShadow 
                    // samplerCubeShadow 
                    // isampler2D 
                    // isampler3D 
                    // isamplerCube 
                    // isampler2DArray 
                    // usampler2D 
                    // usampler3D 
                    // usamplerCube 
                    // usampler2DArray 
                    // struct
            }
        }

        uniforms.push({
            thisUniformName: name,
            thisUniformNameJustForDisplay: null,
            thisUniformType: type,
            thisUniformDefaultValue: parsedValue,
        });
    }

    return uniforms;
}

// Example GLSL code
const glslCode = `
#version 300 es
precision highp float;

uniform sampler2D  tex0;
in      vec2           vTexCoord;
out     vec4           fragColor;
uniform float      time;
uniform vec2 canvasSize;
uniform vec2           texelSize; // - 1.0  , 0.0

uniform float    PI    ;                             // 3.14
uniform float    scan_line_amount    ;//   1.0 
uniform float         warp_amount    ;//   0.1 
uniform float        noise_amount    ;//   0.03
uniform float interference_amount    ;//   0.2 
uniform float       grille_amount    ;//   0.1 
uniform float       grille_size      ;//   1.0 
uniform float     vignette_amount    ;//   0.6 
uniform float     vignette_intensity ;//   0.4 
uniform float    aberation_amount    ;//   0.5 
uniform float    roll_line_amount    ;//   0.3 
uniform float    roll_speed          ;//   1.0 
uniform float    scan_line_strength  ;// - 8.0 
uniform float        pixel_strength  ;// - 2.0 

float random(vec2 uv) {
    return fract(cos(uv.x * 83.4827
                   + uv.y * 92.2842) * 43758.5453123);
}

vec3 fetch_pixel(vec2 uv, vec2 off) {
    vec2 pos = floor(uv * canvasSize + off) / canvasSize + vec2(0.5) / canvasSize;

    float noise        = 0.0;
    if (  noise_amount > 0.0) {
          noise        = random(pos + fract(time))
       *  noise_amount;
    }

    if (max(abs(pos.x - 0.5),
            abs(pos.y - 0.5)) > 0.5) {
        return vec3(0.0, 0.0, 0.0);
    }

    vec3   clr = texture(tex0, pos, -16.0).rgb + noise;
    return clr;
}

// Distance in emulated pixels to nearest texel @@@@.
vec2 Dist(vec2 pos) {
               pos =       pos   * canvasSize;
    return - ((pos - floor(pos)) - vec2(0.5));
}

// 1D@@@@@@ @@ Gaussian @@@@@@ @@ @@@@@@@ @@@@@ @@@@.
float Gaus(float pos, float scale) {
    return
      exp2(                 scale * pos
                                  * pos);
}

// 3-tap@@@ @@ Gaussian filter @@ along@@ horz@ line.
vec3 Horz3(vec2 pos, float off) {
    vec3 b = fetch_pixel(pos, vec2(-1.0, off));
    vec3 c = fetch_pixel(pos, vec2( 0.0, off));
    vec3 d = fetch_pixel(pos, vec2( 1.0, off));
    float dst = Dist(pos).x;

    // Convert distance to weight.
    float scale = pixel_strength;
    float wb = Gaus(dst - 1.0, scale);
    float wc = Gaus(dst + 0.0, scale);
    float wd = Gaus(dst + 1.0, scale);

    // Return@ filtered @@ sample.
    return (b * wb + c * wc + d * wd) / (wb + wc + wd);
}

// Return scanline weight @@@@@ @@ @@@@@@ @@@@@.
float Scan(vec2 pos, float off) {
    float       dst = Dist(pos).y;

    return Gaus(dst + off, scan_line_strength);
}

// Allow@ nearest@ three@ lines to effect pixel.
vec3 Tri(vec2 pos) {
    vec3 clr = fetch_pixel(pos, vec2(0.0));
    if (scan_line_amount > 0.0) {
        vec3 a = Horz3(pos, -1.0);
        vec3 b = Horz3(pos,  0.0);
        vec3 c = Horz3(pos,  1.0);

        float wa = Scan(pos, -1.0);
        float wb = Scan(pos,  0.0);
        float wc = Scan(pos,  1.0);

        vec3 scanlines = a * wa
                       + b * wb
                       + c * wc                       ;
           clr = mix(clr, scanlines, scan_line_amount);
    }
    return clr;
}

// Takes in the UV and warps the edges, creating the spherized effect
vec2 warp(vec2 uv) {
    vec2  delta = uv - 0.5;
    float delta2 = dot(delta.xy, delta.xy);
    float delta4 =       delta2 *      delta2;
    float delta_offset = delta4 * warp_amount;

    vec2    warped = uv + delta *                     delta_offset;
    return (warped - 0.5) / mix(1.0, 1.2, warp_amount / 5.0) + 0.5;
}

float vignette(vec2 uv) {
                    uv *= 1.0 - uv.xy;
    float      vignette = uv.x
                        * uv.y
                        * 15.0;
    return pow(vignette, vignette_intensity * vignette_amount);
}

float floating_mod(float a
,                  float b) {
    return a - b * floor(
           a / b        );
}

vec3 grille(vec2 uv) {
    float  unit =         PI / 3.0        ;
    float scale = 2.0 * unit / grille_size;
    float r = smoothstep(0.5, 0.8, cos(uv.x * scale - unit));
    float g = smoothstep(0.5, 0.8, cos(uv.x * scale + unit));
    float b = smoothstep(0.5, 0.8, cos(uv.x * scale + 3.0 * unit));
    return mix(vec3(1.0), vec3(r, g, b), grille_amount);
}

float roll_line(vec2 uv) {
    float x =  uv.y  * 3.0 - time * roll_speed;
    float f = cos(x) * cos(x * 2.35 + 1.1)
                     * cos(x * 4.45 + 2.3);
    float  roll_line = smoothstep(0.5, 0.9, f);
    return roll_line *
           roll_line_amount;
}

void main() {
    vec2 pix =   gl_FragCoord.xy;
    vec2 pos = warp(vTexCoord)  ;

    float    line =        0.0  ;
    if (roll_line_amount > 0.0) {
             line =
        roll_line(pos);
    }

    vec2 sq_pix = floor(pos * canvasSize) / canvasSize +   vec2(0.5)  / canvasSize  ;
    if (                          interference_amount  + roll_line_amount > 0.0) {
        float     interference =     random(sq_pix.yy  + fract(time));
        pos.x += (interference * (interference_amount  + line * 6.0)) / canvasSize.x;
    }

    vec3 clr = Tri(pos);
    if (aberation_amount > 0.0) {
        float chromatic   = aberation_amount + line * 2.0;
        vec2  chromatic_x = vec2(     chromatic , 0.0) / canvasSize.x;
        vec2  chromatic_y = vec2(0.0, chromatic / 2.0) / canvasSize.y;
        float r = Tri(pos - chromatic_x).r;
        float g = Tri(pos + chromatic_y).g;
        float b = Tri(pos + chromatic_x).b;
        clr = vec3(r, g, b);
    }

    if (     grille_amount > 0.0    )
    clr *=   grille(pix);
    clr *= 1.0 + scan_line_amount * 0.6 + line * 3.0 + grille_amount * 2.0;
    if(    vignette_amount > 0.0    )
    clr *= vignette(pos);

    fragColor.rgb = clr;
    fragColor.a   = 1.0;
}

// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
// https://godotshaders.com/shader/realistic-crt-shader/
// @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


    
`;

const result = parseGLSL(glslCode);
console.log(result);
const saveImage = async (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
    console.log(imageFormatSelection)
        canvasInstance.saveCanvas(
            `test_image_${new Date().toLocaleString()}`,
            imageFormats[imageFormatSelection.selectedIndex].extension); 
    }
const saveVideo = async (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
         mediaRecorder.stop(); 
    }
</script>
<main>
    <div class="container">
        <div class="headerContainer grey-border border">
            <Header/>
        </div>
        <div class="topBarContainer amber7 grey-border border">
            <TopBar
                mode={mode}
                shareImage={shareImage}
                shareVideo={shareVideo}
                startWebCam={startWebCam}
                stopWebCam={ceaseWebCam}
                saveImage={saveImage}
                saveVideo={saveVideo}>
                <input
                    slot="file-input"
                    bind:this={input}
                    on:change={onChange}
                    type="file"
                    accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm"/>
                <div slot="image-format-selection"
                    class="field label suffix round border">
                    <select bind:this={imageFormatSelection}>
                    {#each imageFormats as imageFormat (imageFormat)}
                        <option>{imageFormat.extension}</option>
                    {/each}
                    </select>
                    <label>Image Format</label>
                    <i>arrow_drop_down</i>
                </div>
                <div slot="video-format-selection"
                    class="field label suffix round border">
                    <select bind:this={videoFormatSelection}>
                    {#each videoFormats as videoFormat (videoFormat)}
                        <option>{videoFormat.mimeType}</option>            
                    {/each}
                    </select>
                    <label>Video Format</label>
                    <i>arrow_drop_down</i>
                </div>
            </TopBar>
        </div>
        <div class="mainContainer grey-border border">
            <div class="sideBarContainer grey-border border">
                <SideBar 
                    uniforms={uniforms} onUpdate={handleUpdate}/>
            </div>
            <div class="canvasContainer grey-border border">
                <div class="canvasTool grey-border border">
                    
                </div>
                <div class="canvas grey-border border">
                    <div 
                        bind:this={canvas} 
                        on:change={()=>{console.log("change")}}>
                    </div>
                </div>
            </div>
        </div>
        <div class="footerContainer grey-border border">
            <Footer/>
        </div>
    </div>
</main>
<style>
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
        padding: 10px;
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
        width: 40%;
        height: 100%;
    }
    .canvasContainer {
        width: 60%;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .canvasTool {
        width: 100%;
        height: 20%;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }
    .canvas {
        width: 100%;
        height: 80%;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        overflow: scroll;
    }
</style>