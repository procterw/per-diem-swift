//
//  ExportView.swift
//  per-diem
//
//  Created by William Leahy on 11/20/23.
//

import SwiftUI
import CoreData

struct ExportView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var pending: Bool = false
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first o   ne, which ought to be the only one
        return paths[0]
    }
    
    func writeFile(contents: String) -> Void{
        let file = "test1234.json"
        let dir = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file)
        do {
            try contents.write(to: dir!, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        var filesToShare = [Any]()
        filesToShare.append(dir!)
        let av = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    func exportData() {
        pending = true

        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        
        do {
            // Fetch all activities
            let activities = try viewContext.fetch(request)
            
            // Reformat activities to be JSONable (i.e. removing dates)
            var activityList: Array<ExportedActivity> = []
            activities.forEach({ activity in
                activityList.append(activity.toJSON())
            })
            
            // Encode activity list as json string
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(activityList)
            let jsonStr = String(data: jsonData, encoding: .utf8)
            
            writeFile(contents: jsonStr ?? "")
            
            // Write to documents
            pending = false
            
        } catch {
            print("Error exporting")
            pending = false
        }
    }
    
    var body: some View {
        VStack {
            Text("Export your stuff!")
            if (pending) {
                Text("Exporting...")
            }
            Button("Export") {
                exportData()
            }
        }
    }
}
