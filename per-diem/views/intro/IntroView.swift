//
//  IntroView.swift
//  per-diem
//
//  Created by William Leahy on 10/21/23.
//

import SwiftUI

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
        VStack {
            ZStack {
                Color(.todayBackground)
                IntroIcon()
            }
            .frame(height: 160)
            
            ZStack {
                Color(.viewBackground)
                IntroForm()
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color(.viewBackground))
    }
}
