//
//  Activity+CoreDataProperties.swift
//  per-diem
//
//  Created by William Leahy on 11/19/23.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var dateAdded: Date?
    @NSManaged public var dateId: Int64
    @NSManaged public var dateModified: Date?
    @NSManaged public var note: String?
    @NSManaged public var notePreview: String?
    @NSManaged public var type: String?
    @NSManaged public var option: ActivityOption?

}

extension Activity : Identifiable {
    func toJSON() -> ExportedActivity {
        let activities = ExportedActivity(
            note: self.note ?? "",
            dateId: self.dateId,
            notePreview: self.notePreview ?? "",
            optionType: self.option?.type ?? "",
            optionIcon: self.option?.icon ?? "",
            optionCount: self.option?.count ?? 0
        )
        
        return activities
        
    }
}
//
//extension NSManagedObject {
//  func toJSON() -> String? {
//    let keys = Array(self.entity.attributesByName.keys)
//    let dict = self.dictionaryWithValues(forKeys: keys)
//    do {
//        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
//        let reqJSONStr = String(data: jsonData, encoding: .utf8)
//        return reqJSONStr
//    }
//    catch{}
//    return nil
//  }
//}
//
