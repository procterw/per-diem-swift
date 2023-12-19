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
                    Text("Manage Categories")
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    ActivityOptionEditorView()
                    Text("Daily notifications")
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    NotificationsView()
                    Text("Export your data")
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    ExportView()
                    ImportView()
                    Spacer()
                }
                .padding()
            }
            
            ViewNav()
                .padding(.top, -8)
        }
        .background(Color("ViewBackground"))
    }
}
