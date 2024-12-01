<script lang="ts">
    export let data ;
    import   p5        from "p5";
    import { onMount } from "svelte";

    let canvas: HTMLElement;
    let canvasInstance: p5;
    let i: p5.Image;
    let fps: number = 120;
    let noiseT1:p5.Image;
    let noiseT2:p5.Image;
    let gradient:p5.Image;
    let ascii_tex:p5.Image;
    let tile:p5.Image;
    let bayer:p5.Image;
    let u_bgTexture:p5.Image;
    let u_patternTexture:p5.Image;

    const DEFAULT_CANVAS_SIZE = { WIDTH: 300, HEIGHT: 300 };
    const DPR = window.devicePixelRatio || 1;
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
    onMount(async ()  : Promise<void> => {
    console.log("on mount");
        canvasInstance = new p5(p5Logic, canvas);
        await ui("theme", "#009688")
        
    });
</script>
<div class="canvas">
    <div class="canvas1">
        <div>

        </div>
        <div class="buttonContainer">
            <button class="button">
                <span class="material-icons">history</span>
            </button>
            <button class="button">
                <span class="material-icons">undo</span>
            </button>
            <button class="button">
                <span class="material-icons">redo</span>
            </button>
        </div>
    </div>  
    <div class="canvas2">
        <div bind:this={canvas} on:change={()=>{console.log("change")}}></div>
    </div>
</div>
<style>
    .canvas {
        width: 100%;
        height: 100%;
        border: solid 1px;
        display: flex;
        flex-direction: column;
    }
    .canvas1 {
        width: 100%;
        height: 30%;
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        border: solid 1px;
    }
    .canvas2{
        width: 100%;
        height: 70%;
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: center;
    }
    .buttonContainer {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        padding: 10px;
    }
    .button {
        width: 40px; 
        height: 40px; 
        border-radius: 50%; 
        background-color: #007BFF; 
        padding: 0;
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
</style>