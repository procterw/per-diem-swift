//
//  SettingsView.swift
//  per-diem
//
//  Created by William Leahy on 11/19/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack() {
            SettingsNavbar()
                .padding(.bottom, -8)

            ScrollView {
                VStack(alignment: .leading, spacing: 21) {
                    Text("Daily notifications")
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    NotificationsView()
                    Text("Manage categories")
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    ActivityOptionEditorView()
                    Text("Export your data")
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    ExportView()
                    ImportView()
                    Spacer()
                }
                .padding()
            }
            .scrollDismissesKeyboard(.immediately)
            
            ViewNav()
                .padding(.top, -8)
        }
        .background(Color("ViewBackground"))
    }
}
