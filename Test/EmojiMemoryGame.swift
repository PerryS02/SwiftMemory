//
//  EmojiMemoryGame.swift
//  Test
//
//  Created by Perry Sykes on 1/11/21.
//

//ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject {
//  Here's the model, the VM tells the Model that this memory game will have CardContent of String type
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    //struct Theme
    //  defines which vars make up a Theme for an emojiMemoryGame
    //  'cardRGB' contains Double values 0-1, designating color value for red, green, and blue in that order
    struct Theme {
        var name: String
        var hasRandomPairs: Bool
        var numberofPairs: Int
        var cardRGB: Array<Double>
        var content: Array<String>
    }
    
    //private func createMemoryGame, returns a MemoryGame with CardContent type String
    //Create a bunch of themes to potentially use in the memory game
    //create an array 'allThemes' to hold all declared Themes
    //let 'theme' be a random Theme from 'allThemes', 'theme' will be an optional
    //if 'theme' has a random number of cards
    //  set 'numPairs' to be a random number between 2 and 5
    //else set 'numPairs' to be the the numberOfPairs of 'theme'
    //return a MemoryGame of type String.
    //  Pass in the 'numPairs'
    //  Pass in the cardRGB of 'theme'
    //  Pass in the name of 'theme'
    //  Pass in function to grab the content of 'theme' to be put on cards in the Model
    private static func createMemoryGame() -> MemoryGame<String> {
        let yellowTheme: Theme = Theme(name: "YELLOW", hasRandomPairs: true, numberofPairs: 0, cardRGB: [1.0, 0.8, 0.0], content: ["🐯","🌕","🍋","🧽","📒"])
        let redTheme: Theme = Theme(name: "RED", hasRandomPairs: true, numberofPairs: 0, cardRGB: [1.0, 0.0, 0.0], content: ["👹","🌹","🍅","🧨","📕"])
        let blueTheme: Theme = Theme(name: "BLUE", hasRandomPairs: true, numberofPairs: 0, cardRGB: [0.0, 0.4, 1.0], content: ["🐳","🌎","🧊","💎","📘"])
        let greenTheme: Theme = Theme(name: "GREEN", hasRandomPairs: true, numberofPairs: 0, cardRGB: [0.0, 0.67, 0.0], content: ["🐸","🌳","🍏","🔋","📗"])
        let pinkTheme: Theme = Theme(name: "PINK", hasRandomPairs: true, numberofPairs: 0, cardRGB: [1.0, 0.4, 0.7], content: ["🐷","🌸","🍇","🎀","🔮"])
        let orangeTheme: Theme = Theme(name: "ORANGE", hasRandomPairs: false, numberofPairs: 4, cardRGB: [1.0, 0.5, 0.0], content: ["🦊","🍁","🍊","🚚","📙"])
        
        let allThemes: Array<Theme> = [yellowTheme, redTheme, blueTheme, greenTheme, pinkTheme, orangeTheme]
        let theme = allThemes.randomElement()
        
        var numPairs = 0
        if theme!.hasRandomPairs {
            numPairs = Int.random(in: 2..<6)
        }
        else {
            //theme has to be focibly unwrapped due to .randomElement returning an optional.
            numPairs = theme!.numberofPairs
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: numPairs, colorOfCards: theme!.cardRGB, themeName: theme!.name) { pairIndex in
            return theme!.content[pairIndex]
        }
    }
        
    // MARK: -Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return memoryGame.cards
    }
    
    var numPairs: Int {
        return memoryGame.numPairs
    }
    
    var score: Int {
        return memoryGame.score
    }
    
    var cardRGB: Array<Double> {
        return memoryGame.cardRGB
    }
    
    var themeName: String {
        return memoryGame.theme
    }
    
    // MARK: -Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        memoryGame.choose(card: card)
    }
    
    func newGame() {
        objectWillChange.send()
        memoryGame = EmojiMemoryGame.createMemoryGame()
    }
}
