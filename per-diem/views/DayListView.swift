import SwiftUI

struct DayLabel: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var day: DayItem
    var activities: Array<Activity>

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
            .padding(.top, 10)
            .frame(width: 50)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(activities) { activity in
                    HStack(alignment: .top, spacing: 3) {
                        Text(activity.option?.icon ?? "")
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text(activity.type ?? "")
                                .font(.headline)
                            Text(activity.note ?? "")
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
//            .border(Color("CardBorder"), width: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("CardBorder"), lineWidth: 1)
            )
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DayListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    private var dateList: DayList = DayList()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateId, ascending: false)],
        animation: .default)
    private var activities: FetchedResults<Activity>
//
//    init() {
//        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 18)]
//    }

    var body: some View {
        NavigationStack {
            List(dateList.list) { day in
                ZStack {
                    NavigationLink(destination: EntryView(day: day, activities: activities.filter { $0.dateId == day.dateId }).navigationTitle(day.getDate())) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    
                    HStack {
                        DayLabel(day: day, activities: activities.filter { $0.dateId == day.dateId })
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            .background(Color("AppBackground"))
            .scrollContentBackground(.hidden)
            .navigationTitle("Calendar")
        }
    }
}

struct DayListView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView()
    }
}
