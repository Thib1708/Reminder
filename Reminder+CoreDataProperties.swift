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
    @NSManaged public var notes: String
    @NSManaged public var title: String

}

extension Reminder : Identifiable {

}
