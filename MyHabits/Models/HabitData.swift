//
//  HabitData.swift
//  MyHabits
//
//  Created by Александр Нистратов on 14.12.2024.
//

import Foundation

/// Класс для хранения данных о привычке.
/// Использование класса для хранения данных-  это плохая практика!!! Перевел все в структуру.
struct HabitData: Codable {
    /// Айди привычки.
    var id = UUID().uuidString
    /// Название привычки.
    var name: String
    /// Время выполнения привычки.
    var date: Date
    /// Даты выполнения привычки.
    var trackDates: [Date]
    /// Цвет привычки для выделения в списке.
    var color: String
    /// Описание времени выполнения привычки.
    var dateString: String
    /// Показывает, была ли сегодня добавлена привычка.
    var isAlreadyTakenToday: Bool
}

extension HabitData: Equatable {
    static func == (lhs: HabitData, rhs: HabitData) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.date == rhs.date &&
        lhs.trackDates == rhs.trackDates
    }
}
