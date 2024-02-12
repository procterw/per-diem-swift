import Foundation

// https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

class DayItem: Identifiable, Hashable {
    static func == (lhs: DayItem, rhs: DayItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var date: Date
    var dateString: String
    var dateId: Int64
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
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
    
    public func getFullDayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    public func isWeekend() -> Bool {
        return getDayOfWeek() == "Sat" || getDayOfWeek() == "Sun"
    }
    
    public func getFullDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    public func isToday() -> Bool {
        return Calendar.current.isDateInToday(self.date)
    }
    
    public func nextDay() -> DayItem {
        return DayItem(
            date: Calendar.current.date(byAdding: .day, value: 1, to: date)!
        )
    }
    
    public func previousDay() -> DayItem {
        return DayItem(
            date: Calendar.current.date(byAdding: .day, value: -1, to: date)!
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
    
    init(date: Date) {
        self.date = date;
        
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        let dateString = dateFormatter.string(from: date);
        
        let dateId = Int64(dateString.replacingOccurrences(of: "-", with: "")) ?? 0

        self.dateString = dateString;
        self.dateId = dateId
    }
}

func dayItemFromId (dateId: Int64) -> DayItem {
    let dateFormatter = DateFormatter();
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let dateIdString = String(dateId)
    
    let dateString = [
        dateIdString[0 ..< 4],
        dateIdString[4 ..< 6],
        dateIdString[6 ..< 8]
    ].joined(separator: "-")
    
    return DayItem(date: dateFormatter.date(from: dateString) ?? .now)
}
