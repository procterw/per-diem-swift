import Foundation

class DayList: ObservableObject {
    static func == (lhs: DayList, rhs: DayList) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    @Published var list: Array<DayItem> = []
    var index = 0;
    
    public func loadMore() {
        index = index + 1
        let interval = -86400 * index;
        self.list.append(DayItem(date: Date(timeIntervalSinceNow: TimeInterval(interval)), activities: []));
//        for i in index...index + 15 {
//            let interval = -86400 * i;
//            self.list.append(DayItem(date: Date(timeIntervalSinceNow: TimeInterval(interval)), activities: []));
//        }
//        index = index + 16
    }

    init() {
        self.list.append(DayItem(date: Date(timeIntervalSinceNow: TimeInterval(0)), activities: []))
    }
}

