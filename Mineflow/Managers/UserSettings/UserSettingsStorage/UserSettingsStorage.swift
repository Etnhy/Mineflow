//
//  UserSettingsStorage.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//

import Foundation


final class UserSettingsStorage: SettingsStorage {
    
    private let storage: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(storage: UserDefaults = .standard) {
        self.storage = storage
    }

    func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try encoder.encode(value)
            storage.set(data, forKey: key)
        } catch {
            print("error saving value for key: '\(key)': \(error.localizedDescription)")
        }
    }

    func load<T: Codable>(forKey key: String) -> T? {
        guard let data = storage.data(forKey: key) else {
            return nil
        }
        
        do {
            let value = try decoder.decode(T.self, from: data)
            return value
        } catch {
            print("error loading value for key: '\(key)': \(error.localizedDescription)")
            return nil
        }
    }
    
    func remove(forKey key: String) {
        storage.removeObject(forKey: key)
    }
}
