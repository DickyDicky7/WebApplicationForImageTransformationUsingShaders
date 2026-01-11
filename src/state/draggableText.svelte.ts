    import p5 from "p5";
//  import p5 from "p5";

    export default class DraggableTextState {
//  export default class DraggableTextState {
        fontFaceSelectedIndex: number = $state<number>(0);
//      fontFaceSelectedIndex: number = $state<number>(0);
        defaultFont: p5.Font = $state<p5.Font>(null!);
//      defaultFont: p5.Font = $state<p5.Font>(null!);

        constructor(font: p5.Font) {
//      constructor(font: p5.Font) {
            this.defaultFont = font;
//          this.defaultFont = font;
        }
//      }
    }
//  }
