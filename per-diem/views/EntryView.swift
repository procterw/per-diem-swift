import SwiftUI

enum Focusable: Hashable {
  case none
  case row(id: String)
}


struct EntryView: View {
    @State private var showingSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @FetchRequest var activities: FetchedResults<Activity>
    
    var day: DayItem

    init(day: DayItem) {
        self.day = day;
        _activities = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)],
            predicate: NSPredicate(format: "dateId == %d", day.dateId)
        )
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let activity = activities[index]
            viewContext.delete(activity)
        }
        do {
            try viewContext.save()
        } catch {
            // Handle error
        }
    }

    var body: some View {
        VStack {
            EntryNavbar(day: day)
                .padding(.bottom, -8)
            List() {
                ForEach(activities) { activity in
                    ActivityEditorView(activity: activity, note: activity.note ?? "")
                        .padding(.bottom, 1)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: delete)
                .scrollContentBackground(.hidden)
                .listRowBackground(Color("ViewBackground"))
                .listRowInsets(EdgeInsets())

                ActivityCreatorView(
                    day: day,
                    activities: activities  
                )
                    .listRowSeparator(.hidden)
                    .scrollContentBackground(.hidden)
                    .listRowBackground(Color("ViewBackground"))
                    .listRowInsets(EdgeInsets())
                
                // I'm not sure if this is necessary
                Divider()
                    .background(Color("ViewBackground"))
                    .listRowBackground(Color("ViewBackground"))

                ActivityOptionCreatorView()
                    .listRowSeparator(.hidden)
                    .scrollContentBackground(.hidden)
                    .listRowBackground(Color("ViewBackground"))
            }
            .background(Color("ViewBackground"))
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .scrollDismissesKeyboard(.immediately)
        }
        .background(Color("ViewBackground"))
    }
}
