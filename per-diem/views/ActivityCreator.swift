import SwiftUI

struct ActivityCreator: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var day: DateItem
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ActivityOption.type, ascending: true)],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>
    
    init(day: DateItem) {
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

struct ActivityCreator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCreator()
    }
}
