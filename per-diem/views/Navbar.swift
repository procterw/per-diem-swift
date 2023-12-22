import SwiftUI

struct TopNavbar: View {
 
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Logo()
                Divider()
                FilterView()
                Divider()
                SearchToggle()
                //            SettingsToggle()
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            SearchView()
            PdDivider()
        }
        .background(Color("ToolbarBackground"))
        
    }
}

struct SettingsNavbar: View {

    var body: some View {
        VStack {
            HStack {
                Logo()
                Spacer()
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            
            PdDivider()
        }
        .background(Color("ToolbarBackground"))
    }
}

struct EntryNavbar: View {
    @Environment(\.dismiss) private var dismiss
    
    var day: DayItem

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Label("BackButton", systemImage: "arrowshape.backward.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(Color("TextDark"))
                }
                Text(day.getFullDate())
                    .font(.custom("SourceSerifPro-SemiBold", size: 18))
                Spacer()
            }
            .frame(height: 40)
            .padding(.horizontal, 10)
            .navigationBarBackButtonHidden(true)
            
            PdDivider()
        }
        .background(Color("ToolbarBackground"))
    }
}
