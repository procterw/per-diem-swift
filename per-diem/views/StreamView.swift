//
//  LogView.swift
//  per-diem
//
//  Created by William Leahy on 2/28/23.
//

import SwiftUI

struct StreamItem: View {
    
    var activity: Activity
    var date: DayItem
    
    init(activity: Activity) {
        self.activity = activity
        self.date = DayItem(date: activity.dateAdded ?? Date())
    }
    
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 4) {
                        Text(activity.option?.icon ?? "")
                        Text(activity.type ?? "")
//                            .font(.custom("SourceSerifPro-Semibold", size: 17))
                            .fontWeight(.semibold)
                    }
                    Text(date.getFullDate())
                        .font(.custom("SourceSerifPro-Regular", size: 18))
                    Text(activity.note ?? "")
                }
                .frame(
                      minWidth: 0,
                      maxWidth: .infinity,
                      minHeight: 0,
                      maxHeight: .infinity,
                      alignment: .topLeading
                    )
                .padding()
                .background(Color("CardBackground"))
            }
            .padding(.top, 1)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct StreamView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var activityFilter: ActivityFilter
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Activity.dateId, ascending: false),
            NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)
        ],
        animation: .default)
    private var activities: FetchedResults<Activity>
    
    var body: some View {
        List() {
            ForEach(activities.filter {
                if (activityFilter.selected.isEmpty) {
                    return true
                } else {
                    return activityFilter.selected.contains($0.option?.type ?? "")
                }
            }) { activity in   
                StreamItem(activity: activity)
                    .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
        .background(Color("AppBackground"))
        .scrollContentBackground(.hidden)
    }
}
//
//struct LogView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogView()
//    }
//}
