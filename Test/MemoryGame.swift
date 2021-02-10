//
//  MemoryGame.swift
//  Test
//
//  Created by Perry Sykes on 1/11/21.
//

//MODEL

//import Foundation, Model is interface independent and does not depend on SwiftUI
import Foundation

//struct MemoryGame
//  Model for a memory game whose CardContent type is determined by the View Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    //var cards
    //  an Array of Card structures, can only be set by the model
    private(set) var cards: Array<Card>
    
    //var numPairs, score, cardColor
    //  numPairs is the number of pairs of cards in the game
    //  score is the score
    //  cardColor is the color of the back of the cards, SwiftUI dependent
    var numPairs: Int
    var score: Int
    var cardRGB: Array<Double>
    var theme: String
    //computed, private var indexOfTheONlyFaceUpCard, optional int
    //  get the var
    //      Int array faceUpCardIndices, will hold indeces of face up cards
    //      for each index number in 'cards'
    //          if a card is face up, put it in 'faceUpCardIndices'
    //      if we only have 1 card face up, return it's index number in 'cards'
    //      else return nil
    //  set the var
    //      for each index in 'cards'
    //          set the card at that index to isFaceUp = T if it is the new indexOfTheOnlyFaceUpCard
    //          otherwise set the card at that index isFaceUp to false
    private var indexOfTheOnlyFaceUpCard: Int? {
        get {
            //condensed version:
            //cards.indices.filter { cards[$0].isFaceUp }.only
            var faceUpCardIndices = [Int]()
            for index in cards.indices {
                if cards[index].isFaceUp {
                    faceUpCardIndices.append(index)
                }
            }
            if faceUpCardIndices.count == 1 {
                return faceUpCardIndices.first
            }
            else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    //func choose handles all logic when a card is "chosen" by the user from the View
    //  if let chosenIndex be the index of the card chosen, and if the card we chose is not face up, and if the card we chose is not matched
    //      if we can get an indexOfTheOnlyFaceUpCard, meaning only one card is already face up, we set that to our potential match index
    //          if the content of the chosen card is the same as the content of the potential match
    //              set isMatched for both chosen and matching card to true
    //              add 2 to 'score'
    //          else subtract 1 from 'score'
    //          now we set our chosen card to face up
    //      else set 'indexOfTheOnlyFaceUpCard' to the index of the chosen card
    mutating func choose(card: Card) {
        print("Card chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score = score + 2
                    print("\(score)")
                }
                else {
                    score = score - 1
                    print("\(score)")
                }
                self.cards[chosenIndex].isFaceUp = true
            }
            else {
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    //init
    //  initialize score to 0
    //  initialize numPairs to value of numberOfPairsOfCards passed in
    //  initialize 'cards' Array of Cards
    //  initialize 'cardRGB' to value of colorOfCards passed in
    //  initialize 'theme' to the themeName passed in
    //  for 0 to 'numberOfPairsOfCards'
    //      call cardContentFactory to get content to be put on cards, store in 'content'
    //      create 2 new Cards, each with the content in 'content' and each with a unique id
    //  shuffle 'cards' once all Cards have been appended
    init(numberOfPairsOfCards: Int, colorOfCards: Array<Double>, themeName: String, cardContentFactory: (Int) -> CardContent) {
        score = 0
        numPairs = numberOfPairsOfCards
        cards = Array<Card>()
        cardRGB = colorOfCards
        theme = themeName
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pairIndex*2))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    //Here, identifiable is a protocol that demands that Card have a var id
    //struct Card
    //conforms to Identifiable
    struct Card: Identifiable {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
        var id: Int
    }
}
