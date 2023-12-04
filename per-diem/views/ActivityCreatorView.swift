import SwiftUI
import EmojiPicker

struct ActivityCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingDeleteAlert = false
    @State private var optionToDelete = ""
    
    var day: DayItem
    var activities: FetchedResults<Activity>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ActivityOption.count, ascending: false),
            NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true),
        ],
        animation: .default)
    private var activityOptions: FetchedResults<ActivityOption>
    
    var body: some View {
        WrappedHStack(activityOptions) { activityOpt in
            Button(action: {}){
                Text([activityOpt.icon ?? "", activityOpt.type ?? ""].joined(separator: " "))
                    .padding(.all, 10)
                    .cornerRadius(5)
            }
            //    https://stackoverflow.com/a/66539032/1676699
            .simultaneousGesture(
                LongPressGesture()
                    .onEnded { _ in
                        optionToDelete = activityOpt.type ?? ""
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
                        
                        activityOpt.count = activityOpt.count + 1
                        do {
                            try viewContext.save()
                        } catch {
                            // Handle error
                        }
                    }
            )
            .confirmationDialog(
                Text("Delete category " + optionToDelete + "?"),
                isPresented: $showingDeleteAlert,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    do {
                        if let activityOpt = activityOptions.first(where: { $0.type == optionToDelete }) {
                            viewContext.delete(activityOpt)
                            try viewContext.save()
                        }
                    } catch {
                        // Handle error
                    }
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
            .scrollContentBackground(.hidden)
        }
        .padding()
        .scrollContentBackground(.hidden)
    }
}
