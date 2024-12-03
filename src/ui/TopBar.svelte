<script lang="ts">
    import { MODE } from "../types";

    export let mode: MODE;
    export let shareImage: () => Promise<void>;
    export let shareVideo: () => Promise<void>;
    export let startWebCam: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => Promise<void>;
    export let stopWebCam: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => void;
    export let saveImage: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => void;
    export let saveVideo: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => void;

    let isWebCamOn = false; 
    let isDialogShow = false;
    const save = async(e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => {
        isDialogShow = false;
        if (mode === MODE.IMAGE){
            saveImage(e);
        }
        else {
            saveVideo(e);
        }
    }
    const share = async() => {
        if (mode === MODE.IMAGE){
            shareImage();
        }
        else {
            shareVideo();
        }
    }
    $: {
        if (isWebCamOn){
            startWebCam;
        }
        else{
            stopWebCam;
        }
    }
</script>
<div class="row">
    <button class="">
        <i>upload</i>
        <span>Upload Image Or Video</span>
        <slot name="file-input"></slot>
    </button>
    <div class="row middle-align center-align">
        <label class="switch icon">
            <input type="checkbox" bind:checked={isWebCamOn}>
            <span>
                <i>camera_video</i>
            </span>
        </label>
        <span>WebCam</span>
    </div>
</div>
<div>
    <button 
        class=""
        on:click={() => {isDialogShow = true;}}>
        <i>download</i>
        <span>Download</span>
    </button>
    <button 
        class=""
        on:click={share}>
        <i>share</i>
        <span>Share</span>
    </button>
</div>
{#if isDialogShow}
    <div class="dialog">
        <div class="background padding absolute middle center round dialogContent">
            {#if mode === MODE.IMAGE}
                <slot name="image-format-selection"></slot>
            {:else if mode === MODE.VIDEO}
                <slot name="video-format-selection"></slot>
            {/if}
            <div class="actions">
                <button 
                    class="responsive "
                    on:click={save}>
                    <span>Save</span>
                </button>
                <button 
                    class="responsive "
                    on:click={() => {isDialogShow = false;}}>
                    <span>Cancel</span>
                </button>
            </div>
        </div>
    </div>
{/if}
<style>
    .dialog {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); 
        z-index: 10;
    }
    .dialogContent{
        width: 30%;
        z-index: 15;
    }
    .actions {
        display: flex;
        flex-direction: row;
        justify-content: center;
    }
</style>