//
//  ExportButton.swift
//  per-diem
//
//  Created by William Leahy on 10/14/23.
//


import SwiftUI
import CoreData

extension Activity {
  static let context = CodingUserInfoKey(rawValue: "context")
}

struct ExportButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    func exportActivities() {
        let test = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)]
        )
        let valid = JSONSerialization.isValidJSONObject(test)
//        print(test)
        print(valid)
    }
    
    var body: some View {
        Button(action: exportActivities) {
            Text("Export")
        }
    }
}
