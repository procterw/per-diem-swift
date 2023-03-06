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
        self.date = DayItem(date: activity.dateAdded ?? Date(), activities: [])
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(date.getFullDate())
                .font(.subheadline)
                .padding(.bottom, 5.0)
            Text(activity.note ?? "")
                .font(.body)
        }
        .padding(5)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct StreamView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Activity.dateId, ascending: false),
            NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)
        ],
        animation: .default)
    private var activities: FetchedResults<Activity>
    
    var body: some View {
        List() {
            ForEach(activities) { activity in
                StreamItem(activity: activity)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color("AppBackground"))
        .scrollContentBackground(.hidden)
        .navigationTitle("Stream")
    }
}
//
//struct LogView_Previews: PreviewProvider {
//    static var previews: some View {
//        LogView()
//    }
//}
