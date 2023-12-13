import SwiftUI

struct EntryItemViewAnimated: View {
    var icon: String
    var type: String
    var note: String
    var delay: Double
    
    @State private var height: Int = 20
    @State private var opacity: Double = 0.0

    var body: some View {
        EntryItemView(icon: icon, type: type, note: note)
            .offset(CGSize(width: 0, height: height))
            .opacity(opacity)
            .onAppear {
                withAnimation(.linear(duration: 0.25).delay(delay)) {
                    height = 0
                    opacity = 1.0
                }
            }
            .onDisappear {
                height = 20
                opacity = 0.0
            }
    }
}

struct EntryItemView: View {
    var icon: String
    var type: String
    var note: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(icon)
                .font(.title)
                .frame(width: 33)
            VStack(alignment: .leading) {
                Text(type)
                    .font(.custom("SourceSansPro-SemiBold", size: 17))
                Text(note)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
        }
    }
}

struct DayLabel: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var activityFilter: ActivityFilter
    @FetchRequest var activities: FetchedResults<Activity>
    
    var day: DayItem
    var searchTerm: String

    init(day: DayItem, searchTerm: String) {
        self.day = day;
        self.searchTerm = searchTerm;

        var subpredicates: Array<NSPredicate> = [
            NSPredicate(format: "dateId == %d", day.dateId)
        ]
        
        if (searchTerm.count > 0) {
            subpredicates.append(NSPredicate(format: "note CONTAINS[c] %@", searchTerm))
        }
        
        _activities = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)],
            predicate: NSCompoundPredicate(
                type: .and,
                subpredicates: subpredicates
            )
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 5) {
                Text(day.getDayOfWeek())
                    .font(.custom("SourceSerifPro-Black", size: 20))
                Text(day.getDate())
                    .font(.custom("SourceSerifPro-SemiBold", size: 16))
                Text(day.isToday() ? "Today" : "")
                    .font(.custom("SourceSerifPro-SemiBold", size: 13))
                    .background(Color("TodayBackground"))
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
                EntryItemView(
                    icon: activity.option?.icon ?? "",
                    type: activity.option?.type ?? "",
                    note: activity.note ?? ""
                )
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 15)
        .background(Color("CardBackground"))
        .onAppear {
            activities.forEach { activity in
                print(activity.toJSON())
            }
        }
    }
}

struct DayLink: View {
    @EnvironmentObject private var searchTerm: SearchTerm

    var day: DayItem

    var body: some View {
        ZStack {
            NavigationLink(destination:
                EntryView(day: day)
                    .toolbarBackground(Color("AppBackground"), for: .navigationBar)
            ) {
                EmptyView()
            }
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())

            DayLabel(day: day, searchTerm: searchTerm.term)
                .padding(.bottom, day.getDayOfWeek() == "Sun" ? 12 : 1)
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

struct DayListView: View {
    @ObservedObject var dateList: DayList = DayList()
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        ZStack {
            Color("AppBackground")
            NavigationStack {
                TopNavbar()
                    .padding(.bottom, -8)

                List {
                    ForEach(dateList.list) { day in
                        DayLink(day: day)
                            .listRowInsets(EdgeInsets())
                            .onAppear {
                                dateList.loadMore(date: day.date)
                            }
                        
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color("ViewBackground"))
                // When app is reopened, refresh in case it's a new day
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        dateList.refresh()
                    }
                }

                ViewNav()
                    .padding(.top, -8)
            }
        }
    }
}
