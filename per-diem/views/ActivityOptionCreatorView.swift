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
    
    @State private var isCreatorVisible: Bool = false

    var body: some View {
        if !isCreatorVisible {
            Button(action: {
                isCreatorVisible = true
            }) {
                Text("Add category")
                    .padding(.all, 10)
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(Color("TextDark"))
            .background(Color("CardBackground"))
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("CardBorder"), lineWidth: 1)
            )
        } else {
            VStack {
                Grid(alignment: .leading, horizontalSpacing: 10) {
                    GridRow {
                        Text("Icon")
                            .fontWeight(.semibold)
                        TextField("🏃‍♀️", text: $viewModel.icon)
                    }
                    GridRow {
                        Text("Label")
                            .fontWeight(.semibold)
                        TextField("Running", text: $viewModel.activity)
                    }
                }
                HStack {
                    Button(action: {
                        isCreatorVisible = false
                    }) {
                        Text("Nevermind")
                            .padding(.all, 10)
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(Color("TextDark"))
                    .background(Color("CardBackground"))
                    .font(.custom("SourceSansPro-SemiBold", size: 16))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("CardBorder"), lineWidth: 1)
                    )
                    
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
                        Text("Add category")
                            .padding(.all, 10)
                            .frame(maxWidth: .infinity)
                    }
                    .disabled(viewModel.icon.isEmpty || viewModel.activity.isEmpty)
                    .foregroundColor(Color("TextDark"))
                    .background(Color("CardBackground"))
                    .font(.custom("SourceSansPro-SemiBold", size: 16))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color("CardBorder"), lineWidth: 1)
                    )
                }
            }
        }
    }
}
