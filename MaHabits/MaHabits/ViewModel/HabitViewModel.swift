//
//  HabitViewModel.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//

import RealmSwift

final class HabitViewModel {
    
    private(set) var habits: Results<Habit>!
    private let realm = try! Realm()
    
    init() {
        fetchHabits()
    }
    
    func addHabbit(name: String) {
        let habit = Habit(name: name)
        
        try! realm.write {
            realm.add(habit)
        }
    }
    
    func fetchHabits() {
        habits = realm.objects(Habit.self)
    }
    
    func toggleHabitCompletion(at index: Int) {
        guard index < habits.count else { return }
        let habit = habits[index]
        
        try! realm.write {
            habit.isCompleted.toggle()
        }
    }
    
    func incrementCompletionCount(for habit: Habit) {
        try! realm.write {
            habit.completionCount += 1
            habit.isCompleted = true
        }
    }
    
    func deleteHabit(at index: Int) {
        guard index < habits.count else { return }
        let habit = habits[index]
        
        try! realm.write {
            realm.delete(habit)
        }
    }
}
