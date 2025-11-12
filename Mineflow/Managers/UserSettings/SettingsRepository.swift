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
    static let inProgressGame = "inProgressGame"
    static let hasCompletedOnboarding = "hasCompletedOnboarding"
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
    
    func setOnboardingCompleted() {
        storage.save(true, forKey: .hasCompletedOnboarding)
    }
    
    func getIsOnboardingCompleted() -> Bool {
        #if DEBUG
            return false
        #else
        let isCompleted: Bool? = storage.load(forKey: .hasCompletedOnboarding) as Bool?
        return isCompleted ?? false

        #endif
    }
    
}

extension SettingsRepository {
    
    func saveInProgressGame(_ gameState: GameState) {        
        let dataToSave = gameState.persistenceData
        if let data = try? JSONEncoder().encode(dataToSave) {
            UserDefaults.standard.set(data, forKey: .inProgressGame)
        }
    }
    
    func fetchInProgressGame() -> GameState? {
        guard let data = UserDefaults.standard.data(forKey: .inProgressGame) else {
            return nil
        }
        
        if let loadedData = try? JSONDecoder().decode(InProgressGameData.self, from: data) {
            return GameState(from: loadedData)
        }
        
        return nil
    }
    
    func deleteInProgressGame() {
        storage.remove(forKey: .inProgressGame)
    }
}
