    import CanvasState from "./canvas.svelte";
//  import CanvasState from "../canvas.svelte";
    import MediaState from "./media.svelte";
//  import MediaState from "../media.svelte";
    import UIState from "./ui.svelte";
//  import UIState from "../ui.svelte";
    import SettingsState from "./settings.svelte";
//  import SettingsState from "../settings.svelte";

    export default class AppState {
//  export default class AppState {
        canvasState: CanvasState = new CanvasState();
//      canvasState: CanvasState = new CanvasState();
        mediaState: MediaState = new MediaState();
//      mediaState: MediaState = new MediaState();
        uiState: UIState = new UIState();
//      uiState: UIState = new UIState();
        settingsState: SettingsState = new SettingsState();
//      settingsState: SettingsState = new SettingsState();
    }
//  }
