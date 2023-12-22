//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct ViewNavItem: View {
    @EnvironmentObject private var viewManager: ViewManager
    let label: String
    let icon: String
    let viewKey: CoreViews
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("TodayBackground"))
                .frame(width: viewManager.currentViewId == viewKey ? 40 : 0)
            Label(label, systemImage: icon)
                .labelStyle(.iconOnly)
                .font(.title3)
                .onTapGesture {
                    viewManager.setView(nextViewId: viewKey)
                }
        }
        .frame(width: 40)
    }
}

struct ViewNav: View {
    @EnvironmentObject private var activeView: ActiveView

    var body: some View {
        VStack {
            PdDivider()
            
            HStack(spacing: 40) {
                Spacer()
                ViewNavItem(label: "SettingsView", icon: "gearshape.fill", viewKey: CoreViews.settingsView)
                ViewNavItem(label: "ListView", icon: "calendar.day.timeline.left", viewKey: CoreViews.listView)
                ViewNavItem(label: "CalendarView", icon: "calendar", viewKey: CoreViews.calendarView)
                ViewNavItem(label: "StreamView", icon: "list.dash", viewKey: CoreViews.streamView)
                Spacer()
            }
            .frame(height: 40)
        }
        .background(Color("ToolbarBackground"))
    }
}

struct Logo: View {
    var body: some View {
        ZStack {
            Text("pd")
                .font(.custom("SourceSerifPro-Black", size: 20))
                .padding(.horizontal, 5)
        }
    }
}
