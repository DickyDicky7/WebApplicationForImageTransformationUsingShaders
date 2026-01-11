    import * as global from "../state/global.svelte";
//  import * as global from "../state/global.svelte";
    import * as types from "../types";
//  import * as types from "../types";

    declare const ui: any;
//  declare const ui: any;

    export async function makeNewSnackbarSuccess(newSuccessScript: string): Promise<void> { global.globalState.successScript = newSuccessScript; await ui("#snackbar-success"); }
//  export async function makeNewSnackbarSuccess(newSuccessScript: string): Promise<void> { global.globalState.successScript = newSuccessScript; await ui("#snackbar-success"); }
    export async function makeNewSnackbarFailure(newFailureScript: string): Promise<void> { global.globalState.failureScript = newFailureScript; await ui("#snackbar-failure"); }
//  export async function makeNewSnackbarFailure(newFailureScript: string): Promise<void> { global.globalState.failureScript = newFailureScript; await ui("#snackbar-failure"); }

    export async function onRedoActionExecuted(): Promise<void> {
//  export async function onRedoActionExecuted(): Promise<void> {
        let redoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsRedoStack.pop();
//      let redoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsRedoStack.pop();
        if (redoEditorSnapshot) {
//      if (redoEditorSnapshot) {
            if (redoEditorSnapshot.redo) {
//          if (redoEditorSnapshot.redo) {
                await redoEditorSnapshot.redo(redoEditorSnapshot.dynamicStorage);
//              await redoEditorSnapshot.redo(redoEditorSnapshot.dynamicStorage);
            }
//          }
            global.globalState.editorSnapshotsUndoStack.push(redoEditorSnapshot);
//          global.globalState.editorSnapshotsUndoStack.push(redoEditorSnapshot);
        }
//      }
    }
//  }

    export async function onUndoActionExecuted(): Promise<void> {
//  export async function onUndoActionExecuted(): Promise<void> {
        let undoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsUndoStack.pop();
//      let undoEditorSnapshot: types.EditorSnapshot | undefined = global.globalState.editorSnapshotsUndoStack.pop();
        if (undoEditorSnapshot) {
//      if (undoEditorSnapshot) {
            if (undoEditorSnapshot.undo) {
//          if (undoEditorSnapshot.undo) {
                await undoEditorSnapshot.undo(undoEditorSnapshot.dynamicStorage);
//              await undoEditorSnapshot.undo(undoEditorSnapshot.dynamicStorage);
            }
//          }
            global.globalState.editorSnapshotsRedoStack.push(undoEditorSnapshot);
//          global.globalState.editorSnapshotsRedoStack.push(undoEditorSnapshot);
        }
//      }
    }
//  }
