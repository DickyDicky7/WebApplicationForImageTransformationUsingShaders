    import p5 from "p5";
//  import p5 from "p5";

    export default class MediaState {
//  export default class MediaState {
        downloadStream: MediaStream = $state<MediaStream>(null!);
//      downloadStream: MediaStream = $state<MediaStream>(null!);
        /*
        downloadStreamWebCam: MediaStream = $state<MediaStream>(null!);
//      downloadStreamWebCam: MediaStream = $state<MediaStream>(null!);
        videoStream: MediaStream = $state<MediaStream>(null!);
//      videoStream: MediaStream = $state<MediaStream>(null!);
        audioStream: MediaStream = $state<MediaStream>(null!);
//      audioStream: MediaStream = $state<MediaStream>(null!);
        */
        mediaRecorder: MediaRecorder = $state<MediaRecorder>(null!);
//      mediaRecorder: MediaRecorder = $state<MediaRecorder>(null!);
        mediaRecorderWebCam: MediaRecorder = $state<MediaRecorder>(null!);
//      mediaRecorderWebCam: MediaRecorder = $state<MediaRecorder>(null!);
        video_FileBLOB: string = $state<string>(null!);
//      video_FileBLOB: string = $state<string>(null!);
        /*
        image_FileBLOB: string = $state<string>(null!);
//      image_FileBLOB: string = $state<string>(null!);
        */
        video: p5.MediaElement = $state<p5.MediaElement>(null!);
//      video: p5.MediaElement = $state<p5.MediaElement>(null!);
        /*
        image: p5.MediaElement = $state<p5.MediaElement>(null!);
//      image: p5.MediaElement = $state<p5.MediaElement>(null!);
        */
        catchFirstTime: boolean = $state<boolean>(false);
//      catchFirstTime: boolean = $state<boolean>(false);
        startRecord: boolean = $state<boolean>(!false);
//      startRecord: boolean = $state<boolean>(!false);
        ceaseRecord: boolean = $state<boolean>(false);
//      ceaseRecord: boolean = $state<boolean>(false);
        fshotRecord: boolean = $state<boolean>(false);
//      fshotRecord: boolean = $state<boolean>(false);
        sshotRecord: boolean = $state<boolean>(false);
//      sshotRecord: boolean = $state<boolean>(false);
        webcamCapture: p5.Element = $state<p5.Element>(null!);
//      webcamCapture: p5.Element = $state<p5.Element>(null!);
        videoToShare: Blob = $state<Blob>(null!);
//      videoToShare: Blob = $state<Blob>(null!);
        imageToShare: Blob = $state<Blob>(null!);
//      imageToShare: Blob = $state<Blob>(null!);
        videoIsPlaying: boolean = $state<boolean>(false);
//      videoIsPlaying: boolean = $state<boolean>(false);
        imageIsPlaying: boolean = $state<boolean>(false);
//      imageIsPlaying: boolean = $state<boolean>(false);
        recording: boolean = $state<boolean>(false);
//      recording: boolean = $state<boolean>(false);
    }
//  }
