import Foundation

class DayList: ObservableObject {
    @Published var list: Array<DayItem> = []
    var earliestDate: Date = .now
    
    public func loadMore(date: Date) {
        if (date > earliestDate) {
            return
        }
        self.earliestDate = date
        let interval = -86400 * list.count;
        self.list.append(DayItem(date: Date(timeIntervalSinceNow: TimeInterval(interval)), activities: []));
    }

    init() {
        self.list.append(DayItem(date: .now, activities: []))
    }
}

