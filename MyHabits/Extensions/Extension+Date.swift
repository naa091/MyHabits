//
//  Extension+Date.swift
//  MyHabits
//
//  Created by Александр Нистратов on 14.12.2024.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /// Возвращает форматированную строку для текущей даты.
    /// - Parameter locale: Локаль (по умолчанию используется `ru_RU`).
    /// - Returns: Отформатированная строка.
    func formattedString(locale: Locale = Locale(identifier: "ru_RU")) -> String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: self)
    }
    
    /// Генерация массива последовательных дат.
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var currentDate = fromDate
        let calendar = Calendar.current
        
        while currentDate <= toDate {
            dates.append(currentDate)
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                break
            }
            currentDate = nextDate
        }
        return dates
    }
}
