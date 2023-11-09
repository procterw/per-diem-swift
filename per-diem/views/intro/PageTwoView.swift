//
//  IntroView.swift
//  per-diem
//
//  Created by William Leahy on 10/21/23.
//

import SwiftUI

struct DemoCalendarMonth: Identifiable {
    var id = UUID()
    var weeks: Array<DemoCalendarWeek>
}

struct DemoCalendarWeek: Identifiable {
    var id = UUID()
    var days: Array<DemoCalendarDay>
    var index: Int
}

struct DemoCalendarDay: Identifiable {
    var id = UUID()
    var activity: String
}

struct WeekView: View {
    var week: DemoCalendarWeek
    var delay: Double

    @State private var height: Int = 20
    @State private var opacity: Double = 0.0
    
    var body: some View {
        HStack {
            ForEach(week.days) { day in
                Text(day.activity)
                    .frame(maxWidth: .infinity)
                    .font(.custom("SourceSansPro-SemiBold", size: 30))
            }
        }
        .offset(CGSize(width: 0, height: height))
        .opacity(opacity)
        .onAppear {
            withAnimation(.linear(duration: 0.25).delay(delay)) {
                height = 0
                opacity = 1.0
            }
        }
        .onDisappear {
            height = 20
            opacity = 0.0
        }
    }
}

struct PageTwoView: View {
    var calendar = DemoCalendarMonth(
        weeks: [
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: "🏃‍♀️"),
            ], index: 0),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: ""),
            ], index: 1),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: "🏃‍♀️"),
                DemoCalendarDay(activity: ""),
            ], index: 2),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: "🏋️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏋️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏋️"),
                DemoCalendarDay(activity: ""),
            ], index: 3),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏋️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏋️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏋️"),
            ], index: 4),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏋️"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🏋️"),
                DemoCalendarDay(activity: "🏋️"),
            ], index: 5),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
            ], index: 6),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: "🎻"),
            ], index: 7),
            DemoCalendarWeek(days: [
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: ""),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: "🎻"),
                DemoCalendarDay(activity: ""),
            ], index: 8),
        ]
    )

    var body: some View {
        VStack(spacing: 50) {
            IntroIcon()

            Text("Check in on your consistency or look at what you've been up to in the calendar view.")
            
            VStack(spacing: 5) {
                DayOfWeekLabels()
                ForEach(calendar.weeks) { week in
                    WeekView(week: week, delay: Double(week.index) * 0.1)
                }
            }

            Spacer()
        }
        .padding()
    }
}
