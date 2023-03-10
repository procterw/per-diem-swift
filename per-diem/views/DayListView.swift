import SwiftUI

struct DayLabel: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var activityFilter: ActivityFilter
    @FetchRequest var activities: FetchedResults<Activity>
    
    var day: DayItem

    init(day: DayItem) {
        self.day = day;
        _activities = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)],
            predicate: NSPredicate(format: "dateId == %d", day.dateId)
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text(day.getDayOfWeek())
                    .font(.custom("SourceSerifPro-Black", size: 24))
                Text(day.getDate())
                    .font(.custom("SourceSerifPro-SemiBold", size: 18))
                Spacer()
            }
            .padding(.leading, 40.0)
            ForEach(
                activities.filter {
                    if (activityFilter.selected.isEmpty) {
                        return true
                    } else {
                        return activityFilter.selected.contains($0.option?.type ?? "")
                    }
                }
            ) { activity in
                HStack(alignment: .top) {
                    Text(activity.option?.icon ?? "")
                        .font(.title)
                        .frame(width: 33)
                    VStack(alignment: .leading) {
                        Text(activity.type ?? "")
                            .font(.custom("SourceSerifPro-SemiBold", size: 17))
                        Text(activity.note ?? "")
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 15)
        .background(Color("CardBackground"))
    }
}

struct DayLink: View {
    var day: DayItem

    var body: some View {
        ZStack {
            NavigationLink(destination:
                EntryView(day: day)
                    .navigationTitle(day.getDate())
            ) {
                EmptyView()
            }
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())

            DayLabel(day: day)
                .padding(.top, 5)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct DayListView: View {
    var dateList: DayList = DayList()

    var body: some View {
        NavigationStack {
            List {
                ForEach(dateList.list) { day in
                    DayLink(day: day)
                        .listRowInsets(EdgeInsets())
                
            }
            }
            .listStyle(.plain)
            .background(Color("AppBackground"))
            .scrollContentBackground(.hidden)
        }
    }
}
