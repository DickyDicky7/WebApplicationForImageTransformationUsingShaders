<script lang="ts">
    import type { DraggableText } from "./types";

    export let draggableText: DraggableText = null!;

</script>

<div>
    <span>Outline color</span>
    <button class="circle slow-ripple"><i class="fa-solid fa-palette"></i><input type="color" on:input={ async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => {
        
          }}>
    </button>
    <br>
    <span>Filling color</span>
    <button class="circle slow-ripple"><i class="fa-solid fa-palette"></i><input type="color" on:input={ async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => {
        
          }}>
    </button>
    <br>
    <span>Font size</span>
    <div class="field border">
        <input type="text">
      </div>
    
    <span>Content</span>
    <div class="field border">
        <input type="text">
      </div>
      
      <span>Align H</span>
      <div class="field middle-align">
        <nav>
          <label class="radio">
            <input type="radio" name="radio4_">
            <span>Item 1</span>
          </label>
          <label class="radio">
            <input type="radio" name="radio4_">
            <span>Item 2</span>
          </label>
          <label class="radio">
            <input type="radio" name="radio4_">
            <span>Item 3</span>
          </label>
        </nav>
      </div>

      <span>Align V</span>
      <div class="field middle-align">
        <nav>
          <label class="radio">
            <input type="radio" name="radio4_">
            <span>Item 1</span>
          </label>
          <label class="radio">
            <input type="radio" name="radio4_">
            <span>Item 2</span>
          </label>
          <label class="radio">
            <input type="radio" name="radio4_">
            <span>Item 3</span>
          </label>
        </nav>
      </div>
</div>