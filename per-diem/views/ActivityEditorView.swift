//
//  DateListScreen.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

class ActivityEditorViewModel: ObservableObject {
    @Published var note: String
    
    init(note: String) {
        self.note = note
    }
}

struct ActivityEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: ActivityEditorViewModel

    var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
        self.viewModel = ActivityEditorViewModel(note: activity.note ?? "")
    }
    
    func getTitle() -> String {
        return [activity.option?.icon ?? "", activity.option?.type ?? ""].joined(separator: "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(getTitle())
                    .fontWeight(.bold)
                    .font(.subheadline)
                //                Spacer()
                //                Button("🗑️", role: .destructive) {
                //                    viewContext.delete(activity)
                //                    do {
                //                        try viewContext.save()
                //                    } catch {
                //                        // Handle error
                //                    }
                //                }
            }
            .padding([.top, .leading, .trailing])
            
            HStack {
                TextField("Foo", text: $viewModel.note, axis: .vertical)
                    .scrollDisabled(true)
                    .onReceive(
                        viewModel.$note.throttle(for: 2, scheduler: RunLoop.main, latest: true)
                    ) { note in
                        activity.note = note;
                        if (note.count < 50) {
                            activity.notePreview = note
                        } else {
                            activity.notePreview = String(note.prefix(upTo: note.index(note.startIndex, offsetBy: 50)))
                        }
                        print(activity)
                        do {
                            try viewContext.save()
                        } catch {
                            // Handle error
                        }
                    }
                    .font(.subheadline)
            }
            .padding([.leading, .bottom, .trailing])
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("CardBorder"), lineWidth: 1)
        )
        .cornerRadius(10)
        .background(Color("CardBackground"))
//        .padding([.top, .leading, .trailing])
    }
}
//
//struct ActivityEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityEditorView(activity: Activity())
//    }
//}
