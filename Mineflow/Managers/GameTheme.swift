//
//  GameTheme.swift
//  Mineflow
//
//  Created by evhn on 03.11.2025.
//


import SwiftUI

struct GameTheme: Equatable, Identifiable,Hashable {
    
    var name: String
    let id: UUID = UUID()
    
    // MARK: - Game Board Colors
    var cellClosed: Color
    var cellOpened: Color
    var cellBorder: Color
    var numberColors: [Color]
    var bombIcon: String
    var flagIcon: String
    var questionMarkIcon: String
    var cornerRadius: CGFloat
    

    var backgroundColor: Color
    var headerBackgroundColor: Color
    var primaryTextColor: Color
    var secondaryTextColor: Color
    var accentColor: Color
    
    
    static var allCases: [GameTheme] { [.classic, .nightMode, .midnight, .meadow, .candy, .oledDark] }
    

    
    static let classic = GameTheme(
        name: "Classic",
        cellClosed: Color(.systemGray2),
        cellOpened: Color(.systemGray4),
        cellBorder: Color.black.opacity(0.3),
        numberColors: [
            .blue, .green, .red, .purple, .orange, .cyan, .pink, .black
        ],
        bombIcon: "💣",
        flagIcon: "🚩",
        questionMarkIcon: "❓",
        cornerRadius: 0,

        backgroundColor: Color(.darkGray),
        headerBackgroundColor: Color(.systemGray5),
        primaryTextColor: .primary,
        secondaryTextColor: .secondary,
        accentColor: .blue
    )
    
    static let nightMode = GameTheme(
        name: "Nightmode",
        cellClosed: Color(white: 0.2),
        cellOpened: Color(white: 0.1),
        cellBorder: Color.white.opacity(0.2),
        numberColors: [
            .cyan, .green, .red, .yellow, .orange, .purple, .pink, .white
        ],
        bombIcon: "sun.max.fill",
        flagIcon: "flag.fill",
        questionMarkIcon: "questionmark.diamond.fill",
        cornerRadius: 8.0,

        backgroundColor: Color(white: 0.15),
        headerBackgroundColor: Color(white: 0.2),
        primaryTextColor: .white,
        secondaryTextColor: .gray,
        accentColor: .cyan
    )
    
    static let midnight = GameTheme(
        name: "Midnight",
        cellClosed: Color(red: 45/255, green: 45/255, blue: 50/255),
        cellOpened: Color(red: 30/255, green: 30/255, blue: 35/255),
        cellBorder: Color.black.opacity(0.5),
        numberColors: [
            .cyan, Color(red: 80/255, green: 220/255, blue: 100/255), .red, .indigo, .orange, .teal, .pink, .gray
        ],
        bombIcon: "bolt.fill",
        flagIcon: "pin.fill",
        questionMarkIcon: "questionmark.circle.fill",
        cornerRadius: 4.0,

        backgroundColor: Color(red: 30/255, green: 30/255, blue: 35/255),
        headerBackgroundColor: Color(red: 45/255, green: 45/255, blue: 50/255),
        primaryTextColor: .white,
        secondaryTextColor: .gray,
        accentColor: .indigo
    )
    
    static let meadow = GameTheme(
        name: "Meadow",
        cellClosed: Color(red: 160/255, green: 200/255, blue: 120/255),
        cellOpened: Color(red: 210/255, green: 180/255, blue: 140/255), // "Земля"
        cellBorder: Color(red: 90/255, green: 60/255, blue: 40/255).opacity(0.5),
        numberColors: [
            .blue, .green, .red, .purple, .orange, .teal, .pink, Color(white: 0.4)
        ],
        bombIcon: "🐞",
        flagIcon: "🌸",
        questionMarkIcon: "☘️",
        cornerRadius: 10.0,

        backgroundColor: Color(red: 240/255, green: 255/255, blue: 235/255),
        headerBackgroundColor: Color(red: 160/255, green: 200/255, blue: 120/255).opacity(0.8),
        primaryTextColor: Color(red: 40/255, green: 80/255, blue: 20/255),
        secondaryTextColor: .gray,
        accentColor: .green
    )
    
    static let candy = GameTheme(
        name: "Candy",
        cellClosed: Color(red: 1.0, green: 0.7, blue: 0.85),
        cellOpened: Color(red: 0.95, green: 0.95, blue: 1.0),
        cellBorder: Color.white.opacity(0.7),
        numberColors: [
            Color(red: 0.3, green: 0.2, blue: 1.0), .green, .red, .purple, .orange, .teal, .black, .gray
        ],
        bombIcon: "app.gift.fill",
        flagIcon: "heart.fill",
        questionMarkIcon: "wand.and.stars",
        cornerRadius: 12.0,

        backgroundColor: Color(red: 1.0, green: 0.9, blue: 0.95),
        headerBackgroundColor: Color(red: 1.0, green: 0.7, blue: 0.85).opacity(0.8),
        primaryTextColor: Color(red: 0.7, green: 0.1, blue: 0.4),
        secondaryTextColor: .gray,
        accentColor: .pink
    )
    
    static let oledDark = GameTheme(
        name: "Oled Dark",
        cellClosed: Color(white: 0.1),
        cellOpened: Color.black,
        cellBorder: Color.gray.opacity(0.4),
        numberColors: [
            .cyan, Color(red: 0.5, green: 1, blue: 0), .red, .blue, .orange, .yellow, .pink, Color(white: 0.8)
        ],
        bombIcon: "bolt.slash.fill",
        flagIcon: "pin.fill",
        questionMarkIcon: "questionmark",
        cornerRadius: 4,

        backgroundColor: .black,
        headerBackgroundColor: Color(white: 0.1),
        primaryTextColor: .white,
        secondaryTextColor: .gray,
        accentColor: .cyan
    )
}
