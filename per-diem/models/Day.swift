import Foundation

class DayItem: Identifiable, Hashable {
    static func == (lhs: DayItem, rhs: DayItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var date: Date
    var dateString: String
    var dateId: Int64
    var activities: Array<Activity>
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    init(date: Date, activities: Array<Activity>) {
        self.date = date;
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "YYYY-MM-dd";
        let dateString = dateFormatter.string(from: date);
        let dateId = Int64(dateString.replacingOccurrences(of: "-", with: "")) ?? 0

        self.dateString = dateString;
        self.dateId = dateId
        self.activities = activities.filter { $0.dateId == dateId }
    }
}
