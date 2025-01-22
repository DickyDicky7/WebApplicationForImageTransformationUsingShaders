<script lang="ts">
    import type { DraggableText } from "./types";

    // svelte-ignore export_let_unused
        export let draggableText: DraggableText = null!;

</script>

<div>
    <span>Outline color</span>
    <!-- svelte-ignore a11y_consider_explicit_label -->
    <button class="circle slow-ripple"><i class="fa-solid fa-palette"></i><input type="color" on:input={ async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => {
        
          }}>
    </button>
    <br>
    <span>Filling color</span>
    <!-- svelte-ignore a11y_consider_explicit_label -->
    <button class="circle slow-ripple"><i class="fa-solid fa-palette"></i><input type="color" on:input={ async (e: Event & { currentTarget: EventTarget & HTMLInputElement; }) => {
        
          }}>
    </button>
    <br>
    
    <table>
      <thead>
        <tr>
          <th><span>Font size</span></th>
          <th><span>Spacing</span></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>    <div class="field border">
            <input type="text">
          </div></td>
          <td>    <div class="field border">
            <input type="text">
          </div></td>
        </tr>
      </tbody>
    </table>
    
    
    <table>
      <thead>
        <tr>
          <th><span>Content</span></th>

        </tr>
      </thead>
      <tbody>
        <tr>
          <td>    <div class="field border">
            <input type="text">
          </div></td>

        </tr>
      </tbody>
    </table>
      

    <table>
      <thead>
        <tr>
          <th><span>Align H</span></th>
          <th><span>Align V</span></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <div class="field middle-align">
              <nav class="center-align">
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
                <label class="radio">
                  <input type="radio" name="radio4_">
                  <span>Item 3</span>
                </label>
              </nav>
            </div>
          </td>
          <td>
            <div class="field middle-align">
              <nav class="center-align">
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
                <label class="radio">
                  <input type="radio" name="radio4_">
                  <span>Item 3</span>
                </label>
              </nav>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
      
    <table>
      <thead>
        <tr>
          <th><span>Wrap mode</span></th>
          <th><span>Style</span></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <div class="field middle-align">
              <nav class="center-align">
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
                <label class="radio">
                  <input type="radio" name="radio4_">
                  <span>Item 3</span>
                </label>
              </nav>
            </div>
          </td>
          <td>
            <div class="field middle-align">
              <nav class="center-align">
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
                <label class="radio">
                  <input type="radio" name="radio4_">
                  <span>Item 3</span>
                </label>
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
            <th>Position X</th>
            <th>Position Y</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>    <div class="field border">
              <input type="text">
            </div></td>
            <td>    <div class="field border">
              <input type="text">
            </div></td>
          </tr>
        </tbody>
      </table>
      <table>
        <thead>
          <tr>
            <th>Dimension W</th>
            <th>Dimension H</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>    <div class="field border">
              <input type="text">
            </div></td>
            <td>    <div class="field border">
              <input type="text">
            </div></td>
          </tr>
        </tbody>
      </table>
</div>