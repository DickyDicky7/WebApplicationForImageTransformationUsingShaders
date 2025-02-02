<script lang="ts">
  
  import type { DraggableText } from "./types";
//import type { DraggableText } from "./types";
  import type   p5              from "p5"     ;
//import type   p5              from "p5"     ;
  export let canvasInstance: p5 = null!;
//export let canvasInstance: p5 = null!;
  import { doHexToRgbNormalized } from "./common";
//import { doHexToRgbNormalized } from "./common";
  import { rgba_ToHexNormalized } from "./common";
//import { rgba_ToHexNormalized } from "./common";
  import { noHexToRgbNormalized } from "./common";
//import { noHexToRgbNormalized } from "./common";
  import { customFonts          } from "./global";
//import { customFonts          } from "./global";
  export let draggableText:
             DraggableText = {
    colorFilling: { r: 0, g: 0, b: 0, a: 255 },
    colorOutline: { r: 0, g: 0, b: 0, a: 255 },
    fontSize    : 24                          ,
    contents    : "Text"                      ,
    alignHOption: "center"                    ,
    alignVOption: "center"                    ,
    font        : null!                       ,
    stylesOption: "normal"                    ,
    positionX   : 0                           ,
    positionY   : 0                           ,
    dimensionW  : 24 * 4                      ,
    dimensionH  : 24 * 1                      ,
    isDragging  : false                       ,
    offsetX     : 0                           ,
    offsetY     : 0                           ,
    spacings    : 24                          ,
    wrapMode    : null!                       ,
  };
  //https://p5js.org/reference/p5/drawingContext/
  //https://p5js.org/reference/p5/drawingContext/
  //https://p5js.org/reference/p5/drawingContext/
  //https://www.youtube.com/watch?v=iIWH3IUYHzM
  //https://www.youtube.com/watch?v=iIWH3IUYHzM
  //https://www.youtube.com/watch?v=iIWH3IUYHzM
</script>

<div    >
<!--
  <span>Outline color</span>
--->
  <!-- svelte-ignore a11y_consider_explicit_label -->
<!--
  <button class="circle slow-ripple"><i class="fa-solid fa-palette"></i><input type="color" on:input={async (e: Event & { currentTarget: EventTarget & HTMLInputElement }) => { const { r, g, b, } = await noHexToRgbNormalized(e.currentTarget.value); draggableText.colorOutline = { r, g, b, a: draggableText.colorOutline.a, }; }}/></button>
  <br />
--->  
  <div class="row responsive">
    <div class="field border textarea round label max">
      <textarea on:change={async (e) => { draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length; draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length; }} bind:value={draggableText.contents} ></textarea>
      <!-- svelte-ignore a11y_label_has_associated_control -->
      <label>Content</label>
    </div>
    <!-- svelte-ignore a11y_consider_explicit_label -->
    <button class="circle slow-ripple"><i class="fa-solid fa-palette"></i><input type="color" on:input={async (e: Event & { currentTarget: EventTarget & HTMLInputElement }) => { const { r, g, b, } = await noHexToRgbNormalized(e.currentTarget.value); draggableText.colorFilling = { r, g, b, a: draggableText.colorFilling.a, }; }}/></button>
  </div>
  <!-- <table>
    <thead>
      <tr>
        <th class="center-align"><span>Content</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="field border"><textarea on:change={async (e) => { draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length; draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length; }} bind:value={draggableText.contents} ></textarea></div></td>
      </tr>
    </tbody>
  </table> -->
  <table>
    <thead>
      <tr>
        <!-- <th class="center-align"><span>Font size</span></th>
        <th class="center-align"><span> Spacing </span></th> -->
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <div class="field suffix round border label">
            <select on:input={async (e) => {
              if (              e.currentTarget.options       [
                                e.currentTarget.selectedIndex ].value === "none") {
                  $customFonts[e.currentTarget.selectedIndex ].customFontFace = null;
                  return;
              }
              if (!$customFonts[e.currentTarget.selectedIndex ].customFontFace) {
                  $customFonts[e.currentTarget.selectedIndex ].customFontFace = canvasInstance.loadFont(
                  $customFonts[e.currentTarget.selectedIndex ].customFontPath !                        );
              }
              draggableText.font = $customFonts[e.currentTarget.selectedIndex].customFontFace!;
        //    draggableText.font = $customFonts[e.currentTarget.selectedIndex].customFontFace!;
            }}>
              {#each $customFonts as
                      customFont
                    (customFont)
              }
                <option value={customFont.customFontPath}>
                              {customFont.customFontName!.replace(".ttf", "")
                                                        .replace(".otf", "")}</option>
              {/each}
            </select>
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Font</label>
            <i class="fa-solid fa-chevron-down"></i>
        <!--<i class="fa-solid fa-chevron-down"></i>-->
          </div>
        </td>
        <td>
          <div class="field border round label">
            <input type="number" bind:value={draggableText.fontSize} on:input={async (e) => { draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length; draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length; }} />
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Font size</label>
          </div>
        </td>
        <td>
          <div class="field border round label">
            <input type="number" bind:value={draggableText.spacings} on:input={async (e) => {                                                                                                                                                                                   }} />
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Spacing</label>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
  <!-- <table>
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
              <label class="radio"><input type="radio" name="align-h-radio" on:input={async (e) => { draggableText.alignHOption = e.currentTarget.value as p5.HORIZ_ALIGN; }} checked value="center" /><span>Center</span></label>
              <label class="radio"><input type="radio" name="align-h-radio" on:input={async (e) => { draggableText.alignHOption = e.currentTarget.value as p5.HORIZ_ALIGN; }}         value="left"   /><span>Left@ </span></label>
              <label class="radio"><input type="radio" name="align-h-radio" on:input={async (e) => { draggableText.alignHOption = e.currentTarget.value as p5.HORIZ_ALIGN; }}         value="right"  /><span>Right </span></label>
            </nav>
          </div>
        </td>
        <td>
          <div   class="field middle-align">
            <nav class="      center-align">
              <label class="radio"><input type="radio" name="align-v-radio" on:input={async (e) => { draggableText.alignVOption = e.currentTarget.value as p5.VERT_ALIGN; }}         value="alphabetic" /><span>Alphabetic</span></label>
              <label class="radio"><input type="radio" name="align-v-radio" on:input={async (e) => { draggableText.alignVOption = e.currentTarget.value as p5.VERT_ALIGN; }}         value="top"        /><span>Bottom    </span></label>
              <label class="radio"><input type="radio" name="align-v-radio" on:input={async (e) => { draggableText.alignVOption = e.currentTarget.value as p5.VERT_ALIGN; }} checked value="center"     /><span>Center    </span></label>
              <label class="radio"><input type="radio" name="align-v-radio" on:input={async (e) => { draggableText.alignVOption = e.currentTarget.value as p5.VERT_ALIGN; }}         value="bottom"     /><span>Top       </span></label>
            </nav>
          </div>
        </td>
      </tr>
    </tbody>
  </table> -->
