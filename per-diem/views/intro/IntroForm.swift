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

struct IntroForm: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: EstablishedViewModel = EstablishedViewModel()
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text(
                "Per-diem is a lightweight daily tracker for logging activities, tracking habits, and journaling.\n\nTo get started, select some categories you'd like to track or create your own.")
                .font(.custom("SourceSerifPro-Regular", size: 16))
                .lineLimit(50)
                .padding(.top)

            ActivityList()
            
            ActivityOptionCreatorView()
            
            if (activityOptions.count > 0) {
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
                .transition(.push(from: .bottom))
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(.textDark))
                .background(Color(.cardBackground))
                .font(.custom("SourceSansPro-SemiBold", size: 16))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            
            Spacer()
        }
        .padding()
    }
}
