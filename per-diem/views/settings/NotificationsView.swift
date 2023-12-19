//
//  NotificationsView.swift
//  per-diem
//
//  Created by William Leahy on 11/28/23.
//

import SwiftUI
import UserNotifications

struct NotificationsView: View {
    @AppStorage("notificationTime") private var notificationTime = "2001-01-01T21:00:00Z"
    @AppStorage("enabled") private var enabled = false
    
    private func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    private func scheduleNotifications() {
        print("notificationTime!")

        let current = UNUserNotificationCenter.current()
        
        current.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "What did you do today?"
        content.subtitle = "Reminder to add your activities!"
        content.sound = UNNotificationSound.default
        
        let date = getFormatter().date(from: notificationTime) ?? Date()
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)

        // show this notification five seconds from now
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
    }
    
    private func getNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                scheduleNotifications()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setNotification() {
        if (!enabled) {
            return
        }

        let current = UNUserNotificationCenter.current()

        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                getNotificationPermissions()
            } else if settings.authorizationStatus == .denied {
                getNotificationPermissions()
            } else if settings.authorizationStatus == .authorized {
                scheduleNotifications()
                // Notification permission was already granted
            }
        })
    }

    var body: some View {
        let timeBinding: Binding<Date> = Binding(
            get: {
                return getFormatter().date(from: notificationTime) ?? Date()
            },
            set: {
                notificationTime = getFormatter().string(from: $0)
                setNotification()
            }
        )
        
        let enabledBinding: Binding<Bool> = Binding(
            get: {
                return enabled
            },
            set: {
                enabled = $0
                setNotification()
            }
        )

        HStack {
            Toggle("", isOn: enabledBinding)
                .frame(width: 50)
            DatePicker(
                "",
                selection: timeBinding,
                displayedComponents: [.hourAndMinute]
            )
            .datePickerStyle(.compact)
            .frame(width: 100)
                
            Spacer()
        }
    }
}
    
