//
//  HabitViewModel.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//

import RealmSwift

final class HabitViewModel {

    private let realm = try! Realm()
    
    func addHabbit(name: String) {
        let habit = Habit(name: name)
        
        try! realm.write {
            realm.add(habit)
        }
    }
    
    func getAllHabits() -> Results<Habit> {
        return realm.objects(Habit.self)
    }
    
    func toggleHabitCompletion(habit: Habit) {
        try! realm.write {
            habit.isCompleted.toggle()
        }
    }
    
    func deleteHabit(habit: Habit) {
        try! realm.write {
            realm.delete(habit)
        }
    }
}
