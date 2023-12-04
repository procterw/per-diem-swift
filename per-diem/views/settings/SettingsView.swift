//
//  SettingsView.swift
//  per-diem
//
//  Created by William Leahy on 11/19/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                SettingsNavbar()
                // Why do I need to do this?
                    .padding(.bottom, -8)
                
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
    }
}
