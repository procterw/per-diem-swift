//
//  CalendarView.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import SwiftUI

struct DayCell: View {
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
    
    let columns = [
        GridItem(spacing: 0, alignment: .center),
        GridItem(spacing: 0, alignment: .center)
    ]
    
    var body: some View {
        NavigationLink(destination:
            EntryView(day: day)
                .navigationTitle(day.getDate())
        ) {
            LazyVGrid(columns: columns, alignment: .leading) {
                Text(day.getDayOfMonth())
                    .fixedSize(horizontal: false, vertical: false)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.75)
                    .gridCellColumns(1)
                ForEach(activities) { activity in
                    Text(activity.option?.icon ?? "")
                }
            }
            .frame(minHeight: 60)
            .background(Color("CardBackground"))
        }
        .isDetailLink(false)
        .buttonStyle(PlainButtonStyle())
//        Spacer()
    }
}

struct WeekRowView: View {
    var week: Week
    
    var body: some View {
        GridRow() {
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

    var body: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct CalendarView: View {
    var calendar: PDCalendar = PDCalendar()

    var body: some View {
        NavigationStack {
            VStack {
                ForEach(calendar.months) { month in
                    Grid(alignment: .leading) {
                        Text(month.getMonthName())
                            .font(.title2)
                            .fontWeight(.bold)
                        Divider()
                        DayOfWeekLabels()
                        Divider()
                        ForEach(month.weeks) { week in
                            WeekRowView(week: week)
                        }
                    }
//                    .padding()
                }
                Spacer()
            }
            .background(Color("AppBackground"))
            .scrollContentBackground(.hidden)
            .navigationTitle("Calendar")
        }
    }
}

//
//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
