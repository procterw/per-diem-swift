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
        let timeNow: Date = .now
        let file = "pd-export_" + timeNow.ISO8601Format().split(separator: "T")[0] + ".json"
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
    
    func getTitle() -> String{
        if (pending) {
            return "Exporting entries..."
        }
        return "Export entries as JSON"
    }
    
    var body: some View {
        Button(action: exportData) {
            Text(getTitle())
                .font(.custom("SourceSansPro-SemiBold", size: 16))
                .foregroundStyle(Color("TextDark"))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Color("CardBackground"))
        .cornerRadius(2)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("CardBorder"), lineWidth: 1)
        )
        .frame(height: 45)
    }
}
