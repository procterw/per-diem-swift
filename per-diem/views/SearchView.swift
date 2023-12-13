//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct SearchToggle: View {
    @EnvironmentObject private var searchTerm: SearchTerm
    
    var body: some View {
        Button(action: {
            searchTerm.toggle()
        }) {
            Label("ToggleSearch", systemImage: "magnifyingglass")
                .labelStyle(.iconOnly)
                .foregroundColor(Color("TextDark"))
        }
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
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
        }
    }
}
