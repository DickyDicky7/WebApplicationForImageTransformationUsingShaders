<!--<svelte:options runes={true}></svelte:options>-->
    <svelte:options runes={true}></svelte:options>
<!--<svelte:options runes={true}></svelte:options>-->
<script lang="ts">
    import "beercss";
//  import "beercss";
    import "material-dynamic-colors";
//  import "material-dynamic-colors";
    import * as t from "svelte/transition";
//  import * as t from "svelte/transition";
    import * as global from "./state/global.svelte";
//  import * as global from "./state/global.svelte";
    import * as common from "./common";
//  import * as common from "./common";
    import * as svelte from "svelte";
//  import * as svelte from "svelte";
    import * as types from "./types";
//  import * as types from "./types";
    import * as controller from "./controller";
//  import * as controller from "./controller";
    import * as constants from "./constants";
//  import * as constants from "./constants";
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

    const appController: controller.AppController = new controller.AppController();
//  const appController: controller.AppController = new controller.AppController();

    svelte.onMount(async (): Promise<void> => {
//  svelte.onMount(async (): Promise<void> => {
        /*
        await ui("theme", "#000000");
//      await ui("theme", "#000000");
        await ui("mode", "dark");
//      await ui("mode", "dark");
        */
        window.addEventListener("keydown", onKeyDown);
//      window.addEventListener("keydown", onKeyDown);
        await appController.init();
//      await appController.init();
    });
//  });

    svelte.onDestroy(async (): Promise<void> => {
//  svelte.onDestroy(async (): Promise<void> => {
        window.removeEventListener("keydown", onKeyDown);
//      window.removeEventListener("keydown", onKeyDown);
        await appController.destroy();
//      await appController.destroy();
    });
//  });

    async function onKeyDown(e: KeyboardEvent): Promise<void> {
//  async function onKeyDown(e: KeyboardEvent): Promise<void> {
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
    }
//  }

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

    // DeepAR SDK(s)
//  // DeepAR SDK(s)
    // DeepAR Beauty
//  // DeepAR Beauty

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

    //Imgur video/image
//  //Imgur video/image
    //Giphy #gif#/#gif#
//  //Giphy #gif#/#gif#

    //PREVIEW
//  //PREVIEW
    //IMAGE
//  //IMAGE
    //VIDEO
//  //VIDEO
    //GIF
//  //GIF
</script>

<!--<div bind:this={appController.appState.canvasState.canvasBG} style:position="absolute" style:z-index="0" style:pointer-events="none"></div>-->
    <div bind:this={appController.appState.canvasState.canvasBG} style:position="absolute" style:z-index="0" style:pointer-events="none"></div>
