import SwiftUI
//import WrappingHStack

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
        WrappedHStack(activityOptions) { activityOpt in
            Button([activityOpt.icon ?? "", activityOpt.type ?? ""].joined(separator: " ")) {
                let x = Activity(context: viewContext)
                x.type = activityOpt.type
                x.note = ""
                x.notePreview = ""
                x.dateId = day.dateId
                x.option = activityOpt
                do {
                    try viewContext.save()
                } catch {
                    // Handle error
                }
            }
            .buttonStyle(.bordered)
            
        }
//        HStack {
//            ForEach(activityOptions) { activityOpt in
//                Button([activityOpt.icon ?? "", activityOpt.type ?? ""].joined(separator: " ")) {
//                    let x = Activity(context: viewContext)
//                    x.type = activityOpt.type
//                    x.note = ""
//                    x.notePreview = ""
//                    x.dateId = day.dateId
//                    x.option = activityOpt
//                    do {
//                        try viewContext.save()
//                    } catch {
//                        // Handle error
//                    }
//                }
//                .buttonStyle(.bordered)
//            }
//        }
//        .fixedSize(horizontal: false, vertical: false)
    }
}

struct ActivityCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCreatorView(day: DayItem(date: Date(), activities: []))
    }
}
