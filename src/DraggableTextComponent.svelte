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

  import type { EditorSnapshot } from "./types";
  import { editorSnapshotsUndoStack } from "./global";
  import { editorSnapshotsRedoStack } from "./global";

//let fontFaceSelectedIndex: number = 0;
  let fontFaceSelectedIndex: number = 0;
//let fontFaceSelectedIndex: number = 0;

//let defaultFont: p5.Font = draggableText.font;
  let defaultFont: p5.Font = draggableText.font;
//let defaultFont: p5.Font = draggableText.font;

</script>

<div    >
<!--
  <span>Outline color</span>
  <span>Outline color</span>
--->
  <!-- svelte-ignore a11y_consider_explicit_label -->
  <!-- svelte-ignore a11y_consider_explicit_label -->
<!--
  <button class="circle slow-ripple large-elevate"><i class="fa-solid fa-palette"></i><input type="color" on:input={async (e: Event & { currentTarget: EventTarget & HTMLInputElement }) => { const { r, g, b, } = await noHexToRgbNormalized(e.currentTarget.value); draggableText.colorOutline = { r, g, b, a: draggableText.colorOutline.a, }; }}/></button>
  <button class="circle slow-ripple large-elevate"><i class="fa-solid fa-palette"></i><input type="color" on:input={async (e: Event & { currentTarget: EventTarget & HTMLInputElement }) => { const { r, g, b, } = await noHexToRgbNormalized(e.currentTarget.value); draggableText.colorOutline = { r, g, b, a: draggableText.colorOutline.a, }; }}/></button>
  <br />
  <br />
--->  
  <div   class="                                  row responsive                                            ">
    <div class="field        textarea round label max responsive suffix white-text large-elevate slow-ripple">
      <textarea on:change={async (e) => {
        let oldContents:  string = draggableText.contents;
//                                 draggableText.contents = e.currentTarget.value;
                                   draggableText.contents = e.currentTarget.value;
//                                 draggableText.contents = e.currentTarget.value;
        let newContents:  string = draggableText.contents;
        draggableText.dimensionW = draggableText.fontSize * draggableText.contents.            length;
        draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length;
//      let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//      let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
        editorSnapshot.dynamicStorage = new Map<string , any>();
        editorSnapshot.dynamicStorage.set("oldContents", oldContents);
        editorSnapshot.dynamicStorage.set("newContents", newContents);
        editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.contents = dynamicStorage.get("oldContents"); } };
        editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.contents = dynamicStorage.get("newContents"); } };
//      editorSnapshotsUndoStack.push(editorSnapshot);
        editorSnapshotsUndoStack.push(editorSnapshot);
//      editorSnapshotsUndoStack.push(editorSnapshot);
      }}    value={draggableText.contents} ></textarea>
      <!-- svelte-ignore a11y_label_has_associated_control -->
      <!-- svelte-ignore a11y_label_has_associated_control -->
      <label>Content</label>
    </div>
    <!-- svelte-ignore a11y_consider_explicit_label -->
    <!-- svelte-ignore a11y_consider_explicit_label -->
    <button class="circle slow-ripple large-elevate deep-orange white-text top-round right-round"><i class="fa-solid fa-palette"></i><input type="color" on:change={async (e: Event & { currentTarget: EventTarget & HTMLInputElement }) => {
//    const { r, g, b, } = await noHexToRgbNormalized(e.currentTarget.value);
      const { r, g, b, } = await noHexToRgbNormalized(e.currentTarget.value);
//    const { r, g, b, } = await noHexToRgbNormalized(e.currentTarget.value);
      let oldColorFilling = structuredClone(draggableText.colorFilling);
//                                          draggableText.colorFilling = { r, g, b, a: draggableText.colorFilling.a, };
                                            draggableText.colorFilling = { r, g, b, a: draggableText.colorFilling.a, };
//                                          draggableText.colorFilling = { r, g, b, a: draggableText.colorFilling.a, };
      let newColorFilling = structuredClone(draggableText.colorFilling);
//    let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
      let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//    let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
      editorSnapshot.dynamicStorage      = new Map<string, any>(          );
      editorSnapshot.dynamicStorage.set("oldColorFilling", oldColorFilling);
      editorSnapshot.dynamicStorage.set("newColorFilling", newColorFilling);
      editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.colorFilling = dynamicStorage.get("oldColorFilling"); (e.target as HTMLInputElement).value = (await rgba_ToHexNormalized(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a)).slice(0, -2); } };
      editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.colorFilling = dynamicStorage.get("newColorFilling"); (e.target as HTMLInputElement).value = (await rgba_ToHexNormalized(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a)).slice(0, -2); } };
