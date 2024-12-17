//
//  HabitsStore.swift
//  MyHabits
//
//  Created by Александр Нистратов on 14.12.2024.
//

import Foundation

protocol HabitStoraging {
    var habits: [HabitData] { get set }
    
    /// Сохранение привычки
    func save()
    /// Добавить текущую дату для привычки
    func addCurrentDate(_ habit: HabitData)
    /// Получить дату привычки
    func getDate(forIndex index: Int) -> String?
    /// Проверить была ли привычка выполнена в заданную дату
    func checkHabitCompliteDate(habitData: HabitData, compliteDate: Date) -> Bool
}

/// Класс для сохранения и изменения привычек пользователя.
final class HabitsStore {
    private let userDefaultsService: UserDefaultsServicing
    private let calendar: Calendar
    private let habitsKey: String = "habit key"
    private let startDateKey: String = "start date key"
    
    var habits: [HabitData] = [] {
            didSet {
                save()
            }
        }

        var dates: [Date] {
            guard let startDate = userDefaultsService.load(forKey: startDateKey, as: Date.self) else {
                return []
            }
            return Date.dates(from: startDate, to: Date())
        }

        var todayProgress: Float {
            guard !habits.isEmpty else { return 0 }
            let completedHabits = habits.filter { $0.isAlreadyTakenToday }
            return Float(completedHabits.count) / Float(habits.count)
        }
    
    init(userDefaultsService: UserDefaultsServicing, calendar: Calendar) {
        self.userDefaultsService = userDefaultsService
        self.calendar = calendar
        
        habits = userDefaultsService.load(forKey: habitsKey, as: [HabitData].self) ?? []
        
        if userDefaultsService.load(forKey: startDateKey, as: Date.self) == nil {
            let startDate = calendar.startOfDay(for: Date())
            userDefaultsService.save(startDate, forKey: startDateKey)
        }
    }
}

extension HabitsStore: HabitStoraging {
    func save() {
        userDefaultsService.save(habits, forKey: habitsKey)
    }
    
    func addCurrentDate(_ habit: HabitData) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        
        habits[index].trackDates.append(Date())
        save()
    }
    
    func getDate(forIndex index: Int) -> String? {
        guard index < dates.count else { return nil }
        
        return dates[index].formattedString()
    }
    
    func checkHabitCompliteDate(habitData: HabitData, compliteDate: Date) -> Bool {
        habitData.trackDates.contains { calendar.isDate($0, equalTo: compliteDate, toGranularity: .day)}
    }
}
