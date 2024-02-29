//
//  per_diemApp.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

class ActivityFilter: ObservableObject {
    @Published var selected: [String]
    @Published var open: Bool = false

    init(selected: [String]) {
        self.selected = selected
    }
    
    func isEmpty() -> Bool {
        return selected.isEmpty
    }
    
    func clear() {
        selected = []
    }
    
    func setSelected(next: [String]) {
        selected = next
    }
    
    func toggle() {
        self.open = !open
    }
}

class SearchTerm: ObservableObject {
    @Published var term: String = ""
    @Published var open: Bool = false
    
    func isEmpty() -> Bool {
        return term.isEmpty
    }
    
    func set(nextTerm: String) {
        self.term = nextTerm
    }
    
    func clear() {
        self.term = ""
    }
    
    func toggle() {
        self.open = !open
    }
}

class ActiveView: ObservableObject {
    @Published var active: String
    @Published var settings: Bool = false
    
    init(active: String) {
        self.active = active
    }
    
    func setActive(next: String) {
        active = next
    }
    
    func toggleSettings() {
        settings = !settings
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        print("Application directory: \(NSHomeDirectory())")
        return true
    }
}

@main
struct per_diemApp: App {
    private let persistenceController = PersistenceController.shared
    private let notificationManager = NotificationManager()
    
    // https://stackoverflow.com/questions/75640865/unable-to-add-custom-fonts-to-xcode-14-2/75648998#75648998
    private func registerCustomFonts() {
        let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        fonts?.forEach { url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
    
    init() {
        registerCustomFonts()
        UNUserNotificationCenter.current().delegate = notificationManager
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.font, .custom("SourceSerifPro-Regular", size: 17))
                .environmentObject(ActivityFilter(selected: []))
                .environmentObject(ActiveView(active: "list"))
                .environmentObject(ViewManager())
                .environmentObject(SearchTerm())
                .environmentObject(notificationManager)
        }
    }
}
