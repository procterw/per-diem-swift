import SwiftUI

struct ActivityCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingDeleteAlert = false
    
    var day: DayItem
    var activities: FetchedResults<Activity>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ActivityOption.type, ascending: true)],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>
    
    var filteredOptions: [ActivityOption] {
        let types = activities.map { $0.type }
        return activityOptions.filter { option in
            return !types.contains(option.type)
        }
    }
    
    var body: some View {
        WrappedHStack(filteredOptions) { activityOpt in
            Button(action: {}){
                Text([activityOpt.icon ?? "", activityOpt.type ?? ""].joined(separator: " "))
                    .padding(.all, 10)
                    .cornerRadius(5)
            }
            //    https://stackoverflow.com/a/66539032/1676699
            .simultaneousGesture(
                LongPressGesture()
                    .onEnded { _ in
                        showingDeleteAlert = true
                    }
            )
            .highPriorityGesture(
                TapGesture()
                    .onEnded { _ in
                        let activity = Activity(context: viewContext)
                        activity.type = activityOpt.type
                        activity.note = ""
                        activity.notePreview = ""
                        activity.dateId = day.dateId
                        activity.option = activityOpt
                        activity.dateAdded = Date()
                        activity.dateModified = Date()
                        do {
                            try viewContext.save()
                        } catch {
                            // Handle error
                        }
                    }
            )
            .confirmationDialog(
                Text("Delete category " + (activityOpt.type ?? "") + "?"),
                isPresented: $showingDeleteAlert,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    viewContext.delete(activityOpt)
                }
            }
            .foregroundColor(Color("TextDark"))
            .background(Color("CardBackground"))
            .font(.custom("SourceSansPro-SemiBold", size: 16))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("CardBorder"), lineWidth: 1)
            )
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
    }
}
