import SwiftUI

struct Entry: View {
    @State private var showingSheet = false

    var day: DateItem
    var activities: Array<Activity>

    var body: some View {
        Text(day.dateString)
        VStack {
            ForEach(activities) { activity in
                ActivityEditor(activity: activity)
            }
            ActivityCreator(day: day)
            Button("Add activity type") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                ActivityOptionCreator()
            }
        }
    }
}


struct Entry_Previews: PreviewProvider {
    static var previews: some View {
        Entry()
    }
}
