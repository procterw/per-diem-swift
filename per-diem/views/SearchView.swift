//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var searchTerm: SearchTerm

    var body: some View {
        HStack {
            TextField("Search notes", text: $searchTerm.term, axis: .vertical)
//            Button(action: {
//                searchTerm.clear()
//            }) {
//                Label("ClearSearch", systemImage: "x.circle.fill")
//                    .labelStyle(.iconOnly)
//                    .foregroundColor(Color("TextDark"))
//                    .opacity(0.7)
//            }
//            .disabled(searchTerm.term.count < 1)
        }
        .padding()
    }
}
