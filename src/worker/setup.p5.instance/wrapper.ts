    import p5 from "p5";
//  import p5 from "p5";
    import { type SetupP5InstanceWorkerMessage } from "./shared";
//  import { type SetupP5InstanceWorkerMessage } from "./shared";

    export default class SetupP5InstanceWorkerWrapper {
//  export default class SetupP5InstanceWorkerWrapper {
        private worker: Worker;
//      private worker: Worker;

        constructor() {
//      constructor() {
            this.worker = new Worker(new URL("./worker.ts", import.meta.url), { type: "module" });
//          this.worker = new Worker(new URL("./worker.ts", import.meta.url), { type: "module" });
        }
//      }

        public async setupP5Instance(sketch?: (p: p5) => void, node?: HTMLElement, sync?: boolean): Promise<p5> {
//      public async setupP5Instance(sketch?: (p: p5) => void, node?: HTMLElement, sync?: boolean): Promise<p5> {
            return new Promise((resolve, reject): void => {
//          return new Promise((resolve, reject): void => {
                const listener = (e: MessageEvent<p5>): void => {
//              const listener = (e: MessageEvent<p5>): void => {
                    this.worker.removeEventListener("message", listener);
//                  this.worker.removeEventListener("message", listener);
                    this.worker.removeEventListener("error", errorListener);
//                  this.worker.removeEventListener("error", errorListener);
                    resolve(e.data);
//                  resolve(e.data);
                }
//              }

                const errorListener = (e: ErrorEvent): void => {
//              const errorListener = (e: ErrorEvent): void => {
                    this.worker.removeEventListener("message", listener);
//                  this.worker.removeEventListener("message", listener);
                    this.worker.removeEventListener("error", errorListener);
//                  this.worker.removeEventListener("error", errorListener);
                    reject(e);
//                  reject(e);
                }
//              }

                this.worker.addEventListener("message", listener);
//              this.worker.addEventListener("message", listener);
                this.worker.addEventListener("error", errorListener);
//              this.worker.addEventListener("error", errorListener);

                this.worker.postMessage({
//              this.worker.postMessage({
                    sketch: sketch,
//                  sketch: sketch,
                    node: node,
//                  node: node,
                    sync: sync,
//                  sync: sync,
                } as SetupP5InstanceWorkerMessage);
//              } as SetupP5InstanceWorkerMessage);
            });
//          });
        }
//      }

        public terminate() {
//      public terminate() {
            this.worker.terminate();
//          this.worker.terminate();
        }
//      }
    }
//  }
