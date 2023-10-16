//
//  Activity+CoreDataProperties.swift
//  per-diem
//
//  Created by William Leahy on 10/15/23.
//
//

import Foundation
import CoreData

extension Activity: Codable {

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
