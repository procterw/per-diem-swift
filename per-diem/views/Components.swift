//
//  Components.swift
//  per-diem
//
//  Created by William Leahy on 12/13/23.
//

import SwiftUI

struct PdDivider: View {
    var body: some View {
        Divider()
            .overlay(.gray)
            .frame(height: 1)
    }
}

//struct CustomButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .opacity(configuration.isPressed ? 0.5 : 1)
//    }
//}

//
//struct TitleStyle: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.title)
//            .lineSpacing(8)
//            .foregroundColor(.primary)
//    }
//}
//
