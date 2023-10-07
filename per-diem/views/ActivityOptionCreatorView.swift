//
//  DateListScreen.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var icon: String = ""
    @Published var activity: String = ""
}

struct ActivityOptionCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ActivityViewModel = ActivityViewModel()

    var body: some View {
        HStack {
            EmojiTextField(text: $viewModel.icon, placeholder: "🤹")
                .frame(width: 40)
            TextField("Add category", text: $viewModel.activity)
                .fontWeight(.semibold)
            Button(action: {
                let a = ActivityOption(context: viewContext)
                a.type = viewModel.activity
                a.icon = viewModel.icon
                do {
                    try viewContext.save()
                    viewModel.icon = "🤹"
                    viewModel.activity = ""
                } catch {
                    // Handle error
                }
            }) {
                Label("AddButton", systemImage: "plus.app")
                    .labelStyle(.iconOnly)
                    .foregroundColor(.black)
            }
            .disabled(viewModel.icon.isEmpty || viewModel.activity.isEmpty)
        }
    }
}
