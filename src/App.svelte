<!-- svelte-ignore a11y-label-has-associated-control -->

<script lang="ts">


    import          "beercss"       ;
    import "material-dynamic-colors";

    import   p5        from "p5";
    import { onMount } from "svelte";

    console.log(import.meta.env.VITE_KEY001);
    import * as Beauty from "@deepar/beauty"
    import * as deepar from "deepar";

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
    console.log("on mount");
        canvasInstance = new p5(p5Logic, canvas);
    });


    const successCallback = (imageD: p5.Image): void => {
        canvasInstance.draw  = () => {};
        let     filterShader = (canvasInstance as any)
         .createFilterShader                         (imageFragmentShaderSourceCode);
        let imageRatio = 0.5;
        canvasInstance.resizeCanvas(imageD.width * imageRatio * DPR, imageD.height * imageRatio * DPR);
        imageD        .resize      (imageD.width * imageRatio * DPR, imageD.height * imageRatio * DPR);
        canvasInstance.       image(imageD, 0, 0);
        canvasInstance.filter(filterShader);
    };


    const failureCallback = (eventD:    Event): void => {
        if (canvas.children   .length === 2) {
//          canvas.children[1].remove();
        if (video) {video.remove();} // the same as the above line of code
        }
        if (input.files !== null) {
            if (videoFileBLOB !== null) { window.URL.revokeObjectURL( videoFileBLOB); }
                videoFileBLOB  =          window.URL.createObjectURL(input.files[0]);
            video = canvasInstance.createVideo(videoFileBLOB);
            video .volume(1.0);
            video .hide  (   );
//          video .loop  (   );
            let warp = (canvasInstance as any).createFilterShader(videoFragmentShaderSourceCode);
            let startRecord: boolean = true;
            let ceaseRecord: boolean = false;
            console.log("Assign");
            canvasInstance.resizeCanvas(Math.floor(DEFAULT_CANVAS_SIZE.WIDTH * DPR), Math.floor(DEFAULT_CANVAS_SIZE.HEIGHT * DPR));
            canvasInstance.draw = () => {
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
                    canvasInstance.width,
                    canvasInstance.height,
                    0,
                    0,
                    video.width,
                    video.height,
                    canvasInstance.COVER,
                );
                canvasInstance.pop();
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
        precision highp float;

        uniform sampler2D tex0;
        varying vec2 vTexCoord;

        void main() {
            //   Offset        the input coordinate
            vec2 warpedCoord = vTexCoord;
            warpedCoord.x += 0.05 * sin(vTexCoord.y * 10.0);
            warpedCoord.y += 0.05 * sin(vTexCoord.x * 10.0);

            // Set the new color by looking up the warped coordinate
            gl_FragColor = texture2D(tex0, warpedCoord);
        }
    `;

    
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
        shader.setUniform("time"                     ,         canvasInstance.millis()                                                                                               );
        shader.setUniform(     "canvasSize"          , [       canvasInstance.width                                  ,        canvasInstance.height                                 ]);
        shader.setUniform(                "texelSize", [1.0 / (canvasInstance.width * canvasInstance.pixelDensity()) , 1.0 / (canvasInstance.height * canvasInstance.pixelDensity())]);
    }

        
    const startWebCam = (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
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
        canvasInstance.filter(filterShaderWebCam             );
        };
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
    });
    // console.log(anch.href);
}
</script>

<main>
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
