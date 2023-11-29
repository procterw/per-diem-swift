//
//  Configuration+CoreDataProperties.swift
//  per-diem
//
//  Created by William Leahy on 11/28/23.
//
//

import Foundation
import CoreData


extension Configuration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: "Configuration")
    }

    @NSManaged public var notificationDate: Date?
    @NSManaged public var isEstablished: Bool
    @NSManaged public var notificationsEnabled: Bool

}

extension Configuration : Identifiable {

}
