//
//  ViewManager.swift
//  per-diem
//
//  Created by William Leahy on 12/18/23.
//

import SwiftUI

enum CoreViews {
    case settingsView
    case listView
    case calendarView
    case streamView
}

class ViewManager: ObservableObject {
    @Published var currentViewId: CoreViews
    
    init() {
        currentViewId = CoreViews.listView
    }
    
    func setView(nextViewId: CoreViews) {
        currentViewId = nextViewId
    }
    
    @ViewBuilder
    func currentView() -> some View {
        switch currentViewId {
            case .settingsView:
                SettingsView()
            case .listView:
                DayListView()
            case .calendarView:
                CalendarView()
            case .streamView:
                StreamView()
        }
    }
}
