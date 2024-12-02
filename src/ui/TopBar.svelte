<script lang="ts">
    import { MODE } from "../types";

    export let imageFormatSelection;
    export let videoFormatSelection;
    export let imageFormats;
    export let videoFormats;
    export let mode: MODE;
    export let shareImage: () => Promise<void>;
    export let shareVideo: () => Promise<void>;
    export let startWebCam: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => Promise<void>;
    export let stopWebCam: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => void;
    export let saveImage: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => void;
    export let saveVideo: (e: MouseEvent & { currentTarget: EventTarget & HTMLButtonElement; }) => void;

    let isWebCamOn = false; 
    let isDialogShow = false;
    function save(){
        isDialogShow = false;
        if (mode === MODE.IMAGE){
            saveImage;
        }
        else {
            saveVideo;
        }
    }
    function share(){
        if (mode === MODE.IMAGE){
            shareImage;
        }
        else {
            shareVideo;
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
    <button class="primary-container">
        <i>upload</i>
        <span>Upload Image Or Video</span>
        <slot></slot>
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
        class="primary-container"
        on:click={() => {isDialogShow = true;}}>
        <i>download</i>
        <span>Download</span>
    </button>
    <button 
        class="primary-container"
        on:click={share}>
        <i>share</i>
        <span>Share</span>
    </button>
</div>
{#if isDialogShow}
    <div class="dialog">
        <div class="background padding absolute middle center round dialogContent">
            {#if mode === MODE.IMAGE}
                <div class="field label suffix round border">
                    <select bind:this={imageFormatSelection}>
                    {#each imageFormats as imageFormat (imageFormat)}
                        <option>{imageFormat.extension}</option>
                    {/each}
                    </select>
                    <label>Image Format</label>
                    <i>arrow_drop_down</i>
                </div>
            {:else if mode === MODE.VIDEO}
                <div class="field label suffix round border">
                    <select bind:this={videoFormatSelection}>
                    {#each videoFormats as videoFormat (videoFormat)}
                        <option>{videoFormat.mimeType}</option>            
                    {/each}
                    </select>
                    <label>Video Format</label>
                    <i>arrow_drop_down</i>
                </div>
            {/if}
            <div class="actions">
                <button 
                    class="responsive primary-container"
                    on:click={save}>
                    <span>Save</span>
                </button>
                <button 
                    class="responsive primary-container"
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