//
//  MainView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

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
        ScrollView(.horizontal) {
            HStack {
                ForEach(options) { option in
                    ZStack {
                        Circle()
                            .fill(Color("FilterSelectBackground"))
                            .frame(width: activityFilter.selected.contains(option.type ?? "") ? 28 : 0)

                        Text(option.icon ?? "")
                            .font(.title)
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
                }
            }
        }
    }
}
