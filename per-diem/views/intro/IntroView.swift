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
    }
}

struct IntroView: View {
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("TextDark"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("TextDark")).withAlphaComponent(0.2)
    }

    var body: some View {
        ZStack {
            Color("ViewBackground")
            NavigationStack {
                TabView {
                    PageOneView()
                    PageTwoView()
                    PageThreeView()
                }
                .background(Color("ViewBackground"))
                .tabViewStyle(.page)
                .onAppear {
                    setupAppearance()
                }
            }
        }
    }
}
