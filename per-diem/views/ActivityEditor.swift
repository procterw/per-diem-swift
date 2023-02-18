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

struct ActivityEditor: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: ActivityEditorViewModel

    var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
        self.viewModel = ActivityEditorViewModel(note: activity.note ?? "")
    }
    
    var body: some View {
        Form {
            Text(activity.type ?? "")
            TextField("Foo", text: $viewModel.note, axis: .vertical)
        }
        .scrollDisabled(true)
        .onReceive(
            viewModel.$note.throttle(for: 2, scheduler: RunLoop.main, latest: true)
        ) { note in
            activity.note = note;
            do {
                try viewContext.save()
            } catch {
                // Handle error
            }
        }
    }
}

struct ActivityEditor_Previews: PreviewProvider {
    static var previews: some View {
        ActivityEditor()
    }
}
