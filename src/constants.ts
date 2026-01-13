    // Global Variables & Constants
//  // Global Variables & Constants
    export const DEFAULT_CANVAS_SIZE = { WIDTH_: 500, HEIGHT: 500, };
//  export const DEFAULT_CANVAS_SIZE = { WIDTH_: 500, HEIGHT: 500, };
    export const DPR: number = window.devicePixelRatio || 1;
//  export const DPR: number = window.devicePixelRatio || 1;
    /*
    export const DPR: number = window.devicePixelRatio || 2;
//  export const DPR: number = window.devicePixelRatio || 2;
    */

    export const videoFormats = [
//  export const videoFormats = [
        { mimeType: "video/webm; codecs=vp9", extension: "webm", blobType: "video/webm", },
//      { mimeType: "video/webm; codecs=vp9", extension: "webm", blobType: "video/webm", },
        { mimeType: "video/mp4; codecs=avc1", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=avc1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=hev1", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=hev1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=hvc1", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=hvc1", extension: "mp4" , blobType: "video/mp4" , },
        { mimeType: "video/mp4; codecs=mp4v", extension: "mp4" , blobType: "video/mp4" , },
//      { mimeType: "video/mp4; codecs=mp4v", extension: "mp4" , blobType: "video/mp4" , },
    ] as const;
//  ] as const;

    export const imageFormats = [
//  export const imageFormats = [
        { extension: "png" , blobType: "image/png" , },
//      { extension: "png" , blobType: "image/png" , },
        { extension: "jpeg", blobType: "image/jpeg", },
//      { extension: "jpeg", blobType: "image/jpeg", },
        { extension: "webp", blobType: "image/webp", },
//      { extension: "webp", blobType: "image/webp", },
        { extension: "jpg" , blobType: "image/jpg" , },
//      { extension: "jpg" , blobType: "image/jpg" , },
    ] as const;
//  ] as const;

    export const bgURLs: string[] = [
//  export const bgURLs: string[] = [
        "/shadertoy/bg1.1.glsl",
//      "/shadertoy/bg1.1.glsl",
        "/shadertoy/bg2.1.glsl",
//      "/shadertoy/bg2.1.glsl",
        "/shadertoy/bg2.2.glsl",
//      "/shadertoy/bg2.2.glsl",
        "/shadertoy/bg2.3.glsl",
//      "/shadertoy/bg2.3.glsl",
        "/shadertoy/bg2.4.glsl",
//      "/shadertoy/bg2.4.glsl",
        "/shadertoy/bg3.1.glsl",
//      "/shadertoy/bg3.1.glsl",
        "/shadertoy/bg4.1.glsl",
//      "/shadertoy/bg4.1.glsl",
        "/shadertoy/bg5.1.glsl",
//      "/shadertoy/bg5.1.glsl",
        "/shadertoy/bg6.1.glsl",
//      "/shadertoy/bg6.1.glsl",
        "/shadertoy/bg7.1.glsl",
//      "/shadertoy/bg7.1.glsl",
        "/shadertoy/bg8.1.glsl",
//      "/shadertoy/bg8.1.glsl",
        "/shadertoy/bg9.1.glsl",
//      "/shadertoy/bg9.1.glsl",
        "/shadertoy/bg11.1.glsl",
//      "/shadertoy/bg11.1.glsl",
        "/shadertoy/bg12.1.glsl",
//      "/shadertoy/bg12.1.glsl",
        "/shadertoy/bg13.1.glsl",
//      "/shadertoy/bg13.1.glsl",
    ] as const;
//  ] as const;
