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
            Button(action: {
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
            }){
                HStack(spacing: 6) {
                    Text(activityOpt.icon ?? "")
                        .font(.custom("SourceSansPro-SemiBold", size: 18))
                    Text(activityOpt.type ?? "")
                        .font(.custom("SourceSansPro-SemiBold", size: 15))
                        .foregroundColor(Color(.textDark))
                }
                .padding(.horizontal, 11)
                .padding(.vertical, 8)
            }
            .background(Color(.cardBackground))
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
            .buttonStyle(BorderlessButtonStyle())
            .scrollContentBackground(.hidden)
        }
        .padding()
        .scrollContentBackground(.hidden)
    }
}
