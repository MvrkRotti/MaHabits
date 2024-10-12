//
//  HabitViewModel.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//

import CoreData

final class HabitViewModel {
    private let context: NSManagedObjectContext
    
    @Published var habits: [Habit] = []
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchHabits()
    }
    
    func fetchHabits() {
        let request: NSFetchRequest<Habit> = Habit.fetchRequest()
        
        do {
            habits = try context.fetch(request)
        } catch {
            print("Ошибка загрузки привычек: \(error)")
        }
    }
    
    func addHabitWith(title: String) {
        let newHabit = Habit(context: context)
        newHabit.title = title
        newHabit.completionCount = 0
        newHabit.createdAt = Date()
        
        saveContext()
        fetchHabits()
    }
    
    func completeHabit(_ habit: Habit) {
        habit.completionCount += 1
        saveContext()
    }
    
    func deleteHabit(_ habit: Habit) {
        context.delete(habit)
        saveContext()
        fetchHabits()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Saving error: \(error)")
        }
    }
}
