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
    
    var undoActionCounter: Int = 0
    
    public func isRedoAvailable() -> Bool {
        return redoStack.count > 0
    }
    
    public func isUndoAvailable() -> Bool {
        return undoStack.count > 1
    }
    
    public func initialize(entry: String) {
        undoStack = [entry]
        tempStack = []
        redoStack = []
    }
        
    public func undo() -> String {
        if (!isUndoAvailable()) {
            return ""
        }

        undoActionCounter = 1

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

        undoActionCounter = 1

        let entry = redoStack.popLast() ?? ""
        undoStack.append(entry)
        return entry
    }

    public func add(entry: String) {
        if (undoActionCounter > 0) {
            undoActionCounter = 0
            return
        }
        undoStack.append(entry)
        redoStack = []
    }

    init() {
        undoStack = []
        tempStack = []
        redoStack = []
    }
}


