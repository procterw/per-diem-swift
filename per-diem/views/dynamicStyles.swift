//
//  dynamicStyles.swift
//  per-diem
//
//  Created by William Leahy on 1/7/24.
//

import SwiftUI

func cardBackground(day: DayItem) -> Color {
    if (day.isToday()) {
        return Color("TodayBackground")
    }
    
    var opacity = 1.0
    
    if (day.isWeekend()) {
        opacity = 0.6
    }
    
    return Color("CardBackground").opacity(opacity)
}
