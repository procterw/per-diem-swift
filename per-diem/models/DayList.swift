import Foundation

class DayList: ObservableObject {
    @Published var list: Array<DayItem> = []
    private var tempList: Array<DayItem> = []
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
        var date: DayItem = firstDate
        var firstDayChanged = false
        
        // is it today? If it is, we're done!
        while (!date.getIsToday()) {
            firstDayChanged = true
            // if not, make it yesterday then add it to front of the list
            date = date.nextDay()
            self.list.insert(date, at: 0)
        }
        
        list.forEach { item in
            item.setIsToday()
        }
        
        // Attempt to fix issue where old days appear to be "today"
        // Need to go back and address the root issue of why those
        // child views aren't updating in the first place
        if (firstDayChanged) {
            tempList = list
            list.remove(at: 0)
            list.remove(at: 0)
            list.remove(at: 0)
            list.remove(at: 0)
            
            Task {
                await fullyRefreshList()
            }
        }
    }
    
    public func fullyRefreshList() async {
        try? await Task.sleep(nanoseconds: 5_000_000)
        list = tempList
    }

    init() {
        self.list.append(DayItem(date: .now))
        self.calendar.locale = Locale.autoupdatingCurrent
    }
}

