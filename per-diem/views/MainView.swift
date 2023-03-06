//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct FilterView: View {
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)
        ],
        animation: .default)
    private var options: FetchedResults<ActivityOption>
    
    var selectedActivities: [String]
    
    var body: some View {
        HStack() {
            ForEach(options) { option in
                Text(option.icon ?? "")
                    .font(.title)
                    .padding(.horizontal, 5)
            }
            Spacer()
        }
        .padding(.horizontal)
//        .border(.red)
    }
}

struct MainView: View {
    var body: some View {
        VStack {
            FilterView(selectedActivities: [])
            TabView {
                DayListView()
                    .tabItem {
                        Label("Daily", systemImage: "list.dash")
                    }
                CalendarView()
                    .tabItem {
                        Label("Monthly", systemImage: "calendar")
                    }
                StreamView()
                    .tabItem {
                        Label("Stream", systemImage: "scroll")
                    }
            }
        }
    }
}
