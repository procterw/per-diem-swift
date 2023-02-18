import SwiftUI

struct EntryView: View {
    @State private var showingSheet = false

    var day: DayItem
    var activities: Array<Activity>

    var body: some View {
        Text(day.dateString)
//        VStack {
            ForEach(activities) { activity in
                ActivityEditorView(activity: activity)
            }
            ActivityCreatorView(day: day)
            Button("Add activity type") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                ActivityOptionCreatorView()
            }
//        }
    }
}


struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(day: DayItem(date: Date(), activities: []), activities: [])
    }
}
