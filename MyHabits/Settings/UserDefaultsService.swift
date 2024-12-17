//
//  UserDefaultsService.swift
//  MyHabits
//
//  Created by Александр Нистратов on 14.12.2024.
//

import Foundation

protocol UserDefaultsServicing {
    func save<T: Codable>(_ value: T, forKey key: String)
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T?
    func remove(forKey key: String)
}

/// Сервис для работы с UserDefaults.
final class UserDefaultsService {
    private let userDefaults: UserDefaults = .standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
}

extension UserDefaultsService: UserDefaultsServicing {
    func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try encoder.encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Ошибка при сохранении объекта \(T.self): \(error)")
        }
    }
    
    func load<T: Codable>(forKey key: String, as type: T.Type) -> T? {
        guard let data = userDefaults.data(forKey: key) else { return nil }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Ошибка при загрузке объекта \(T.self): \(error)")
            return nil
        }
    }
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
