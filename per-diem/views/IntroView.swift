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

struct IntroView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: EstablishedViewModel = EstablishedViewModel()
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color("FilterSelectBackground"))
                    .frame(width: 30)
                Text("pd")
                    .font(.custom("SourceSerifPro-Bold", size: 25))
                    .padding(.horizontal, 5)
            }
//            Text("Welcome to Per-diem! 👋")
//                .font(.custom("SourceSerifPro-Bold", size: 20))
        }
        VStack(alignment: .leading, spacing: 5) {
            Text("Start by creating some categories of things you'd like to track. 🏃‍♀️")
                .font(.custom("SourceSansPro-Regular", size: 16))
            Text("This could be your workouts, meditation, morning pages, up to you. 🧘")
                .font(.custom("SourceSansPro-Regular", size: 16))
            Text("Per-diem does not collect or store any of your entries, personal data, or usage. 😶")
                .font(.custom("SourceSansPro-Regular", size: 16))
            ActivityOptionCreatorView()
            
        }
        .padding()
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
//        Spacer()
    }
}
