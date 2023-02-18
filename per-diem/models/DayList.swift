import Foundation

class DayList: Hashable {
    static func == (lhs: DayList, rhs: DayList) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var list: Array<DayItem>
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    init() {
        var list: Array<DayItem> = [];
        for i in 0...15 {
            let interval = -86400 * i;
            list.append(DayItem(date: Date(timeIntervalSinceNow: TimeInterval(interval)), activities: []));
        }
        self.list = list;
    }
}

