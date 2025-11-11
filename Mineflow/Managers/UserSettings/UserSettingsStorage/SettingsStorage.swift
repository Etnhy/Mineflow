//
//  SettingsStorage.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//


protocol SettingsStorage {
    func save<T: Codable>(_ value: T, forKey key: String)
    
    func load<T: Codable>(forKey key: String) -> T?
    
    func remove(forKey key: String)
}