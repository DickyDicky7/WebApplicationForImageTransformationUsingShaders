<script lang="ts">
    
  import type { DraggableText } from "./types";
  import type p5 from "p5";
  export let defaultFont: p5.Font = null!;
  import { doHexToRgbNormalized } from "./common";
  import { rgba_ToHexNormalized } from "./common";
  // svelte-ignore export_let_unused
  export let draggableText: DraggableText = {
    colorFilling: { r: 0, g: 0, b: 0, a: 1 },
    colorOutline: { r: 0, g: 0, b: 0, a: 1 },
    fontSize: 24,
    contents: "Text",
    alignHOption: "center",
    alignVOption: "center",
    font: defaultFont,
    stylesOption: "normal",
    positionX: 0,
    positionY: 0,
    dimensionW: 24 * 4,
    dimensionH: 24 * 1,
    isDragging: false,
    offsetX: 0,
    offsetY: 0,
    spacings: 0,
    wrapMode: null!,
  };
</script>

<div>
  <span>Outline color</span>
  <!-- svelte-ignore a11y_consider_explicit_label -->
  <button class="circle slow-ripple">
    <i class="fa-solid fa-palette"></i>
    <input type="color" on:input={async (e: Event & { currentTarget: EventTarget & HTMLInputElement }) => {

    }}/>
  </button>
  <br />
  <span>Filling color</span>
  <!-- svelte-ignore a11y_consider_explicit_label -->
  <button class="circle slow-ripple"
    ><i class="fa-solid fa-palette"></i><input
      type="color"
      on:input={async (
        e: Event & { currentTarget: EventTarget & HTMLInputElement }
      ) => {}}
    />
  </button>
  <br />
  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Font size</span></th>
        <th class="center-align"><span> Spacing </span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="field border"><input type="number" bind:value={draggableText.fontSize} /></div></td>
        <td><div class="field border"><input type="number" bind:value={draggableText.spacings} /></div></td>
      </tr>
    </tbody>
  </table>
  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Content</span></th>
<!--    <th class="center-align"><span>Content</span></th>   -->
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="field border"><input type="text" bind:value={draggableText.contents} /></div></td>
<!--    <td><div class="field border"><input type="text" bind:value={draggableText.contents} /></div></td>    -->
      </tr>
    </tbody>
  </table>

  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Align H</span></th>
        <th class="center-align"><span>Align V</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <div   class="field middle-align">
            <nav class="      center-align">
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 1</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 2</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
            </nav>
          </div>
        </td>
        <td>
          <div   class="field middle-align">
            <nav class="      center-align">
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 1</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 2</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
            </nav>
          </div>
        </td>
      </tr>
    </tbody>
  </table>

  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Wraps Mode</span></th>
        <th class="center-align"><span>Style     </span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <div   class="field middle-align">
            <nav class="      center-align">
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 1</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 2</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
            </nav>
          </div>
        </td>
        <td>
          <div class="field middle-align">
            <nav class="center-align">
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 1</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 2</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
              <label class="radio"><input type="radio" name="radio4_" /><span>Item 3</span></label>
            </nav>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
  <span>Font</span>
  <div class="field suffix round fill small border">
    <select>
      <option>Item 1</option>
      <option>Item 2</option>
      <option>Item 3</option>
    </select>
    <i>arrow_drop_down</i>
  </div>
  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Position X</span></th>
        <th class="center-align"><span>Position Y</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="field border"><input type="number" bind:value={draggableText.positionX} /></div></td>
        <td><div class="field border"><input type="number" bind:value={draggableText.positionY} /></div></td>
      </tr>
    </tbody>
  </table>
  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Dimension W</span></th>
        <th class="center-align"><span>Dimension H</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="field border"><input type="number" bind:value={draggableText.dimensionW} /></div></td>
        <td><div class="field border"><input type="number" bind:value={draggableText.dimensionH} /></div></td>
      </tr>
    </tbody>
  </table>
</div>
