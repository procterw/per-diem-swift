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
    
    func getColor () -> Color {
        if (viewManager.currentViewId == viewKey) {
            return Color("SelectedContrast")
        }
        return Color("TextDark")
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Label(label, systemImage: icon)
                .foregroundColor(getColor())
                .labelStyle(.iconOnly)
                .font(.title3)
            
            Text(label)
                .font(.custom("SourceSansPro-SemiBold", size: 13))
                .foregroundStyle(getColor())
        }
        .padding(.horizontal, 10)
        .onTapGesture {
            viewManager.setView(nextViewId: viewKey)
        }
    }
}

struct ViewNav: View {
    @EnvironmentObject private var activeView: ActiveView

    var body: some View {
        VStack {
            PdDivider()
            
            HStack(spacing: 20) {
                Spacer()
                ViewNavItem(label: "Settings", icon: "gearshape.fill", viewKey: CoreViews.settingsView)
                ViewNavItem(label: "Daily", icon: "calendar.day.timeline.left", viewKey: CoreViews.listView)
                ViewNavItem(label: "Calendar", icon: "calendar", viewKey: CoreViews.calendarView)
                ViewNavItem(label: "List", icon: "list.dash", viewKey: CoreViews.streamView)
                Spacer()
            }
            .frame(height: 50)
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
