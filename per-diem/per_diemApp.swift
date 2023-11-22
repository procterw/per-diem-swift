//
//  per_diemApp.swift
//  per-diem
//
//  Created by William Leahy on 2/16/23.
//

import SwiftUI

class ActivityFilter: ObservableObject {
    @Published var selected: [String]

    init(selected: [String]) {
        self.selected = selected
    }
    
    func setSelected(next: [String]) {
        selected = next
    }
}

class SearchTerm: ObservableObject {
    @Published var term: String = ""
    @Published var isOpen: Bool = false
    
    func set(nextTerm: String) {
        self.term = nextTerm
    }
    
    func clear() {
        self.term = ""
    }
    
    func toggle() {
        if (self.isOpen) {
            self.clear()
        }
        self.isOpen = !self.isOpen
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

@main
struct per_diemApp: App {
    let persistenceController = PersistenceController.shared
    
    // https://stackoverflow.com/questions/75640865/unable-to-add-custom-fonts-to-xcode-14-2/75648998#75648998
    private func registerCustomFonts() {
        let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        fonts?.forEach { url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
    
    init() {
        registerCustomFonts()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.font, .custom("SourceSerifPro-Regular", size: 17))
                .environmentObject(ActivityFilter(selected: []))
                .environmentObject(ActiveView(active: "list"))
                .environmentObject(SearchTerm())
        }
    }
}
