//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            DayListView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            CalendarView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}
