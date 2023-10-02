import SwiftUI

struct EntryView: View {
    @State private var showingSheet = false
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @FetchRequest var activities: FetchedResults<Activity>
    
    var day: DayItem

    init(day: DayItem) {
        self.day = day;
        print(day)
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
            List() {
                ForEach(activities) { activity in
                    ActivityEditorView(activity: activity)
                        .padding(.bottom, 5)
                }
                .onDelete(perform: delete)
                .listRowSeparator(.hidden)
                .scrollContentBackground(.hidden)
                .listRowBackground(Color("AppBackground"))
                .listRowInsets(EdgeInsets())

                ActivityCreatorView(day: day, activities: activities)
                    .listRowSeparator(.hidden)
                    .scrollContentBackground(.hidden)
                    .listRowBackground(Color("AppBackground"))
                    .listRowInsets(EdgeInsets())
            }
            .background(Color("AppBackground"))
            .scrollContentBackground(.hidden)
            .listStyle(.plain) 
        }
        .background(Color("AppBackground"))
    }
}
