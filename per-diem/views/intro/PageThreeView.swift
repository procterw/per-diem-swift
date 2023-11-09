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

struct PageThreeView: View {
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
