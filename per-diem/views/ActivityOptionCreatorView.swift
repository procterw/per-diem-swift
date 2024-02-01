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
    @State var icon: String = ""
    @State var activity: String = ""
    
    private let activityCharLimit = 30

    var body: some View {
        HStack {
            EmojiTextField(
                text: $icon,
                placeholder: "Icon",
                font: UIFont(name: "SourceSansPro-SemiBold", size: 15)
            )
            .frame(width: 33)
            .onChange(of: icon) { newValue in
                // Limits characters to 1 and replaces with most recent input
                if (newValue.count > 0) {
                    let lastChar = newValue.last
                    icon = String(lastChar ?? Character(""))
                }
            }
            
            Divider()
                .padding(.trailing, 5)

            TextField("Your category name", text: $activity)
                .font(.custom("SourceSansPro-SemiBold", size: 15))
                .onChange(of: activity) { newValue in
                    if activity.count > activityCharLimit {
                        activity = String(activity.prefix(activityCharLimit))
                    }
                }
            
            Button(action: {
                let a = ActivityOption(context: viewContext)
                a.type = activity
                a.icon = icon
                do {
                    try viewContext.save()
                    icon = ""
                    activity = ""
//                    viewModel.reset()
                } catch {
                    // Handle error
                }
            }) {
                if (!icon.isEmpty && !activity.isEmpty) {
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
