/// <reference lib="webworker" />
/// <reference lib="webworker" />

    import p5 from "p5";
//  import p5 from "p5";
    import { type SetupP5InstanceWorkerMessage } from "./shared";
//  import { type SetupP5InstanceWorkerMessage } from "./shared";

    self.onmessage = (messageEvent: MessageEvent<SetupP5InstanceWorkerMessage>) => {
//  self.onmessage = (messageEvent: MessageEvent<SetupP5InstanceWorkerMessage>) => {
        const setupP5InstanceWorkerMessage: SetupP5InstanceWorkerMessage = messageEvent.data;
//      const setupP5InstanceWorkerMessage: SetupP5InstanceWorkerMessage = messageEvent.data;
        const p5Instance: p5 = new p5(
//      const p5Instance: p5 = new p5(
            setupP5InstanceWorkerMessage.sketch,
//          setupP5InstanceWorkerMessage.sketch,
            setupP5InstanceWorkerMessage.node,
//          setupP5InstanceWorkerMessage.node,
            setupP5InstanceWorkerMessage.sync,
//          setupP5InstanceWorkerMessage.sync,
        );
//      );
        self.postMessage(p5Instance);
//      self.postMessage(p5Instance);
    }
//  }