<!--
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
              <label class="radio"><input type="radio" name="wrap-mode-radio" on:input={async (e) => { draggableText.wrapMode =                                  null!; }} value="none" /><span>None</span></label>
              <label class="radio"><input type="radio" name="wrap-mode-radio" on:input={async (e) => { draggableText.wrapMode = e.currentTarget.value as p5.WRAP_STYLE; }} value="char" /><span>Char</span></label>
              <label class="radio"><input type="radio" name="wrap-mode-radio" on:input={async (e) => { draggableText.wrapMode = e.currentTarget.value as p5.WRAP_STYLE; }} value="word" /><span>Word</span></label>
              <label class="radio"><input type="radio" name="wrap-mode-radio" on:input={async (e) => { draggableText.wrapMode = e.currentTarget.value as p5.WRAP_STYLE; }} value="char" /><span>Char</span></label>
              <label class="radio"><input type="radio" name="wrap-mode-radio" on:input={async (e) => { draggableText.wrapMode = e.currentTarget.value as p5.WRAP_STYLE; }} value="word" /><span>Word</span></label>
            </nav>
          </div>
        </td>
        <td>
          <div   class="field middle-align">
            <nav class="      center-align">
              <label class="radio"><input type="radio" name="style-radio" on:input={async (e) => { draggableText.stylesOption = e.currentTarget.value as p5.THE_STYLE; }} value="normal"     /><span>Normal     </span></label>
              <label class="radio"><input type="radio" name="style-radio" on:input={async (e) => { draggableText.stylesOption = e.currentTarget.value as p5.THE_STYLE; }} value="italic"     /><span>Italic     </span></label>
              <label class="radio"><input type="radio" name="style-radio" on:input={async (e) => { draggableText.stylesOption = e.currentTarget.value as p5.THE_STYLE; }} value="bold"       /><span>Bold       </span></label>
              <label class="radio"><input type="radio" name="style-radio" on:input={async (e) => { draggableText.stylesOption = e.currentTarget.value as p5.THE_STYLE; }} value="bolditalic" /><span>Bold Italic</span></label>
            </nav>
          </div>
        </td>
      </tr>
    </tbody>
  </table>

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
--->
<!--
  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Dimension W</span></th>
        <th class="center-align"><span>Dimension H</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="field border"><input type="number" bind:value={draggableText.dimensionW} disabled /></div></td>
        <td><div class="field border"><input type="number" bind:value={draggableText.dimensionH} disabled /></div></td>
      </tr>
    </tbody>
  </table>
--->
</div>




