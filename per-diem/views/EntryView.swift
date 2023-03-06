import SwiftUI

struct EntryView: View {
    @State private var showingSheet = false
    @Environment(\.managedObjectContext) private var viewContext
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
            List() {
                ForEach(activities) { activity in
                    ActivityEditorView(activity: activity)
                }
                .onDelete(perform: delete)
                .listRowSeparator(.hidden)
                .scrollContentBackground(.hidden)
                .listRowBackground(Color("AppBackground"))
                .cornerRadius(10)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.inset)
            .cornerRadius(10)
            ActivityCreatorView(day: day, activities: activities)
            Button("Add activity type") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                ActivityOptionCreatorView()
            }
            Spacer()
        }
        .toolbar(.hidden, for: .tabBar)
        .background(Color("AppBackground"))
        
    }
}

//
//struct EntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryView(day: DayItem(date: Date(), activities: []), activities: [])
//    }
//}
