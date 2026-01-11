    import p5 from "p5";
//  import p5 from "p5";

    interface SetupP5InstanceWorkerMessage {
//  interface SetupP5InstanceWorkerMessage {
        sketch?: (p: p5) => void;
//      sketch?: (p: p5) => void;
        node?: HTMLElement;
//      node?: HTMLElement;
        sync?: boolean;
//      sync?: boolean;
    }
//  }

    export {
//  export {
        type SetupP5InstanceWorkerMessage,
//      type SetupP5InstanceWorkerMessage,
    }
//  }
