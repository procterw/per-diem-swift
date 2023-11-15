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
                font: UIFont(name: "SourceSansPro-SemiBold", size: 16)
            )
            .frame(width: 50)
            .onChange(of: viewModel.icon) { newValue in
                print(newValue)
                // Limits characters to 1 and replaces with most recent input
                if (newValue.count > 0) {
                    let lastChar = newValue.last
                    viewModel.icon = String(lastChar ?? Character(""))
                }
            }

            TextField("Category name", text: $viewModel.activity)
                .font(.custom("SourceSansPro-SemiBold", size: 16))
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
                Label("Submit", systemImage: "plus.app.fill")
                    .labelStyle(.iconOnly)
                    .foregroundColor(Color("FilterSelectBackground"))
            }
            .disabled(viewModel.icon.isEmpty || viewModel.activity.isEmpty)
            .foregroundColor(Color("TextDark"))
            .background(Color("CardBackground"))
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Color("CardBackground"))
        .cornerRadius(2)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("CardBorder"), lineWidth: 1)
        )
        .frame(height: 60)
    }
}
