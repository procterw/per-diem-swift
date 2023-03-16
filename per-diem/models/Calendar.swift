//
//  Calendar.swift
//  per-diem
//
//  Created by William Leahy on 2/24/23.
//

import Foundation

class Week: Identifiable, Hashable {
    static func == (lhs: Week, rhs: Week) -> Bool {
        return lhs.id == rhs.id
    }

    let id = UUID()
    var days: [DayItem]
    var offset: Int
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    init(days: Array<DayItem>) {
        self.offset = days[0].getDayOffset()
        self.days = days;
    }
}

class Month: Identifiable, Hashable {
    static func == (lhs: Month, rhs: Month) -> Bool {
        return lhs.id == rhs.id
    }

    let id = UUID()
    let initDate: Date
    var weeks: [Week] = []

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public func getMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: initDate)
    }
    
    func splitDaysIntoWeeks(for days: [DayItem]) -> [Week] {
        var weeks: [Week] = []
        var currentWeek: [DayItem] = []
        for day in days {
            currentWeek.append(day)
            if (day.getDayOfWeek() == "Sat") {
                weeks.append(Week(days: currentWeek))
                currentWeek = []
            }
        }
        if (!currentWeek.isEmpty) {
            weeks.append(Week(days: currentWeek))
        }
        return weeks
    }
    
    // https://codecrew.codewithchris.com/t/list-of-days-in-current-month/17722
    func getDaysInMonth(for month: Date) -> [DayItem] {
        //get the current Calendar for our calculations
        let cal = Calendar.current
        //get the days in the month as a range, e.g. 1..<32 for March
        let monthRange = cal.range(of: .day, in: .month, for: month)!
        //get first day of the month
        let comps = cal.dateComponents([.year, .month], from: month)
        //start with the first day
        //building a date from just a year and a month gets us day 1
        var date = cal.date(from: comps)!

        //somewhere to store our output
        var dates: [DayItem] = []
        //loop thru the days of the month
        for _ in monthRange {
            //add to our output array...
            dates.append(DayItem(date: date, activities: []))
            //and increment the day
            date = cal.date(byAdding: .day, value: 1, to: date)!
        }
        return dates
    }
    
    init(month: Date) {
        self.initDate = month
        let days = getDaysInMonth(for: month)
        self.weeks = splitDaysIntoWeeks(for: days)
    }
}

class PDCalendar: ObservableObject {
    @Published var months: [Month]
    
    var index = -2;
    
    public func loadMore() {
        self.months.append(
            Month(month: Calendar.current.date(byAdding: .month, value: index - 1, to: Date())!)
        )

        index = index - 1
    }
    
    init () {
        self.months = [
            Month(month: .now),
            Month(month: Calendar.current.date(byAdding: .month, value: -1, to: Date())!),
            Month(month: Calendar.current.date(byAdding: .month, value: -2, to: Date())!),
        ]
    }
}
