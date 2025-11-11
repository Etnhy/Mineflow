//
//  ThemeView.swift
//  Mineflow
//
//  Created by evhn on 06.11.2025.
//

import SwiftUI

struct ThemeView: View {
    
    var state: ThemeState

    var send: (ThemeAction) -> Void
    
    
    private let padding: CGFloat = 2.0
    private let cellSpacing: CGFloat = 1.0

    @State private var finalScale: CGFloat = 1.0

    @State private var finalOffset: CGSize = .zero

    @State private var selectedTheme: GameTheme
    
    
    init(state: ThemeState, send: @escaping (ThemeAction) -> Void) {
            self.state = state
            self.send = send
            self._selectedTheme = State(initialValue: state.theme)
        }
    
    var body: some View {
        ZStack {
            selectedTheme.backgroundColor.ignoresSafeArea()
                .animation(.linear, value: selectedTheme)
            VStack {
                TabView(selection: $selectedTheme) {
                    ForEach(GameTheme.allCases,id: \.id) { item in
                        
                        VStack {
                            Text(item.name)
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                                .foregroundStyle(item.headerBackgroundColor)

                            gameField(theme: item)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 400)

                        }
                        .tag(item)

                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                .onChange(of: selectedTheme) { theme in
                    print(selectedTheme.name)
                }
                Button {
                    send(.themeChanged(selectedTheme))

                } label: {
                    Text("select")
                }

                
            }
        }
    }
    
    @ViewBuilder
    private func gameField(theme: GameTheme) -> some View {
        GeometryReader { geometry in
            let boardView = Grid(horizontalSpacing: cellSpacing, verticalSpacing: cellSpacing) {
                ForEach(0..<state.testState.gameModel.rows, id: \.self) { row in
                    GridRow {
                        ForEach(0..<state.testState.gameModel.cols, id: \.self) { col in
                            let cell = state.testState.board[row][col]
                            
                            CellView(theme: theme,cell: cell)
                           
                        }
                    }
                }
            }
                .padding(padding)
                .background(Color.gray.opacity(0.5))
            ZStack(alignment: .center) {
                boardView
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .clipped()
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .clipped()
            .contentShape(Rectangle())
        }

    }

}

#Preview {
    ThemeView(state: .init(theme: .candy)) { action in
        print(action)
    }
}
