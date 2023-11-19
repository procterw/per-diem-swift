//
//  ActivityOption+CoreDataProperties.swift
//  per-diem
//
//  Created by William Leahy on 11/19/23.
//
//

import Foundation
import CoreData


extension ActivityOption {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityOption> {
        return NSFetchRequest<ActivityOption>(entityName: "ActivityOption")
    }

    @NSManaged public var count: Int16
    @NSManaged public var dateAdded: Date?
    @NSManaged public var dateModified: Date?
    @NSManaged public var icon: String?
    @NSManaged public var type: String?
    @NSManaged public var activities: NSSet?

}

// MARK: Generated accessors for activities
extension ActivityOption {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}
