//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct SearchToggle: View {
    @EnvironmentObject private var searchTerm: SearchTerm
    
    func getColor () -> Color {
        if (searchTerm.open) {
            return Color("SelectedContrast")
        }
        return Color("TextDark")
    }
    
    var body: some View {
        Button(action: {
            searchTerm.toggle()
            searchTerm.clear()
        }) {
            HStack(spacing: 3) {
                Label("Search", systemImage: "magnifyingglass")
                    .labelStyle(.iconOnly)
                Text("Search")
            }
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            .foregroundColor(getColor())
        }
        .buttonStyle(NoPressEffectButton())
    }
}

struct SearchView: View {
    @EnvironmentObject private var searchTerm: SearchTerm

    var body: some View {
        if (searchTerm.open) {
            HStack {
                TextField("Search notes", text: $searchTerm.term, axis: .vertical)
                if (searchTerm.term.count > 0) {
                    Button(action: {
                        searchTerm.clear()
                    }) {
                        Label("ClearSearch", systemImage: "x.circle.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color("TextDark"))
                            .opacity(0.5)
                    }
                }

                Spacer()
                Divider()

                Button("Clear") {
                    searchTerm.clear()
                }
                .foregroundColor(Color(.textDark))
                .font(.custom("SourceSansPro-SemiBold", size: 16))
                .padding(.leading, 6)
                .disabled(searchTerm.isEmpty())
            }
            .frame(height: 38)
            .padding(.horizontal, 15)
        }
    }
}
