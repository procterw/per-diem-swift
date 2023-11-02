//
//  IntroView.swift
//  per-diem
//
//  Created by William Leahy on 10/21/23.
//

import SwiftUI


class EstablishedViewModel: ObservableObject {
    @Published var isEstablished: Bool = false
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
    }
}

struct IntroPageOne: View {
    var body: some View {
        VStack(spacing: 50) {
            IntroIcon()
            
            Text("Per-diem is a feature-light daily tracker for logging activities, journaling, or tracking progress.")
            
            Image("ListDemo")
                .resizable()
                .frame(width: 340, height: 340)
            
            Spacer()
        }
        .padding()
    }
}

struct IntroPageTwo: View {
    var body: some View {
        VStack(spacing: 50) {
            IntroIcon()

            Text("Check in on your consistency or look at what you've been up to in the calendar view.")

            Image("CalendarDemo")
                .resizable()
                .frame(width: 340, height: 340)
            
            Spacer()
        }
        .padding()
    }
}

struct IntroPageThree: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: EstablishedViewModel = EstablishedViewModel()
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>

    var body: some View {
        VStack(spacing: 50) {
            IntroIcon()
            
            Text("To get started, what are some things you'd like to keep track of?")
            
            Text("Per-diem does not collect or store any user or usage data.")

            ActivityOptionCreatorView()
            
            WrappedHStack(activityOptions) { activityOpt in
                Text([activityOpt.icon ?? "", activityOpt.type ?? ""].joined(separator: " "))
                    .padding(.all, 5)
                    .foregroundColor(Color("TextDark"))
                    .font(.custom("SourceSansPro-SemiBold", size: 16))
            }
            .background(Color("CardBackground"))
            
            Button(action: {
                let a = Established(context: viewContext)
                a.isEstablished = true
                
                do {
                    try viewContext.save()
                } catch {
                    // Handle error
                }
            }) {
                Text("Get started")
            }
            .disabled(activityOptions.count < 1)
            .padding()
            .foregroundColor(Color("TextDark"))
            .background(Color("CardBackground"))
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("CardBorder"), lineWidth: 1)
            )
            .buttonStyle(BorderlessButtonStyle())
            
            Spacer()
        }
        .padding()
    }
}

struct IntroView: View {
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("FilterSelectBackground"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("FilterSelectBackground")).withAlphaComponent(0.2)
    }

    var body: some View {
        ZStack {
            Color("AppBackground")
            NavigationStack {
                TabView {
                    IntroPageOne()
                    IntroPageTwo()
                    IntroPageThree()
                }
                .background(Color("AppBackground"))
                .tabViewStyle(.page)
                .onAppear {
                    setupAppearance()
                }
            }
        }
    }
}
