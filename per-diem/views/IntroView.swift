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

    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            ActivityOptionCreatorView()
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
            Text("Give it a shot")
        }
    }
}
