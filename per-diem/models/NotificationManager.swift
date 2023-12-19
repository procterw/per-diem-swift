//
//  NotificationManager.swift
//  per-diem
//
//  Created by William Leahy on 12/18/23.
//

import Foundation
import SwiftUI

enum MyViews {
    case viewA
    case viewB
    case viewC
}

class NotificationManager: NSObject, ObservableObject {
    @Published var currentViewId: MyViews?
    @Published var viewManager: ViewManager?
    
    func setViewMananger(nextViewMananger: ViewManager) {
        self.viewManager = nextViewMananger
    }
    
    @ViewBuilder
    func currentView(for id: MyViews) -> some View {
        switch id {
        case .viewA:
            DayListView()
        case .viewB:
            CalendarView()
        default:
            DayListView()
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //App is in foreground
        //do whatever you want here, for example:
        print("FOOOO")
//        currentViewId = .viewB
//        completionHandler([.sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if (viewManager != nil) {
            viewManager?.setView(nextViewId: CoreViews.listView)
        }
    }
}
