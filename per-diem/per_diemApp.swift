//
//  per_diemApp.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

@main
struct per_diemApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DayList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
