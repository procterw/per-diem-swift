//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct ViewToggle: View {
    @EnvironmentObject private var activeView: ActiveView
    
    func getImage() -> String {
        switch activeView.active {
            case "list":
                return "calendar"
            case "calendar":
                return "list.dash"
            default:
                return ""
        }
    }
    
    func getNext() -> String {
        switch activeView.active {
            case "list":
                return "calendar"
            case "calendar":
                return "list"
            default:
                return ""
        }
    }
    
    var body: some View {
        Label("ViewToggle", systemImage: getImage())
            .labelStyle(.iconOnly)
            .font(.title3)
            .padding(.horizontal, 5)
            .onTapGesture {
                activeView.setActive(next: getNext())
            }
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

struct SettingsToggle: View {
    @EnvironmentObject private var activeView: ActiveView
    
    var body: some View {
        Logo()
            .onTapGesture {
                activeView.toggleSettings()
            }
    }
}
