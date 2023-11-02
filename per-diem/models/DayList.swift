import Foundation

class DayList: ObservableObject {
    @Published var list: Array<DayItem> = []
    var calendar = Calendar(identifier: .gregorian)
    
    // Adding 100ms prevents edge case where only one day would be added
    var earliestDate: Date = .now + 100
    
    public func loadMore(date: Date) {
        print("load more")
        if (date > earliestDate) {
            return
        }
        self.earliestDate = date
        let interval = -86400 * list.count;
        self.list.append(DayItem(date: Date(timeIntervalSinceNow: TimeInterval(interval)), activities: []));
    }
    
    public func refresh() {
        print("refreshing")
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
        self.list.append(DayItem(date: .now, activities: []))
        self.calendar.locale = Locale.autoupdatingCurrent
    }
}

