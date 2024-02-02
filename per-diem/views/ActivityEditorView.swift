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
            HStack(spacing: 5) {
                Text(activity.option?.icon ?? "")
                Text(activity.option?.type ?? "")
                    .font(.custom("SourceSansPro-SemiBold", size: 17))
                
                Spacer()
                
                Button(action: {
                    save(note: undo.undo())
                }) {
                    Label("Undo", systemImage: "arrow.uturn.backward")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color("TextDark"))
                }
                .scrollContentBackground(.hidden)
                .disabled(!undo.isUndoAvailable())
                .opacity(!undo.isUndoAvailable() ? 0 : 1)

                Button(action: {
                    save(note: undo.redo())
                }) {
                    Label("Redo", systemImage: "arrow.uturn.forward")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color("TextDark"))
                }
                .scrollContentBackground(.hidden)
                .disabled(!undo.isRedoAvailable())
                .opacity(!undo.isRedoAvailable() ? 0 : 1)
            }
            .padding([.top, .leading, .trailing])
        

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
