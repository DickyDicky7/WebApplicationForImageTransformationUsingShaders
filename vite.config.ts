    import { defineConfig } from "vite";
//  import { defineConfig } from "vite";
    import { svelte } from "@sveltejs/vite-plugin-svelte";
//  import { svelte } from "@sveltejs/vite-plugin-svelte";
    import { nodePolyfills } from "vite-plugin-node-polyfills";
//  import { nodePolyfills } from "vite-plugin-node-polyfills";

    // https://vite.dev/config/
//  // https://vite.dev/config/
    export default defineConfig({
//  export default defineConfig({
        plugins: [
//      plugins: [
            svelte(),
//          svelte(),
            nodePolyfills(),
//          nodePolyfills(),
        ],
//      ],
        build: {
//      build: {
            target: "es2020",
//          target: "es2020",
        },
//      },
    });
//  });
