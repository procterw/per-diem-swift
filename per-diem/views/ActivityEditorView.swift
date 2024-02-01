//
//  DateListScreen.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

struct ActivityEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var activity: Activity
    @State var note: String
    
    @StateObject private var undo = UndoModule()
    
    init(activity: Activity) {
        self.activity = activity
        self.note = activity.note ?? ""
    }

    func getTitle() -> String {
        return [activity.option?.icon ?? "", activity.option?.type ?? ""].joined(separator: "")
    }
    
    func save(note: String) {
        activity.note = note
        self.note = note

        if (note.count < 50) {
            activity.notePreview = note
        } else {
            activity.notePreview = String(note.prefix(upTo: note.index(note.startIndex, offsetBy: 50)))
        }

        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch  {
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 3) {
                Text(activity.option?.icon ?? "")
                Text(activity.option?.type ?? "")
                    .font(.custom("SourceSansPro-SemiBold", size: 17))
            }
            .padding([.top, .leading, .trailing])
            
            HStack {
                
                Button("Undo") {
                    save(note: undo.undo())
                }
                .scrollContentBackground(.hidden)
                .buttonStyle(BorderlessButtonStyle())
                .disabled(!undo.isUndoAvailable())

                Button("Redo") {
                    save(note: undo.redo())
                }
                .scrollContentBackground(.hidden)
                .buttonStyle(BorderlessButtonStyle())
                .disabled(!undo.isRedoAvailable())

            }.scrollContentBackground(.hidden)
            
            Divider()
            Text(String(undo.undoStack.count))
            Text(undo.undoStack.joined(separator: ", "))
            Divider()

            HStack {
                TextField("...", text: $note, axis: .vertical)
                    .scrollDisabled(true)
                    .onChange(of: note) { _ in
                        undo.add(entry: note)
                        save(note: note)
                    }
                    .onAppear() {
                        undo.initialize(entry: activity.note ?? "")
                    }
            }
            .padding([.leading, .bottom, .trailing])
        }
        .background(Color("CardBackground"))
    }
}
