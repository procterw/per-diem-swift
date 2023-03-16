//
//  DateListScreen.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

//class ActivityEditorViewModel: ObservableObject {
//    @Published var note: String
//
//    init(note: String) {
//        self.note = note
//    }
//}

struct ActivityEditorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var activity: Activity
    @State var note: String
    
    init(activity: Activity) {
        self.activity = activity
        self.note = activity.note ?? ""
    }
    
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
//                    .font(.custom("SourceSerifPro-Regular", size: 17))
//                    .font(.subheadline)
//                    .onReceive(
//                        viewModel.$note.throttle(for: 2, scheduler: RunLoop.main, latest: true)
////                        viewModel.$note.throttle(for: 2, scheduler: RunLoop.main, latest: true)
//                    ) { note in
////                        let activity = Activity(context: viewContext)
//                        activity.note = note;
//                        activity.dateModified = Date()
//                        if (note.count < 50) {
//                            activity.notePreview = note
//                        } else {
//                            activity.notePreview = String(note.prefix(upTo: note.index(note.startIndex, offsetBy: 50)))
//                        }
//                        do {
//                            try viewContext.save()
//                        } catch {
//                            // Handle error
//                        }
//                    }

            }
            .padding([.leading, .bottom, .trailing])
        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color("CardBorder"), lineWidth: 1)
//        )
//        .cornerRadius(10)
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
