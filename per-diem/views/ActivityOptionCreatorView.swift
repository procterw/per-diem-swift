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
    
    func reset() {
        self.icon = ""
        self.activity = ""
    }
}

struct ActivityOptionCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ActivityViewModel = ActivityViewModel()
    
    private let activityCharLimit = 30

    var body: some View {
        HStack {
            EmojiTextField(
                text: $viewModel.icon,
                placeholder: "Icon",
                font: UIFont(name: "SourceSansPro-SemiBold", size: 15)
            )
            .frame(width: 33)
            .onChange(of: viewModel.icon) { newValue in
                print(newValue)
                // Limits characters to 1 and replaces with most recent input
                if (newValue.count > 0) {
                    let lastChar = newValue.last
                    viewModel.icon = String(lastChar ?? Character(""))
                }
            }
            
            Divider()
                .padding(.trailing, 5)

            TextField("Your category name", text: $viewModel.activity)
                .font(.custom("SourceSansPro-SemiBold", size: 15))
                .onChange(of: viewModel.activity) { newValue in
                    if viewModel.activity.count > activityCharLimit {
                        viewModel.activity = String(viewModel.activity.prefix(activityCharLimit))
                    }
                }
            
            Button(action: {
                let a = ActivityOption(context: viewContext)
                a.type = viewModel.activity
                a.icon = viewModel.icon
                do {
                    try viewContext.save()
                    viewModel.reset()
                } catch {
                    // Handle error
                }
            }) {
                if (!viewModel.icon.isEmpty && !viewModel.activity.isEmpty) {
                    Label("Submit", systemImage: "checkmark.square")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color(.textDark))
                        .frame(height: 24)
                }
            }
            .foregroundColor(Color(.textDark))
            .background(Color(.cardBackground))
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color(.cardBackground))
        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        .frame(height: 50)
    }
}
