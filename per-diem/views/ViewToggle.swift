//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct ViewNav: View {
    @EnvironmentObject private var activeView: ActiveView

    var body: some View {
        VStack {
            PdDivider()
            
            HStack(spacing: 40) {
                Spacer()
                Label("SettingsView", systemImage: "gearshape.fill")
                    .labelStyle(.iconOnly)
                    .font(.title3)
//                    .opacity(activeView.active == "settings" ? 1 : 0.4)
                    .onTapGesture {
                        activeView.setActive(next: "settings")
                    }
                
                ZStack {
                    Circle()
                        .fill(Color("FilterSelectBackground"))
                        .frame(width: 35)
                    Label("ListView", systemImage: "calendar.day.timeline.left")
                        .labelStyle(.iconOnly)
                        .font(.title3)
                    //                    .opacity(activeView.active == "list" ? 1 : 0.4)
                        .onTapGesture {
                            activeView.setActive(next: "list")
                        }
                }
                
                Label("CalendarView", systemImage: "calendar")
                    .labelStyle(.iconOnly)
                    .font(.title3)
//                    .opacity(activeView.active == "calendar" ? 1 : 0.4)
                    .onTapGesture {
                        activeView.setActive(next: "calendar")
                    }
                Spacer()
            }
            .padding(.horizontal, 15)
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
