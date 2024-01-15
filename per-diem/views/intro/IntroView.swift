//
//  IntroView.swift
//  per-diem
//
//  Created by William Leahy on 10/21/23.
//

import SwiftUI

struct ActivityExampleScroll: View {
    var activities = [
        "🧳🍜🎾🏀🎽🛼🏋️🏌️‍♀️🤹‍♀️🥦😎🐔🌞🐟👜🚶🏻‍♀️👣🧑‍🍳🪕🧗🎻🚲1️⃣2️⃣3️⃣4️⃣5️⃣🩼📖🔨🧘🛹🍼🧁"
    ]

    var body: some View {
        HStack {
            
        }
//
//        .font(.custom("SourceSerifPro-Regular", size: 34))
//        .frame(width: 3000)
//        .tracking(15)
//        .foregroundColor(Color(.filterSelectBackground))
    }
}

struct IntroIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color("FilterSelectBackground"))
                .frame(width: 30)
            
            Text("per-diem")
                .font(.custom("SourceSerifPro-Bold", size: 25))
                .padding(.horizontal, 5)
            
            Spacer()
        }
        .padding(.top, 40)
    }
}

struct IntroView: View {
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("TextDark"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("TextDark")).withAlphaComponent(0.2)
    }

    var body: some View {
        ScrollView {
            ZStack {
                Color(.todayBackground)
                IntroIcon()
            }
            .frame(height: 160)
            
            ZStack {
                Color(.viewBackground)
                PageThreeView()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(.viewBackground))
    }
}
