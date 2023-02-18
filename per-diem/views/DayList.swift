import SwiftUI

struct DayLabel: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var day: DateItem
    var activities: Array<Activity>

    var body: some View {
        HStack{
            Text(day.dateString)
            VStack {
                ForEach(activities) { activity in
                    Text(activity.type ?? "")
                }
            }
        }
    }
}

struct DayList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    private var dateList: DateList = DateList()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateId, ascending: true)],
        animation: .default)
    private var activities: FetchedResults<Activity>

    var body: some View {
        NavigationStack {
            List(dateList.list) { day in
                NavigationLink(value: day) {
                    DayLabel(day: day, activities: activities.filter { $0.dateId == day.dateId })
                }
            }
            .navigationDestination(for: DateItem.self) { day in
                EntryScreen(day: day, activities: activities.filter { $0.dateId == day.dateId })
            }
            .navigationTitle("Calendar")
        }
    }
}

struct DayList_Previews: PreviewProvider {
    static var previews: some View {
        DayList()
    }
}
