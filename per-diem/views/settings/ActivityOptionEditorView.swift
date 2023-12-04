//
//  ActivityOptionEditorView.swift
//  per-diem
//
//  Created by William Leahy on 11/29/23.
//

import SwiftUI

struct OptionEditorItem: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var option: ActivityOption
    @State var icon: String
    @State var type: String
    @State var isConfirmingDelete: Bool
    @State var isDeleting: Bool
    
    func isBeingEdited() -> Bool {
        if (isDeleting) {
            return false
        }
        return icon != option.icon || type != option.type
    }
    
    func saveUpdate() {
        do {
            option.icon = icon
            option.type = type
            try viewContext.save()
        } catch {
            // Handle error
        }
    }
    
    func delete() {
        isDeleting = true
        do {
            viewContext.delete(option)
            try viewContext.save()
        } catch {
            // Handle error
        }
        
        // LOAD ALL ACTIVITIES AND DELETE?
    }
    
    init(option: ActivityOption) {
        self.option = option
        self.icon = option.icon ?? ""
        self.type = option.type ?? ""
        self.isConfirmingDelete = false
        self.isDeleting = false
    }
    
    var body: some View {
        HStack {
            EmojiTextField(
                text: $icon,
                placeholder: "Icon",
                font: UIFont(name: "SourceSansPro-SemiBold", size: 16)
            )
            .frame(width: 30)
            .onChange(of: icon) { newValue in
                print(newValue)
                // Limits characters to 1 and replaces with most recent input
                if (newValue.count > 0) {
                    let lastChar = newValue.last
                    icon = String(lastChar ?? Character(""))
                }
            }

            TextField("Category name", text: $type)
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            
            if(isBeingEdited()) {
                Button(action: {
                    icon = option.icon ?? ""
                    type = option.type ?? ""
                }) {
                    Label("Revert", systemImage: "arrow.uturn.backward")
                        .labelStyle(.iconOnly)
                }
                .foregroundColor(Color("TextDark"))

                Button(action: {
                    saveUpdate()
                }) {
                    Label("Save", systemImage: "checkmark")
                        .labelStyle(.iconOnly)
                }
                .foregroundColor(Color("TextDark"))
            } else {
                Button(action: {
                    isConfirmingDelete = true
                }) {
                    Label("Delete", systemImage: "trash")
                        .labelStyle(.iconOnly)
                }
                .foregroundColor(Color("TextDark"))
                .confirmationDialog(
                    "Are you sure you want to remove this category and all entries?",
                    isPresented: $isConfirmingDelete, presenting: "Delete"
                ) { detail in
                    Button(role: .destructive) {
                        delete()
                    } label: {
                        Text("Delete category, including all entries?")
                    }
                    Button("Cancel", role: .cancel) {
                        print("it's over")
                    }
                }
            }
        }
    }
}

struct ActivityOptionEditorView: View {
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ActivityOption.count, ascending: false),
            NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true),
        ],
        animation: .default)
    private var options: FetchedResults<ActivityOption>

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(options) { option in
                HStack {
                    OptionEditorItem(option: option)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color("CardBackground"))
                        .cornerRadius(2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color("CardBorder"), lineWidth: 1)
                        )
                        .frame(height: 45)
                }
            }
            ActivityOptionCreatorView()
        }
        .padding()
    }
}
