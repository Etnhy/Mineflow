//
//  GameTheme.swift
//  Mineflow
//
//  Created by evhn on 03.11.2025.
//


import SwiftUI

enum GameModelThemeIDs: String {
    case classicID      = "classic_theme_id"
    case nightModeID    = "nightmode_theme_id"
    case midnightID     = "midnight_theme_id"
    case meadowID       = "meadow_theme_id"
    case candyID        = "candy_theme_id"
    case oledDarkID     = "oled_dark_theme_id"

}

struct GameTheme: Equatable, Identifiable, Hashable {
    
    var name: String
    let id: String
    
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
        
        backgroundColor: .bimbBackground,
        headerBackgroundColor: Color(.systemGray5),
        primaryTextColor: .primary,
        secondaryTextColor: .secondary,
        accentColor: Color(hex: "#77D6FF")//"#66CCFF")
    )
    
    static let nightMode = GameTheme(
        name: "Nightmode", id: GameModelThemeIDs.nightModeID.rawValue,
        cellClosed: Color(white: 0.2),
        cellOpened: Color(white: 0.1),
        cellBorder: Color.white.opacity(0.2),
        numberColors: [
            Color(red: 100/255, green: 210/255, blue: 255/255),
            Color(red: 120/255, green: 220/255, blue: 120/255),
            Color(red: 255/255, green: 130/255, blue: 130/255),
            Color(red: 255/255, green: 230/255, blue: 130/255),
            Color(red: 255/255, green: 180/255, blue: 130/255),
            Color(red: 180/255, green: 140/255, blue: 255/255),
            Color(red: 255/255, green: 140/255, blue: 200/255),
            .white
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
        accentColor: Color(red: 100/255, green: 210/255, blue: 255/255)
    )
    
    
    static let midnight = GameTheme(
        name: "Midnight", id: GameModelThemeIDs.midnightID.rawValue,
        cellClosed: Color(red: 45/255, green: 45/255, blue: 50/255),
        cellOpened: Color(red: 30/255, green: 30/255, blue: 35/255),
        cellBorder: Color.black.opacity(0.5),
        numberColors: [
            Color(red: 120/255, green: 200/255, blue: 220/255),
            Color(red: 80/255, green: 220/255, blue: 100/255),
            Color(red: 220/255, green: 100/255, blue: 100/255),
            Color(red: 150/255, green: 130/255, blue: 255/255),
            Color(red: 220/255, green: 160/255, blue: 100/255),
            .teal,
            Color(red: 220/255, green: 130/255, blue: 180/255),
            .gray
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
        cellClosed: Color(red: 170/255, green: 190/255, blue: 150/255),
        
        cellOpened: Color(red: 220/255, green: 210/255, blue: 190/255),
        cellBorder: Color(red: 90/255, green: 60/255, blue: 40/255).opacity(0.5),
        numberColors: [
            Color(red: 0/255, green: 110/255, blue: 180/255),
            Color(red: 50/255, green: 140/255, blue: 70/255),
            Color(red: 210/255, green: 50/255, blue: 60/255),
            Color(red: 100/255, green: 90/255, blue: 190/255),
            Color(red: 230/255, green: 130/255, blue: 40/255),
            Color(red: 60/255, green: 150/255, blue: 140/255),
            Color(red: 190/255, green: 100/255, blue: 110/255),
            Color(white: 0.3)
        ],
        
        bombIcon: "🐞",
        bombImage: Image(.meadowMine),
        flagIcon: "🌸",
        flagImage: Image(.meadowFlag),
        questionMarkIcon: "☘️",
        questionImage: Image(.questionMeadow),
        cornerRadius: 10.0,
        backgroundColor: Color(red: 230/255, green: 245/255, blue: 230/255),
        headerBackgroundColor: Color(red: 170/255, green: 190/255, blue: 150/255).opacity(0.8),
        primaryTextColor: Color(red: 40/255, green: 80/255, blue: 20/255), // (Темно-зеленый - окей)
        secondaryTextColor: .gray,
        accentColor: Color(red: 80/255, green: 130/255, blue: 90/255)
    )
    
    static let candy = GameTheme(
        name: "Candy", id: GameModelThemeIDs.candyID.rawValue,
        
        cellClosed: Color(red: 255/255, green: 190/255, blue: 210/255),
        cellOpened: Color(red: 240/255, green: 245/255, blue: 255/255),
        cellBorder: Color.white.opacity(0.7),
        
        numberColors: [
            Color(red: 80/255, green: 150/255, blue: 255/255),
            Color(red: 100/255, green: 200/255, blue: 150/255),
            Color(red: 230/255, green: 70/255, blue: 80/255),
            Color(red: 90/255, green: 60/255, blue: 130/255),
            Color(red: 255/255, green: 160/255, blue: 70/255),
            Color(red: 150/255, green: 220/255, blue: 90/255),
            Color.black,
            Color(white: 0.4)
        ],
        
        bombIcon: "app.gift.fill",
        bombImage: Image(.candyMine),
        flagIcon: "heart.fill",
        flagImage: Image(.candyFlag),
        questionMarkIcon: "wand.and.stars",
        questionImage: Image(.questionCandy),
        
        cornerRadius: 12.0,
        
        backgroundColor: Color(red: 230/255, green: 240/255, blue: 255/255),
        headerBackgroundColor: Color(red: 255/255, green: 190/255, blue: 210/255).opacity(0.8),
        primaryTextColor: Color(red: 90/255, green: 60/255, blue: 130/255),
        secondaryTextColor: .gray,
        accentColor: Color(red: 255/255, green: 100/255, blue: 130/255)
    )
    
    
    static let oledDark = GameTheme(
        name: "Oled Dark", id: GameModelThemeIDs.oledDarkID.rawValue,
        cellClosed: Color(white: 0.1),
        cellOpened: Color.black,
        cellBorder: Color.gray.opacity(0.4),
        numberColors: [
            .cyan,
            Color(red: 0.5, green: 1.0, blue: 0.3),
            Color(red: 1.0, green: 0.3, blue: 0.3),
            Color(red: 0.3, green: 0.5, blue: 1.0),
            Color(red: 1.0, green: 0.6, blue: 0.2),
            Color(red: 1.0, green: 0.9, blue: 0.4),
            Color(red: 1.0, green: 0.4, blue: 0.7),
            Color(white: 0.8)
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


