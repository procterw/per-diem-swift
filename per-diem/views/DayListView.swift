import SwiftUI

struct DayLabel: View {
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
    
    var body: some View {
        HStack(alignment: .top){
            VStack {
                Text(day.getDayOfWeek())
                    .font(.title3)
                    .fontWeight(.bold)
                Text(day.getDate())
                    .font(.footnote)
                Spacer()
            }
            .padding(.top, 5)
            .frame(width: 50)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(activities.filter { $0.dateId == day.dateId }) { activity in
                    HStack(alignment: .top, spacing: 3) {
                        Text(activity.option?.icon ?? "")
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text(activity.type ?? "")
                                .font(.headline)
                            Text(activity.notePreview ?? "")
                                .font(.subheadline)
                                .lineLimit(1)
                        }
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color("CardBackground"))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("CardBorder"), lineWidth: 1)
            )
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
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

            HStack {
                DayLabel(day: day)
                Spacer()
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct DayListView: View {
    var dateList: DayList = DayList()

    var body: some View {
        NavigationStack {
            List(dateList.list) { day in
                DayLink(day: day)
            }
            .listStyle(PlainListStyle())
            .background(Color("AppBackground"))
            .scrollContentBackground(.hidden)
            .navigationTitle("Calendar")
        }
    }
}
//
//struct DayListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DayListView()
//    }
//}
