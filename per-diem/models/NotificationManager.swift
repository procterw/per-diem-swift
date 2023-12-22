//
//  NotificationManager.swift
//  per-diem
//
//  Created by William Leahy on 12/18/23.
//

import Foundation
import SwiftUI

class NotificationManager: NSObject, ObservableObject {
    @Published var viewManager: ViewManager?
    
    func setViewMananger(nextViewMananger: ViewManager) {
        self.viewManager = nextViewMananger
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if (viewManager != nil) {
            viewManager?.setView(nextViewId: CoreViews.listView)
        }
    }
}
