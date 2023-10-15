//
//  Reminder+CoreDataProperties.swift
//  Reminder
//
//  Created by Thibault Giraudon on 13/10/2023.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var isDone: Bool
    @NSManaged public var isDate: Bool
    @NSManaged public var isHour: Bool
    @NSManaged public var notes: String
    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var hour: Date

}

extension Reminder : Identifiable {

}
