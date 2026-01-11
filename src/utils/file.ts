    import * as global from "../state/global.svelte";
//  import * as global from "../state/global.svelte";

    function blobToBase64(blob: Blob): Promise<string> {
//  function blobToBase64(blob: Blob): Promise<string> {
        return new Promise((resolve, rejects) => {
//      return new Promise((resolve, rejects) => {
            const reader: FileReader = new FileReader();
//          const reader: FileReader = new FileReader();
            reader.onloadend = () => {
//          reader.onloadend = () => {
                if (reader.result) {
//              if (reader.result) {
                    resolve((reader.result as string).split(",")[1]);
//                  resolve((reader.result as string).split(",")[1]);
                } else {
//              } else {
                    rejects(new Error("FileReader result is null!"));
//                  rejects(new Error("FileReader result is null!"));
                }
//              }
            };
//          };
            reader.onerror = () => rejects(new Error("Failed to read the Blob as a Data URL"));
//          reader.onerror = () => rejects(new Error("Failed to read the Blob as a Data URL"));
            reader.readAsDataURL(blob);
//          reader.readAsDataURL(blob);
        });
//      });
    }
//  }

    export async function shareImage(
//  export async function shareImage(
        htmlCanvasElement: HTMLCanvasElement,
//      htmlCanvasElement: HTMLCanvasElement,
        name: string = "image_name.png",
//      name: string = "image_name.png",
        title: string = "image_title",
//      title: string = "image_title",
        description: string = "image_description",
//      description: string = "image_description",
        text: string = "image_text",
//      text: string = "image_text",
    ): Promise<void> {
//  ): Promise<void> {
        const uploadResult = await global.imgurClient.upload({
//      const uploadResult = await global.imgurClient.upload({
            image: htmlCanvasElement.toDataURL("image/png", 1.0).split(",")[1],
//          image: htmlCanvasElement.toDataURL("image/png", 1.0).split(",")[1],
            type: "base64",
//          type: "base64",
            name: name,
//          name: name,
            title: title,
//          title: title,
            description: description,
//          description: description,
            disable_audio: "1",
//          disable_audio: "1",
        });
//      });
        console.info(uploadResult.data);
//      console.info(uploadResult.data);
        window.navigator.share({
//      window.navigator.share({
            title: title,
//          title: title,
            text: text,
//          text: text,
            url: uploadResult.data.link,
//          url: uploadResult.data.link,
        });
//      });
    }
//  }

    export async function shareVideo(
//  export async function shareVideo(
        shareVideoBlob: Blob,
//      shareVideoBlob: Blob,
        htmlCanvasElement: HTMLCanvasElement,
//      htmlCanvasElement: HTMLCanvasElement,
        name: string = "video_name.mp4",
//      name: string = "video_name.mp4",
        title: string = "video_title",
//      title: string = "video_title",
        description: string = "video_description",
//      description: string = "video_description",
        text: string = "video_text",
//      text: string = "video_text",
    ): Promise<void> {
//  ): Promise<void> {
        const uploadResult = await global.imgurClient.upload({
//      const uploadResult = await global.imgurClient.upload({
            image: await blobToBase64(shareVideoBlob),
//          image: await blobToBase64(shareVideoBlob),
            type: "base64",
//          type: "base64",
            name: name,
//          name: name,
            title: title,
//          title: title,
            description: description,
//          description: description,
            disable_audio: "1",
//          disable_audio: "1",
        });
//      });
        console.info(uploadResult.data);
//      console.info(uploadResult.data);
        window.navigator.share({
//      window.navigator.share({
            title: title,
//          title: title,
            text: text,
//          text: text,
            url: uploadResult.data.link,
//          url: uploadResult.data.link,
        });
//      });
    }
//  }

    export async function shareWebcam(
//  export async function shareWebcam(
        shareWebcamBlob: Blob,
//      shareWebcamBlob: Blob,
        htmlCanvasElement: HTMLCanvasElement,
//      htmlCanvasElement: HTMLCanvasElement,
        name: string = "video_name.mp4",
//      name: string = "video_name.mp4",
        title: string = "video_title",
//      title: string = "video_title",
        description: string = "video_description",
//      description: string = "video_description",
        text: string = "video_text",
//      text: string = "video_text",
    ): Promise<void> {
//  ): Promise<void> {
        const uploadResult = await global.imgurClient.upload({
//      const uploadResult = await global.imgurClient.upload({
            image: await blobToBase64(shareWebcamBlob),
//          image: await blobToBase64(shareWebcamBlob),
            type: "base64",
//          type: "base64",
            name: name,
//          name: name,
            title: title,
//          title: title,
            description: description,
//          description: description,
            disable_audio: "1",
//          disable_audio: "1",
        });
//      });
        console.info(uploadResult.data);
//      console.info(uploadResult.data);
        window.navigator.share({
//      window.navigator.share({
            title: title,
//          title: title,
            text: text,
//          text: text,
            url: uploadResult.data.link,
//          url: uploadResult.data.link,
        });
//      });
    }
//  }
