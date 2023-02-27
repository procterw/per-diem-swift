import SwiftUI
//import WrappingHStack

struct ActivityCreatorView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
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
            Button(action: {
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
            }) {
                Text([activityOpt.icon ?? "", activityOpt.type ?? ""].joined(separator: " "))
                    .padding(.all, 10)
                    .cornerRadius(5)
            }
            .foregroundColor(Color("TextDark"))
            .background(Color("CardBackground"))
            .font(.subheadline)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("CardBorder"), lineWidth: 1)
            )
        }
        .padding()
    }
}
//
//struct ActivityCreatorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityCreatorView(day: DayItem(date: Date(), activities: []), activities: [])
//    }
//}
