//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct FilterToggle: View {
    @EnvironmentObject private var activityFilter: ActivityFilter
    
    func getColor () -> Color {
        if (activityFilter.open) {
            return Color("SelectedContrast")
        }
        return Color("TextDark")
    }
    
    var body: some View {
        Button(action: {
            activityFilter.toggle()
            activityFilter.clear()
        }) {
            HStack(spacing: 5) {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    .labelStyle(.iconOnly)
                Text("Filter")
            }
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            .foregroundColor(getColor())
        }
        .buttonStyle(NoPressEffectButton())
    }
}

struct FilterView: View {
    @EnvironmentObject private var activityFilter: ActivityFilter
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ActivityOption.count, ascending: false),
            NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true),
        ],
        animation: .default)
    private var options: FetchedResults<ActivityOption>

    var body: some View {
        if (activityFilter.open) {
            HStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 3) {
                        ForEach(options) { option in
                            ZStack {
                                Circle()
                                    .fill(Color("FilterSelectBackground"))
                                    .frame(width: activityFilter.selected.contains(option.type ?? "") ? 33 : 0)
                                
                                Text(option.icon ?? "")
                                    .font(.title2)
                                    .onTapGesture {
                                        let type = option.type ?? ""
                                        if (activityFilter.selected.contains(type)) {
                                            activityFilter.setSelected(next: activityFilter.selected.filter { $0 != type })
                                        } else {
                                            var next = activityFilter.selected
                                            next.append(type)
                                            activityFilter.setSelected(next: next)
                                        }
                                    }
                            }
                            .frame(width: 33)
                        }
                    }
                }
                
                Spacer()
                Divider()

                Button("Clear") {
                    activityFilter.clear()
                }
                .foregroundColor(Color(.textDark))
                .font(.custom("SourceSansPro-SemiBold", size: 16))
                .padding(.leading, 6)
                .disabled(activityFilter.isEmpty())
            }
            .frame(height: 38)
            .padding(.horizontal, 15)
        }
    }
}
