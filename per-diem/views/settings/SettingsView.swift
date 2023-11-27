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
                // Why do I need to do this?
                .padding(.bottom, -8)
            ExportView()
            ImportView()
            Spacer()
        }
    }
}
