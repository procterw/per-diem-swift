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
        }
    }
}

struct IntroPageOne: View {
    var body: some View {
        VStack(spacing: 5) {
            IntroIcon()
            Text("per-diem is a feature-light daily tracker for logging activities, journaling, and checking in on your consistency over time.")
            Image("ListDemo")
                .resizable()
                .frame(width: 350, height: 600)
        }
        .padding()
    }
}

struct IntroPageTwo: View {
    var body: some View {
        VStack(spacing: 5) {
            IntroIcon()
            Text("Start by creating some categories of things you'd like to track on a daily basis. 🏃‍♀️")
                .font(.custom("SourceSansPro-Regular", size: 16))
            Text("This could be your workouts, meditation, morning pages, up to you. 🧘")
                .font(.custom("SourceSansPro-Regular", size: 16))
            Text("Per-diem does not collect or store any of your entries, personal data, or usage. 😶")
                .font(.custom("SourceSansPro-Regular", size: 16))
            Image("CalendarDemo")
                .resizable()
                .frame(width: 350, height: 380)
            
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
        VStack {
            ActivityOptionCreatorView()
            
            Button(action: {
                let a = Established(context: viewContext)
                a.isEstablished = true
                
                do {
                    try viewContext.save()
                } catch {
                    // Handle error
                }
            }) {
                Text("Give it a shot")
            }
        }
    }
}

struct IntroView: View {

    var body: some View {
        TabView {
            IntroPageOne()
            IntroPageTwo()
            IntroPageThree()
        }
        .tabViewStyle(.page)
        .scrollContentBackground(.hidden)
    }
}
