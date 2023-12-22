//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewManager: ViewManager
    @EnvironmentObject private var notificationManager: NotificationManager
    @FetchRequest(sortDescriptors: [])
    private var options: FetchedResults<Established>

    var body: some View {
        ZStack {
            Color("AppBackground")
            VStack {
                if (options.count > 0) {
                    if (viewManager.currentViewId == CoreViews.listView) {
                        DayListView()
                    } else if (viewManager.currentViewId == CoreViews.calendarView) {
                        CalendarView()
                    } else if (viewManager.currentViewId == CoreViews.settingsView) {
                        SettingsView()
                    } else if (viewManager.currentViewId == CoreViews.streamView) {
                        StreamView()
                    }
                } else {
                    IntroView()
                }
            }
        }.onAppear(perform: {
            notificationManager.setViewMananger(nextViewMananger: viewManager)
        })
    }
}
