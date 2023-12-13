//
//  SettingsView.swift
//  per-diem
//
//  Created by William Leahy on 11/19/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            SettingsNavbar()
                .padding(.bottom, -8)

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Manage categories")
                    ActivityOptionEditorView()
                    Text("Daily notifications")
                    NotificationsView()
                    Text("Export your data")
                    ExportView()
                    ImportView()
                    Spacer()
                }
            }
            
            ViewNav()
                .padding(.top, -8)
        }
    }
}