<!--<div bind:this={appController.appState.canvasState.canvasBG} style:position="absolute" style:z-index="0" style:pointer-events="none"></div>-->
<!--<DraggableTextComponent bind:canvasInstance={appState.canvasState.canvasInstance} bind:draggableText={appState.draggableText}></DraggableTextComponent>-->
<!--<DraggableTextComponent bind:canvasInstance={appState.canvasState.canvasInstance} bind:draggableText={appState.draggableText}></DraggableTextComponent>-->
<!--<DraggableTextComponent bind:canvasInstance={appState.canvasState.canvasInstance} bind:draggableText={appState.draggableText}></DraggableTextComponent>-->
<MouseCursor></MouseCursor>
{#if appController.appState.uiState.isInitializing}
<!--<div class="grey10 white-text large-elevate" out:t.fade style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; z-index: 9999; display: flex; justify-content: center; align-items: center;">-->
    <div class="grey10 white-text large-elevate" out:t.fade style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; z-index: 9999; display: flex; justify-content: center; align-items: center;">
<!--<div class="grey10 white-text large-elevate" out:t.fade style="position: fixed; top: 0; left: 0; width: 100vw; height: 100vh; z-index: 9999; display: flex; justify-content: center; align-items: center;">-->
    <!--<div class="row center-align">-->
        <div class="row center-align">
    <!--<div class="row center-align">-->
        <!--<h5 class="margin">Loading...</h5>-->
            <h5 class="margin">Loading...</h5>
        <!--<h5 class="margin">Loading...</h5>-->
        <!--<progress class="circle lime"></progress>-->
            <progress class="circle lime"></progress>
        <!--<progress class="circle lime"></progress>-->
    <!--</div>-->
        </div>
    <!--</div>-->
<!--</div>-->
    </div>
<!--</div>-->
{/if}
<main>
    <div class="container">
    <!--<div class="headerContainer"></div>-->
    <!--<div class="headerContainer"></div>-->
        <div class="topBarContainer small-padding">
            <div class="row">
            <!--<button class="slow-ripple large-elevate margin grey10 white-text"><i class="fa-solid fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={appController.appState.uiState.input} onchange={async (e) => await appController.onChange(e)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>-->
                <button class="slow-ripple large-elevate margin grey10 white-text"><i class="fa-solid fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={appController.appState.uiState.input} onchange={async (e) => await appController.onChange(e)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>
            <!--<button class="slow-ripple large-elevate margin grey10 white-text"><i class="fa-solid fa-paperclip white-text white-text"></i><span class="white-text">Load Image Or Video</span><input bind:this={appController.appState.uiState.input} onchange={async (e) => await appController.onChange(e)} type="file" accept="image/png, image/jpeg, image/webp, image/jpg, video/mp4, video/webm" /></button>-->
                <div class="field middle-align">
                    <nav>
                    <!--<div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>-->
                        <div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>
                    <!--<div class="max margin"><i class="fa-solid fa-face-grin-tongue white-text tiny-padding"></i><span class="white-text">WEBCAM</span><i class="fa-solid fa-hand-peace white-text tiny-padding"></i></div>-->
                        <label class="switch icon">
                            <input class="" type="checkbox" onchange={(e) => appController.toggleWebCam(e)}>
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
                                <select bind:this={appController.appState.uiState.imageFormatSelection}>
                                    {#each constants.imageFormats as imageFormat (imageFormat)}
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
                        <!--<button class="slow-ripple center large-elevate deep-orange white-text" onclick={async (e) => await appController.handleStartCaptureAsImage(e)}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate blue white-text slow-ripple medium-space" style:text-align="center"><span class="white-text">Save current frame</span></div></button>-->
                            <button class="slow-ripple center large-elevate deep-orange white-text" onclick={async (e) => await appController.handleStartCaptureAsImage(e)}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate blue white-text slow-ripple medium-space" style:text-align="center"><span class="white-text">Save current frame</span></div></button>
                        <!--<button class="slow-ripple center large-elevate deep-orange white-text" onclick={async (e) => await appController.handleStartCaptureAsImage(e)}><i class="fas fa-camera white-text"></i><span>Capture</span><div class="tooltip left max toolTip round left-round top-round large-elevate blue white-text slow-ripple medium-space" style:text-align="center"><span class="white-text">Save current frame</span></div></button>-->
                            <!--Đang render image/video trên canvas -> capture frame hình hiện tại-->
                            <!--Đang render image/video trên canvas -> capture frame hình hiện tại-->
                        </div>
                        <div class="medium-space"></div>
                        <div class="column">
                            <h6  class="                         white-text                          ">Save as video</h6>
                            <div class="field label suffix round white-text large-elevate slow-ripple">
                                <select bind:this={appController.appState.uiState.videoFormatSelection}>
                                    {#each constants.videoFormats as videoFormat (videoFormat)}
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
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={appController.appState.settingsState.selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round blue white-text large-elevate slow-ripple top-round right-round medium-space" style:text-align="center"><span class="white-text">Save frames (ACut)</span></div></label>-->
                                        <label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={appController.appState.settingsState.selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round blue white-text large-elevate slow-ripple top-round right-round medium-space" style:text-align="center"><span class="white-text">Save frames (ACut)</span></div></label>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Snapshot" bind:group={appController.appState.settingsState.selectedCaptureOption}><span>Snapshot</span><div class="tooltip right max toolTip round blue white-text large-elevate slow-ripple top-round right-round medium-space" style:text-align="center"><span class="white-text">Save frames (ACut)</span></div></label>-->
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={appController.appState.settingsState.selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round blue white-text large-elevate slow-ripple top-round  left-round medium-space" style:text-align="center"><span class="white-text">Save frames (Full)</span></div></label>-->
                                        <label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={appController.appState.settingsState.selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round blue white-text large-elevate slow-ripple top-round  left-round medium-space" style:text-align="center"><span class="white-text">Save frames (Full)</span></div></label>
                                    <!--<label class="radio"><input type="radio" name="radio4_" value="Fullshot" bind:group={appController.appState.settingsState.selectedCaptureOption}><span>Fullshot</span><div class="tooltip left  max toolTip round blue white-text large-elevate slow-ripple top-round  left-round medium-space" style:text-align="center"><span class="white-text">Save frames (Full)</span></div></label>-->
                                    </nav>
                                </div>
                            </div>
                            <div class="middle-align row">
                                <button class="slow-ripple large-elevate deep-orange white-text" onclick={async (e) => await appController.handleVideoToggle(e)}>
                                    {#if !appController.appState.mediaState.recording}
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
                                {#if appController.appState.mediaState.recording}
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
                <button class="slow-ripple large-elevate margin deep-orange" onclick={async (e) => await appController.handleShare(e)}>
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
                        <button class="slow-ripple responsive large-elevate deep-orange white-text" onclick={async (e) => await appController.handleAddEffectNI(e)}>
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
                        <button class="slow-ripple responsive large-elevate deep-orange white-text" onclick={async (e) => await appController.handleAddEffectAI(e)}>
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
                        <button class="slow-ripple responsive large-elevate grey10 align-center white-text" onclick={async (e) => await appController.handleInsertText(e)}>
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
            <!--<div class="effectContainer margin" bind:this={appController.appState.uiState.bigList}>-->
                <div class="effectContainer margin" bind:this={appController.appState.uiState.bigList}>
            <!--<div class="effectContainer margin" bind:this={appController.appState.uiState.bigList}>-->
                    {#each global.globalState.effectsUsedForFiltering as effect, effectIndex}
                    <!--<div class="tiny-space"></div>-->
                        <div class="tiny-space"></div>
                    <!--<div class="tiny-space"></div>-->
                    <!--<div class="medium-padding" in:t.fly={{x: -100}} out:t.fly={{x: +100}}>-->
                        <div class="medium-padding" in:t.fly={{x: -100}} out:t.fly={{x: +100}}>
                    <!--<div class="medium-padding" in:t.fly={{x: -100}} out:t.fly={{x: +100}}>-->
                        {#if effect.fragmentShaderSourceType________ === "NI"}
                            <div class="row">
                                <div class="field label suffix round max large-elevate white-text slow-ripple">
                                <!--<select bind:this={effect.fragmentShader_HTMLSelectElement}></select>-->
                                <!--<select bind:this={effect.fragmentShader_HTMLSelectElement}></select>-->
                                <!--<select bind:this={effect.fragmentShader_HTMLSelectElement}></select>-->
                                    <select bind:this={effect.fragmentShader_HTMLSelectElement} onchange={async (e) => await appController.handleEffectNIChange(e, effect, effectIndex)}>
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
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "NI")}><i class="fa-solid fa-ban white-text"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "NI")}><i class="fa-solid fa-ban white-text"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "NI")}><i class="fa-solid fa-ban white-text"></i></button>-->
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
                                        bind:canvasInstance={appController.appState.canvasState.canvasInstance}
                                        bind:uniforms={effect.fragmentShader______GLSLUniforms}
                                        onUpdate={(u) => appController.handleUpdate(u)}>
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
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "AI")}><i class="fa-solid fa-ban white-text"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "AI")}><i class="fa-solid fa-ban white-text"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "AI")}><i class="fa-solid fa-ban white-text"></i></button>-->
                            </div>
                        <!--<div class="overlay large-blur"></div>-->
                            <div class="overlay large-blur"></div>
                        <!--<div class="overlay large-blur"></div>-->
                            <dialog class="responsive dialog blur" id={`c${effectIndex}`}>
                                {#if appController.appState.uiState.isLoading}
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
                                        <input
                                            type="text"
                                            bind:this={appController.appState.uiState.AIInputPrompts}>
                                        <!-- svelte-ignore a11y_label_has_associated_control -->
                                        <!-- svelte-ignore a11y_label_has_associated_control -->
                                    <!--<label>Describe the effect you want</label>-->
                                        <label>Describe the effect you want</label>
                                    <!--<label>Describe the effect you want</label>-->
                                    </div>
                                    <!-- svelte-ignore a11y_consider_explicit_label -->
                                    <!-- svelte-ignore a11y_consider_explicit_label -->
                                    <button class="slow-ripple circle top-round right-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleAskAI(effect, effectIndex)}>
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
                                        bind:canvasInstance={appController.appState.canvasState.canvasInstance}
                                        bind:uniforms={effect.fragmentShader______GLSLUniforms}
                                        onUpdate={(u) => appController.handleUpdate(u)}>
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
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "text")}><i class="fa-solid fa-ban white-text"></i></button>-->
                                <button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "text")}><i class="fa-solid fa-ban white-text"></i></button>
                            <!--<button class="slow-ripple circle bottom-round left-round large-elevate deep-orange white-text" onclick={async (e) => await appController.handleRemoveEffect(effectIndex, "text")}><i class="fa-solid fa-ban white-text"></i></button>-->
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
                            <!--<DraggableTextComponent bind:canvasInstance={appController.appState.canvasState.canvasInstance} bind:draggableText={effect.draggableText!}></DraggableTextComponent>-->
                                <DraggableTextComponent bind:canvasInstance={appController.appState.canvasState.canvasInstance} bind:draggableText={effect.draggableText!}></DraggableTextComponent>
                            <!--<DraggableTextComponent bind:canvasInstance={appController.appState.canvasState.canvasInstance} bind:draggableText={effect.draggableText!}></DraggableTextComponent>-->
                            </dialog>
                        {/if}
                        <div class="row max">
                            {#if effectIndex > 0}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await appController.handleMoveEffectUp(effectIndex)}>-->
                                <button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await appController.handleMoveEffectUp(effectIndex)}>
                            <!--<button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await appController.handleMoveEffectUp(effectIndex)}>-->
                                <!--<i class="fa-solid fa-chevron-up white-text"></i>-->
                                    <i class="fa-solid fa-chevron-up white-text"></i>
                                <!--<i class="fa-solid fa-chevron-up white-text"></i>-->
                            <!--</button>-->
                                </button>
                            <!--</button>-->
                            {/if}
                            {#if effectIndex < global.globalState.effectsUsedForFiltering.length - 1}
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await appController.handleMoveEffectDown(effectIndex)}>-->
                                <button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await appController.handleMoveEffectDown(effectIndex)}>
                            <!--<button class="slow-ripple max large-elevate grey10 white-text" onclick={async (e) => await appController.handleMoveEffectDown(effectIndex)}>-->
                                <!--<i class="fa-solid fa-chevron-down white-text"></i>-->
                                    <i class="fa-solid fa-chevron-down white-text"></i>
                                <!--<i class="fa-solid fa-chevron-down white-text"></i>-->
                            <!--</button>-->
                                </button>
                            <!--</button>-->
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
                        {#if appController.appState.settingsState.mode === types.MODE.VIDEO}
                            <div class="column">
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                                <!-- svelte-ignore a11y_consider_explicit_label -->
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" style="margin-left: 5px;" onclick={async () => await appController.handleVideoRewind()}>-->
                                <button class="slow-ripple square large-elevate blue white-text margin" style="margin-left: 5px;" onclick={async () => await appController.handleVideoRewind()}>
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" style="margin-left: 5px;" onclick={async () => await appController.handleVideoRewind()}>-->
                                <!--<i class="fas fa-backward white-text"></i>-->
                                    <i class="fas fa-backward white-text"></i>
                                <!--<i class="fas fa-backward white-text"></i>-->
                                </button>
                            <!--<button class="slow-ripple square large-elevate grey10 white-text margin" onclick={async () => await appController.handleVideoPlayPause()}>-->
                                <button class="slow-ripple square large-elevate grey10 white-text margin" onclick={async () => await appController.handleVideoPlayPause()}>
                            <!--<button class="slow-ripple square large-elevate grey10 white-text margin" onclick={async () => await appController.handleVideoPlayPause()}>-->
                                    {#if appController.appState.mediaState.videoIsPlaying}
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
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" onclick={async () => await appController.handleVideoForward()}>-->
                                <button class="slow-ripple square large-elevate blue white-text margin" onclick={async () => await appController.handleVideoForward()}>
                            <!--<button class="slow-ripple square large-elevate blue white-text margin" onclick={async () => await appController.handleVideoForward()}>-->
                                <!--<i class="fas fa-forward white-text"></i>-->
                                    <i class="fas fa-forward white-text"></i>
                                <!--<i class="fas fa-forward white-text"></i>-->
                                </button>
                                <progress value="0" max="100" class="white-text blue large-elevate" bind:this={appController.appState.uiState.videoProgressSlider_}></progress>
                            </div>
                            <nav class="no-space">
                            <!--<i class="fas fa-volume-off padding-tiny white-text"></i>-->
                                <i class="fas fa-volume-off padding-tiny white-text"></i>
                            <!--<i class="fas fa-volume-off padding-tiny white-text"></i>-->
                                <label class="slider medium">
                                    <input
                                        type="range"
                                        value="1.0"
                                        min="0.0"
                                        max="1.0"
                                        step="0.010"
                                        oninput={async (e) => await appController.handleVideoVolumeChange(e)}>
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
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={async () => await appController.handleUndo()}><i class="fa-solid fa-arrow-rotate-left  white-text"></i><span>Undo</span></button>-->
                        <button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={async () => await appController.handleUndo()}><i class="fa-solid fa-arrow-rotate-left  white-text"></i><span>Undo</span></button>
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={async () => await appController.handleUndo()}><i class="fa-solid fa-arrow-rotate-left  white-text"></i><span>Undo</span></button>-->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                        <!-- svelte-ignore a11y_consider_explicit_label -->
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={async () => await appController.handleRedo()}><i class="fa-solid fa-arrow-rotate-right white-text"></i><span>Redo</span></button>-->
                        <button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={async () => await appController.handleRedo()}><i class="fa-solid fa-arrow-rotate-right white-text"></i><span>Redo</span></button>
                    <!--<button class="slow-ripple circle bottom-round right-round extend large-elevate margin grey10 white-text" onclick={async () => await appController.handleRedo()}><i class="fa-solid fa-arrow-rotate-right white-text"></i><span>Redo</span></button>-->
                    </div>
                </div>
                <div class="canvas">
                <!--<div bind:this={appController.appState.canvasState.canvas} onchange={async (e) => { console.log("change"); }}></div>-->
                    <div bind:this={appController.appState.canvasState.canvas} onchange={async (e) => { console.log("change"); }}></div>
                <!--<div bind:this={appController.appState.canvasState.canvas} onchange={async (e) => { console.log("change"); }}></div>-->
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

    i { text-shadow: 0 0 3px; }
    i { text-shadow: 0 0 3px; }
    h5 { text-shadow: 0 0 3px; }
    h5 { text-shadow: 0 0 3px; }
    h6 { text-shadow: 0 0 3px; }
    h6 { text-shadow: 0 0 3px; }
    span { text-shadow: 0 0 3px; }
    span { text-shadow: 0 0 3px; }
    label { text-shadow: 0 0 3px; }
    label { text-shadow: 0 0 3px; }
    input { text-shadow: 0 0 3px; }
    input { text-shadow: 0 0 3px; }
    select { text-shadow: 0 0 3px; }
    select { text-shadow: 0 0 3px; }
    option { text-shadow: 0 0 3px; }
    option { text-shadow: 0 0 3px; }
    progress { text-shadow: 0 0 3px; }
    progress { text-shadow: 0 0 3px; }
    main { overflow: hidden; width: 100vw; height: 100vh; }
    main { overflow: hidden; width: 100vw; height: 100vh; }
    * { scroll-behavior: smooth; }
    * { scroll-behavior: smooth; }
    @font-face { font-family: "SF Mono Regular"; font-weight: normal; font-style: normal; src: url("./assets/fonts/SF-Mono-Regular.otf") format("opentype"); }
    @font-face { font-family: "SF Mono Regular"; font-weight: normal; font-style: normal; src: url("./assets/fonts/SF-Mono-Regular.otf") format("opentype"); }
    * { font-family: "SF Mono Regular", "fontawesome"; }
    * { font-family: "SF Mono Regular", "fontawesome"; }
    .container { width: 100vw; height: 100vh; position: relative; display: flex; flex-direction: column; }
    .container { width: 100vw; height: 100vh; position: relative; display: flex; flex-direction: column; }
    /*
    .headerContainer { width: 100% ; }
    .headerContainer { width: 100% ; }
    .footerContainer { width: 100% ; }
    .footerContainer { width: 100% ; }
    */
    .topBarContainer { width: 100% ; display: flex; flex-direction: row; justify-content: space-between; }
    .topBarContainer { width: 100% ; display: flex; flex-direction: row; justify-content: space-between; }
    .mainBarContainer { width: 100% ; height: 100% ; display: flex; flex-direction: row; }
    .mainBarContainer { width: 100% ; height: 100% ; display: flex; flex-direction: row; }
    .sideBarContainer { width: 025% ; height: 100% ; display: flex; flex-direction: column; order: 2; overflow: hidden; }
    .sideBarContainer { width: 025% ; height: 100% ; display: flex; flex-direction: column; order: 2; overflow: hidden; }
    .canvasContainer { width: 075% ; height: 100% ; display: flex; flex-direction: column; order: 1; }
    .canvasContainer { width: 075% ; height: 100% ; display: flex; flex-direction: column; order: 1; }
    .canvasToolBoxes { width: 100% ; display: flex; flex-direction: row; justify-content: space-between; align-items: center; }
    .canvasToolBoxes { width: 100% ; display: flex; flex-direction: row; justify-content: space-between; align-items: center; }
    .canvas { width: 100% ; height: 100%; display: flex; overflow: auto; flex-grow: 1; }
    .canvas { width: 100% ; height: 100%; display: flex; overflow: auto; flex-grow: 1; }
    .canvas > div { margin: auto; }
    .canvas > div { margin: auto; }
    .dialog { width: 050%; }
    .dialog { width: 050%; }
    .effectContainer { height: auto; min-height: 0; flex-grow: 1; overflow-y: auto; }
    .effectContainer { height: auto; min-height: 0; flex-grow: 1; overflow-y: auto; }
    .dialogSide { width: 030%; }
    .dialogSide { width: 030%; }
    .toolTip { width: 200px; }
    .toolTip { width: 200px; }
    .switch > input:checked + span:after { border: none; background-color: #222222           ;                          box-shadow: 0 0 10px #222222;                               }
    .switch > input:checked + span:after { border: none; background-color: #222222           ;                          box-shadow: 0 0 10px #222222;                               }
    .switch >                 span:after {                   border-color: #222222 !important; background: #ffffff22; box-shadow: 0 0 10px #222222; border-width: 3px !important; }
    .switch >                 span:after {                   border-color: #222222 !important; background: #ffffff22; box-shadow: 0 0 10px #222222; border-width: 3px !important; }

</style>
