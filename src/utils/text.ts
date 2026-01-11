    import p5 from "p5";
//  import p5 from "p5";
    import * as types from "../types";
//  import * as types from "../types";

    export function display(draggableText: types.DraggableText, canvasInstance: p5): void {
//  export function display(draggableText: types.DraggableText, canvasInstance: p5): void {
        canvasInstance.push();
//      canvasInstance.push();
        canvasInstance.textLeading(draggableText.spacings);
//      canvasInstance.textLeading(draggableText.spacings);
        canvasInstance.textSize(draggableText.fontSize);
//      canvasInstance.textSize(draggableText.fontSize);
        if (draggableText.font)
//      if (draggableText.font)
            canvasInstance.textFont(draggableText.font, draggableText.fontSize);
//          canvasInstance.textFont(draggableText.font, draggableText.fontSize);
        canvasInstance.fill(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a);
//      canvasInstance.fill(draggableText.colorFilling.r, draggableText.colorFilling.g, draggableText.colorFilling.b, draggableText.colorFilling.a);
        canvasInstance.textAlign(draggableText.alignHOption, draggableText.alignVOption);
//      canvasInstance.textAlign(draggableText.alignHOption, draggableText.alignVOption);
        canvasInstance.text(draggableText.contents, draggableText.positionX, draggableText.positionY);
//      canvasInstance.text(draggableText.contents, draggableText.positionX, draggableText.positionY);
        canvasInstance.pop();
//      canvasInstance.pop();
    }
//  }

    export function onMousePressed(draggableText: types.DraggableText, canvasInstance: p5): void {
//  export function onMousePressed(draggableText: types.DraggableText, canvasInstance: p5): void {
        if (canvasInstance.mouseX - canvasInstance.width / 2 > draggableText.positionX &&
//      if (canvasInstance.mouseX - canvasInstance.width / 2 > draggableText.positionX &&
            canvasInstance.mouseX - canvasInstance.width / 2 < draggableText.positionX + draggableText.dimensionW &&
//          canvasInstance.mouseX - canvasInstance.width / 2 < draggableText.positionX + draggableText.dimensionW &&
            canvasInstance.mouseY - canvasInstance.height / 2 < draggableText.positionY + draggableText.dimensionH &&
//          canvasInstance.mouseY - canvasInstance.height / 2 < draggableText.positionY + draggableText.dimensionH &&
            canvasInstance.mouseY - canvasInstance.height / 2 > draggableText.positionY) {
//          canvasInstance.mouseY - canvasInstance.height / 2 > draggableText.positionY) {
            draggableText.isDragging = true;
//          draggableText.isDragging = true;
        }
//      }
    }
//  }

    export function startDragging(draggableText: types.DraggableText, canvasInstance: p5): void {
//  export function startDragging(draggableText: types.DraggableText, canvasInstance: p5): void {
        if (draggableText.isDragging) {
//      if (draggableText.isDragging) {
            draggableText.positionX = canvasInstance.mouseX - canvasInstance.width  / 2;
//          draggableText.positionX = canvasInstance.mouseX - canvasInstance.width  / 2;
            draggableText.positionY = canvasInstance.mouseY - canvasInstance.height / 2;
//          draggableText.positionY = canvasInstance.mouseY - canvasInstance.height / 2;
        }
//      }
    }
//  }

    export function ceaseDragging(draggableText: types.DraggableText, canvasInstance: p5): void {
//  export function ceaseDragging(draggableText: types.DraggableText, canvasInstance: p5): void {
        draggableText.isDragging = false;
//      draggableText.isDragging = false;
    }
//  }
