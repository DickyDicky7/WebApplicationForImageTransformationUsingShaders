    import p5 from "p5";
//  import p5 from "p5";

    export default class CanvasState {
//  export default class CanvasState {
        defaultFont: p5.Font = $state<p5.Font>(null!);
//      defaultFont: p5.Font = $state<p5.Font>(null!);
        canvasBG: HTMLElement = $state<HTMLElement>(null!);
//      canvasBG: HTMLElement = $state<HTMLElement>(null!);
        canvas: HTMLElement = $state<HTMLElement>(null!);
//      canvas: HTMLElement = $state<HTMLElement>(null!);
        canvasInstanceBG: p5 = $state<p5>(null!);
//      canvasInstanceBG: p5 = $state<p5>(null!);
        canvasInstance: p5 = $state<p5>(null!);
//      canvasInstance: p5 = $state<p5>(null!);
        /*
        bufferInstance: p5.Graphics = $state<p5.Graphics>(null!);
//      bufferInstance: p5.Graphics = $state<p5.Graphics>(null!);
        */
        /*
        graphicsObj: p5.Graphics = $state<p5.Graphics>(null!);
//      graphicsObj: p5.Graphics = $state<p5.Graphics>(null!);
        */
    }
//  }
