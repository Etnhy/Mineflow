//
//  SettingsRepository.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//

import Foundation

extension String {
    static let themeKey: String = "theme"
    static let hapticPreference = "hapticPreference"
}

final class SettingsRepository {
    
    private let storage: SettingsStorage
    
    private(set) var hapticIsOn = false
    
    init(storage: SettingsStorage = UserSettingsStorage()) {
        self.storage = storage
        loadSettings()
    }
    
    func loadSettings() {
        hapticIsOn = loadHapticPreference()
    }
    
    func saveTheme(_ theme: GameTheme) {
        storage.save(theme.id, forKey: .themeKey)
    }
    
    func loadTheme() -> GameTheme {
        let themeID: String? = storage.load(forKey: .themeKey) as String?
        return GameTheme.allCases.first(where: { $0.id == themeID }) ?? .classic
    }
    
    func saveHapticPreference(_ isEnabled: Bool) {
        hapticIsOn = isEnabled
        storage.save(isEnabled, forKey: .hapticPreference)
    }
    
    func loadHapticPreference() -> Bool {
        let isEnabled: Bool? = storage.load(forKey: .hapticPreference) as Bool?
        return isEnabled ?? true
    }
    
}
