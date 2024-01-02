//
//  ImportView.swift
//  per-diem
//
//  Created by William Leahy on 11/21/23.
//

import SwiftUI

// Upload a file
// Parse json into a dict
// For each activity:
// // does the activity option exist?
// // if so, overwrite it (?) (controlled by options?)
// // if not, create it (?)

struct ImportView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [])
    private var options: FetchedResults<ActivityOption>

    @ObservedObject var viewModel: ActivityViewModel = ActivityViewModel()

    @State private var presentImporter = false
    
    // https://useyourloaf.com/blog/accessing-security-scoped-files/
    private func read(from url: URL) -> Result<String,Error> {
      let accessing = url.startAccessingSecurityScopedResource()
      defer {
        if accessing {
          url.stopAccessingSecurityScopedResource()
        }
      }
      return Result { try String(contentsOf: url) }
    }
    
    private func importData(data: [ExportedActivity]) {
        data.forEach({ activity in
            
            var activityOpt = options.first(where: { $0.type == activity.optionType })
            
            if (activityOpt == nil) {
                print("TEST nothing there")

                let newOption = ActivityOption(context: viewContext)
                newOption.type = activity.optionType
                newOption.icon = activity.optionIcon
                newOption.count = activity.optionCount
                
                activityOpt = newOption
            }
            
            let newActivity = Activity(context: viewContext)
            newActivity.option = activityOpt
            newActivity.note = activity.note
            newActivity.notePreview = activity.notePreview
            newActivity.dateId = activity.dateId
            
            do {
                try viewContext.save()
                viewModel.reset()
            } catch {
                print("Unable to create activity option")
            }
        })
    }

    var body: some View {
        VStack {
            Button(action: {
                presentImporter = true
            }) {
                Text("Import entries from JSON")
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
            .fileImporter(isPresented: $presentImporter, allowedContentTypes: [.json]) { result in
                switch result {
                case .success(let url):
                    print(url)
                    do {
                        let readResults = read(from: url)
                        let dataString = try readResults.get()
                        let activityList: [ExportedActivity] = try! JSONDecoder().decode([ExportedActivity].self, from: dataString.data(using: .utf8)!)
                        
                        importData(data: activityList)
                    }  catch {}
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
