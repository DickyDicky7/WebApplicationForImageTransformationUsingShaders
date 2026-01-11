    import * as types from "../types";
//  import * as types from "../types";

    export default class UIState {
//  export default class UIState {
        input: HTMLInputElement = $state<HTMLInputElement>(null!);
//      input: HTMLInputElement = $state<HTMLInputElement>(null!);
        imageFormatSelection: HTMLSelectElement = $state<HTMLSelectElement>(null!);
//      imageFormatSelection: HTMLSelectElement = $state<HTMLSelectElement>(null!);
        videoFormatSelection: HTMLSelectElement = $state<HTMLSelectElement>(null!);
//      videoFormatSelection: HTMLSelectElement = $state<HTMLSelectElement>(null!);
        videoProgressSlider_: HTMLProgressElement = $state<HTMLProgressElement>(null!);
//      videoProgressSlider_: HTMLProgressElement = $state<HTMLProgressElement>(null!);
        AIInputPrompts: HTMLInputElement = $state<HTMLInputElement>(null!);
//      AIInputPrompts: HTMLInputElement = $state<HTMLInputElement>(null!);
        cachedSelectedIndex: number = $state<number>(0);
//      cachedSelectedIndex: number = $state<number>(0);
        /*
        draggableText: types.DraggableText = $state<types.DraggableText>(null!);
//      draggableText: types.DraggableText = $state<types.DraggableText>(null!);
        */
        bigList: HTMLDivElement = $state<HTMLDivElement>(null!);
//      bigList: HTMLDivElement = $state<HTMLDivElement>(null!);
        isLoading: boolean = $state<boolean>(false);
//      isLoading: boolean = $state<boolean>(false);
        isInitializing: boolean = $state<boolean>(true);
//      isInitializing: boolean = $state<boolean>(true);
    }
//  }
