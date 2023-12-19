import Foundation

class DayList: ObservableObject {
    @Published var list: Array<DayItem> = []
    var calendar = Calendar(identifier: .gregorian)
    
    // Adding 100ms prevents edge case where only one day would be added
    var earliestDate: Date = .now + 100
    
    public func loadMore(date: Date) {
        if (date > earliestDate) {
            return
        }
        self.earliestDate = date
        let interval = -86400 * list.count;
        self.list.append(DayItem(date: Date(timeIntervalSinceNow: TimeInterval(interval))));
    }
    
    public func refresh() {
        // start at first day in list
        let firstDate: DayItem = list[0]
        var date: DayItem = firstDate;

        // is it today? If it is, we're done!
        while (!date.isToday()) {
            // if not, make it yesterday then add it to front of the list
            date = date.nextDay()
            self.list.insert(date, at: 0)
        }
    }

    init() {
        self.list.append(DayItem(date: .now))
        self.calendar.locale = Locale.autoupdatingCurrent
    }
}

