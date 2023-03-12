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
        VStack {
            HStack(spacing: 5) {
                FilterView()
                Spacer()
                Divider()
                ViewToggle()
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .overlay(
                VStack {
                    Divider()
                        .foregroundColor(.black)
                        .background(.black)
                        .offset(x: 0, y: 27.8)
                }
            )
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
