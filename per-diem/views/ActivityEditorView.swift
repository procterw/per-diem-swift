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

    func getTitle() -> String {
        return [activity.option?.icon ?? "", activity.option?.type ?? ""].joined(separator: "")
    }
    
    func save() {
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
                TextField("...", text: $note, axis: .vertical)
                    .scrollDisabled(true)
                    .onChange(of: note) { _ in
                        activity.note = note
                        if (note.count < 50) {
                            activity.notePreview = note
                        } else {
                            activity.notePreview = String(note.prefix(upTo: note.index(note.startIndex, offsetBy: 50)))
                        }
                        save()
                    }
            }
            .padding([.leading, .bottom, .trailing])
        }
        .background(Color("CardBackground"))
    }
}
