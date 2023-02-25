import SwiftUI

struct EntryView: View {
    @State private var showingSheet = false
    @Environment(\.managedObjectContext) private var viewContext

    var day: DayItem
    var activities: Array<Activity>
    
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
        .background(Color("AppBackground"))
        
    }
}


struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(day: DayItem(date: Date(), activities: []), activities: [])
    }
}
