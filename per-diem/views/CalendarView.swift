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
            sortDescriptors: [NSSortDescriptor(keyPath: \Activity.dateAdded, ascending: false)],
            predicate: NSPredicate(format: "dateId == %d", day.dateId)
        )
    }
    
    let columns = [
        GridItem(spacing: 5, alignment: .top),
        GridItem(spacing: 5, alignment: .top)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            Text(day.getDayOfMonth())
                .fixedSize(horizontal: false, vertical: true)
                .font(.subheadline)
                .fontWeight(.bold)
            ForEach(activities) { activity in
                Text(activity.option?.icon ?? "")
            }
        }
        .frame(minHeight: 50)
        
    }
}

struct WeekRowView: View {
    var week: Week
    
    var body: some View {
        GridRow {
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

struct CalendarView: View {
    var calendar: PDCalendar = PDCalendar()

    var body: some View {
        VStack {
            ForEach(calendar.months) { month in
                Grid {
                    Text(month.getMonthName())
                        .font(.title3)
                        .fontWeight(.bold)
                    Divider()
                    ForEach(month.weeks) { week in
                        WeekRowView(week: week)
                    }
                }
            }
            Spacer()
        }
        .background(Color("AppBackground"))
    }
}

//
//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
