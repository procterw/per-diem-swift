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
    
    public func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: date)
    }
    
    public func getDayOfMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    public func getDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: date)
    }
    
    public func getFullDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter.string(from: date)
    }
    
    public func isToday() -> Bool {
        return Calendar.current.isDateInToday(self.date)
    }
    
    public func nextDay() -> DayItem {
        return DayItem(
            date: Calendar.current.date(byAdding: .day, value: 1, to: date)!,
            activities: []
        )
    }
    
    public func previousDay() -> DayItem {
        return DayItem(
            date: Calendar.current.date(byAdding: .day, value: -1, to: date)!,
            activities: []
        )
    }
    
    public func isInTheFuture() -> Bool {
        return self.date < Date()
    }
    
    // How many days from Sunday is this day?
    public func getDayOffset() -> Int {
        let offset = Calendar.current.dateComponents([.weekday], from: date).weekday ?? 0
        return offset - 1
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