//    editorSnapshotsUndoStack.push(editorSnapshot);
      editorSnapshotsUndoStack.push(editorSnapshot);
//    editorSnapshotsUndoStack.push(editorSnapshot);
    }}/></button>
  </div>
<!--
  <table>
    <thead>
      <tr>
        <th class="center-align"><span>Content</span></th>
        <th class="center-align"><span>Content</span></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><div class="field border"><textarea on:change={async (e) => { draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length; draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length; }} bind:value={draggableText.contents} ></textarea></div></td>
        <td><div class="field border"><textarea on:change={async (e) => { draggableText.dimensionW = draggableText.fontSize * draggableText.contents.length; draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length; }} bind:value={draggableText.contents} ></textarea></div></td>
      </tr>
    </tbody>
  </table>
--->
  <table>
    <thead>
      <tr>
<!--
        <th class="center-align"><span>Font size</span></th>
        <th class="center-align"><span>Font size</span></th>
        <th class="center-align"><span> Spacing </span></th>
        <th class="center-align"><span> Spacing </span></th>
--->
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>
          <div         class="field label suffix round white-text large-elevate slow-ripple">
            <select on:input={async (e) => {
              if (              e.currentTarget.options       [
                                e.currentTarget.selectedIndex ].value         ===       "none") {
                   $customFonts[e.currentTarget.selectedIndex ].customFontFace =  defaultFont ;
//                 $customFonts[e.currentTarget.selectedIndex ].customFontFace =  defaultFont ;
//                  return;
//                  return;
//                  return;
              }
              if (!$customFonts[e.currentTarget.selectedIndex ].customFontFace                ) {
                   $customFonts[e.currentTarget.selectedIndex ].customFontFace = canvasInstance.loadFont(
                   $customFonts[e.currentTarget.selectedIndex ].customFontPath !                        );
              }
              draggableText.font = $customFonts[e.currentTarget.selectedIndex].customFontFace!;
//            draggableText.font = $customFonts[e.currentTarget.selectedIndex].customFontFace!;

              let oldFontFaceSelectedIndex: number =         fontFaceSelectedIndex;
                     fontFaceSelectedIndex         = e.currentTarget.selectedIndex;
              let newFontFaceSelectedIndex: number =         fontFaceSelectedIndex;

//            let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
              let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//            let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
              editorSnapshot.dynamicStorage = new Map<string, any>();
              editorSnapshot.dynamicStorage.set("oldFontFaceSelectedIndex", oldFontFaceSelectedIndex);
              editorSnapshot.dynamicStorage.set("newFontFaceSelectedIndex", newFontFaceSelectedIndex);
              editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => {
                if (dynamicStorage) {
                  if (!$customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace) {
                       $customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace = defaultFont;
                  }
                  draggableText.font = $customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace!;
//                draggableText.font = $customFonts[dynamicStorage.get("oldFontFaceSelectedIndex")].customFontFace!;
                  e.currentTarget.selectedIndex  =  dynamicStorage.get("oldFontFaceSelectedIndex");
//                e.currentTarget.selectedIndex  =  dynamicStorage.get("oldFontFaceSelectedIndex");
                }
              };
              editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => {
                if (dynamicStorage) {
                  if (!$customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace) {
                       $customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace = defaultFont;
                  }
                  draggableText.font = $customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace!;
//                draggableText.font = $customFonts[dynamicStorage.get("newFontFaceSelectedIndex")].customFontFace!;
                  e.currentTarget.selectedIndex  =  dynamicStorage.get("newFontFaceSelectedIndex");
//                e.currentTarget.selectedIndex  =  dynamicStorage.get("newFontFaceSelectedIndex");
                }
              };
//            editorSnapshotsUndoStack.push(editorSnapshot);
              editorSnapshotsUndoStack.push(editorSnapshot);
//            editorSnapshotsUndoStack.push(editorSnapshot);
            }}>
              {#each $customFonts as
                      customFont
                     (customFont)
              }
                <option value={customFont.customFontPath}   class="grey10 white-text" >
                              {customFont.customFontName!.replace(".ttf", "")
                                                         .replace(".otf", "")}</option>
              {/each}
            </select>
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Font</label>
        <!--<i class="fa-solid fa-chevron-down"></i>-->
            <i class="fa-solid fa-chevron-down"></i>
        <!--<i class="fa-solid fa-chevron-down"></i>-->
          </div>
        </td>
        <td>
          <div                    class="field label suffix round white-text large-elevate slow-ripple">
            <input type="number"  value={draggableText.fontSize} on:input={async (e) => {
              let oldFontSize: number  = draggableText.fontSize;
//                                       draggableText.fontSize = e.currentTarget.valueAsNumber;
                                         draggableText.fontSize = e.currentTarget.valueAsNumber;
//                                       draggableText.fontSize = e.currentTarget.valueAsNumber;
              let newFontSize: number  = draggableText.fontSize;
              draggableText.dimensionW = draggableText.fontSize * draggableText.contents.            length;
              draggableText.dimensionH = draggableText.fontSize * draggableText.contents.split("\n").length;
//            let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
              let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//            let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
              editorSnapshot.dynamicStorage = new Map<string , any>();
              editorSnapshot.dynamicStorage.set("oldFontSize", oldFontSize);
              editorSnapshot.dynamicStorage.set("newFontSize", newFontSize);
              editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.fontSize = dynamicStorage.get("oldFontSize"); } };
              editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.fontSize = dynamicStorage.get("newFontSize"); } };
