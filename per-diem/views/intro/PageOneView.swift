//
//  IntroView.swift
//  per-diem
//
//  Created by William Leahy on 10/21/23.
//

import SwiftUI

struct DemoActivity: Identifiable {
    var id = UUID()
    var icon: String
    var type: String
    var note: String
    var time: Double
}

struct PageOneView: View {
    @State private var opacity: Double = 0.0
    
    var activities = [DemoActivity]()
    
    init() {
        activities.append(
            DemoActivity(
                icon: "🏃‍♀️",
                type: "Running",
                note: "3 mile 8min pace Greenlake, ankle wasn't feeling great near the end",
                time: 0.2)
        )
        activities.append(
            DemoActivity(
                icon: "🌞",
                type: "Gratitude",
                note: "Did a walk with Kyle today \nNew episode of bake-off with Mary \n Skin feeling okay",
                time: 0.3)
        )
        activities.append(
            DemoActivity(
                icon: "🧘",
                type: "Stretching",
                note: "Forward fold routine, some lacrosse ball for neck and shoulders for 30 min",
                time: 0.4)
        )
        activities.append(
            DemoActivity(
                icon: "📖",
                type: "Journal",
                note: "Got up relatively early today, felt sluggish though. Coffee with Ted and took a short walk w/ music. Pretty meh day at work",
                time: 0.5)
        )
        activities.append(
            DemoActivity(
                icon: "🏋️",
                type: "Gym",
                note: "Mostly legs today; squat 3x12x245; hip thrusts 3x15x205; back extensions w/ 35lb 3x25; monkey foot leg raises w/ 25s",
                time: 0.6)
        )
        activities.append(
            DemoActivity(
                icon: "🎻",
                type: "Violin",
                note: "Got 20 minutes of practice in before dinner, ran through some slow bowing exercises",
                time: 0.7)
        )
    }

    var body: some View {
        VStack(spacing: 50) {
            IntroIcon()
            
            Text("Per-diem is a feature-light daily tracker for logging activities, journaling, and tracking progress.")

            VStack(spacing: 5) {
                ForEach(activities) { activity in
                    EntryItemViewAnimated(
                        icon: activity.icon,
                        type: activity.type,
                        note: activity.note,
                        delay: activity.time
                    )
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
