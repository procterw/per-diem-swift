//
//  DateListScreen.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var icon: String = "⛵"
    @Published var activity: String = "test"
}

struct ActivityOptionCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ActivityViewModel = ActivityViewModel()

    var body: some View {
        Form {
            TextField("Bar", text: $viewModel.icon)
            TextField("Foo", text: $viewModel.activity)
        }
        Button("Save it") {
            let a = ActivityOption(context: viewContext)
            a.type = viewModel.activity
            a.icon = viewModel.icon
            do {
                try viewContext.save()
                dismiss()
            } catch {
                // Handle error
            }
        }
    }
}
