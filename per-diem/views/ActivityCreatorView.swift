import SwiftUI

struct ActivityCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var day: DayItem
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ActivityOption.type, ascending: true)],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>
    
    init(day: DayItem) {
        self.day = day
    }
    
    var body: some View {
        HStack {
            Button("foo") {
                print("foooo")
            }
        }
    }
}

struct ActivityCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCreatorView(day: DayItem(date: Date(), activities: []))
    }
}
