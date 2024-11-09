//
//  Habit.swift
//  MaHabits
//
//  Created by Danil Pestov on 09.11.2024.
//

import Foundation
import RealmSwift

class Habit: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var isCompleted: Bool = false
    @Persisted var createdDate: Date = Date()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
