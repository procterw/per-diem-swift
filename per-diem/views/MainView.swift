//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var activeView: ActiveView

    var body: some View {
        ZStack {
            Color("AppBackground")
            VStack {
                switch activeView.active {
                case "list":
                    DayListView()
                case "calendar":
                    CalendarView()
                default:
                    Text("ERROR")
                }
            }
        }
    }
}
