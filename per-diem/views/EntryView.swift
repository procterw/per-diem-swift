import SwiftUI

struct EntryView: View {
    @State private var showingSheet = false

    var day: DayItem
    var activities: Array<Activity>
    
    func delete(at offsets: IndexSet) {
        print("delete")
    }

    var body: some View {
        VStack {
            ForEach(activities) { activity in
                ActivityEditorView(activity: activity)
            }
            .onDelete(perform: delete)
            ActivityCreatorView(day: day)
            Button("Add activity type") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                ActivityOptionCreatorView()
            }
            Spacer()
        }
        .background(Color("AppBackground"))
    }
}


struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(day: DayItem(date: Date(), activities: []), activities: [])
    }
}
