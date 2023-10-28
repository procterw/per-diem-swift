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

//
//struct ActivityOptionCreatorToggle: View {
//    @State private var isCreatorVisible: Bool = false
//    
//    func close() {
//        isCreatorVisible = false
//    }
//    
//    var body: some View {
//        if isCreatorVisible {
//            ActivityOptionCreatorView(toggle: self.close)
//        } else {
//            Button(action: {
//                isCreatorVisible = true
//            }) {
//                Text("Add category")
//                    .padding(.all, 10)
//                    .frame(maxWidth: .infinity)
//            }
//            .foregroundColor(Color("TextDark"))
//            .background(Color("CardBackground"))
//            .font(.custom("SourceSansPro-SemiBold", size: 16))
//            .cornerRadius(5)
//            .overlay(
//                RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color("CardBorder"), lineWidth: 1)
//            )
//        }
//    }
//}

struct ActivityOptionCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ActivityViewModel = ActivityViewModel()

    var body: some View {
        VStack {
            HStack {

                EmojiTextField(
                    text: $viewModel.icon,
                    placeholder: "Icon",
                    font: UIFont(name: "SourceSansPro-SemiBold", size: 16)
                )
                .frame(width: 60)

                TextField("Create category", text: $viewModel.activity)
                    .font(.custom("SourceSansPro-SemiBold", size: 16))
                
                Button(action: {
                    let a = ActivityOption(context: viewContext)
                    a.type = viewModel.activity
                    a.icon = viewModel.icon
                    do {
                        try viewContext.save()
                        viewModel.icon = ""
                        viewModel.activity = ""
                    } catch {
                        // Handle error
                    }
                }) {
                    Label("Submit", systemImage: "plus.app.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color("TextDark"))
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
        }

    }
}
