    import * as types from "../types";
//  import * as types from "../types";

    export default class SettingsState {
//  export default class SettingsState {
        fps: number = $state<number>(120);
//      fps: number = $state<number>(120);
        mode: types.MODE = $state<types.MODE>(types.MODE.IMAGE);
//      mode: types.MODE = $state<types.MODE>(types.MODE.IMAGE);
        /*
        modeCaptureImage: types.MODE_CAPTURE_IMAGE = $state<types.MODE_CAPTURE_IMAGE>(types.MODE_CAPTURE_IMAGE.AS_IMAGE);
//      modeCaptureImage: types.MODE_CAPTURE_IMAGE = $state<types.MODE_CAPTURE_IMAGE>(types.MODE_CAPTURE_IMAGE.AS_IMAGE);
        modeCaptureVideo: types.MODE_CAPTURE_VIDEO = $state<types.MODE_CAPTURE_VIDEO>(types.MODE_CAPTURE_VIDEO.AS_VIDEO_FULLSHOT);
//      modeCaptureVideo: types.MODE_CAPTURE_VIDEO = $state<types.MODE_CAPTURE_VIDEO>(types.MODE_CAPTURE_VIDEO.AS_VIDEO_FULLSHOT);
        */
        selectedCaptureOption: string = $state<string>("Snapshot");
//      selectedCaptureOption: string = $state<string>("Snapshot");
    }
//  }
