import SwiftUI

struct DayLabel: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var day: DayItem
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

struct DayListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    private var dateList: DayList = DayList()
    
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
            .navigationDestination(for: DayItem.self) { day in
                EntryView(day: day, activities: activities.filter { $0.dateId == day.dateId })
            }
            .navigationTitle("Calendar")
        }
    }
}

struct DayListView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView()
    }
}
