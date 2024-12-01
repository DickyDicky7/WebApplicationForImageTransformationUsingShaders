<script lang="ts">
    let showDialog = false;
    function openDialog(){
        showDialog = true;
    }
    function closeDialog(){
        showDialog = false;
    }
    let imageFormatSelection: HTMLSelectElement;
    let videoFormatSelection: HTMLSelectElement;
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
</script>
<div class="topBar">
    <button class="button">
        <span class="material-icons">upload</span>Load Image Or Video
    </button>
    <div>
        <button 
            class="button"
            on:click={openDialog}>
            <span class="material-icons">download</span>Save Image Or Video
        </button>
        <button class="button">
            <span class="material-icons">share</span>Share
        </button>
    </div>
</div>
{#if showDialog}
    <div class="dialog">
        <div class="dialogContent">
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
            <div class="actions">
                <button 
                    class="button"
                    on:click={closeDialog}>
                    Save
                </button>
                <button 
                    class="button"
                    on:click={closeDialog}>
                    Cancel
                </button>
            </div>
        </div>
    </div>
{/if}
<style>
    .topBar {
        width: 100%;
        padding: 10px;
        justify-content: space-between;
        display: flex;
        flex-direction: row;
    }
    .button {
        border-radius: 15px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); 
        transition: background-color 0.3s ease, transform 0.2s ease;
    }
    .button:hover {
        background-color: #0056b3; 
        transform: scale(1.1); 
    }
    .material-icons {
        font-size: 20px; 
    }
    .dialog {
        display: flex;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); 
        justify-content: center;
        align-items: center;
    }
    .dialogContent {
        background-color: white;
        padding: 40px;
        border-radius: 20px;
        width: 30%;
    }
    .actions {
        margin-top: 20px;
        display: flex;
        flex-direction: row;
        justify-content: center;
    }
</style>