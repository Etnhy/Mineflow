# 🌊 Mineflow: Modern Logic Puzzle

![Banner](assets/banner.png)
[![Swift](https://img.shields.io/badge/Swift-5.9-F05138?style=flat-square&logo=swift&logoColor=white)](https://developer.apple.com/swift/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0-007AFF?style=flat-square&logo=swift&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![iOS](https://img.shields.io/badge/iOS-16.0%2B-000000?style=flat-square&logo=apple&logoColor=white)]()
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)]()

**Mineflow** is a high-performance, modern reimagining of the classic minesweeper logic puzzle, built entirely with **SwiftUI**.

The project demonstrates a production-level implementation of **UDF (Unidirectional Data Flow)** architecture, custom gesture handling, and advanced rendering optimizations, ensuring a buttery-smooth experience even on large grids.

---

## ✨ Key Features

* **🧠 Robust UDF Architecture:** Built on a custom Redux-like state management system. Every state change is predictable, traceable, and easy to debug.
* **🎨 100% Custom UI:** No standard UIKit components. Custom grid rendering, animated cells, and themed interfaces.
* **🚀 High Performance:** Utilizes `Canvas` and `.drawingGroup()` for GPU-accelerated rendering, maintaining 60 FPS on large 16x30 grids.
* **📳 Haptic Experience:** deeply integrated haptic feedback for flagging, tapping, and game events.
* **💾 Smart Persistence:** The game state is automatically saved. Users can leave the app and resume their "flow" instantly.
* **🕹 Advanced Logic:** Implements recursive "flood fill" algorithms and a "safe start" guarantee (the first tap is never a mine).

---

## 📱 Screenshots

| Main Menu | Gameplay (Light) | Gameplay (Dark) |
|:---:|:---:|:---:|
| <img width="250" alt="Simulator Screenshot - 17 - 2025-11-26 at 14 07 23" src="https://github.com/user-attachments/assets/6ebc9734-fa56-47e8-940d-464330d1ec03" /> | <img width="250" alt="Simulator Screenshot - 17 - 2025-11-26 at 14 07 29" src="https://github.com/user-attachments/assets/dc637040-6236-47a4-b431-c7b2cb482d10" /> | <img width="250" alt="Simulator Screenshot - 17 - 2025-11-26 at 14 07 54" src="https://github.com/user-attachments/assets/59de31a8-c873-4885-a6bf-60624142a572" /> |

---

## 🛠 Tech Stack

* **Language:** Swift 6
* **UI Framework:** SwiftUI
* **Architecture:** Custom UDF (Unidirectional Data Flow) / The Composable Architecture (TCA) concepts.
* **Concurrency:** Swift Concurrency (async/await)
* **Assets:** SF Symbols, Custom Vector Graphics
* **Persistence:** UserDefaults / Codable

---

## 🏗 Architecture & Code Style

The app follows a strict **Unidirectional Data Flow**. The View never mutates the State directly; instead, it sends Actions to a Reducer.

### The Reducer Pattern
Core game logic is isolated in pure functions, making it highly testable.

```swift
func gameReducer(state: inout GameState, action: GameAction) {
    switch action {
    case .tapCell(let r, let c):
        // Logic handles the game rules, distinct from the UI
        if state.board[r][c].isMine {
            state.status = .lost
        } else {
            openCell(&state, r: r, c: c)
        }
        
    case .longPressCell(let r, let c):
        // Handles flagging logic
        toggleFlag(&state, r: r, c: c)
        
    case .restartGame:
        state = GameState.initial
    }
}
