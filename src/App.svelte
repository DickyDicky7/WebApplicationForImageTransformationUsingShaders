<script lang="ts">
  import svelteLogo from "./assets/svelte.svg";
  import vitejsLogo from           "/vite.svg";
  import  Counter   from                       "./lib/Counter.svelte";
  import "beercss";
  import "material-dynamic-colors"; 

  import p5 from      "p5";
  import { onMount } from "svelte";
  const  p5Logic = (p: p5) =>
  {
    p.setup = () =>
    {
      p.createCanvas(400, 400);
    };

    p. draw = () =>
    {
      p.background  (220     );
      p.ellipse(p.mouseX,
                p.mouseY,
                      50,
                      50);
    };
  };
  let canvas        :  HTMLElement;
  let canvasInstance:  p5         ;
  onMount(() =>
  {
      canvasInstance = new p5(p5Logic, canvas);
  });

</script>

<main>
  <div bind:this={canvas} on:click={(e) => { canvasInstance.saveCanvas(); }}></div>

  <div>
    <a href="https://vitejs.dev" target="_blank" rel="noreferrer">
      <img src={vitejsLogo} class="logo  vitejs" alt="ViteJS Logo" />
    </a>
    <a href="https://svelte.dev" target="_blank" rel="noreferrer">
      <img src={svelteLogo} class="logo  svelte" alt="Svelte Logo" />
    </a>
  </div>
  <h1>Vite + Svelte</h1>

  <div class="card">
    <Counter />
  </div>

  <p>
    Check out <a href="https://github.com/sveltejs/kit#readme" target="_blank" rel="noreferrer">SvelteKit</a>, the official Svelte app framework powered by Vite!
  </p>

  <p class="read-the-docs">
    Click on the Vite and Svelte logos to learn more
  </p>
</main>

<style>
  .logo
  {
     height: 6.0em;
    padding: 1.5em;
    will-change: filter      ;
     transition: filter 300ms;
  }
  .logo.vitejs:hover
  {
    filter: drop-shadow(0 0 2em #646cffaa);
  }
  .logo.svelte:hover
  {
    filter: drop-shadow(0 0 2em #ff3e00aa);
  }
  .read-the-docs
  {
    color: #888;
  }
</style>
