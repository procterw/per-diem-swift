//
//  TodayBadge.swift
//  per-diem
//
//  Created by William Leahy on 1/7/24.
//

import SwiftUI

struct TodayBadge: View {
    var day: DayItem

    var body: some View {
        if (day.isToday()) {
            Text("Today")
                .font(.custom("SourceSerifPro-SemiBold", size: 13))
                .background(Color("TodayBackground"))
        } else {
            EmptyView()
        }
    }
}

