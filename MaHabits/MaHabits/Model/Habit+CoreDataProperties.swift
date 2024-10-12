//
//  Habit+CoreDataProperties.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var title: String?
    @NSManaged public var completionCount: Int32
    @NSManaged public var createdAt: Date?

}

extension Habit : Identifiable {

}
