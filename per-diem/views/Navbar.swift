import SwiftUI

struct Navbar: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text("pd")
                    .font(.custom("SourceSerifPro-Black", size: 20))
                    .padding(.horizontal, 5)
                Divider()
                FilterView()
                Spacer()
                Divider()
                ViewToggle()
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            
            Divider()
        }
        .background(Color("AppBackground"))
//        .overlay(
//            VStack {
//                Divider()
//                    .offset(x: 0, y: 0)
//            }
//        )
    }
}

struct EntryNavbar: View {
    @Environment(\.dismiss) private var dismiss
    
    var day: DayItem

    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Label("BackButton", systemImage: "arrowshape.backward.fill")
                    .labelStyle(.iconOnly)
                    .foregroundColor(.black)
            }
            Text(day.getFullDate())
                .font(.custom("SourceSerifPro-SemiBold", size: 18))
            Spacer()
        }
        .background(Color("AppBackground"))
        .frame(height: 40)
        .padding(.horizontal, 10)
        .overlay(
            VStack {
                Divider()
                    .offset(x: 0, y: 27)
            }
        )
    }
}
