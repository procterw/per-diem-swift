//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var activeView: ActiveView
    @FetchRequest(sortDescriptors: [])
    private var options: FetchedResults<Established>

    var body: some View {
        ZStack {
            Color("AppBackground")
            VStack {
                if (options.count > 0) {
                    if (activeView.active == "list") {
                        DayListView()
                    } else if (activeView.active == "calendar") {
                        CalendarView()
                    } else if (activeView.active == "settings") {
                        SettingsView()
                    }
                } else {
                    IntroView()
                }
            }
        }
    }
}
