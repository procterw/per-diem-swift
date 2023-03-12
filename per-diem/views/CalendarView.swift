//
//  CalendarView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI
//
//List() {
//    ForEach(activities.filter {
//        if (activityFilter.selected.isEmpty) {
//            return true
//        } else {
//            return activityFilter.selected.contains($0.option?.type ?? "")
//        }
//    }) { activity in
//        StreamItem(activity: activity)
//            .listRowInsets(EdgeInsets())
//    }
//}

struct DayCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var activities: FetchedResults<Activity>
    @EnvironmentObject private var activityFilter: ActivityFilter
    
    var day: DayItem

    init(day: DayItem) {
        self.day = day;
        _activities = FetchRequest<Activity>(
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: true)],
            predicate: NSPredicate(format: "dateId == %d", day.dateId)
        )
    }
    
    func getActivity(index: Int) -> some View {
        let filteredActivites = activities.filter {
            if (activityFilter.selected.isEmpty) {
                return true
            } else {
                return activityFilter.selected.contains($0.option?.type ?? "")
            }
        }
        if (filteredActivites.count < index + 1) {
            return Text("").frame(maxWidth: .infinity)
        }
        return Text(filteredActivites[index].option?.icon ?? "").frame(maxWidth: .infinity)
    }
    
    var body: some View {
        NavigationLink(destination:
            EntryView(day: day)
                .navigationTitle(day.getDate())
        ) {
            VStack(spacing: 0) {
                Group {
                    VStack(spacing: 3) {
                        HStack(spacing: 0) {
                            Text(day.getDayOfMonth())
                                .font(.custom("SourceSansPro-SemiBold", size: 15))
                                .frame(maxWidth: .infinity)
                            getActivity(index: 0)
                        }
                        HStack(spacing: 0) {
                            getActivity(index: 1)
                            getActivity(index: 2)
                        }
                    }
                    .padding(4)
                    .frame(height: 55)
                    .cornerRadius(5)
                }
                .background(Color("CardBackground"))

//                Group {
//                    LazyVGrid(columns: columns, alignment: .leading) {
//                        ForEach(activities) { activity in
//                            Text(activity.option?.icon ?? "")
//                        }
//                    }
//                }
//                .frame(height: 60)
//                .background(Color("CardBackground"))
            }
//            .border(Color("AppBackgroundLight"))
//            .padding(0.25)
        }
        .isDetailLink(false)
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(3)
    }
}

struct WeekRowView: View {
    var week: Week
    
    var body: some View {
        GridRow(alignment: .top) {
            if (week.offset > 0) {
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(week.offset)
            }
            ForEach(week.days) { day in
                DayCell(day: day)
            }
        }
    }
}

struct DayOfWeekLabels: View {
    private let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//    private let days: [String] = ["S", "M", "T", "W", "T", "F", "S"]

    var body: some View {
        HStack() {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity)
                    .font(.custom("SourceSansPro-SemiBold", size: 13))
//                    .italic()
            }
        }
    }
}

struct CalendarView: View {
    var calendar: PDCalendar = PDCalendar()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(calendar.months) { month in
                        Grid(horizontalSpacing: 2, verticalSpacing: 2) {
                            Text(month.getMonthName())
                                .font(.custom("SourceSerifPro-Black", size: 24))
                                .padding(.vertical, 5)
//                                .foregroundColor(Color("AppBackgroundBold"))
//                            Divider()
                            DayOfWeekLabels()
                                .padding(.vertical, 5)
//                            Divider()
                            ForEach(month.weeks) { week in
                                WeekRowView(week: week)
                            }
                        }
                        .padding(6)
                        //                    .padding()
                    }
                    Spacer()
                }
                .background(Color("AppBackground"))
                .scrollContentBackground(.hidden)
            }
        }
    }
}

//
//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
