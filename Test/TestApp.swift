//
//  TestApp.swift
//  Test
//
//  Created by Perry Sykes on 1/7/21.
//

import SwiftUI

@main
struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
