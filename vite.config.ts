import { defineConfig, ViteDevServer } from "vite"
import { svelte } from "@sveltejs/vite-plugin-svelte"
import { nodePolyfills } from "vite-plugin-node-polyfills"
import basicSsl from '@vitejs/plugin-basic-ssl'


/** @type {import("vite").Plugin} */
const viteServerConfig = () => ({
  name: "add-headers",
  configureServer: (server: ViteDevServer) => {
    server.middlewares.use((req, res, next) => {
      // res.setHeader("Access-Control-Allow-Origin", "*");
      // res.setHeader("Access-Control-Allow-Methods", "GET");
      // res.setHeader("Cross-Origin-Opener-Policy", "same-origin");
      // res.setHeader("Cross-Origin-Embedder-Policy", "require-corp");
      next();
    });
  }
});

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [svelte(), viteServerConfig(), nodePolyfills(),basicSsl(),],
  server: {
    "host": "192.168.6.150", //YOUR IP-V4
  },
  assetsInclude: ["**/*.glsl"]
});
