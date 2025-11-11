//
//  GameTheme.swift
//  Mineflow
//
//  Created by evhn on 03.11.2025.
//


import SwiftUI

enum GameModelThemeIDs: String {
    case classicID =   "classic_theme_id"
    case nightModeID = "nightmode_theme_id"
    case midnightID = "midnight_theme_id"
    case meadowID =    "meadow_theme_id"
    case candyID =     "candy_theme_id"
    case oledDarkID =  "oled_dark_theme_id"

}

struct GameTheme: Equatable, Identifiable, Hashable {
    
    var name: String
    let id: String
    
    // MARK: - Game Board Colors
    var cellClosed: Color
    var cellOpened: Color
    var cellBorder: Color
    var numberColors: [Color]
    var bombIcon: String
    
    var bombImage: Image?
    
    var flagIcon: String
    var flagImage: Image?
    
    var questionMarkIcon: String
    var questionImage: Image?
    
    var cornerRadius: CGFloat
    

    var backgroundColor: Color
    var headerBackgroundColor: Color
    var primaryTextColor: Color
    var secondaryTextColor: Color
    var accentColor: Color
    
    
    static var allCases: [GameTheme] { [.classic, .nightMode, .midnight, .meadow, .candy, .oledDark] }
    

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static let classic = GameTheme(
        name: "Classic", id: GameModelThemeIDs.classicID.rawValue,
        cellClosed: Color(.systemGray2),
        cellOpened: Color(.systemGray4),
        cellBorder: Color.black.opacity(0.3),
        numberColors: [
            .blue, .green, .red, .purple, .orange, .cyan, .pink, .black
        ],
        bombIcon: "💣",
        bombImage: Image(.classicMine),
        flagIcon: "🚩",
        flagImage: Image(.classicFlag),
        questionMarkIcon: "❓",
        questionImage: Image(.questionClassic),
        cornerRadius: 0,

        backgroundColor: Color(.darkGray),
        headerBackgroundColor: Color(.systemGray5),
        primaryTextColor: .primary,
        secondaryTextColor: .secondary,
        accentColor: .blue
    )
    
    static let nightMode = GameTheme(
        name: "Nightmode", id: GameModelThemeIDs.nightModeID.rawValue,
        cellClosed: Color(white: 0.2),
        cellOpened: Color(white: 0.1),
        cellBorder: Color.white.opacity(0.2),
        numberColors: [
            .cyan, .green, .red, .yellow, .orange, .purple, .pink, .white
        ],
        bombIcon: "sun.max.fill",
        bombImage: Image(.nightModeMine),
        flagIcon: "flag.fill",
        flagImage: Image(.nightModeFlag),
        questionMarkIcon: "questionmark.diamond.fill",
        questionImage: Image(.questionNightMode),

        cornerRadius: 8.0,

        backgroundColor: Color(white: 0.15),
        headerBackgroundColor: Color(white: 0.2),
        primaryTextColor: .white,
        secondaryTextColor: .gray,
        accentColor: .cyan
    )
    
    static let midnight = GameTheme(
        name: "Midnight", id: GameModelThemeIDs.midnightID.rawValue,
        cellClosed: Color(red: 45/255, green: 45/255, blue: 50/255),
        cellOpened: Color(red: 30/255, green: 30/255, blue: 35/255),
        cellBorder: Color.black.opacity(0.5),
        numberColors: [
            .cyan, Color(red: 80/255, green: 220/255, blue: 100/255), .red, .indigo, .orange, .teal, .pink, .gray
        ],
        bombIcon: "bolt.fill",
        bombImage: Image(.midnightMine),
        flagIcon: "pin.fill",
        flagImage: Image(.midnightFlag),
        questionMarkIcon: "questionmark.circle.fill",
        questionImage: Image(.questionMidnight),

        cornerRadius: 4.0,

        backgroundColor: Color(red: 30/255, green: 30/255, blue: 35/255),
        headerBackgroundColor: Color(red: 45/255, green: 45/255, blue: 50/255),
        primaryTextColor: .white,
        secondaryTextColor: .gray,
        accentColor: .indigo
    )
    
    static let meadow = GameTheme(
        name: "Meadow", id: GameModelThemeIDs.meadowID.rawValue,
        cellClosed: Color(red: 160/255, green: 200/255, blue: 120/255),
        cellOpened: Color(red: 210/255, green: 180/255, blue: 140/255), // "Земля"
        cellBorder: Color(red: 90/255, green: 60/255, blue: 40/255).opacity(0.5),
        numberColors: [
            .blue, .green, .red, .purple, .orange, .teal, .pink, Color(white: 0.4)
        ],
        bombIcon: "🐞",
        bombImage: Image(.meadowMine),
        flagIcon: "🌸",
        flagImage: Image(.meadowFlag),
        questionMarkIcon: "☘️",
        questionImage: Image(.questionMeadow),

        cornerRadius: 10.0,

        backgroundColor: Color(red: 240/255, green: 255/255, blue: 235/255),
        headerBackgroundColor: Color(red: 160/255, green: 200/255, blue: 120/255).opacity(0.8),
        primaryTextColor: Color(red: 40/255, green: 80/255, blue: 20/255),
        secondaryTextColor: .gray,
        accentColor: .green
    )
    
    static let candy = GameTheme(
        name: "Candy", id: GameModelThemeIDs.candyID.rawValue,
        cellClosed: Color(red: 1.0, green: 0.7, blue: 0.85),
        cellOpened: Color(red: 0.95, green: 0.95, blue: 1.0),
        cellBorder: Color.white.opacity(0.7),
        numberColors: [
            Color(red: 0.3, green: 0.2, blue: 1.0), .green, .red, .purple, .orange, .teal, .black, .gray
        ],
        bombIcon: "app.gift.fill",
        bombImage: Image(.candyMine),
        flagIcon: "heart.fill",
        flagImage: Image(.candyFlag),
        questionMarkIcon: "wand.and.stars",
        questionImage: Image(.questionCandy),

        cornerRadius: 12.0,

        backgroundColor: Color(red: 1.0, green: 0.9, blue: 0.95),
        headerBackgroundColor: Color(red: 1.0, green: 0.7, blue: 0.85).opacity(0.8),
        primaryTextColor: Color(red: 0.7, green: 0.1, blue: 0.4),
        secondaryTextColor: .gray,
        accentColor: .pink
    )
    
    static let oledDark = GameTheme(
        name: "Oled Dark", id: GameModelThemeIDs.oledDarkID.rawValue,
        cellClosed: Color(white: 0.1),
        cellOpened: Color.black,
        cellBorder: Color.gray.opacity(0.4),
        numberColors: [
            .cyan, Color(red: 0.5, green: 1, blue: 0), .red, .blue, .orange, .yellow, .pink, Color(white: 0.8)
        ],
        bombIcon: "bolt.slash.fill",
        bombImage: Image(.oledDarkMine),
        flagIcon: "pin.fill",
        flagImage: Image(.oledDarkFlag),
        questionMarkIcon: "questionmark",
        questionImage: Image(.questionOleddark),

        cornerRadius: 4,

        backgroundColor: .black,
        headerBackgroundColor: Color(white: 0.1),
        primaryTextColor: .white,
        secondaryTextColor: .gray,
        accentColor: .cyan
    )
}