//            editorSnapshotsUndoStack.push(editorSnapshot);
              editorSnapshotsUndoStack.push(editorSnapshot);
//            editorSnapshotsUndoStack.push(editorSnapshot);
            }} />
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Font size</label>
          </div>
        </td>
        <td>
          <div                   class="field label suffix round white-text large-elevate slow-ripple">
            <input type="number" value={draggableText.spacings} on:input={async (e) => {
              let oldSpacings: number = draggableText.spacings;
//                                      draggableText.spacings = e.currentTarget.valueAsNumber;
                                        draggableText.spacings = e.currentTarget.valueAsNumber;
//                                      draggableText.spacings = e.currentTarget.valueAsNumber;
              let newSpacings: number = draggableText.spacings;
//            let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
              let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
//            let editorSnapshot: EditorSnapshot = { undo: null, redo: null, dynamicStorage: null, };
              editorSnapshot.dynamicStorage = new Map<string , any>();
              editorSnapshot.dynamicStorage.set("oldSpacings", oldSpacings);
              editorSnapshot.dynamicStorage.set("newSpacings", newSpacings);
              editorSnapshot.undo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.spacings = dynamicStorage.get("oldSpacings"); } };
              editorSnapshot.redo = async (dynamicStorage: Map<string, any> | null) => { if (dynamicStorage) { draggableText.spacings = dynamicStorage.get("newSpacings"); } };
//            editorSnapshotsUndoStack.push(editorSnapshot);
              editorSnapshotsUndoStack.push(editorSnapshot);
//            editorSnapshotsUndoStack.push(editorSnapshot);
            }} />
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <!-- svelte-ignore a11y_label_has_associated_control -->
            <label>Spacing</label>
          </div>
        </td>
      </tr>
    </tbody>
  </table>
<!--
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
  </table>
--->
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





<style>
  i        { text-shadow: 0 0 3px; }
/*i        { text-shadow: 0 0 3px; }*/
/*h6       { text-shadow: 0 0 3px; }*/
/*h6       { text-shadow: 0 0 3px; }*/
/*span     { text-shadow: 0 0 3px; }*/
/*span     { text-shadow: 0 0 3px; }*/
  label    { text-shadow: 0 0 3px; }
/*label    { text-shadow: 0 0 3px; }*/
  input    { text-shadow: 0 0 3px; }
/*input    { text-shadow: 0 0 3px; }*/
  select   { text-shadow: 0 0 3px; }
/*select   { text-shadow: 0 0 3px; }*/
  button   { text-shadow: 0 0 3px; }
/*button   { text-shadow: 0 0 3px; }*/
  textarea { text-shadow: 0 0 3px; }
/*textarea { text-shadow: 0 0 3px; }*/
</style>











