//
//  UndoModule.swift
//  per-diem
//
//  Created by William Leahy on 1/24/24.
//

import Foundation

class UndoModule: ObservableObject {
    var undoStack: Array<String>
    var tempStack: Array<String>
    var redoStack: Array<String>
    
    // Due to how SwiftUI's input handling works,
    // an undo or redo will change the text in the textarea
    // which the 'add' function interprets as new input.
    // So, we need a flag to ignore that function call
    // immediately after an undo/redo
    var acceptNextChange: Bool = true
    
    public func isRedoAvailable() -> Bool {
        return redoStack.count > 0
    }
    
    public func isUndoAvailable() -> Bool {
        return undoStack.count > 1
    }
    
    public func initialize(entry: String) {
        undoStack = [entry]
        tempStack = [entry]
        redoStack = []
    }
    
    // Bundles temporary changes into a single change
    // That's added to the undo stack
    private func processQueue() {
        if (tempStack.count == 0) {
            return
        }
        undoStack.append(tempStack.last ?? "")
        self.tempStack = []
    }
    
    // Determines if the temporary stack is ready to
    // Be moved to undo
    private func checkQueue() {
        if (tempStack.count < 2) {
            return
        }

        let last = tempStack.last ?? "";
        let secondLast = tempStack[tempStack.count - 2];

        let totalDiff = tempStack.count
        let lastDiff = abs(last.count - secondLast.count)
        
        if (lastDiff > 3) {
            // If several characters are changed at once like replacing text or
            // pasting text
            processQueue()
        } else if (totalDiff > 15) {
            // Catchall for longer queue that hasn't been emptied yet
            processQueue()
        } else if (totalDiff > 8) {
            // If there is a space or punctuation clear the queue
            if (
                (last.last ?? Character("")).isPunctuation ||
                (last.last ?? Character("")).isWhitespace ||
                (last.last ?? Character("")).isNewline
            ) {
                processQueue()
            }
        }
    
    }
        
    public func undo() -> String {
        if (!isUndoAvailable()) {
            return ""
        }
        
        acceptNextChange = false
        
        // Preserve the current state even if there aren't many changes
        processQueue()

        // Preserve the latest state
        let latestEntry = undoStack.popLast() ?? ""
        redoStack.append(latestEntry)

        // Return the previous entry
        let previousEntry = undoStack.last ?? ""

        return previousEntry
    }
    
    public func redo() -> String {
        if (!isRedoAvailable()) {
            return ""
        }

        acceptNextChange = false

        let entry = redoStack.popLast() ?? ""
        undoStack.append(entry)
        return entry
    }

    public func add(entry: String) {
        if (!acceptNextChange) {
            acceptNextChange = true
            return
        }
        tempStack.append(entry)
        redoStack = []

        checkQueue()
    }

    init() {
        undoStack = []
        tempStack = []
        redoStack = []
    }
}


