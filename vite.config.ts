import { defineConfig , ViteDevServer } from "vite"; import { svelte } from "@sveltejs/vite-plugin-svelte"; import { nodePolyfills } from "vite-plugin-node-polyfills"; import basicSsl from "@vitejs/plugin-basic-ssl";


/** @type {import("vite").Plugin} */
/** @type {import("vite").Plugin} */
/** @type {import("vite").Plugin} */
const viteServerConfig = () => ({
    name: "add-headers"     ,
    configureServer: (server: ViteDevServer) => {
                      server.middlewares.use((req, res, next) => {
            // res.setHeader("Access-Control-Allow-Origin", "*");
            // res.setHeader("Access-Control-Allow-Origin", "*");
            // res.setHeader("Access-Control-Allow-Methods", "GET");
            // res.setHeader("Access-Control-Allow-Methods", "GET");
            // res.setHeader("Cross-Origin-Opener-Policy", "same-origin");
            // res.setHeader("Cross-Origin-Opener-Policy", "same-origin");
            // res.setHeader("Cross-Origin-Embedder-Policy", "require-corp");
            // res.setHeader("Cross-Origin-Embedder-Policy", "require-corp");
            next();
        });
    }
});

// https://vitejs.dev/config/
// https://vitejs.dev/config/
// https://vitejs.dev/config/
export default defineConfig({
       plugins: [          svelte({ compilerOptions: { compatibility: { componentApi: 4 } } })
              ,  viteServerConfig()
              ,  nodePolyfills()
              ,          basicSsl()
              , ]
              ,
server        : {
        "host": "192.168.1.2"
              , //YOUR IPV4ADRR
                }
              ,
 assetsInclude: [ "**/*.glsl"
              ,   "**/*.hlsl"
              , ]
              ,
});







